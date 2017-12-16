
(defvar weidu-tp2-mode-hook nil)
(defvar weidu-general-hook nil)

(defvar weidu-tp2-mode-map
  (let ((map (make-keymap)))
    ;;(define-key map (kbd "RET") 'weidu-tp2-indent-newline-indent)
    map))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.[Tt][Pp][2AaHhPp]\\'" . weidu-tp2-mode))

(defvar weidu-tp2-patches (regexp-opt '("PATCH_DEFINE_ARRAY" "SET" "INSERT_FILE" "SPRINT" "PATCH_FAIL" "REPLACE" "READ_STRREF_S" "PATCH_SILENT" "PATCH_INCLUDE" "APPEND_FILE_EVALUATE" "SPRINTF" "WRITE_ASCII" "READ_STRREF_FS" "REMOVE_MEMORIZED_SPELL" "SAY_EVALUATED" "COMPRESS_INTO_FILE" "SOURCE_BIFF" "PATCH_CLEAR_ARRAY" "REFACTOR_BAF_TRIGGER" "DECOMPILE_AND_PATCH" "REFACTOR_TRIGGER" "TO_LOWER" "WRITE_ASCII_TERMINATED" "DECOMPRESS_REPLACE_FILE" "APPLY_BCS_PATCH_OR_COPY" "REMOVE_CRE_ITEM" "PATCH_GAM" "ADD_MEMORIZED_SPELL" "EDIT_SAV_FILE" "READ_ASCII" "ADD_MAP_NOTE" "DEFINE_ASSOCIATIVE_ARRAY" "EVALUATE_BUFFER_SPECIAL" "PATCH_RANDOM_SEED" "EXTEND_MOS" "REMOVE_CRE_EFFECTS" "PATCH_LOG" "REMOVE_MEMORIZED_SPELLS" "ADD_CRE_ITEM" "READ_SHORT" "REBUILD_CRE_FILE" "READ_SLONG" "COMPRESS_REPLACE_FILE" "COUNT_REGEXP_INSTANCES" "PATCH_VERBOSE" "GET_STRREF_FS" "COMPRESS_INTO_VAR" "READ_BYTE" "PATCH_WARN" "REPLACE_BCS_BLOCK_REGEXP" "READ_STRREF_F" "REMOVE_KNOWN_SPELL" "DECOMPRESS_INTO_VAR" "SPACES" "REPLACE_BCS_BLOCK" "TEXT_SPRINT" "REMOVE_KNOWN_SPELLS" "WRITE_SHORT" "PATCH_RERAISE" "READ_STRREF" "COMPILE_D_TO_DLG" "SNPRINT" "APPEND_FILE" "ADD_STORE_ITEM" "WRITE_LONG" "REPLACE_EVALUATE" "PATCH_PRINT" "READ_SBYTE" "DECOMPRESS_INTO_FILE" "REFACTOR_D_TRIGGER" "REMOVE_STORE_ITEM" "WRITE_BYTE" "GET_STRREF_F" "DELETE_BYTES" "COMPILE_BAF_TO_BCS" "LAUNCH_PATCH_MACRO" "WRITE_FILE" "DECOMPILE_BCS_TO_BAF" "INSERT_BYTES" "PATCH_REINCLUDE" "WRITE_EVALUATED_ASCII" "READ_SSHORT" "REMOVE_CRE_ITEMS" "REPLACE_TEXTUALLY" "ADD_KNOWN_SPELL" "DECOMPILE_DLG_TO_D" "TO_UPPER" "APPLY_BCS_PATCH" "GET_STRREF" "READ_LONG" "PATCH_READLN" "QUOTE" "SAY" "GET_OFFSET_ARRAY" "GET_OFFSET_ARRAY2" "LAUNCH_PATCH_FUNCTION" "REPLACE_CRE_ITEM" "SET_IDS_SYMBOL_OF_INT" "GET_STRREF_S" "A_B_P" "WRITE_ASCII_TERMINATE" "WRITE_ASCIIT" "WRITE_ASCIIE" "WRITE_ASCII_LIST" "WRITE_ASCIIL" "ADD_GAM_NPC" "R_B_B" "R_B_B_RE" "CLEAR_ARRAY" "LOOKUP_IDS_SYMBOL_OF_INT" "DEFINE_ARRAY" "ADD_GAME_NPC" "ADD_GAM_NPC" "PATCH_DEFINE_ASSOCIATIVE_ARRAY" "LOCAL_SET" "LOCAL_SPRINT" "LOCAL_TEXT_SPRINT" "PRETTY_PRINT_2DA" "SET_2DA_ENTRY" "READ_2DA_ENTRY" "READ_2DA_ENTRIES_NOW" "READ_2DA_ENTRY_FORMER" "SET_2DA_ENTRY_LATER" "SET_2DA_ENTRIES_NOW" "INSERT_2DA_ROW" "REMOVE_2DA_ROW" "COUNT_2DA_ROWS" "COUNT_2DA_COLS" "LAUNCH_MACRO_PATCH" "LPM" "LAUNCH_FUNCTION_PATCH" "LPF" "PATCH_IF" "EVALUATE_BUFFER" "EVAL"  "INNER_ACTION" "INNER_PATCH" "PATCH_PHP_EACH" "PATCH_FOR_EACH" "PATCH_BASH_FOR" "INNER_PATCH_SAVE" "INNER_PATCH_FILE" "PHP_EACH" "FOR" "WHILE" "PATCH_TRY" "PATCH_MATCH" "SET_BG2_PROFICIENCY" "PATCH_WITH_TRA" "PATCH_WITH_SCOPE" "PATCH_TIME") 'words))

;;These get their context from the LPMs, LAMs, etc
(defvar weidu-tp2-builtin-functions (regexp-opt '("fj_are_structure" "FJ_CRE_VALIDITY" "RES_NUM_OF_SPELL_NAME" "RES_NAME_OF_SPELL_NUM" "NAME_NUM_OF_SPELL_RES" "GET_UNIQUE_FILE_NAME" "ADD_AREA_REGION_TRIGGER" "T-CRE_EFF_V1" "FJ_CRE_EFF_V2" "FJ_CRE_REINDEX" "WRITE_SOUNDSET" "READ_SOUNDSET" "SET_CRE_ITEM_FLAGS" "REMOVE_CRE_ITEM_FLAGS" "ADD_CRE_ITEM_FLAGS" "ADD_AREA_ITEM" "REPLACE_AREA_ITEM" "REPLACE_STORE_ITEM" "DELETE_AREA_ITEM" "DELETE_STORE_ITEM" "DELETE_CRE_ITEM" "ADD_CRE_EFFECT" "ADD_ITEM_EQEFFECT" "ADD_ITEM_EFFECT" "ADD_SPELL_EFFECT" "ADD_SPELL_CFEFFECT" "ITEM_EFFECT_TO_SPELL" "DELETE_CRE_EFFECT" "DELETE_ITEM_EQEFFECT" "DELETE_ITEM_EFFECT" "DELETE_SPELL_EFFECT" "tb#fix_file_size" "tb#factorial" "sc#addWmpAre" "ALTER_AREA_ENTRANCE" "ALTER_AREA_REGION" "ALTER_AREA_ACTOR" "ALTER_AREA_CONTAINER" "ALTER_AREA_DOOR" "ALTER_ITEM_EFFECT" "ALTER_ITEM_HEADER" "ALTER_SPELL_EFFECT" "ALTER_SPELL_HEADER" "DELETE_ITEM_HEADER" "DELETE_SPELL_HEADER" "SUBSTRING" "ADD_CRE_SCRIPT" "HANDLE_AUDIO" "HANDLE_TILESETS" "HANDLE_CHARSETS" "DELETE_WORLDMAP_LINKS" "ADD_WORLDMAP_LINKS" "CLONE_EFFECT" "DELETE_EFFECT" "ALTER_EFFECT" "DIRECTORY_OF_FILESPEC" "FILE_OF_FILESPEC" "RES_OF_FILESPEC" "EXT_OF_FILESPEC" "UPDATE_PVRZ_INDICES" "INSTALL_PVRZ" "FIND_FREE_PVRZ_INDEX") 'words))

(defvar weidu-tp2-keywords (regexp-opt '("BEGIN" "END" "ELSE" "THEN" "PATCH_IF" "PATCH_TRY" "WITH" "PATCH_MATCH" "STR_VAR" "INT_VAR" "RET" "DEFAULT" "EQUIP" "CASE_INSENSITIVE" "CASE_SENSITIVE" "EXACT_MATCH" "EVALUATE_REGEXP" "ACTION_IF" "ACTION_TRY" "ACTION_MATCH" "WHEN" "ANY" "AUTHOR" "SUPPORT" "BACKUP" "ALWAYS" "LANGUAGE" "VERSION" "README" "AUTO_TRA" "NO_IF_EVAL_BUG" "MENU_STYLE" "ASK_EVERY_COMPONENT" "MODDER" "ALLOW_MISSING" "SCRIPT_STYLE" "UNINSTALL_ORDER" "QUICK_MENU" "ALWAYS_ASK" "SUBCOMPONENT" "SUB_COMPONENT" "FORCED_SUBCOMPONENT" "NO_LOG_RECORD" "DEPRECATED" "DESIGNATED" "REQUIRE_COMPONENT" "INSTALL_BY_DEFAULT" "FORBID_COMPONENT" "REQUIRE_PREDICATE" "GROUP" "LABEL" "USING" "TWOHANDED" "GLOB" "NOGLOB" "IF" "UNLESS" "IF_SIZE_IS" "IF_EVAL" "BUT_ONLY_IF_IT_CHANGES" "I_S_I" "BUT_ONLY" "IF_EXISTS" "AFTER" "BEFORE" "LAST" "FIRST" "AT" "EXACT" "NULL" "EVALUATE_BUFFER" "EVAL" "LOAD" "KEEP_CRLF" "IF_EXISTING" "ON_DISABLE" "IN" "AS" "ON_MISMATCH" "OUTER_PATCH" "OUTER_INNER_PATCH" "OUTER_PATCH_SAVE" "OUTER_INNER_PATCH_SAVE" "ACTION_MATCH" "ACTION_TRY" "THIS" "STHIS" "INNER_ACTION" "INNER_PATCH" "PATCH_PHP_EACH" "PATCH_FOR_EACH" "PATCH_BASH_FOR" "INNER_PATCH_SAVE" "INNER_PATCH_FILE" "PHP_EACH" "FOR" "WHILE" "PATCH_TRY" "PATCH_MATCH" "ACTION_PHP_EACH" "ACTION_BASH_FOR" "OUTER_FOR" "OUTER_WHILE" "ACTION_IF" "AUTO_EVAL_STRINGS" "EXISTING" "MANAGED" "TITLE" "TEXT" "NOMOVE") 'words))

(defvar weidu-tp2-actions (regexp-opt '("CREATE" "VERBOSE" "ADD_MUSIC" "EXTEND_TOP" "ALTER_TLK" "FORBID_FILE" "COPY_EXISTING_REGEXP" "CLEAR_IDS_MAP" "APPEND" "CLEAR_EVERYTHING" "BIFF" "AT_NOW" "EXTEND_BOTTOM_REGEXP" "INCLUDE" "AT_INTERACTIVE_NOW" "ADD_SECTYPE" "EXTEND_BOTTOM" "COPY_KIT" "ADD_SCHOOL" "MKDIR" "AT_EXIT" "ALTER_TLK_LIST" "ACTION_FOR_EACH" "DEFINE_PATCH_MACRO" "ADD_KIT" "LAUNCH_ACTION_MACRO" "COPY_EXISTING" "MOVE" "RANDOM_SEED" "ADD_SPELL" "ACTION_CLEAR_ARRAY" "COPY_ALL_GAM_FILES" "WARN" "OUTER_TEXT_SPRINT" "COPY_LARGE" "PRINT" "ALTER_TLK_RANGE" "REQUIRE_FILE" "GET_FILE_ARRAY" "GET_DIRECTORY_ARRAY" "OUTER_SET" "LAUNCH_ACTION_FUNCTION" "ACTION_DEFINE_ASSOCIATIVE_ARRAY" "DEFINE_PATCH_FUNCTION" "REINCLUDE" "COPY_RANDOM" "ACTION_RERAISE" "AT_UNINSTALL_EXIT" "AT_INTERACTIVE_UNINSTALL_EXIT" "COMPILE" "APPEND_COL" "OUTER_PATCH" "STRING_SET_EVALUATE" "ACTION_READLN" "OUTER_SPRINT" "AT_INTERACTIVE_UNINSTALL" "EXTEND_TOP_REGEXP" "CLEAR_MEMORY" "COPY" "CLEAR_INLINED" "LOAD_TRA" "CLEAR_ARRAYS" "ACTION_DEFINE_ARRAY" "AT_UNINSTALL" "ADD_PROJECTILE" "LOG" "CLEAR_CODES" "FAIL" "SILENT" "APPEND_OUTER" "STRING_SET_RANGE" "DISABLE_FROM_KEY" "DECOMPRESS_BIFF" "DEFINE_ACTION_FUNCTION" "STRING_SET" "ADD_AREA_TYPE" "AT_INTERACTIVE_EXIT" "UNINSTALL" "DEFINE_ACTION_MACRO" "MAKE_BIFF" "DEFINE_MACRO_ACTION" "DEFINE_MACRO_PATCH" "DEFINE_FUNCTION_PATCH" "DEFINE_FUNCTION_ACTION" "ACTION_INCLUDE" "LAUNCH_MACRO_ACTION" "LAM" "LAUNCH_FUNCTION_ACTION" "LAF" "ACTION_REINCLUDE" "APPEND_COL_OUTER" "ACTION_TO_UPPER" "ACTION_TO_LOWER" "ACTION_GET_STRREF" "ACTION_GET_STRREF_F" "ACTION_GET_STRREF_S" "ACTION_GET_STRREF_FS" "ACTION_PHP_EACH" "OUTER_PATCH_SAVE" "ACTION_BASH_FOR" "OUTER_INNER_PATCH" "OUTER_INNER_PATCH_SAVE" "OUTER_FOR" "OUTER_WHILE" "ACTION_IF" "ACTION_TRY" "ACTION_MATCH" "DELETE" "ADD_JOURNAL" "WITH_TRA" "WITH_SCOPE" "ACTION_TIME") 'words))

(defvar weidu-tp2-constants (regexp-opt '("ARE_V10_ACTORS" "ARE_V10_REGIONS" "ARE_V10_SPAWN_POINTS" "ARE_V10_ENTRANCES" "ARE_V10_CONTAINERS" "ARE_V10_AMBIENTS" "ARE_V10_DOORS" "ARE_V10_ANIMATIONS" "ARE_V91_ACTORS" "ARE_V10_ITEMS" "ARE_V10_REGION_VERTICES" "ARE_V10_CONTAINER_VERTICES" "ARE_V10_DOOR_OPEN_OUTLINE_VERTICES" "ARE_V10_DOOR_CLOSED_OUTLINE_VERTICES" "ARE_V10_DOOR_OPEN_CELL_VERTICES" "ARE_V10_DOOR_CLOSED_CELL_VERTICES" "CRE_V10_KNOWN_SPELLS" "CRE_V10_SPELL_MEM_INFO" "CRE_V10_EFFECTS" "CRE_V10_ITEMS" "CRE_V10_SPELL_MEM" "ITM_V10_HEADERS" "ITM_V10_GEN_EFFECTS" "ITM_V10_HEAD_EFFECTS" "SPL_V10_HEADERS" "SPL_V10_GEN_EFFECTS" "SPL_V10_HEAD_EFFECTS" "STO_V10_ITEMS_PURCHASED" "STO_V10_ITEMS_SOLD" "STO_V10_DRINKS" "STO_V10_CURES" "WMP_AREAS" "WMP_LINKS" "WMP_NORTH_LINKS" "WMP_WEST_LINKS" "WMP_SOUTH_LINKS" "WMP_EAST_LINKS" "AREA_CITY" "AREA_DAY" "AREA_DUNGEON" "AREA_FOREST" "AREA_NIGHT" "ATTACK1" "ATTACK2" "ATTACK3" "ATTACK4" "BATTLE_CRY1" "BATTLE_CRY2" "BATTLE_CRY3" "BATTLE_CRY4" "BATTLE_CRY5" "BIO" "BORED" "COMPLIMENT1" "COMPLIMENT2" "COMPLIMENT3" "CRITICAL_HIT" "CRITICAL_MISS" "DAMAGE" "DESC" "DIALOGUE_DEFAULT" "DIALOGUE_HOSTILE" "DYING" "EXISTANCE1" "EXISTANCE2" "EXISTANCE3" "EXISTANCE4" "EXISTANCE5" "HAPPY" "HURT" "IDENTIFIED_DESC" "INITIAL_MEETING" "INSULT" "INTERACTION1" "INTERACTION2" "INTERACTION3" "INTERACTION4" "INTERACTION5" "INVENTORY_FULL" "LEADER" "MISCELLANEOUS" "MORALE" "NAME1" "NAME2" "PICKED_POCKET" "REACT_TO_DIE_GENERAL" "REACT_TO_DIE_SPECIFIC" "RESPONSE_TO_COMPLIMENT2" "RESPONSE_TO_COMPLIMENT3" "RESPONSE_TO_INSULT1" "RESPONSE_TO_INSULT2" "RESPONSE_TO_INSULT3" "SELECT_ACTION1" "SELECT_ACTION2" "SELECT_ACTION3" "SELECT_ACTION4" "SELECT_ACTION5" "SELECT_ACTION6" "SELECT_ACTION7" "SELECT_COMMON1" "SELECT_COMMON2" "SELECT_COMMON3" "SELECT_COMMON4" "SELECT_COMMON5" "SELECT_COMMON6" "SELECT_RARE1" "SELECT_RARE2" "SPECIAL1" "SPECIAL2" "SPECIAL3" "TARGET_IMMUNE" "TIRED" "UNHAPPY_ANNOYED" "UNHAPPY_BREAKING" "UNHAPPY_SERIOUS" "UNIDENTIFIED_DESC" "HIDDEN_IN_SHADOWS" "SPELL_DISRUPTED" "SET_A_TRAP" "STORE_NAME" "SCRIPT_OVERRIDE" "SCRIPT_CLASS" "SCRIPT_RACE" "SCRIPT_GENERAL" "SCRIPT_DEFAULT" "DEATHVAR" "DIALOG" "AREA_SCRIPT" "WNL" "MNL" "LNL" "TAB" "BIT0" "BIT1" "BIT2" "BIT3" "BIT4" "BIT5" "BIT6" "BIT7" "BIT8" "BIT9" "BIT10" "BIT11" "BIT12" "BIT13" "BIT14" "BIT15" "BIT16" "BIT17" "BIT18" "BIT19" "BIT20" "BIT21" "BIT22" "BIT23" "BIT24" "BIT25" "BIT26" "BIT27" "BIT28" "BIT29" "BIT30" "BIT31") 'words))

(defvar weidu-tp2-values (regexp-opt '("STRING_COMPARE" "STR_CMP" "STRING_COMPARE_CASE" "STRING_EQUAL" "STRING_EQUAL_CASE" "STR_EQ" "STRING_MATCHES_REGEXP" "STRING_COMPARE_REGEXP" "STRING_CONTAINS_REGEXP" "BYTE_AT" "SBYTE_AT" "SHORT_AT" "SSHORT_AT" "LONG_AT" "SLONG_AT" "RANDOM" "BUFFER_LENGTH" "STRING_LENGTH" "INDEX" "RINDEX" "INDEX_BUFFER" "RINDEX_BUFFER" "FILE_CONTAINS_EVALUATED" "FILE_EXISTS" "BIFF_IS_COMPRESSED" "FILE_IS_IN_COMPRESSED_BIF" "FILE_IS_IN_COMPRESSED_BIFF" "FILE_MD5" "FILE_EXISTS_IN_GAME" "FILE_SIZE" "FILE_CONTAINS" "NOT" "AND" "OR" "BAND" "BOR" "BNOT" "ABS" "BXOR" "BLSL" "BLSR" "BASR" "MOD_IS_INSTALLED" "INSTALL_ORDER" "ID_OF_LABEL" "GAME_IS" "ENGINE_IS" "GAME_INCLUDES" "VARIABLE_IS_SET" "IDS_OF_SYMBOL" "STATE_WHICH_SAYS" "IS_AN_INT" "TRA_ENTRY_EXISTS" "RESOLVE_STR_REF" "IS_SILENT" "SOURCE_DIRECTORY" "SOURCE_FILESPEC" "SOURCE_FILE" "SOURCE_RES" "SOURCE_EXT" "SOURCE_SIZE" "DEST_DIRECTORY" "DEST_FILESPEC" "DEST_FILE" "DEST_RES" "DEST_EXT" "COMPONENT_NUMBER" "BASH_FOR_DIRECTORY" "BASH_FOR_FILESPEC" "BASH_FOR_FILE" "BASH_FOR_RES" "BASH_FOR_SIZE" "BASH_FOR_EXT" "WEIDU_ARCH" "WEIDU_OS" "INTERACTIVE" "REGISTRY_BG1_PATH" "REGISTRY_BG2_PATH" "REGISTRY_PST_PATH" "REGISTRY_IWD1_PATH" "REGISTRY_IWD2_PATH" "WEIDU_EXECUTABLE" "SAVE_DIRECTORY" "MPSAVE_DIRECTORY" "MOD_FOLDER" "TP2_AUTHOR" "TP2_FILE_NAME" "TP2_BASE_NAME" "SIZE_OF_FILE" "DIRECTORY_EXISTS" "NEXT_STRREF" "MODULO") 'words))

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
  :type 'integer
  :group 'style)

(defvar weidu-tp2-end-openings (regexp-opt '("BEGIN" "ALWAYS" "ALWAYS_ASK" "QUICK_MENU" "IF_EXISTING" "ON_DISABLE" "ACTION_MATCH" "PATCH_MATCH" "ACTION_TRY" "PATCH_TRY" "LAUNCH_ACTION_FUNCTION" "LAUNCH_FUNCTION_ACTION" "LAF" "LAUNCH_PATCH_FUNCTION" "LAUNCH_FUNCTION_PATCH" "LPF" "ON_MISMATCH") 'words))

(defvar weidu-tp2-when-openings (regexp-opt '("COPY" "COPY_EXISTING" "COPY_EXISTING_REGEXP" "COPY_RANDOM" "COPY_ALL_GAM_FILES" "APPEND" "APPEND_OUTER" "APPEND_COL" "ADD_SPELL") 'words))

(defvar weidu-tp2-when-clauses (regexp-opt '("IF" "UNLESS" "BUT_ONLY" "BUT_ONLY_IF_IT_CHANGES" "IF_SIZE_IS" "I_S_I" "IF_EXISTS") 'words))

(defvar weidu-tp2-function-indent-cue (regexp-opt '("DEFINE_PATCH_FUNCTION" "DEFINE_ACTION_FUNCTION" "LAUNCH_PATCH_FUNCTION" "LAUNCH_ACTION_FUNCTION" "LAUNCH_FUNCTION_PATCH" "LAUNCH_FUNCTION_ACTION" "LAF" "LPF") 'words))

(defvar weidu-tp2-component-flags (regexp-opt '("DEPRECATED" "REQUIRE_COMPONENT" "FORBID_COMPONENT" "REQUIRE_PREDICATE" "SUBCOMPONENT" "FORCED_SUBCOMPONENT" "GROUP" "INSTALL_BY_DEFAULT" "DESIGNATED" "NO_LOG_RECORD" "LABEL")))

(defvar weidu-tp2-end-inside-string ".*\\(\".*\\<END\\>.*\"\\|~[^~]*\\<END\\>[^~]*~\\|~~~~~.*\\<END\\>.*~~~~~\\)")

(defvar weidu-tp2-debug t)

(defun weidu-tp2-indent-line (&optional fix-point)
  (interactive)
  (let ((indent 0) ;how much?
        indentedp ;are we done yet?
        (case-fold-search nil)) ;case-sensitive regexps
    (save-excursion
      (beginning-of-line)
      (cond
       ;;;Indent lines where the indentation depends on the content of the current line
       ;;END
       ((and (looking-at "^[ \t]*END\\>")
             (not (looking-at weidu-tp2-end-inside-string))
             (not (looking-at ".*\\<END[\"~]"))) ;hackish; not looking at e.g., END~, which is probably the most common case of END-inside-string where both string delimiters are not on the same line (a situation in which the first END-inside-string will not match)
        (when weidu-tp2-debug (print "Looking at END"))
        (setq indentedp t)
        (incf indent (weidu-tp2-indent-end)))
       ;;next
       )
      )
    (if (not fix-point)
        (indent-line-to indent)
      (save-excursion
        (indent-line-to indent)))
    )
  )

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

(defun weidu-tp2-indent-end ()
  "Returns the indentation of the end-opening where the number of end-openings and ENDs are balanced."
  (save-excursion
    (let ((open 0)
	  (closed 0)
	  done
          line-done)
      (while (and (not done) (not (looking-at "[ \t]*<<<<<<<<")))
	;;Skip past any in-lined stuff
	(when (looking-at "[ \t]*>>>>>>>>")
	  (weidu-tp2-move-backwards-past-inline))
	(when (and (or (and (looking-at ".*\\<END\\>")
                            (not (looking-at weidu-tp2-end-inside-string))
                            (not (looking-at ".*\\<END[\"~]"))
                            (not (looking-at (concat ".*" weidu-tp2-end-openings ".*\\<END\\>")))) ;this is to filter out BEGIN foo END and such
                       (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
                   (not line-done))
	  (incf closed)
          (setq line-done t))
	(when (and (or (and (looking-at (concat ".*" weidu-tp2-end-openings ".*")) ;make sure this is alright
                            (not (looking-at ".*\\<END\\>.*")))
                       (looking-at ".*\\<END[ \t]+ELSE[ \t]+BEGIN\\>.*"))
                   (not line-done))
	  (incf open)
          (setq line-done t))
        (setq line-done nil)
	(when (= open closed)
	  (setq done t))
	(when (bobp)
	  (setq done t))
	(unless done
	  (forward-line -1)
	  (when weidu-tp2-debug (print "back"))))
      (current-indentation))))

(defun weidu-tp2-indent-newline-indent ()
  (interactive)
  (weidu-tp2-indent-line t)
  (newline)
  (weidu-tp2-indent-line))

(defun weidu-tp2-indent-buffer ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
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
  ;;(set (make-local-variable 'indent-line-function) 'weidu-tp2-indent-line)
  (setq mode-name "WeiDU-TP2")
  (run-hooks 'weidu-general-hook 'weidu-tp2-mode-hook)
  (setq major-mode 'weidu-tp2-mode))

(provide 'weidu-tp2-mode)
