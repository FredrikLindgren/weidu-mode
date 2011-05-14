
(defvar weidu-baf-mode-hook nil)
(defvar weidu-baf-mode-map
  (let ((weidu-baf-mode-map (make-keymap)))
    (define-key weidu-baf-mode-map (kbd "RET") 'weidu-baf-indent-newline-indent)
    (define-key weidu-baf-mode-map (kbd "C-M-q") 'weidu-baf-indent-block)
    weidu-baf-mode-map)
  "Keymap for WeiDU-BAF major mode")

(add-to-list 'auto-mode-alist '("\\.[Bb][Aa][Ff]\\'" . weidu-baf-mode))

(defconst weidu-baf-triggers (regexp-opt '("Acquired" "Help" "Joins" "Leaves" "ReceivedOrder" "Said" "TurnedBy" "Unusable" "Alignment" "Allegiance" "Class" "Exists" "General" "Global" "HP" "HPGT" "HPLT" "LOS" "Morale" "MoraleGT" "MoraleLT" "Race" "Range" "Reputation" "ReputationGT" "ReputationLT" "See" "Specifics" "Time" "TimeOfDay" "HitBy" "HotKey" "TimerExpired" "True" "Trigger" "Die" "TargetUnreachable" "Delay" "NumCreature" "NumCreatureLT" "NumCreatureGT" "ActionListEmpty" "HPPercent" "HPPercentLT" "HPPercentGT" "Heard" "False" "HaveSpell" "HaveAnySpells" "BecameVisible" "GlobalGT" "GlobalLT" "OnCreation" "StateCheck" "NotStateCheck" "NumTimesTalkedTo" "NumTimesTalkedToGT" "NumTimesTalkedToLT" "Reaction" "ReactionGT" "ReactionLT" "GlobalTimerExact" "GlobalTimerExpired" "GlobalTimerNotExpired" "PartyHasItem" "InParty" "CheckStat" "CheckStatGT" "CheckStatLT" "RandomNum" "RandomNumGT" "RandomNumLT" "Died" "Killed" "Entered" "Gender" "PartyGold" "PartyGoldGT" "PartyGoldLT" "Dead" "Opened" "Closed" "Detected" "Reset" "Disarmed" "Unlocked" "OutOfAmmo" "NumTimesInteracted" "NumTimesInteractedGT" "NumTimesInteractedLT" "BreakingPoint" "PickPocketFailed" "StealFailed" "DisarmFailed" "PickLockFailed" "HasItem" "InteractingWith" "InWeaponRange" "HasWeaponEquiped" "Happiness" "HappinessGT" "HappinessLT" "TimeGT" "TimeLT" "NumInParty" "NumInPartyGT" "NumInPartyLT" "UnselectableVariable" "UnselectableVariableGT" "UnselectableVariableLT" "Clicked" "NumberOfTimesTalkedTo" "NumDead" "NumDeadGT" "NumDeadLT" "Detect" "Contains" "OpenState" "NumItems" "NumItemsGT" "NumItemsLT" "NumItemsParty" "NumItemsPartyGT" "NumItemsPartyLT" "IsOverMe" "AreaCheck" "HasItemEquiped" "NumCreatureVsParty" "NumCreatureVsPartyLT" "NumCreatureVsPartyGT" "CombatCounter" "CombatCounterLT" "CombatCounterGT" "AreaType" "TrapTriggered" "PartyMemberDied" "OR" "InPartySlot" "SpellCast" "InLine" "PartyRested" "Level" "LevelGT" "LevelLT" "Summoned" "GlobalsEqual" "GlobalsGT" "GlobalsLT" "LocalsEqual" "LocalsGT" "LocalsLT" "ObjectActionListEmpty" "OnScreen" "InActiveArea" "SpellCastOnMe" "CalanderDay" "CalanderDayGT" "CalanderDayLT" "Name" "SpellCastPriest" "SpellCastInnate" "IsValidForPartyDialog" "IfValidForPartyDialog" "IsValidForPartyDialogue" "IfValidForPartyDialogue" "PartyHasItemIdentified" "HasBounceEffects" "HasImmunityEffects" "HasItemSlot" "PersonalSpaceDistance" "InMyGroup" "RealGlobalTimerExact" "RealGlobalTimerExpired" "RealGlobalTimerNotExpired" "NumInPartyAlive" "NumInPartyAliveGT" "NumInPartyAliveLT" "Kit" "IsGabber" "IsActive" "CharName" "FallenRanger" "FallenPaladin" "InventoryFull" "HasItemEquipedReal" "XP" "XPGT" "XPLT" "G" "GGT" "GLT" "ModalState" "InMyArea" "TookDamage" "DamageTaken" "DamageTakenGT" "DamageTakenLT" "Difficulty" "DifficultyGT" "DifficultyLT" "InPartyAllowDead" "AreaCheckObject" "ActuallyInCombat" "WalkedToTrigger" "LevelParty" "LevelPartyGT" "LevelPartyLT" "HaveSpellParty" "HaveSpellRES" "AmIInWatchersKeepPleaseIgnoreTheLackOfApostophe" "InWatchersKeep") 'words))

(defconst weidu-baf-actions (regexp-opt '("NoAction" "ActionOverride" "AddWayPoint" "Attack" "BackStab" "CreateCreature" "Dialogue" "DropItem" "Enemy" "EquipItem" "FindTraps" "GetItem" "GiveItem" "GiveOrder" "Help" "Hide" "JoinParty" "LayHands" "LeaveParty" "MoveToObject" "MoveToPoint" "Panic" "PickPockets" "PlaySound" "ProtectPoint" "RemoveTraps" "RunAwayFrom" "SetGlobal" "Spell" "SpellRES" "Turn" "UseItem" "Continue" "FollowPath" "Swing" "Recoil" "PlayDead" "Formation" "JumpToPoint" "MoveViewPoint" "MoveViewObject" "ClickLButtonPoint" "ClickLButtonObject" "ClickRButtonPoint" "ClickRButtonObject" "DoubleClickLButtonPoint" "DoubleClickLButtonObject" "DoubleClickRButtonPoint" "DoubleClickRButtonObject" "MoveCursorPoint" "ChangeAIScript" "StartTimer" "SendTrigger" "Wait" "UndoExplore" "Explore" "DayNight" "Weather" "CallLightning" "VEquip" "NIDSpecial1" "CreateItem" "SmallWait" "Face" "RandomWalk" "SetInterrupt" "ProtectObject" "Leader" "Follow" "MoveToPointNoRecticle" "LeaveArea" "SelectWeaponAbility" "LeaveAreaName" "GroupAttack" "SpellPoint" "SpellPointRES" "Rest" "UseItemPoint" "AttackNoSound" "RandomFly" "FlyToPoint" "MoraleSet" "MoraleInc" "MoraleDec" "AttackOneRound" "Shout" "MoveToOffset" "EscapeArea" "IncrementGlobal" "LeaveAreaLUA" "DestroySelf" "UseContainer" "ForceSpell" "ForceSpellPoint" "SetGlobalTimer" "TakePartyItem" "TakePartyGold" "GivePartyGold" "DropInventory" "StartCutScene" "StartCutSceneMode" "EndCutSceneMode" "ClearAllActions" "Berserk" "Deactivate" "Activate" "CutSceneId" "AnkhegEmerge" "AnkhegHide" "RandomTurn" "Kill" "VerbalConstant" "ClearActions" "AttackReevaluate" "LockScroll" "UnlockScroll" "StartDialog" "SetDialog" "PlayerDialog" "PlayerDialogue" "GiveItemCreate" "GivePartyGoldGlobal" "UseDoor" "OpenDoor" "CloseDoor" "PickLock" "Polymorph" "RemoveSpell" "RemoveSpellRES" "BashDoor" "EquipMostDamagingMelee" "StartStore" "DisplayString" "ChangeAIType" "ChangeEnemyAlly" "ChangeGeneral" "ChangeRace" "ChangeClass" "ChangeSpecifics" "ChangeGender" "ChangeAlignment" "ApplySpell" "ApplySpellRES" "IncrementChapter" "ReputationSet" "ReputationInc" "AddexperienceParty" "AddExperiencePartyGlobal" "SetNumTimesTalkedTo" "StartMovie" "Interact" "DestroyItem" "RevealAreaOnMap" "GiveGoldForce" "ChangeTileState" "AddJournalEntry" "EquipRanged" "SetLeavePartyDialogFile" "EscapeAreaDestroy" "TriggerActivation" "BreakInstants" "DialogInterrupt" "DialogueInterrupt" "MoveToObjectFollow" "ReallyForceSpell" "ReallyForceSpellRES" "MakeUnselectable" "MultiPlayerSync" "RunAwayFromNoInterrupt" "SetMasterArea" "EndCredits" "StartMusic" "TakePartyItemAll" "LeaveAreaLUAPanic" "SaveGame" "SpellNoDec" "SpellPointNoDec" "TakePartyItemRange" "ChangeAnimation" "Lock" "Unlock" "MoveGlobal" "StartDialogueNoSet" "StartDialogNoSet" "TextScreen" "RandomWalkContinuous" "DetectSecretDoor" "FadeToColor" "FadeFromColor" "TakePartyItemNum" "WaitWait" "MoveToPointNoInterrupt" "MoveToObjectNoInterrupt" "SpawnPtActivate" "SpawnPtDeactivate" "SpawnPtSpawn" "GlobalShout" "StaticStart" "StaticStop" "FollowObjectFormation" "AddFamiliar" "RemoveFamiliar" "PauseGame" "ChangeAnimationNoEffect" "TakeItemListParty" "SetMoraleAI" "IncMoraleAI" "DestroyAllEquipment" "GivePartyAllEquipment" "MoveBetweenAreas" "MoveBetweenAreasEffect" "TakeItemListPartyNum" "CreateCreatureObject" "CreateCreatureImpassable" "FaceObject" "RestParty" "CreateCreatureDoor" "CreateCreatureObjectDoor" "CreateCreatureObjectOffScreen" "MoveGlobalObjectOffScreen" "SetQuestDone" "StorePartyLocations" "RestorePartyLocations" "CreateCreatureOffScreen" "MoveToCenterOfScreen" "ReallyForceSpellDead" "Calm" "Ally" "RestNoSpells" "SaveLocation" "SaveObjectLocation" "CreateCreatureAtLocation" "SetToken" "SetTokenObject" "SetGabber" "CreateCreatureObjectCopy" "HideAreaOnMap" "CreateCreatureObjectOffset" "ContainerEnable" "ScreenShake" "AddGlobals" "CreateItemNumGlobal" "PickUpItem" "FillSlot" "AddXPObject" "DestroyGold" "SetHomeLocation" "DisplayStringNoName" "EraseJournalEntry" "CopyGroundPilesTo" "DialogueForceInterrupt" "DialogForceInterrupt" "StartDialogInterrupt" "StartDialogueInterrupt" "StartDialogueNoSetInterrupt" "StartDialogNoSetInterrupt" "RealSetGlobalTimer" "DisplayStringHead" "PolymorphCopy" "VerbalConstantHead" "CreateVisualEffect" "CreateVisualEffectObject" "AddKit" "StartCombatCounter" "EscapeAreaNoSee" "EscapeAreaObject" "EscapeAreaObjectMove" "TakeItemReplace" "AddSpecialAbility" "DestroyAllDestructableEquipment" "RemovePaladinHood" "RemoveRangerHood" "RegainPaladinHood" "RegainRangerHood" "PolymorphCopyBase" "HideGUI" "UnhideGUI" "SetName" "AddSuperKit" "PlayDeadInterruptable" "PlayDeadInterruptible" "MoveGlobalObject" "DisplayStringHeadOwner" "StartDialogOverride" "StartDialogOverride" "StartDialogOverrideInterrupt" "CreateCreatureCopyPoint" "BattleSong" "MoveToSavedLocation" "MoveToSavedLocationn" "ApplyDamage" "BanterBlockTime" "BanterBlockFlag" "AmbientActivate" "AttachTransitionToDoor" "DeathMatchPositionGlobal" "DeathMatchPositionArea" "DeathMatchPositionLocal" "ApplyDamagePercent" "SG" "AddMapNote" "DemoEnd" "MoveGlobalsTo" "DisplayStringWait" "StateOverrideTime" "StateOverrideFlag" "SetRestEncounterProbabilityDay" "SetRestEncounterProbabilityNight" "SoundActivate" "PlaySong" "ForceSpellRange" "ForceSpellPointRange" "SetPlayerSound" "SetAreaRestFlag" "FakeEffectExpiryCheck" "CreateCreatureImpassableAllowOverlap" "SetBeenInPartyFlags" "GoToStartScreen" "ExitPocketPlane" "AddXP2DA" "RemoveMapNote" "TriggerWalkTo" "AddAreaType" "RemoveAreaType" "AddAreaFlags" "RemoveAreaFlags" "StartDialogNoName" "SetTokenGlobal" "MakeGlobal" "ReallyForceSpellPoint" "SetCutSceneLite" "CutAllowScripts" "SetCursorState" "SwingOnce" "StaticSequence" "StaticPalette" "DisplayStringHeadDead" "MoveToExpansion" "StartRainNow" "SetSequence" "DisplayStringNoNameHead" "SetEncounterProbability" "SetupWish" "SetupWishObject" "LeaveAreaLUAEntry" "LeaveAreaLUAPanicEntry") 'words))

(defconst weidu-baf-font-lock-keywords-1 (list (cons weidu-baf-triggers font-lock-builtin-face)))
(defconst weidu-baf-font-lock-keywords-2
  (append weidu-baf-font-lock-keywords-1 (list (cons weidu-baf-actions font-lock-function-name-face))))
(defconst weidu-baf-font-lock-keywords-3 
  (append weidu-baf-font-lock-keywords-2 
    (list (cons (regexp-opt '("IF" "THEN" "RESPONSE" "END")) font-lock-keyword-face))))

;font-lock-comment-face           -maroon
;font-lock-comment-delimiter-face -maroon
;font-lock-doc-face               -beige
;font-lock-string-face            -beige
;font-lock-keyword-face           -purple
;font-lock-builtin-face           -pink
;font-lock-function-name-face     -blue
;font-lock-variable-name-face     -yellow
;font-lock-type-face              -green
;font-lock-constant-face          -teal
;font-lock-preprocessor-face      -maroon
;font-lock-negation-char-face     -black
;font-lock-warning-face           -red

(defvar weidu-baf-font-lock-keywords weidu-baf-font-lock-keywords-3)

;; IF
;;   Triggers
;; THEN
;;   RESPONSE #x
;;     Actions
;; END

(defvar weidu-baf-indent-width 2)

(defun weidu-baf-indent-line (&optional move-point)
  "Indents the current line and optionally moves point to the end of the inserted whitespace."
  (interactive)
  (let (indented-p indent)
    (save-excursion
      (beginning-of-line)
      (when (or (bobp) (looking-at "^[ \t]*THEN") (looking-at "^[ \t]*END"))
	(setq indent nil)
	(setq indented-p t))
      (while (null indented-p)
	(forward-line -1)
	(cond ((looking-at "^[ \t]*IF")
	       (progn
		 (setq indent weidu-baf-indent-width)
		 (setq indented-p t)))
	      ((bobp)
	       (progn
		 (setq indent nil)
		 (setq indented-p t)))
	      ((looking-at (concat "^[ \t]*" weidu-baf-triggers))
	       (progn
		 (setq indent weidu-baf-indent-width)
		 (setq indented-p t)))
	      ((looking-at "^[ \t]*THEN")
	       (progn
		 (setq indent weidu-baf-indent-width)
		 (setq indented-p t)))
	      ((looking-at "^[ \t]*RESPONSE")
	       (progn
		 (setq indent (* weidu-baf-indent-width 2))
		 (setq indented-p t)))
	      ((looking-at (concat "^[ \t]*" weidu-baf-actions))
	       (progn
		 (setq indent (* weidu-baf-indent-width 2))
		 (setq indented-p t)))
	      ((looking-at "^[ \t]*END")
	       (progn
		 (setq indent nil)
		 (setq indented-p t))))))	   
    (if move-point
	(if indent
	    (indent-line-to indent)
	    (indent-line-to 0))
	(save-excursion
	  (if indent
	      (indent-line-to indent)
	      (indent-line-to 0))))))

(defun weidu-baf-indent-block ()
  "Indents the current block, from IF to END."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (when (looking-at "^[ \t]*IF")
      (let (done)
	(while (null done)
	  (weidu-baf-indent-line)
	  (forward-line 1)
	  (when (or (eobp) (looking-at "^[ \t]*END"))
	    (setq done t)))))))

(defun weidu-baf-indent-newline-indent ()
  "Indents the current line, inserts a newline and indents while moving point."
  (interactive)
  (weidu-baf-indent-line)
  (newline)
  (weidu-baf-indent-line t))

(defvar weidu-baf-mode-syntax-table
  (let ((weidu-baf-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" weidu-baf-mode-syntax-table)
    ;(modify-syntax-entry ?# "w" weidu-baf-mode-syntax-table) ;Probably shouldn't have this
    ;(modify-syntax-table ?~ '"'  weidu-baf-mode-syntax-table) ;Need to get this working
    (modify-syntax-entry ?/ ". 124b" weidu-baf-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" weidu-baf-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" weidu-baf-mode-syntax-table)
    weidu-baf-mode-syntax-table))

(defun weidu-baf-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map weidu-baf-mode-map)
  (set-syntax-table weidu-baf-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(weidu-baf-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'weidu-baf-indent-line)
  (setq mode-name "WeiDU-BAF")
  (run-hooks 'weidu-baf-mode-hook)
  (setq major-mode weidu-baf-mode))

(provide 'weidu-baf-mode)