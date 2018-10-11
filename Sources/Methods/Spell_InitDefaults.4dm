//%attributes = {}
  //Spell_InitDefaults
C_TEXT:C284(<>vtXS_CountryCode)
C_LONGINT:C283(<>vl_Langage)
C_BOOLEAN:C305(<>vb_AutoSpellCheck;<>vb_SpellCheckTextFieldOnly)


<>vb_SpellCheckNow:=False:C215
<>vb_AutoSpellCheck:=(PREF_fGet (USR_GetUserID ;"AutoSpellCheck";"1")="1")
<>vb_SpellCheckTextFieldOnly:=(PREF_fGet (USR_GetUserID ;"SpellCheck_TextFieldsOnly";"1")="1")
Case of 
	: (<>vtXS_CountryCode="cl")
		<>vl_Langage:=196867
	: (<>vtXS_CountryCode="ar")
		<>vl_Langage:=196865
	: (<>vtXS_CountryCode="mx")
		<>vl_Langage:=196875
	: (<>vtXS_CountryCode="pe")
		<>vl_Langage:=196879
	: (<>vtXS_CountryCode="es")
		<>vl_Langage:=196608
		
	: (<>vtXS_CountryCode="us")
		<>vl_Langage:=65792
	: (<>vtXS_CountryCode="ir")
		<>vl_Langage:=65600
	: (<>vtXS_CountryCode="ie")
		<>vl_Langage:=65600
		
	: (<>vtXS_CountryCode="fr")
		<>vl_Langage:=262144
	: (<>vtXS_CountryCode="ca")
		<>vl_Langage:=262160
	: (<>vtXS_CountryCode="be")
		<>vl_Langage:=262176
		
	Else 
		<>vl_Langage:=196608
End case 
<>vl_Langage:=Num:C11(PREF_fGet (USR_GetUserID ;"SpellCheck_LANGAGE";String:C10(<>vl_Langage)))
  //20140404 RCH Se pasa lectura al onload del browser
  //  //ASM 20140327 Agrego una tarea Bach para setear el diccionario.
  //BM_CreateRequest ("STR_SeteaDiccionario";String(<>vl_Langage);String(<>vl_Langage))