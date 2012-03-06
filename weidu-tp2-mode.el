
;;;Redesign:
;;Have one function for indenting actions and another for indenting patches
;;The main function does context-sensitive dispatch

;;;Known issues:
;;Does not support commenting code with multi-line comments; use single-line comments instead

;;no indent-newline-indent; just newline-indent

(defvar weidu-tp2-mode-hook nil)
(defvar weidu-tp2-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "RET") 'weidu-tp2-indent-newline-indent)
    map))    

(add-to-list 'auto-mode-alist '("\\.[Tt][Pp][2AaHhPp]\\'" . weidu-tp2-mode))

(defvar weidu-tp2-patches (regexp-opt '("PATCH_DEFINE_ARRAY" "SET" "INSERT_FILE" "SPRINT" "PATCH_FAIL" "REPLACE" "DESCRIBE_ITEM" "READ_STRREF_S" "PATCH_SILENT" "PATCH_INCLUDE" "APPEND_FILE_EVALUATE" "SPRINTF" "WRITE_ASCII" "READ_STRREF_FS" "REMOVE_MEMORIZED_SPELL" "SAY_EVALUATED" "COMPRESS_INTO_FILE" "SOURCE_BIFF" "PATCH_CLEAR_ARRAY" "REFACTOR_BAF_TRIGGER" "DECOMPILE_AND_PATCH" "REFACTOR_TRIGGER" "TO_LOWER" "WRITE_ASCII_TERMINATED" "DECOMPRESS_REPLACE_FILE" "APPLY_BCS_PATCH_OR_COPY" "REMOVE_CRE_ITEM" "PATCH_GAM" "ADD_MEMORIZED_SPELL" "EDIT_SAV_FILE" "READ_ASCII" "ADD_MAP_NOTE" "DEFINE_ASSOCIATIVE_ARRAY" "EVALUATE_BUFFER_SPECIAL" "PATCH_RANDOM_SEED" "EXTEND_MOS" "REMOVE_CRE_EFFECTS" "PATCH_LOG" "REMOVE_MEMORIZED_SPELLS" "ADD_CRE_ITEM" "READ_SHORT" "REBUILD_CRE_FILE" "READ_SLONG" "COMPRESS_REPLACE_FILE" "COUNT_REGEXP_INSTANCES" "PATCH_VERBOSE" "GET_STRREF_FS" "COMPRESS_INTO_VAR" "READ_BYTE" "PATCH_WARN" "REPLACE_BCS_BLOCK_REGEXP" "READ_STRREF_F" "REMOVE_KNOWN_SPELL" "DECOMPRESS_INTO_VAR" "SPACES" "REPLACE_BCS_BLOCK" "TEXT_SPRINT" "REMOVE_KNOWN_SPELLS" "WRITE_SHORT" "PATCH_RERAISE" "READ_STRREF" "COMPILE_D_TO_DLG" "SNPRINT" "APPEND_FILE" "ADD_STORE_ITEM" "WRITE_LONG" "REPLACE_EVALUATE" "PATCH_PRINT" "READ_SBYTE" "DECOMPRESS_INTO_FILE" "REFACTOR_D_TRIGGER" "REMOVE_STORE_ITEM" "WRITE_BYTE" "GET_STRREF_F" "DELETE_BYTES" "COMPILE_BAF_TO_BCS" "LAUNCH_PATCH_MACRO" "WRITE_FILE" "DECOMPILE_BCS_TO_BAF" "INSERT_BYTES" "PATCH_REINCLUDE" "WRITE_EVALUATED_ASCII" "READ_SSHORT" "REMOVE_CRE_ITEMS" "REPLACE_TEXTUALLY" "ADD_KNOWN_SPELL" "DECOMPILE_DLG_TO_D" "TO_UPPER" "APPLY_BCS_PATCH" "GET_STRREF" "READ_LONG" "PATCH_READLN" "QUOTE" "SAY" "GET_OFFSET_ARRAY" "GET_OFFSET_ARRAY2" "LAUNCH_PATCH_FUNCTION" "REPLACE_CRE_ITEM" "SET_IDS_SYMBOL_OF_INT" "GET_STRREF_S" "A_B_P" "WRITE_ASCII_TERMINATE" "WRITE_ASCIIT" "WRITE_ASCIIE" "WRITE_ASCII_LIST" "WRITE_ASCIIL" "ADD_GAM_NPC" "R_B_B" "R_B_B_RE" "CLEAR_ARRAY" "LOOKUP_IDS_SYMBOL_OF_INT" "DEFINE_ARRAY" "ADD_GAME_NPC" "ADD_GAM_NPC" "PATCH_DEFINE_ASSOCIATIVE_ARRAY" "LOCAL_SET" "LOCAL_SPRINT" "LOCAL_TEXT_SPRINT" "PRETTY_PRINT_2DA" "SET_2DA_ENTRY" "READ_2DA_ENTRY" "READ_2DA_ENTRIES_NOW" "READ_2DA_ENTRY_FORMER" "SET_2DA_ENTRY_LATER" "SET_2DA_ENTRIES_NOW" "INSERT_2DA_ROW" "COUNT_2DA_ROWS" "COUNT_2DA_COLS" "LAUNCH_MACRO_PATCH" "LPM" "LAUNCH_FUNCTION_PATCH" "LPF" "PATCH_IF" "EVALUATE_BUFFER" "EVAL"  "INNER_ACTION" "INNER_PATCH" "PATCH_PHP_EACH" "PATCH_FOR_EACH" "PATCH_BASH_FOR" "INNER_PATCH_SAVE" "INNER_PATCH_FILE" "PHP_EACH" "FOR" "WHILE" "PATCH_TRY" "PATCH_MATCH") 'words))

;;These get their context from the LPMs, LAMs, etc
(defvar weidu-tp2-builtin-functions (regexp-opt '("fj_are_structure" "FJ_CRE_VALIDITY" "RES_NUM_OF_SPELL_NAME" "RES_NAME_OF_SPELL_NUM" "NAME_NUM_OF_SPELL_RES" "GET_UNIQUE_FILE_NAME" "ADD_AREA_REGION_TRIGGER" "T-CRE_EFF_V1" "FJ_CRE_EFF_V2" "FJ_CRE_REINDEX" "WRITE_SOUNDSET" "READ_SOUNDSET" "SET_CRE_ITEM_FLAGS" "REMOVE_CRE_ITEM_FLAGS" "ADD_CRE_ITEM_FLAGS" "ADD_AREA_ITEM" "REPLACE_AREA_ITEM" "REPLACE_STORE_ITEM" "DELETE_AREA_ITEM" "DELETE_STORE_ITEM" "DELETE_CRE_ITEM" "ADD_CRE_EFFECT" "ADD_ITEM_EQEFFECT" "ADD_ITEM_EFFECT" "ADD_SPELL_EFFECT" "ITEM_EFFECT_TO_SPELL" "DELETE_CRE_EFFECT" "DELETE_ITEM_EQEFFECT" "DELETE_ITEM_EFFECT" "DELETE_SPELL_EFFECT" "tb#fix_file_size" "tb#factorial" "sc#addWmpAre") 'words))

(defvar weidu-tp2-keywords (regexp-opt '("BEGIN" "END" "ELSE" "THEN" "PATCH_IF" "PATCH_TRY" "WITH" "PATCH_MATCH" "STR_VAR" "INT_VAR" "RET" "DEFAULT" "EQUIP" "CASE_INSENSITIVE" "CASE_SENSITIVE" "EXACT_MATCH" "EVALUATE_REGEXP" "ACTION_IF" "ACTION_TRY" "ACTION_MATCH" "WHEN" "ANY" "AUTHOR" "BACKUP" "ALWAYS" "LANGUAGE" "VERSION" "README" "AUTO_TRA" "NO_IF_EVAL_BUG" "MENU_STYLE" "ASK_EVERY_COMPONENT" "MODDER" "ALLOW_MISSING" "SCRIPT_STYLE" "UNINSTALL_ORDER" "QUICK_MENU" "ALWAYS_ASK" "SUBCOMPONENT" "SUB_COMPONENT" "FORCED_SUBCOMPONENT" "NO_LOG_RECORD" "DEPRECATED" "DESIGNATED" "REQUIRE_COMPONENT" "INSTALL_BY_DEFAULT" "FORBID_COMPONENT" "REQUIRE_PREDICATE" "GROUP" "LABEL" "USING" "TWOHANDED" "GLOB" "NOGLOB" "IF" "UNLESS" "IF_SIZE_IS" "IF_EVAL" "BUT_ONLY_IF_IT_CHANGES" "I_S_I" "BUT_ONLY" "AFTER" "BEFORE" "LAST" "FIRST" "AT" "EXACT" "NULL" "EVALUATE_BUFFER" "EVAL" "LOAD" "KEEP_CRLF" "IF_EXISTING" "ON_DISABLE" "IN" "AS" "ON_MISMATCH" "OUTER_PATCH" "OUTER_INNER_PATCH" "OUTER_PATCH_SAVE" "OUTER_INNER_PATCH_SAVE" "ACTION_MATCH" "ACTION_TRY" "THIS" "INNER_ACTION" "INNER_PATCH" "PATCH_PHP_EACH" "PATCH_FOR_EACH" "PATCH_BASH_FOR" "INNER_PATCH_SAVE" "INNER_PATCH_FILE" "PHP_EACH" "FOR" "WHILE" "PATCH_TRY" "PATCH_MATCH" "ACTION_PHP_EACH" "ACTION_BASH_FOR" "OUTER_FOR" "OUTER_WHILE" "ACTION_IF") 'words))

(defvar weidu-tp2-actions (regexp-opt '("VERBOSE" "ADD_MUSIC" "EXTEND_TOP" "ALTER_TLK" "FORBID_FILE" "COPY_EXISTING_REGEXP" "CLEAR_IDS_MAP" "APPEND" "CLEAR_EVERYTHING" "BIFF" "AT_NOW" "EXTEND_BOTTOM_REGEXP" "INCLUDE" "AT_INTERACTIVE_NOW" "ADD_SECTYPE" "EXTEND_BOTTOM" "COPY_KIT" "ADD_SCHOOL" "MKDIR" "AT_EXIT" "ALTER_TLK_LIST" "ACTION_FOR_EACH" "DEFINE_PATCH_MACRO" "ADD_KIT" "LAUNCH_ACTION_MACRO" "COPY_EXISTING" "MOVE" "RANDOM_SEED" "ADD_SPELL" "ACTION_CLEAR_ARRAY" "COPY_ALL_GAM_FILES" "WARN" "OUTER_TEXT_SPRINT" "COPY_LARGE" "PRINT" "ALTER_TLK_RANGE" "REQUIRE_FILE" "GET_FILE_ARRAY" "GET_DIRECTORY_ARRAY" "OUTER_SET" "LAUNCH_ACTION_FUNCTION" "ACTION_DEFINE_ASSOCIATIVE_ARRAY" "DEFINE_PATCH_FUNCTION" "REINCLUDE" "COPY_RANDOM" "ACTION_RERAISE" "AT_UNINSTALL_EXIT" "AT_INTERACTIVE_UNINSTALL_EXIT" "COMPILE" "APPEND_COL" "OUTER_PATCH" "STRING_SET_EVALUATE" "ACTION_READLN" "OUTER_SPRINT" "AT_INTERACTIVE_UNINSTALL" "EXTEND_TOP_REGEXP" "CLEAR_MEMORY" "COPY" "CLEAR_INLINED" "LOAD_TRA" "CLEAR_ARRAYS" "ACTION_DEFINE_ARRAY" "AT_UNINSTALL" "ADD_PROJECTILE" "LOG" "CLEAR_CODES" "FAIL" "SILENT" "APPEND_OUTER" "STRING_SET_RANGE" "DISABLE_FROM_KEY" "DECOMPRESS_BIFF" "DEFINE_ACTION_FUNCTION" "STRING_SET" "ADD_AREA_TYPE" "AT_INTERACTIVE_EXIT" "UNINSTALL" "DEFINE_ACTION_MACRO" "MAKE_BIFF" "DEFINE_MACRO_ACTION" "DEFINE_MACRO_PATCH" "DEFINE_FUNCTION_PATCH" "DEFINE_FUNCTION_ACTION" "ACTION_INCLUDE" "LAUNCH_MACRO_ACTION" "LAM" "LAUNCH_FUNCTION_ACTION" "LAF" "ACTION_REINCLUDE" "APPEND_COL_OUTER" "ACTION_TO_UPPER" "ACTION_TO_LOWER" "ACTION_GET_STRREF" "ACTION_PHP_EACH" "OUTER_PATCH_SAVE" "ACTION_BASH_FOR" "OUTER_INNER_PATCH" "OUTER_INNER_PATCH_SAVE" "OUTER_FOR" "OUTER_WHILE" "ACTION_IF" "ACTION_TRY" "ACTION_MATCH") 'words))

(defvar weidu-tp2-constants (regexp-opt '("ITM_V10_HEAD_EFFECTS" "ITM_V10_HEADERS" "ITM_V10_GEN_EFFECTS" "WMP_AREAS" "WMP_LINKS" "AREA_CITY" "AREA_DAY" "AREA_DUNGEON" "AREA_FOREST" "AREA_NIGHT" "ATTACK1" "ATTACK2" "ATTACK3" "ATTACK4" "BATTLE_CRY1" "BATTLE_CRY2" "BATTLE_CRY3" "BATTLE_CRY4" "BATTLE_CRY5" "BIO" "BORED" "COMPLIMENT1" "COMPLIMENT2" "COMPLIMENT3" "CRITICAL_HIT" "CRITICAL_MISS" "DAMAGE" "DESC" "DIALOGUE_DEFAULT" "DIALOGUE_HOSTILE" "DYING" "EXISTANCE1" "EXISTANCE2" "EXISTANCE3" "EXISTANCE4" "EXISTANCE5" "HAPPY" "HURT" "IDENTIFIED_DESC" "INITIAL_MEETING" "INSULT" "INTERACTION1" "INTERACTION2" "INTERACTION3" "INTERACTION4" "INTERACTION5" "INVENTORY_FULL" "LEADER" "MISCELLANEOUS" "MORALE" "NAME1" "NAME2" "PICKED_POCKET" "REACT_TO_DIE_GENERAL" "REACT_TO_DIE_SPECIFIC" "RESPONSE_TO_COMPLIMENT2" "RESPONSE_TO_COMPLIMENT3" "RESPONSE_TO_INSULT1" "RESPONSE_TO_INSULT2" "RESPONSE_TO_INSULT3" "SELECT_ACTION1" "SELECT_ACTION2" "SELECT_ACTION3" "SELECT_ACTION4" "SELECT_ACTION5" "SELECT_ACTION6" "SELECT_ACTION7" "SELECT_COMMON1" "SELECT_COMMON2" "SELECT_COMMON3" "SELECT_COMMON4" "SELECT_COMMON5" "SELECT_COMMON6" "SELECT_RARE1" "SELECT_RARE2" "SPECIAL1" "SPECIAL2" "SPECIAL3" "TARGET_IMMUNE" "TIRED" "UNHAPPY_ANNOYED" "UNHAPPY_BREAKING" "UNHAPPY_SERIOUS" "UNIDENTIFIED_DESC" "HIDDEN_IN_SHADOWS" "SPELL_DISRUPTED" "SET_A_TRAP" "STORE_NAME" "SCRIPT_OVERRIDE" "SCRIPT_CLASS" "SCRIPT_RACE" "SCRIPT_GENERAL" "SCRIPT_DEFAULT" "DEATHVAR" "DIALOG" "AREA_SCRIPT" "WNL" "MNL" "LNL" "TAB" "BIT0" "BIT1" "BIT2" "BIT3" "BIT4" "BIT5" "BIT6" "BIT7" "BIT8" "BIT9" "BIT10" "BIT11" "BIT12" "BIT13" "BIT14" "BIT15" "BIT16" "BIT17" "BIT18" "BIT19" "BIT20" "BIT21" "BIT22" "BIT23" "BIT24" "BIT25" "BIT26" "BIT27" "BIT28" "BIT29" "BIT30" "BIT31") 'words))

(defvar weidu-tp2-values (regexp-opt '("STRING_COMPARE" "STR_CMP" "STRING_COMPARE_CASE" "STRING_EQUAL" "STRING_EQUAL_CASE" "STRING_MATCHES_REGEXP" "STRING_COMPARE_REGEXP" "STRING_CONTAINS_REGEXP" "BYTE_AT" "SBYTE_AT" "SHORT_AT" "SSHORT_AT" "LONG_AT" "SLONG_AT" "RANDOM" "BUFFER_LENGTH" "STRING_LENGTH" "INDEX" "RINDEX" "INDEX_BUFFER" "RINDEX_BUFFER" "FILE_CONTAINS_EVALUATED" "FILE_EXISTS" "BIFF_IS_COMPRESSED" "FILE_IS_IN_COMPRESSED_BIF" "FILE_IS_IN_COMPRESSED_BIFF" "FILE_MD5" "FILE_EXISTS_IN_GAME" "FILE_SIZE" "FILE_CONTAINS" "NOT" "AND" "OR" "BAND" "BOR" "BNOT" "ABS" "BXOR" "BLSL" "BLSR" "BASR" "MOD_IS_INSTALLED" "INSTALL_ORDER" "ID_OF_LABEL" "GAME_IS" "ENGINE_IS" "VARIABLE_IS_SET" "IDS_OF_SYMBOL" "STATE_WHICH_SAYS" "IS_AN_INT" "TRA_ENTRY_EXISTS" "RESOLVE_STR_REF" "IS_SILENT" "SOURCE_DIRECTORY" "SOURCE_FILESPEC" "SOURCE_FILE" "SOURCE_RES" "SOURCE_EXT" "SOURCE_SIZE" "DEST_DIRECTORY" "DEST_FILESPEC" "DEST_FILE" "DEST_RES" "DEST_EXT" "COMPONENT_NUMBER" "BASH_FOR_DIRECTORY" "BASH_FOR_FILESPEC" "BASH_FOR_FILE" "BASH_FOR_RES" "BASH_FOR_SIZE" "BASH_FOR_EXT" "WEIDU_ARCH" "WEIDU_OS" "INTERACTIVE" "REGISTRY_BG1_PATH" "REGISTRY_BG2_PATH" "REGISTRY_PST_PATH" "REGISTRY_IWD1_PATH" "REGISTRY_IWD2_PATH" "WEIDU_EXECUTABLE") 'words))

; "!" "<<" ">>" "&&" "||" "&" "|" "`" "=" "!=" ">=" "<=" "^^" "^" "**" "+" "-" "*" "/" ":" "?" "$" ">" "<" "+=" "-=" "*=" "/=" "|=" "&=" "<<=" ">>=" "^^=" "++" "--"

(defvar weidu-tp2-decial-values "\\<[0-9]+\\>")
(defvar weidu-tp2-hex-values "\\<0[xX][0-9A-Fa-f]+\\>")
(defvar weidu-tp2-octal-values "\\<0[oO][0-7]+\\>")
(defvar weidu-tp2-bin-values "\\<0[bB][01]+\\>")

(defvar weidu-tp2-wrong-hex-values "\\<0[cC][0-9A-Fa-f]+\\>")

(defvar weidu-tp2-font-lock-keywords-1
  (list
   (cons weidu-tp2-keywords font-lock-keyword-face) ;order matters here, becasue keywords, patches and actions share words, but they should be fonted as keywords and nothing else
   (cons weidu-tp2-patches font-lock-function-name-face)
   (cons weidu-tp2-actions font-lock-type-face)
   (cons weidu-tp2-constants font-lock-constant-face)
   (cons weidu-tp2-values font-lock-variable-name-face)
   ;;(cons weidu-tp2-decimal-values font-lock-variable-name-face)
   ;;(cons weidu-tp2-hex-values font-lock-variable-name-face)
   ;;(cons weidu-tp2-octal-values font-lock-variable-name-face)
   ;;(cons weidu-tp2-binary-values font-lock-variable-name-face)
   (cons weidu-tp2-wrong-hex-values font-lock-warning-face)
   (cons weidu-tp2-builtin-functions font-lock-builtin-face)))

(defvar weidu-tp2-font-lock-keywords weidu-tp2-font-lock-keywords-1)


(defcustom weidu-tp2-indent-width 2
  "Width of indentation"
  :type 'integer)

(defvar weidu-tp2-end-openings (regexp-opt '("BEGIN" "ALWAYS" "ALWAYS_ASK" "QUICK_MENU" "IF_EXISTING" "ON_DISABLE" "ACTION_MATCH" "PATCH_MATCH" "ACTION_TRY" "PATCH_TRY" "LAUNCH_ACTION_FUNCTION" "LAUNCH_FUNCTION_ACTION" "LAF" "LAUNCH_PATCH_FUNCTION" "LAUNCH_FUNCTION_PATCH" "LPF" "ON_MISMATCH") 'words))

(defvar weidu-tp2-when-openings (regexp-opt '("COPY" "COPY_EXISTING" "COPY_EXISTING_REGEXP" "COPY_RANDOM" "COPY_ALL_GAM_FILES" "APPEND" "APPEND_OUTER" "APPEND_COL" "ADD_SPELL") 'words))

(defvar weidu-tp2-when-clauses (regexp-opt '("IF" "UNLESS" "BUT_ONLY" "BUT_ONLY_IF_IT_CHANGES" "IF_SIZE_IS" "I_S_I") 'words))

(defvar weidu-tp2-function-indent-cue (regexp-opt '("DEFINE_PATCH_FUNCTION" "DEFINE_ACTION_FUNCTION" "LAUNCH_PATCH_FUNCTION" "LAUNCH_ACTION_FUNCTION" "LAUNCH_FUNCTION_PATCH" "LAUNCH_FUNCTION_ACTION" "LAF" "LPF") 'words))

(defvar weidu-tp2-component-flags (regexp-opt '("DEPRECATED" "REQUIRE_COMPONENT" "FORBID_COMPONENT" "REQUIRE_PREDICATE" "SUBCOMPONENT" "FORCED_SUBCOMPONENT" "GROUP" "INSTALL_BY_DEFAULT" "DESIGNATED" "NO_LOG_RECORD" "LABEL")))


;;;To do:

;;Need to avoid indenting inside multi-line strings

;;Disregard comments (also, consistent treatment of the same)

;;Handle in-lined

;;Doesn't indent properly after END ELSE BEGIN

;;Doesn't indent END ELSE BEGIN (context: ACTION_IF)

;;foo = bar (implicit SET) misbehaves due to "looking at string"

;;DEFINE_(ACTION|PATCH)_FUNCTION foo
;;  INT_VAR
;;    something = something
;;  STR_VAR
;;    something = something
;;    BEGIN <--WRONG
;;

;;"looking at string" apparently also interferes with the indentation of function arguments (rr#mdcre in make_fiend, for example)


;;Need to be able to indent foo and DEFAULT in
;(ACTION|PATCH)_MATCH something WITH
;  foo BEGIN something END
;  DEFAULT
;END
;The problem is that foo is picked up as a string and indented accordingly

;;Need to be able to handle [SET] foo = bar with the implicit SET

;;Unindenting when clauses misbehaves, due to REPLACE_TEXTUALLY ~END~ ~~

;;INCLUDE is apparently not considered an action for indentation purposes (it passes it over and looks for indentation clues above)


(defun weidu-tp2-indent-line (&optional fix-point)
  (interactive)
  (let (indent ;How much?
	indent-from ;How much (relative)?
	indentedp ;Are we there yet?
	(case-fold-search nil) ;Case-sensitive regexps
	inside-string-p) ;Are we inside a multi-line string?
    (save-excursion
      (beginning-of-line)
      (cond
       ;;Unindent END
       ((looking-at "^[ \t]*END\\>.*")
	(prin1 "Looking at END")
	(setq indent 0)
	(setq indent-from (weidu-tp2-unindent-end))
	(setq indentedp t))
       ;;Unindent in-line openings
       ((looking-at "^[ \t]*<<<<<<<<")
	(prin1 "Looking-at in-line opening")
	(setq indent 0)
	(setq indent-from 0)
	(setq indentedp t))
       ;;Unindent in-line ends
       ((looking-at "^[ \t]*>>>>>>>>")
	(prin1 "Looking at in-line end")
	(setq indent 0)
	(setq indent-from (weidu-tp2-find-in-line-opening))
	(setq indentedp t))
       ;;Unindent when clauses
       ((looking-at (concat "^[ \t]*" weidu-tp2-when-clauses))
	(prin1 "Looking at when clause")
	(setq indent 0)
	(setq indent-from (weidu-tp2-unindent-when-clause))
	(setq indentedp t))
       ;;Unindent components
       ((and (looking-at "^[ \t]*\\<BEGIN[ \t]+[\"~#@A-Za-z0-9_-!]+.*")
	     (not (looking-at (concat ".*\\<BEGIN[ \t]+\\(" weidu-tp2-actions "\\|" weidu-tp2-patches "\\|" weidu-tp2-keywords "\\).*"))))
	(prin1 "Looking at component start")
	(setq indent 0)
	(setq indent-from 0)
	(setq indentedp t))
       ;;Unindent component flags
       ((looking-at (concat "^[ \t]*" weidu-tp2-component-flags ".*"))
	(prin1 "Looking at component flag")
	(setq indent 0)
	(setq indent-from 0)
	(setq indentedp t))
       ;;Unindent actions.
       ((looking-at (concat "^[ \t]*" weidu-tp2-actions ".*"))
	(prin1 "Looking at action")
	(setq indent 0)
	(setq indent-from (weidu-tp2-unindent-action))
	(setq indentedp t))
       ;;Unindent COMPILE_*_TO_*
       ((looking-at "^[ \t]*COMPILE_\\(BAF\\|D\\)_TO_\\(BCS\\|DLG\\)\\>")
	(prin1 "Looking at COMPILE_*")
	(setq indent 0)
	(setq indent-from (weidu-tp2-unindent-compile-baf-d))
	(setq indentedp t))
       ;;Unindent function keywords
       ((looking-at "^[ \t]*\\(\\(INT\\|STR\\)_VAR\\|RET\\)\\>.*")
	(prin1 "Looking at fun keys")
	(setq indent 0)
	(setq indent-from (weidu-tp2-indent-fun-keys))
	(setq indentedp t))
       ;;Indent strings
       ((and (looking-at "[ \t]*[A-Za-z0-9!@\"~#%\\-\\_]+") ;Apparently unescaped hyphens and underscores match stuff in emacs-regexp, or something
	     (not (looking-at (concat "[ \t]*" weidu-tp2-actions ".*")))
	     (not (looking-at (concat "[ \t]*" weidu-tp2-patches ".*")))
	     (not (looking-at (concat "[ \t]*" weidu-tp2-keywords ".*")))
	     (not (looking-at (concat "[ \t]*" weidu-tp2-values ".*"))))
	(prin1 "Looking at string")
	(setq indent 0)
	(setq indent-from (weidu-tp2-indent-to-next-whitespace))
	(setq indentedp t)))
      ;;Look for indentation clues on the lines above
      (while (and (not indentedp) (not (bobp)))
	(forward-line -1)
	(cond
	 ;;If we find an in-line ending, move past the whole in-lined block
	 ((looking-at "[ \t]*>>>>>>>>")
	  (weidu-tp2-move-backwards-past-inline))
	 ;;If we find an in-line opening, indent to its level
	 ((looking-at "[ \t]*<<<<<<<<")
	  (setq indent 0)
	  (setq indent-from (current-indentation))
	  (setq indentedp t))
	 ;;Disregard one-line comments
	 ((looking-at "^[ \t]*//"))
	 ;;Increase indentation if we find an unclosed end-opening
	 ((or (and (looking-at (concat ".*" weidu-tp2-end-openings ".*"))
		   (not (looking-at ".*\\<END\\>.*")))
	      (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (prin1 "Looking at END opening")
	  (setq indent weidu-tp2-indent-width)
	  (setq indent-from (current-indentation))
	  (setq indentedp t))
	 ;;If we find an END, indent to its level
	 ((looking-at ".*\\<END\\>.*")
	  (prin1 "Looking at END")
	  (setq indent 0)
	  (setq indent-from (weidu-tp2-find-corresponding-opening))
	  (setq indentedp t))
	 ;;If we find a COMPILE_*, indent to its level
	 ((looking-at "[ \t]*COMPILE_\\(BAF\\|D\\)_TO_\\(BCS\\|DLG\\)\\>")
	  (prin1 "Looking-at COMPILE_* 2")
	  (setq indent 0)
	  (setq indent-from (current-indentation))
	  (setq indentedp t))
	 ;;If we find a when clause, indent to its level
	 ((looking-at (concat ".*" weidu-tp2-when-clauses ".*"))
	  (prin1 "Looking at when clause 2")
	  (setq indent 0)
	  (setq indent-from (current-indentation))
	  (setq indentedp t))
	 ;;Increase indentation if we find a COPY
	 ((and (looking-at (concat "^[ \t]*" weidu-tp2-when-openings ".*"))
	       (not (looking-at (concat "^[ \t]*" weidu-tp2-when-clauses ".*"))))
	  (prin1 "Looking at when opening")
	  (setq indent weidu-tp2-indent-width)
	  (setq indent-from (current-indentation))
	  (setq indentedp t))
	 ;;Increase indentation if we find a DECOMPILE_*_TO_*
	 ((looking-at "[ \t]*DECOMPILE_\\(BCS\\|DLG\\)_TO_\\(BAF\\|D\\)\\>")
	  (prin1 "Looking at DECOMPILE_*")
	  (setq indent weidu-tp2-indent-width)
	  (setq indent-from (current-indentation))
	  (setq indentedp t))
	 ;;Increase indentation if we find one of INT_VAR, STR_VAR or RET
	 ((looking-at "[ \t]*\\(\\(INT\\|STR\\)_VAR\\|RET\\)")
	  (prin1 "Looking at INT_VAR, STR_VAR, RET")
	  (setq indent weidu-tp2-indent-width)
	  (setq indent-from (current-indentation))
	  (setq indentedp t)))))
    (prin1 indent)
    (prin1 " and ")
    (prin1 indent-from)
    (if (not fix-point)
	(indent-line-to (+ (or indent 0) (or indent-from 0)))
      (save-excursion
	(indent-line-to (+ (or indent 0) (or indent-from 0)))))))

(defun weidu-tp2-indent-to-next-whitespace ()
  (save-excursion
    ;;Move backwards to the first action or patch
    (while (and (not (bobp)) (not (looking-at (concat "[ \t]*\\(" weidu-tp2-actions "\\|" weidu-tp2-patches "\\|<<<<<<<<\\).*"))))
      (forward-line -1))
    ;;Move forward on that line past any leading whitespace and past the first collection of non-whitespace. Lastly, move forward another character (whitespace) to get into alignment
    (when (looking-at "[ \t]*[^ \t\n\r]+[ \t]+.*")
      (while (not (looking-at "[^ \t\n\r].*"))
	(forward-char))
      (while (looking-at "[^ \t\n\r].*")
	(forward-char))
      (forward-char))
    (current-column)))

(defun weidu-tp2-move-backwards-past-inline ()
  (while (and (not (bobp)) (not (looking-at "[ \t]*<<<<<<<<")))
    (forward-line -1)))

(defun weidu-tp2-move-forward-past-inline ()
  (while (and (not (eobp)) (not (looking-at "[ \t]*>>>>>>>>")))
    (forward-line)))

(defun weidu-tp2-find-in-line-opening ()
  (save-excursion
    (while (and (not (looking-at "[ \t]*<<<<<<<<"))
		(not (bobp)))
      (forward-line -1))
    (current-indentation)))

(defun weidu-tp2-unindent-compile-baf-d ()
  (save-excursion
    (while (and (not (looking-at "[ \t]*DECOMPILE_\\(BCS\\|DLG\\)_TO_\\(BAF\\|D\\)\\>"))
		(not (bobp)))
      (forward-line -1))
    (current-indentation)))

(defun weidu-tp2-indent-fun-keys ()
  (save-excursion
    (let (done
	  (indent 0))
      (while (and (not done) (not (bobp)) (not (looking-at "[ \t]<<<<<<<<")))
	(unless done
	  (forward-line -1))
	(when (looking-at "[ \t]*\\(INT\\|STR\\)_VAR\\>.*")
	  (setq done t))
	(when (looking-at (concat ".*" weidu-tp2-function-indent-cue ".*"))
	  (setq done t)
	  (setq indent weidu-tp2-indent-width)))
      (+ (current-indentation) indent))))

(defun weidu-tp2-unindent-when-clause ()
  (save-excursion
    (let (done
	  (open 0)
	  (closed 0))
      (while (and (not done) (not (bobp)) (not (looking-at "[ \t]*<<<<<<<<")))
	;;Skip past any in-lined stuff
	(when (looking-at "[ \t]*>>>>>>>>")
	  (weidu-tp2-move-backwards-past-inline))
	(when (or (and (looking-at ".*\\<END\\>.*")
		       (not (looking-at (concat ".*" weidu-tp2-end-openings ".*"))))
		  (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (incf closed))
	(when (or (and (looking-at (concat ".*" weidu-tp2-end-openings ".*"))
		       (not (looking-at ".*\\<END\\>.*")))
		  (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (incf open))
	(when (and (= open closed)
		   (looking-at (concat ".*" weidu-tp2-when-openings ".*")))
	  (setq done t))
	(unless done
	  (forward-line -1)))
      (current-indentation))))

(defun weidu-tp2-find-corresponding-opening ()
  (save-excursion
    (let (done
	  (open 0)
	  (closed 0))
      ;;If the end-opening is on the same line
      (when (looking-at (concat ".*" weidu-tp2-end-openings ".*" "\\<END\\>.*"))
	(setq done t))
      (while (not done)
	;;Skip past any in-lined stuff
	(when (looking-at "[ \t]*>>>>>>>>")
	  (weidu-tp2-move-backwards-past-inline))
	(when (or (and (looking-at ".*\\<END\\>.*")
		       (not (looking-at (concat ".*" weidu-tp2-end-openings ".*"))))
		  (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (incf closed))
	(when (or (and (looking-at (concat ".*" weidu-tp2-end-openings ".*"))
		       (not (looking-at ".*\\<END\\>.*")))
		  (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (incf open))
	(when (or (= open closed) (bobp))
	  (setq done t))
	(unless done
	  (forward-line -1)))
      (current-indentation))))

(defun weidu-tp2-unindent-action ()
  "Returns the indentation of the first action after the line where end-openings and ENDs are balanced. If the action has an unclosed end-opening, add a level of indentation."
  (save-excursion
    (let (done
	  (open 0)
	  (closed 0)
	  (indent 0)
	  bobp)
      (while (not done)
	;;We only want to consider lines above the current line and due to the way forward-line interacts with BoB and EoB, we need to be able to detect if we start at BoB
	(when (bobp)
	  (setq bobp t))
	(forward-line -1)
	(print "back")
	;;Skip past any in-lined stuff
	(when (looking-at "[ \t]*>>>>>>>>")
	  (weidu-tp2-move-backwards-past-inline))
	(when (looking-at "[ \t]*<<<<<<<<")
	  (setq done t))
	(when (or (and (looking-at ".*\\<END\\>.*")
		       (not (looking-at (concat ".*" weidu-tp2-end-openings ".*"))))
		  (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (incf closed))
	(when (or (and (looking-at (concat ".*" weidu-tp2-end-openings ".*"))
		       (not (looking-at ".*\\<END\\>.*")))
		  (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (incf open))
	;;If we find an unnested action, indent to its level
	(when (and (= open closed)
		   (looking-at (concat "^[ \t]*" weidu-tp2-actions ".*")))
	  (setq done t))
	(when (and (= (- open closed) 1)
		   (not bobp))
	  (while (not done)
	    ;;Skip past any in-lined stuff
	    (when (looking-at "[ \t]*<<<<<<<<")
	      (weidu-tp2-move-forward-past-inline))
	    (when (or (looking-at (concat "^[ \t]*" weidu-tp2-actions ".*"))
		      (looking-at "[ \t]*INNER_ACTION\\>.*")
		      (looking-at ".*\\<BEGIN\\>.*"))
	      (if (or (and (looking-at (concat ".*" weidu-tp2-end-openings ".*"))
			   (not (looking-at ".*\\<END\\>.*")))
		      (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
		  (progn
		    (setq done t)
		    (setq indent weidu-tp2-indent-width))
		(setq done t)))
	    (when (or (bobp) (eobp))
	      (setq done t))
	    (unless done
	      (forward-line 1)
	      (print "forward")
	      )))
	(when (bobp)
	  (setq done t)))
      (+ (current-indentation) indent))))

(defun weidu-tp2-unindent-end ()
  "Returns the indentation of the end-opening where the number of end-openings and ENDs are balanced."
  (save-excursion
    (let ((open 0)
	  (closed 0)
	  done)
      (while (and (not done) (not (looking-at "[ \t]*<<<<<<<<")))
	;;Skip past any in-lined stuff
	(when (looking-at "[ \t]*>>>>>>>>")
	  (weidu-tp2-move-backwards-past-inline))
	(when (or (and (looking-at ".*\\<END\\>.*")
		       (not (looking-at (concat ".*" weidu-tp2-end-openings ".*"))))
		  (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (incf closed))
	(when (or (and (looking-at (concat ".*" weidu-tp2-end-openings ".*"))
		       (not (looking-at ".*\\<END\\>.*")))
		  (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
	  (incf open))
	(when (= open closed)
	  (setq done t))
	(when (bobp)
	  (setq done t))
	(unless done
	  (forward-line -1)
	  (print "back")))
      (current-indentation))))

(defun weidu-tp2-indent-newline-indent ()
  (interactive)
  (weidu-tp2-indent-line t)
  (newline)
  (weidu-tp2-indent-line))

(defun weidu-tp2-indent-buffer ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (while (not (eobp))
      (weidu-tp2-indent-line)
      (forward-line 1))))

(defvar weidu-tp2-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" table) ;word character
    (modify-syntax-entry ?/ ". 124b" table) ;this and next three are for declaring comments (both multi-line and single-line) but I forget what does what
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?\" "$" table) ;paired delimiter (like string but without suppressing the syntactic properties of the enclosed text
    (modify-syntax-entry ?~ "$" table) ;maybe this will cause problems with ~~~~~ but if so, that is a problem for another day
    table))

;;;###autoload
(defun weidu-tp2-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map weidu-tp2-mode-map)
  (set-syntax-table weidu-tp2-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(weidu-tp2-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'weidu-tp2-indent-line)
  (setq mode-name "WeiDU-TP2")
  (run-hooks 'weidu-tp2-mode-hook)
  (setq major-mode 'weidu-tp2-mode))

(provide 'weidu-tp2-mode)
