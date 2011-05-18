
(defvar weidu-tp2-mode-hook nil)
;(defvar weidu-tp2-mode-map
;  (let ((map (make-keymap)))
;    (define-key map (kbd "RET") 'weidu-tp2-indent-newline-indent)
;    map))    

(add-to-list 'auto-mode-alist '("\\.[Tt][Pp][2AaHhPp]\\'" . weidu-tp2-mode))

(defvar weidu-tp2-patches (regexp-opt '("PATCH_DEFINE_ARRAY" "SET" "INSERT_FILE" "SPRINT" "PATCH_FAIL" "REPLACE" "DESCRIBE_ITEM" "READ_STRREF_S" "PATCH_SILENT" "PATCH_INCLUDE" "APPEND_FILE_EVALUATE" "SPRINTF" "INNER_ACTION" "WRITE_ASCII" "READ_STRREF_FS" "REMOVE_MEMORIZED_SPELL""INNER_PATCH" "SAY_EVALUATED" "COMPRESS_INTO_FILE" "SOURCE_BIFF" "PATCH_CLEAR_ARRAY" "REFACTOR_BAF_TRIGGER" "DECOMPILE_AND_PATCH" "REFACTOR_TRIGGER" "TO_LOWER" "WRITE_ASCII_TERMINATED" "DECOMPRESS_REPLACE_FILE" "APPLY_BCS_PATCH_OR_COPY" "REMOVE_CRE_ITEM" "PATCH_GAM" "ADD_MEMORIZED_SPELL" "EDIT_SAV_FILE" "READ_ASCII" "ADD_MAP_NOTE" "DEFINE_ASSOCIATIVE_ARRAY" "EVALUATE_BUFFER_SPECIAL" "PATCH_RANDOM_SEED" "EXTEND_MOS" "REMOVE_CRE_EFFECTS" "PATCH_LOG" "REMOVE_MEMORIZED_SPELLS" "ADD_CRE_ITEM" "READ_SHORT" "REBUILD_CRE_FILE" "READ_SLONG" "COMPRESS_REPLACE_FILE" "COUNT_REGEXP_INSTANCES" "PATCH_VERBOSE" "GET_STRREF_FS" "COMPRESS_INTO_VAR" "READ_BYTE" "PATCH_WARN" "REPLACE_BCS_BLOCK_REGEXP" "READ_STRREF_F" "REMOVE_KNOWN_SPELL" "DECOMPRESS_INTO_VAR" "SPACES" "REPLACE_BCS_BLOCK" "TEXT_SPRINT" "REMOVE_KNOWN_SPELLS" "PATCH_PHP_EACH" "WRITE_SHORT" "PATCH_RERAISE" "READ_STRREF" "COMPILE_D_TO_DLG" "SNPRINT" "APPEND_FILE" "ADD_STORE_ITEM" "WRITE_LONG" "REPLACE_EVALUATE" "PATCH_FOR_EACH" "PATCH_BASH_FOR" "PATCH_PRINT" "INNER_PATCH_SAVE" "READ_SBYTE" "DECOMPRESS_INTO_FILE" "REFACTOR_D_TRIGGER" "REMOVE_STORE_ITEM" "WRITE_BYTE" "GET_STRREF_F" "DELETE_BYTES" "COMPILE_BAF_TO_BCS" "LAUNCH_PATCH_MACRO" "WRITE_FILE" "DECOMPILE_BCS_TO_BAF" "INSERT_BYTES" "PATCH_REINCLUDE" "WRITE_EVALUATED_ASCII" "READ_SSHORT" "REMOVE_CRE_ITEMS" "REPLACE_TEXTUALLY""ADD_KNOWN_SPELL" "DECOMPILE_DLG_TO_D" "TO_UPPER" "APPLY_BCS_PATCH" "GET_STRREF" "READ_LONG" "PATCH_READLN" "QUOTE" "SAY" "INNER_PATCH_FILE" "GET_OFFSET_ARRAY" "LAUNCH_PATCH_FUNCTION" "REPLACE_CRE_ITEM" "SET_IDS_SYMBOL_OF_INT" "GET_STRREF_S" "A_B_P" "WRITE_ASCII_TERMINATE" "WRITE_ASCIIT" "WRITE_ASCIIE" "WRITE_ASCIIL" "ADD_GAM_NPC" "R_B_B" "R_B_B_RE" "CLEAR_ARRAY" "PHP_EACH" "LOOKUP_IDS_SYMBOL_OF_INT" "DEFINE_ARRAY" "ADD_GAME_NPC" "ADD_GAM_NPC" "PATCH_DEFINE_ASSOCIATIVE_ARRAY" "FOR" "WHILE" "LOCAL_SET" "LOCAL_SPRINT" "LOCAL_TEXT_SPRINT" "PRETTY_PRINT_2DA") 'words))

(defconst weidu-tp2-keywords (regexp-opt '("BEGIN" "END" "ELSE" "THEN" "PATCH_IF" "PATCH_TRY" "WITH" "PATCH_MATCH" "STR_VAR" "INT_VAR" "RET" "DEFAULT" "EQUIP" "CASE_INSENSITIVE" "CASE_SENSITIVE" "EXACT_MATCH" "EVALUATE_REGEXP" "ACTION_IF" "ACTION_TRY" "ACTION_MATCH" "WHEN" "ANY" "AUTHOR" "BACKUP" "ALWAYS" "LANGUAGE" "VERSION" "README" "AUTO_TRA" "NO_IF_EVAL_BUG" "MENU_STYLE" "ASK_EVERY_COMPONENT" "MODDER" "ALLOW_MISSING" "SCRIPT_STYLE" "UNINSTALL_ORDER" "QUICK_MENU" "ALWAYS_ASK" "SUBCOMPONENT" "SUB_COMPONENT" "FORCED_SUBCOMPONENT" "NO_LOG_RECORD" "DEPRECATED" "DESIGNATED" "REQUIRE_COMPONENT" "INSTALL_BY_DEFAULT" "FORBID_COMPONENT" "REQUIRE_PREDICATE" "GROUP" "LABEL" "USING" "TWOHANDED" "GLOB" "NOGLOB" "IF" "UNLESS" "IF_SIZE_IS" "IF_EVAL" "BUT_ONLY_IF_IT_CHANGES" "I_S_I" "BUT_ONLY" "AFTER" "BEFORE" "LAST" "FIRST" "AT" "EXACT" "NULL" "EVALUATE_BUFFER" "EVAL" "LOAD" "=>" "KEEP_CRLF" "IF_EXISTING" "ON_DISABLE" "IN" "AS" "ON_MISMATCH") 'words))

(defconst weidu-tp2-actions (regexp-opt '("VERBOSE" "ADD_MUSIC" "EXTEND_TOP" "ALTER_TLK" "FORBID_FILE" "COPY_EXISTING_REGEXP" "CLEAR_IDS_MAP" "APPEND" "CLEAR_EVERYTHING" "BIFF" "AT_NOW" "EXTEND_BOTTOM_REGEXP" "INCLUDE" "AT_INTERACTIVE_NOW" "ADD_SECTYPE" "EXTEND_BOTTOM" "COPY_KIT" "ADD_SCHOOL" "MKDIR" "ACTION_PHP_EACH" "AT_EXIT" "ALTER_TLK_LIST" "ACTION_FOR_EACH" "DEFINE_PATCH_MACRO" "ADD_KIT" "LAUNCH_ACTION_MACRO" "COPY_EXISTING" "MOVE" "RANDOM_SEED" "ADD_SPELL" "ACTION_CLEAR_ARRAY" "COPY_ALL_GAM_FILES" "WARN" "OUTER_PATCH_SAVE" "OUTER_TEXT_SPRINT" "COPY_LARGE" "PRINT" "ALTER_TLK_RANGE" "REQUIRE_FILE" "GET_FILE_ARRAY" "GET_DIRECTORY_ARRAY" "OUTER_SET" "LAUNCH_ACTION_FUNCTION" "ACTION_DEFINE_ASSOCIATIVE_ARRAY" "DEFINE_PATCH_FUNCTION" "REINCLUDE" "COPY_RANDOM" "ACTION_RERAISE" "AT_UNINSTALL_EXIT" "AT_INTERACTIVE_UNINSTALL_EXIT" "COMPILE" "APPEND_COL" "OUTER_PATCH" "STRING_SET_EVALUATE" "ACTION_READLN" "OUTER_SPRINT" "<<<<<<<<" ">>>>>>>>" "AT_INTERACTIVE_UNINSTALL" "EXTEND_TOP_REGEXP" "CLEAR_MEMORY" "COPY" "CLEAR_INLINED" "LOAD_TRA" "CLEAR_ARRAYS" "ACTION_DEFINE_ARRAY" "AT_UNINSTALL" "ADD_PROJECTILE" "LOG" "CLEAR_CODES" "FAIL" "SILENT" "APPEND_OUTER" "STRING_SET_RANGE" "DISABLE_FROM_KEY" "DECOMPRESS_BIFF" "DEFINE_ACTION_FUNCTION" "STRING_SET" "ADD_AREA_TYPE" "ACTION_BASH_FOR" "AT_INTERACTIVE_EXIT" "UNINSTALL" "DEFINE_ACTION_MACRO" "MAKE_BIFF" "DEFINE_MACRO_ACTION" "DEFINE_MACRO_PATCH" "DEFINE_FUNCTION_PATCH" "DEFINE_FUNCTION_ACTION" "ACTION_INCLUDE" "LAUNCH_MACRO_ACTION" "LAM" "LAUNCH_FUNCTION_PATCH" "LPF" "LAUNCH_FUNCTION_ACTION" "LAF" "OUTER_INNER_PATCH" "OUTER_INNER_PATCH_SAVE" "ACTION_REINCLUDE" "LAUNCH_MACRO_PATCH" "LPM" "OUTER_FOR" "OUTER_WHILE") 'words))

(defconst weidu-tp2-constants (regexp-opt '("ITM_V10_HEAD_EFFECTS" "ITM_V10_HEADERS" "ITM_V10_GEN_EFFECTS" "WMP_AREAS" "WMP_LINKS" "AREA_CITY" "AREA_DAY" "AREA_DUNGEON" "AREA_FOREST" "AREA_NIGHT" "ATTACK1" "ATTACK2" "ATTACK3" "ATTACK4" "BATTLE_CRY1" "BATTLE_CRY2" "BATTLE_CRY3" "BATTLE_CRY4" "BATTLE_CRY5" "BIO" "BORED" "COMPLIMENT1" "COMPLIMENT2" "COMPLIMENT3" "CRITICAL_HIT" "CRITICAL_MISS" "DAMAGE" "DESC" "DIALOGUE_DEFAULT" "DIALOGUE_HOSTILE" "DYING" "EXISTANCE1" "EXISTANCE2" "EXISTANCE3" "EXISTANCE4" "EXISTANCE5" "HAPPY" "HURT" "IDENTIFIED_DESC" "INITIAL_MEETING" "INSULT" "INTERACTION1" "INTERACTION2" "INTERACTION3" "INTERACTION4" "INTERACTION5" "INVENTORY_FULL" "LEADER" "MISCELLANEOUS" "MORALE" "NAME1" "NAME2" "PICKED_POCKET" "REACT_TO_DIE_GENERAL" "REACT_TO_DIE_SPECIFIC" "RESPONSE_TO_COMPLIMENT2" "RESPONSE_TO_COMPLIMENT3" "RESPONSE_TO_INSULT1" "RESPONSE_TO_INSULT2" "RESPONSE_TO_INSULT3" "SELECT_ACTION1" "SELECT_ACTION2" "SELECT_ACTION3" "SELECT_ACTION4" "SELECT_ACTION5" "SELECT_ACTION6" "SELECT_ACTION7" "SELECT_COMMON1" "SELECT_COMMON2" "SELECT_COMMON3" "SELECT_COMMON4" "SELECT_COMMON5" "SELECT_COMMON6" "SELECT_RARE1" "SELECT_RARE2" "SPECIAL1" "SPECIAL2" "SPECIAL3" "TARGET_IMMUNE" "TIRED" "UNHAPPY_ANNOYED" "UNHAPPY_BREAKING" "UNHAPPY_SERIOUS" "UNIDENTIFIED_DESC" "HIDDEN_IN_SHADOWS" "SPELL_DISRUPTED" "SET_A_TRAP" "STORE_NAME" "SCRIPT_OVERRIDE" "SCRIPT_CLASS" "SCRIPT_RACE" "SCRIPT_GENERAL" "SCRIPT_DEFAULT" "DEATHVAR" "DIALOG" "AREA_SCRIPT" "WNL" "MNL" "LNL" "TAB" "REGISTRY_BG1_PATH" "REGISTRY_BG2_PATH" "REGISTRY_PST_PATH" "REGISTRY_IWD1_PATH" "REGISTRY_IWD2_PATH" "BIT0" "BIT1" "BIT2" "BIT3" "BIT4" "BIT5" "BIT6" "BIT7" "BIT8" "BIT9" "BIT10" "BIT11" "BIT12" "BIT13" "BIT14" "BIT15" "BIT16" "BIT17" "BIT18" "BIT19" "BIT20" "BIT21" "BIT22" "BIT23" "BIT24" "BIT25" "BIT26" "BIT27" "BIT28" "BIT29" "BIT30" "BIT31") 'words))

(defconst weidu-tp2-values (regexp-opt '("STRING_COMPARE" "STR_CMP" "STRING_COMPARE_CASE" "STRING_EQUAL" "STRING_EQUAL_CASE" "STRING_MATCHES_REGEXP" "STRING_COMPARE_REGEXP" "STRING_CONTAINS_REGEXP" "BYTE_AT" "SBYTE_AT" "SHORT_AT" "SSHORT_AT" "LONG_AT" "SLONG_AT" "RANDOM" "BUFFER_LENGTH" "STRING_LENGTH" "INDEX" "RINDEX" "INDEX_BUFFER" "RINDEX_BUFFER" "FILE_CONTAINS_EVALUATED" "FILE_EXISTS" "BIFF_IS_COMPRESSED" "FILE_IS_IN_COMPRESSED_BIF" "FILE_IS_IN_COMPRESSED_BIFF" "FILE_MD5" "FILE_EXISTS_IN_GAME" "FILE_SIZE" "FILE_CONTAINS" "NOT" "AND" "OR" "BAND" "BOR" "BNOT" "ABS" "BXOR" "BLSL" "BLSR" "BASR" "MOD_IS_INSTALLED" "INSTALL_ORDER" "ID_OF_LABEL" "GAME_IS" "ENGINE_IS" "VARIABLE_IS_SET" "IDS_OF_SYMBOL" "STATE_WHICH_SAYS" "IS_AN_INT" "TRA_ENTRY_EXISTS" "RESOLVE_STR_REF" "IS_SILENT" "SOURCE_DIRECTORY" "SOURCE_FILESPEC" "SOURCE_FILE" "SOURCE_RES" "SOURCE_EXT" "SOURCE_SIZE" "DEST_DIRECTORY" "DEST_FILESPEC" "DEST_FILE" "DEST_RES" "DEST_EXT" "COMPONENT_NUMBER" "BASH_FOR_DIRECTORY" "BASH_FOR_FILESPEC" "BASH_FOR_FILE" "BASH_FOR_RES" "BASH_FOR_SIZE" "WEIDU_ARCH" "WEIDU_OS" "INTERACTIVE") 'words))

; "!" "<<" ">>" "&&" "||" "&" "|" "`" "=" "!=" ">=" "<=" "^^" "^" "**" "+" "-" "*" "/" ":" "?" "$" ">" "<" "+=" "-=" "*=" "/=" "|=" "&=" "<<=" ">>=" "^^=" "++" "--"

(defconst weidu-tp2-decial-values "\\<[0-9]+\\>")
(defconst weidu-tp2-hex-values "\\<0[xX][0-9A-Fa-f]+\\>")
(defconst weidu-tp2-octal-values "\\<0[oO][0-7]+\\>")
(defconst weidu-tp2-bin-values "\\<0[bB][01]+\\>")

(defconst weidu-tp2-wrong-hex-values "\\<0[cC][0-9A-Fa-f]+\\>")

(defconst weidu-tp2-functions (regexp-opt '("fj_are_structure" "FJ_CRE_VALIDITY" "RES_NUM_OF_SPELL_NAME" "RES_NAME_OF_SPELL_NUM" "NAME_NUM_OF_SPELL_RES" "GET_UNIQUE_FILE_NAME" "ADD_AREA_REGION_TRIGGER" "T-CRE_EFF_V1" "FJ_CRE_EFF_V2" "FJ_CRE_REINDEX" "WRITE_SOUNDSET" "READ_SOUNDSET" "SET_CRE_ITEM_FLAGS" "REMOVE_CRE_ITEM_FLAGS" "ADD_CRE_ITEM_FLAGS" "ADD_AREA_ITEM" "REPLACE_AREA_ITEM" "REPLACE_STORE_ITEM" "DELETE_AREA_ITEM" "DELETE_STORE_ITEM" "DELETE_CRE_ITEM" "ADD_CRE_EFFECT" "ADD_ITEM_EQEFFECT" "ADD_ITEM_EFFECT" "ADD_SPELL_EFFECT" "ITEM_EFFECT_TO_SPELL" "DELETE_CRE_EFFECT" "DELETE_ITEM_EQEFFECT" "DELETE_ITEM_EFFECT" "DELETE_SPELL_EFFECT" "tb#fix_file_size" "tb#factorial" "sc#addWmpAre") 'words))

(defconst weidu-tp2-font-lock-keywords-1
  (list
   (cons weidu-tp2-patches font-lock-function-name-face)
   (cons weidu-tp2-actions font-lock-type-face)
   (cons weidu-tp2-keywords font-lock-keyword-face)
   (cons weidu-tp2-constants font-lock-constant-face)
   (cons weidu-tp2-values font-lock-variable-name-face)
   ;(cons weidu-tp2-decimal-values font-lock-variable-name-face)
   ;(cons weidu-tp2-hex-values font-lock-variable-name-face)
   ;(cons weidu-tp2-octal-values font-lock-variable-name-face)
   ;(cons weidu-tp2-binary-values font-lock-variable-name-face)
   (cons weidu-tp2-wrong-hex-values font-lock-warning-face)
   (cons weidu-tp2-functions font-lock-builtin-face)))

(defvar weidu-tp2-font-lock-keywords weidu-tp2-font-lock-keywords-1)


(defvar weidu-tp2-indent-width 2)

;If the current line starts with END, find the open BEGIN (also, function calls) and indent to the level of that line
;If the current line is a when (BUT_ONLY), find the COPY and indent to the level of that line
;If the current line is one of INT_VAR, STR_VAR, RET and it's below a function, indent to function +1
;
;If a line above has an unclosed BEGIN, indent +1
;If a line above has a WITH, indent +1 (MATCH)
;If a line above begins with a INT_VAR, STR_VAR or RET, indent +1
;If a line above is a COPY and I'm a patch, indent +1
;If a line above is a COPY and I'm an action, indent to indentation of the COPY
;If all else fails, indent to the first non-trailing whitespace on the line above (0 if there is none)?
;;Needs a good rewrite
;(defun weidu-tp2-indent-line (&optional move-point)
;  (interactive)
;  (let (indentedp
;	indent
;	(when-clauses (concat "^[ \t]*" (regexp-opt '("IF" "UNLESS" "BUT_ONLY" "IF_SIZE_IS" "I_S_I") 'words)))
;	(fun-keys (concat "^[ \t]*" (regexp-opt '("INT_VAR" "STR_VAR" "RET") 'words))))
;    (save-excursion
;      (beginning-of-line)
;      (when (looking-at when-clauses)
;	(setq indent (weidu-tp2-get-indentation 'when)) ;write this
;	(setq indentedp t))
;      (when (looking-at "^[ \t]*END")
;	(setq indent (weidu-tp2-get-indentation 'end))
;	(setq indentedp t))
;      (when (looking-at fun-keys)
;	(setq indent (weidu-tp2-get-indentation 'fun-keys))
;	(setq indentedp t))
;      )))

(defvar weidu-tp2-end-openings (regexp-opt '("BEGIN" "LAUNCH_ACTION_FUNCTION" "LAUNCH_FUNCTION_ACTION" "LAM" "LAUNCH_PATCH_FUNCTION" "LAUNCH_FUNCTION_PATCH" "LPF" "ACTION_MATCH" "ACTION_TRY" "PATCH_MATCH" "PATCH_TRY" "IF_EXISTING" "ON_DISABLE") 'words))

(defun weidu-tp2-indent-line (&optional move-point)
  (interactive)
  (let (indentedp
	indent)
    (save-excursion
      (beginning-of-line)
      (when (looking-at "^[ \t]*END\\>")
	(setq indent (weidu-tp2-indent-end))
	(setq indentedp t))
      ;(when (looking-at (concat "^[ \t]" when-clauses)) ;write this
        ;(setq indent (weidu-tp2-indent-when)) ;and this
	;(setq indentedp t)))
      )
    (if move-point
	(indent-line-to indent)
        (save-excursion
	  (indent-line-to indent)))))

(defun weidu-tp2-indent-end ()
  (save-excursion
    (let (done
	  (num-open 0)
	  (num-close 0))
      (while (and (not done) (not (bobp))) ;This will misbehave if the first line is indented and relevant
	(when (looking-at ".*\\<END\\>")
	  (incf num-close))
	(when (looking-at (concat ".*" weidu-tp2-end-openings))
	  (incf num-open))
	(when (= num-open num-close)
	  (setq done t)
	  (while (not (looking-at weidu-tp2-end-openings))
	    (forward-char)))
	(unless done
	  (forward-line -1)))
      (current-indentation))))

;;This function is bunk. We need something more syntax-aware (hence also specialised).
;(defun weidu-tp2-get-indentation (arg) ;can probably move these out and send them in as the arg itself - nope, we need a keyword
;  (let* ((when-paired (regexp-opt '("COPY" "COPY_EXISTING" "COPY_EXISTING_REGEXP" "COPY_RANDOM" "COPY_ALL_GAM_FILES" "APPEND" "APPEND_OUTER" "APPEND_COL" "ADD_SPELL") 'words))
;	 (when-clause (regexp-opt '("BUT_ONLY" "BUT_ONLY_IF_IT_CHANGES" "IF" "UNLESS" "IF_SIZE_IS" "I_S_I") 'words))
;	 (end-paired (regexp-opt '("BEGIN" "LAUNCH_ACTION_FUNCTION" "LAUNCH_FUNCTION_ACTION" "LAM" "LAUNCH_PATCH_FUNCTION" "LAUNCH_FUNCTION_PATCH" "LPF" "ACTION_MATCH" "ACTION_TRY" "PATCH_MATCH" "PATCH_TRY" "IF_EXISTING" "ON_DISABLE") 'words))
;	 (fun-paired (regexp-opt '("LAUNCH_ACTION_FUNCTION" "LAUNCH_FUNCTION_ACTION" "LAM" "LAUNCH_PATCH_FUNCTION" "LAUNCH_FUNCTION_PATCH" "LPF" "DEFINE_ACTION_FUNCTION" "DEFINE_PATCH_FUNCTION") 'words))
;	 (looking-for (cond ((string-equal arg 'when) when-paired)
;			    ((string-equal arg 'end) end-paired)
;			    ((string-equal arg 'fun-keys) fun-paired)))
;	 done
;	 (num-open 0)
;	 (num-close 0))
;    (save-excursion
;      (while (not done) ;this doesn't work because when-clauses are optional
;	(when (and (string-equal arg 'when) (looking-at when-clause))
;	  (incf num-close))
;	(when (and (string-equal arg 'when) (looking-at when-paired))
;	  (incf num-open))
;	(when (and (string-equal arg 'end) (looking-at "^[ \t]*END"))
;	  (incf num-close))
;	(when (and (string-equal arg 'end) (looking-at end-paired))
;	  (incf num-open))
;	;(when (and (string-equal arg 'fun-keys) (looking-at 
;	(when (= num-open num-close)
;	  (setq done t)
;	  ;get indentation of the opening line and return it
;	  (while (not (looking-at "[^ \t]"))
;	    (forward-char)))
;	(unless done
;	  (forward-line -1)))
;      (current-indentation))))

(defvar weidu-tp2-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    table))

(defun weidu-tp2-mode ()
  (interactive)
  (kill-all-local-variables)
  ;(use-local-map weidu-tp2-mode-map)
  (set-syntax-table weidu-tp2-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(weidu-tp2-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'weidu-tp2-indent-line)
  (setq mode-name "WeiDU-TP2")
  (run-hooks 'weidu-tp2-mode-hook)
  (setq major-mode 'weidu-tp2-mode))

(provide 'weidu-tp2-mode)