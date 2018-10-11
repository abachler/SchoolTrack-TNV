Case of 
		
	: (<>vtXS_CountryCode="fr")
		<>vl_Langage:=262144
	: (<>vtXS_CountryCode="ca")
		<>vl_Langage:=262160
	: (<>vtXS_CountryCode="be")
		<>vl_Langage:=262176
	Else 
		<>vl_Langage:=262144
End case 
PREF_Set (USR_GetUserID ;"SpellCheck_LANGAGE";String:C10(<>vl_Langage))
SPELL SET CURRENT DICTIONARY:C904(<>vl_Langage)