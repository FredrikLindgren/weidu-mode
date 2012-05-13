
(defcustom weidu-baf-indent-width 2
  "Width of indentation"
  :type 'integer)

(defvar weidu-baf-mode-hook nil)
(defvar weidu-general-hook nil)

(defvar weidu-baf-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "RET") 'weidu-baf-indent-newline-indent)
    (define-key map (kbd "C-M-q") 'weidu-baf-indent-block)
    map))

;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.[Bb][Aa][Ff]\\'" 'weidu-baf-mode)) ;when last I tried it would not work with inflix, hence three different
;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.[Ss][Ss][Ll]\\'" 'weidu-baf-mode))
;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.[Ss][Ll][Bb]\\'" 'weidu-baf-mode))

(require 'weidu-mode-library-bg)

(defvar weidu-baf-ssl (regexp-opt '("RequireBlock" "IgnoreBlock" "TargetBlock" "Target" "TriggerBlock" "Action" "ConditionalTargetBlock" "Combine" "ActionCondition" "OnContinue") 'words))

(defvar weidu-baf-keywords (regexp-opt '("IF" "THEN" "RESPONSE" "END" "TRIGGER" "TARGET" "INCLUDE FILE" "BEGIN LOOP" "END LOOP" "DO" "VARIABLE" "BEGIN_ACTION_DEFINITION" "ACTION") 'words))

(defvar weidu-baf-font-lock-keywords-1 
  (list
   ;;weidu-bg-triggers and weidu-bg-actions are set up to only match the trigger/action part of "foo(", to avoid font lock of any old "foo"
   (cons weidu-bg-triggers (list 1 font-lock-function-name-face))
   (cons weidu-bg-actions (list 1 font-lock-function-name-face))
   (cons weidu-bg-constants font-lock-constant-face)
   (cons weidu-bg-objects font-lock-type-face)
   (cons weidu-baf-keywords font-lock-keyword-face)
   (cons weidu-baf-ssl font-lock-builtin-face)))

(defvar weidu-baf-font-lock-keywords weidu-baf-font-lock-keywords-1)

(defun weidu-baf-indent-line (&optional fix-point)
  "Indents the current line and optionally moves point to the end of the inserted whitespace."
  (interactive)
  (let (indentedp			;Are we there yet?
	indent				;How much (relative)
	indent-from			;How much (base-line)
	(lines-moved 0)			;For keeping track of ORs
	(case-fold-search nil))		;Case-sensitive regexps
    (save-excursion
      (beginning-of-line)
      ;;Indent END LOOP
      (when (looking-at "^[ \t]*END LOOP\\>")
	(setq indent 0)
	(let (done (open 0) (closed 0))
	  (while (and (not done) (not (bobp)))
	    (when (looking-at "^[ \t]*END LOOP\\>")
	      (incf closed))
	    (when (looking-at "^[ \t]*BEGIN LOOP\\>")
	      (incf open))
	    (when (= open closed)
	      (setq done t))
	    (unless done
	      (forward-line -1))))
	(setq indent-from (current-indentation))
	(setq indentedp t))
      ;;Indent THEN, END
      (when (looking-at "^[ \t]*\\(THEN\\|END\\)\\>")
	(setq indent 0)
	(while (and (not (looking-at "^[ \t]*\\(IF\\|BEGIN_ACTION_DEFINITION\\)\\>")) (not (bobp)))
	  (forward-line -1))
	(setq indent-from (current-indentation))
	(setq indentedp t))
      ;;Indent TARGET (found in SLBs)
      (when (looking-at "^[ \t]*TARGET\\>")
	(save-excursion
	  (while (and (not (looking-at "^[ \t]*\\(TRIGGER\\|TARGET\\)\\>")) (not (bop)))
	    (forward-line -1))
	  (setq indent 0)
	  (setq indent-from (current-indentation))
	  (setq indentedp t)))
      ;;Indent TRIGGER (found in SLBs and in SSL action defs)
      (when (looking-at "^[ \t]*TRIGGER\\>")
	(save-excursion
	  (while (and (not (bobp)) (not indentedp))
	    (forward-line -1)
	    (when (looking-at "^[ \t]*\\(TRIGGER\\|TARGET\\)\\>") ;We are in a SLB
	      (setq indent 0)
	      (setq indentedp t)
	      (setq indent-from (current-indentation)))
	    (when (looking-at "^[ \t]*BEGIN_ACTION_DEFINITION\\>")
	      (setq indent weidu-baf-indent-width)
	      (setq indentedp t)
	      (setq indent-from (current-indentation))))))
      ;;Indent ACTION (found in SSL action defs)
      (when (looking-at "^[ \t]*ACTION\\>")
	(save-excursion
	  (while (and (not (bobp)) (not (looking-at "^[ \t]*BEGIN_ACTION_DEFINITION\\>")))
	    (forward-line -1))
	  (setq indent weidu-baf-indent-width)
	  (setq indent-from (current-indentation))
	  (setq indentedp t)))
      ;;Indent Name (found as a BAF trigger and in SSL actio defs)
      (when (looking-at "^[ \t]*Name\\>")
	(let (done)
	  (save-excursion
	    (while (and (not done) (not (bobp)))
	      (forward-line -1)
	      (when (looking-at "^[ \t]*IF\\>") ;BAF or SSL IF
		(setq done t))
	      (when (looking-at "^[ \t]*BEGIN_ACTION_DEFINITION")
		(setq indent weidu-baf-indent-width)
		(setq indent-from (current-indentation))
		(setq done t)
		(setq indentedp t))))))
      ;;Indent RESPONSE
      (when (looking-at "^[ \t]*RESPONSE\\>")
	(while (and (not (looking-at "^[ \t]*\\(THEN\\|ACTION\\)\\>")) (not (bobp)))
	  (forward-line -1))
	(setq indent weidu-baf-indent-width)
	(setq indent-from (current-indentation))
	(setq indentedp t))
      ;;Keep opening statements from being indented if they are on the first line
      (when (and (bobp) (looking-at "^[ \t]*\\(IF\\|BEGIN_ACTION_DEFINITION\\|TRIGGER\\|TARGET\\|BEGIN LOOP\\|THEN\\|ACTION\\)\\>"))
	(setq indentedp t)
	(setq indent (current-indentation)))
      ;;Look for indentation clues on the lines above
      (while (not indentedp)
	(forward-line -1)
	(when (not (looking-at "^[ \t]*//")) ;do not count commented lines (may be a mistake, but it is probably preferable to counting them)
          (decf lines-moved))
	;;General-purpose increasing indentation
	(cond ((looking-at "^[ \t]*\\(IF\\|TRIGGER\\|TARGET\\|BEGIN_ACTION_DEFINITION\\|BEGIN LOOP\\)\\>")
	       (setq indent weidu-baf-indent-width)
	       (setq indent-from (current-indentation))
	       (setq indentedp t))
	      ;;If we've rolled all the way to BoB, abort the loop
	      ((bobp)
	       (setq indentedp t))
	      ;;Indent stuff inside OR triggers
	      ((and (looking-at "^[ \t]*OR\\>") (weidu-baf-within-or-p lines-moved))
	       (setq indent weidu-baf-indent-width)
	       (setq indent-from (current-indentation))
	       (setq indentedp t))
	      ;;Indent stuff under RESPONSEs
	      ((looking-at "^[ \t]*RESPONSE\\>")
	       (setq indent weidu-baf-indent-width)
	       (setq indent-from (current-indentation))
	       (setq indentedp t))
	      ;;Allow for THEN RESPONSE and THEN DO
	      ((looking-at "^[ \t]*\\(THEN[ \t]+RESPONSE\\|THEN[ \t]+DO\\)\\>")
	       (setq indent (* weidu-baf-indent-width 2))
	       (setq indent-from (current-indentation))
	       (setq indentedp t))
	      ;;If we come across an END LOOP, keep rolling and indent to the indentation of the BEGIN LOOP
	      ((looking-at "^[ \t]*END LOOP\\>")
	       (setq indent 0)
	       (let (done (open 0) (closed 0))
		 (while (and (not done) (not (bobp)))
		   (when (looking-at "^[ \t]*END LOOP\\>")
		     (incf closed))
		   (when (looking-at "^[ \t]*BEGIN LOOP\\>")
		     (incf open))
		   (when (= open closed)
		     (setq done t))
		   (unless done
		     (forward-line -1))))
	       (setq indent-from (current-indentation))
	       (setq indentedp t))
	      ;;If we come across an END, keep rolling and indent to the indentation of the IF
	      ((looking-at "^[ \t]*END\\>")
	       (setq indent 0)
	       (while (and (not (looking-at "^[ \t]*\\(IF\\|BEGIN_ACTION_DEFINITION\\)\\>")) (not (bobp)))
		 (forward-line -1))
	       (setq indent-from (current-indentation))
	       (setq indentedp t)))))
    (if (not fix-point)
	(indent-line-to (+ (or indent 0) (or indent-from 0)))
      (save-excursion
	(indent-line-to (+ (or indent 0) (or indent-from 0)))))))

(defun weidu-baf-within-or-p (lines-moved)
  "lines-moved is expected to be negative"
  (save-excursion
    (if (looking-at "^[ \t]*OR([0-9]+)")
        (save-match-data
          (re-search-forward "OR(\\(.*\\))")
          (let ((value (match-string 1)))
            (if (and (string-match "^[0-9]+$" value)
                     (>= (+ lines-moved (string-to-number value)) 0))
                t
              nil)))
      nil)))

;;OR(2)
;;  Foo
;;  Bar
;;Baz

(defun weidu-baf-indent-block ()
  "Indents the current block, from IF to END."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (unless (looking-at "^[ \t]*IF\\>")
      (while (and (not (bobp)) (not (looking-at "^[ \t]*IF\\>")) (not (looking-at "^[ \t]*END\\>")))
	(forward-line -1)))
    (when (looking-at "^[ \t]*IF\\>")
      (let (done)
	(while (null done)
	  (weidu-baf-indent-line)
	  (forward-line 1)
	  (when (eobp)
	    (setq done t))
	  (when (looking-at "^[ \t]*END\\>")
	    (weidu-baf-indent-line)
	    (setq done t)))))))

(defun weidu-baf-indent-buffer ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (while (not (eobp))
      (weidu-baf-indent-line)
      (forward-line 1))))

(defun weidu-baf-indent-newline-indent ()
  "Indents the current line, inserts a newline and indents while moving point."
  (interactive)
  (weidu-baf-indent-line t)
  (newline)
  (weidu-baf-indent-line))

(defvar weidu-baf-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?~ "$" table)
    (modify-syntax-entry ?\" "$" table)
    table))

;;;###autoload
(defun weidu-baf-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map weidu-baf-mode-map)
  (set-syntax-table weidu-baf-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(weidu-baf-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'weidu-baf-indent-line)
  (setq mode-name "WeiDU-BAF")
  (run-hooks 'weidu-general-hook 'weidu-baf-mode-hook)
  (setq major-mode 'weidu-baf-mode))

(provide 'weidu-baf-mode)
