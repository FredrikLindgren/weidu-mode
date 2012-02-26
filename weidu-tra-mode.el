
(defvar weidu-tra-mode-hook nil)

(add-to-list 'auto-mode-alist (cons "\\.[tT][rR][aA]\\'" 'weidu-tra-mode))

(defvar weidu-tra-traref "@[0-9]+")

(defvar weidu-tra-sndref "\[[a-zA-Z0-9!#_-]+\]")

(defvar weidu-tra-font-lock-keywords-1
  (list
   (cons weidu-tra-traref font-lock-variable-name-face)
   (cons weidu-tra-sndref font-lock-constant-face)))

(defvar weidu-tra-font-lock-keywords weidu-tra-font-lock-keywords-1)

(defvar weidu-tra-mode-map
  (let ((map (make-keymap)))
    map))

(defvar weidu-tra-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?~ "\"" table)
    table))

;;;###autoload
(defun weidu-tra-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map weidu-tra-mode-map)
  (set-syntax-table weidu-tra-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(weidu-tra-font-lock-keywords))
  (setq mode-name "WeiDU-TRA")
  (run-hooks 'weidu-tra-mode-hook)
  (setq major-mode 'weidu-tra-mode))

(provide 'weidu-tra-mode)
