
(defcustom weidu-d-indent-width 2
  "Width of indentation"
  :type 'integer)

(defvar weidu-d-mode-hook nil)

(defvar weidu-d-mode-map
  (let ((map (make-keymap)))
    ;;(define-key map (kbd "RET") 'weidu-d-indent-newline-indent)
    map))

(add-to-list 'auto-mode-alist (cons "\\.[dD]\\'" 'weidu-d-mode))

(require 'weidu-mode-library-bg)

(defvar weidu-d-keywords (regexp-opt '("IF" "THEN" "BEGIN" "SAY" "END" "REPLY" "GOTO" "EXIT" "WEIGHT" "DO" "JOURNAL" "UNSOLVED_JOURNAL" "SOLVED_JOURNAL" "FLAGS" "EXTERN" "BRANCH" "AT" "UNLESS" "COPY_TRANS" "COPY_TRANS_LATE" "IF_FILE_EXISTS") 'words)) ;+ and =
;BEGIN is both a keyword and a builtin, look into differentiating them by context; or APPEND is a keyword rather than a builtin
(defvar weidu-d-builtins (regexp-opt '("APPEND" "APPEND_EARLY" "CHAIN" "INTERJECT" "INTERJECT_COPY_TRANS" "INTERJECT_COPY_TRANS2" "INTERJECT_COPY_TRANS3" "INTERJECT_COPY_TRANS4" "EXTEND_TOP" "EXTEND_BOTTOM" "ADD_STATE_TRIGGER" "ADD_TRANS_TRIGGER" "ADD_TRANS_ACTION" "REPLACE_TRANS_ACTION" "REPLACE_TRANS_TRIGGER" "ALTER_TRANS" "REPLACE" "SET_WEIGHT" "REPLACE_SAY" "REPLACE_STATE_TRIGGER" "REPLACE_TRIGGER_TEXT" "REPLACE_TRIGGER_TEXT_REGEXP" "REPLACE_ACTION_TEXT" "REPLACE_ACTION_TEXT_REGEXP" "REPLACE_ACTION_TEXT_PROCESS" "REPLACE_ACTION_TEXT_PROCESS_REGEXP" "R_A_T_P_R" "A_S_T" "A_T_T" "I_C_T" "I_C_T2" "I_C_T3" "I_C_T4" "R_A_T" "R_S_T" "R_T_T") 'words))

(defvar weidu-d-deprecated (regexp-opt '("APPENDI" "CHAIN2")))

(defvar weidu-d-font-lock-keywords-1
  (list
   (cons weidu-bg-triggers font-lock-function-name-face)
   (cons weidu-bg-actions font-lock-function-name-face)
   (cons weidu-bg-constants font-lock-constant-face)
   (cons weidu-bg-objects font-lock-type-face)
   (cons weidu-d-deprecated font-lock-warning-face)
   (cons weidu-d-keywords font-lock-keyword-face)
   (cons weidu-d-builtins font-lock-builtin-face)))

(defvar weidu-d-font-lock-keywords weidu-d-font-lock-keywords-1)

(defun weidu-d-indent-line (&optional fix-point)
  "Indents the current line and optionally moves point to the end of the inserted whitespace"
  (interactive)
  (let (indentedp               ;Are we finished with this line?
        indent                  ;How much to indent
        (lines-moved 0)         ;For keeping track of ORs   
        (case-fold-search nil)) ;Case-sensitive regexps
    (save-excursion
      (beginning-of-line)
      
      )
    ))

(defvar weidu-d-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    table))

;;;###autoload
(defun weidu-d-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map weidu-d-mode-map)
  (set-syntax-table weidu-d-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(weidu-d-font-lock-keywords))
  ;;(set (make-local-variable 'indent-line-function) 'weidu-d-indent-line)
  (setq mode-name "WeiDU-D")
  (run-hooks 'weidu-d-mode-hook)
  (setq major-mode 'weidu-d-mode))

(provide 'weidu-d-mode)
