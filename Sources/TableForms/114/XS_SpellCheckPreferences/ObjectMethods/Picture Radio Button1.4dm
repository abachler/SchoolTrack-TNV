Case of 
	: (<>vtXS_CountryCode="us")
		<>vl_Langage:=65792
	: (<>vtXS_CountryCode="uk")
		<>vl_Langage:=65536
	: (<>vtXS_CountryCode="ie")
		<>vl_Langage:=65600
	Else 
		<>vl_Langage:=69632
End case 
PREF_Set (USR_GetUserID ;"SpellCheck_LANGAGE";String:C10(<>vl_Langage))
SPELL SET CURRENT DICTIONARY:C904(<>vl_Langage)
