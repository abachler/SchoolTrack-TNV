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
	Else 
		<>vl_Langage:=196608
End case 
PREF_Set (USR_GetUserID ;"SpellCheck_LANGAGE";String:C10(<>vl_Langage))
SPELL SET CURRENT DICTIONARY:C904(<>vl_Langage)