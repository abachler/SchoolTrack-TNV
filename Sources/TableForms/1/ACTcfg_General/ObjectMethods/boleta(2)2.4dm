If ((bAvisoAlumno#bAvisoAlumnoInitial) | (bAvisoApoderado#bAvisoApoderadoInitial))
	BEEP:C151
	WDW_OpenPopupWindow (Self:C308;->[xxSTR_Constants:1];"ACTcfg_WarningEmision";2)
	DIALOG:C40([xxSTR_Constants:1];"ACTcfg_WarningEmision")
	CLOSE WINDOW:C154
End if 
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)