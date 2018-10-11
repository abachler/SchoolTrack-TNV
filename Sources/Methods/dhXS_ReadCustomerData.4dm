//%attributes = {}
  //dhXS_ReadCustomerData

  // 20051218 ABK 
  //dhXS_ReadCustomerData
Case of 
	: (<>vtXS_CountryCode="cl")
		<>vs_AppDecimalSeparator:=(PREF_fGet (0;"DecimalSeparator";","))
	: (<>vtXS_CountryCode="co")
		<>vs_AppDecimalSeparator:=(PREF_fGet (0;"DecimalSeparator";","))
	: (<>vtXS_CountryCode="pe")
		<>vs_AppDecimalSeparator:=(PREF_fGet (0;"DecimalSeparator";","))
	: (<>vtXS_CountryCode="ar")
		<>vs_AppDecimalSeparator:=(PREF_fGet (0;"DecimalSeparator";","))
	: (<>vtXS_CountryCode="mx")
		<>vs_AppDecimalSeparator:=(PREF_fGet (0;"DecimalSeparator";"."))
	Else 
		<>vs_AppDecimalSeparator:=(PREF_fGet (0;"DecimalSeparator";","))
End case 

If (<>vs_AppDecimalSeparator="")
	Case of 
		: (<>vtXS_CountryCode="cl")
			PREF_Set (0;"DecimalSeparator";",")
		: (<>vtXS_CountryCode="co")
			PREF_Set (0;"DecimalSeparator";",")
		: (<>vtXS_CountryCode="pe")
			PREF_Set (0;"DecimalSeparator";",")
		: (<>vtXS_CountryCode="ar")
			PREF_Set (0;"DecimalSeparator";",")
		: (<>vtXS_CountryCode="mx")
			PREF_Set (0;"DecimalSeparator";".")
		Else 
			PREF_Set (0;"DecimalSeparator";",")
	End case 
End if 