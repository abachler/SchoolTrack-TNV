//%attributes = {}
  //SPELL_SpellCheckPreferences


WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_SpellCheckPreferences";0;8;__ ("Corrector Ortográfico"))
DIALOG:C40([xShell_Dialogs:114];"XS_SpellCheckPreferences")
CLOSE WINDOW:C154

<>vb_AutoSpellCheck:=(PREF_fGet (USR_GetUserID ;"AutoSpellCheck";"1")="1")
<>vb_SpellCheckTextFieldOnly:=(PREF_fGet (USR_GetUserID ;"SpellCheck_TextFieldsOnly";"1")="1")
<>vl_Langage:=Num:C11(PREF_fGet (USR_GetUserID ;"SpellCheck_LANGAGE";String:C10(<>vl_Langage)))
