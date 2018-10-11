If ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
	FORM SET OUTPUT:C54([xxSTR_Subasignaturas:83];"PlanillaSubasignatura")
	PRINT RECORD:C71([xxSTR_Subasignaturas:83])
	FORM SET OUTPUT:C54([xxSTR_Subasignaturas:83];"Output")
End if 