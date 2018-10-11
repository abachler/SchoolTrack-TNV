//%attributes = {}
If (USR_GetMethodAcces ("Lenguaje_Manager";0))
	ARRAY TEXT:C222(<>aStrText;0)
	ARRAY INTEGER:C220(<>aStrIndex;0)
	ARRAY INTEGER:C220(<>aStrId;0)
	C_LONGINT:C283($i)
	<>sRsrID:=""
	ARRAY TEXT:C222(<>aPopRsr;0)
	ARRAY LONGINT:C221(<>aPopRsrID;0)
	ARRAY TEXT:C222(<>aLang;0)
	LIST TO ARRAY:C288("STR_InformesNotas_Idiomas";<>aLang)
	READ ONLY:C145([xxSTR_TextosInformesNotas:56])
	ALL RECORDS:C47([xxSTR_TextosInformesNotas:56])
	ARRAY LONGINT:C221(<>aPopRsrID;0)
	ARRAY TEXT:C222(<>aPopRsr;0)
	SELECTION TO ARRAY:C260([xxSTR_TextosInformesNotas:56]ID:1;<>aPopRsrID;[xxSTR_TextosInformesNotas:56]Name:2;<>aPopRsr)
	For ($i;1;Size of array:C274(<>aPopRsr))
		<>aPopRsr{$i}:=String:C10(<>aPopRsrID{$i};"00000")+": "+<>aPopRsr{$i}
	End for 
	SORT ARRAY:C229(<>aPopRsrID;<>aPopRsr)
	<>aLang:=1
	<>langPtr:=Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);<>aLang+7)
	WDW_OpenFormWindow (->[xxSTR_TextosInformesNotas:56];"MasterMngr";0;4;__ ("Traducción"))
	DIALOG:C40([xxSTR_TextosInformesNotas:56];"MasterMngr")
	CLOSE WINDOW:C154
	UNLOAD RECORD:C212([xxSTR_TextosInformesNotas:56])
	READ ONLY:C145([xxSTR_TextosInformesNotas:56])
Else 
	CD_Dlog (0;__ ("Lo siento. Ud. no dispone de los derechos que le permiten modificar la configuración de lenguaje."))
End if 