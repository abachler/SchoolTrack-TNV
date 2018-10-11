//%attributes = {}
  //PST_Assistant

If (Semaphore:C143("Config_postulaciones"))
	CD_Dlog (0;__ ("Otro usuario está modificando la configuración del sistema.\rPor favor intente nuevamente esta operación en un momento más."))
Else 
	START TRANSACTION:C239
	C_LONGINT:C283(viPST_gotoAssistPage)
	WDW_Open (580;350;0;4;"Asistente para la creación de grupos de examenes")
	DIALOG:C40([xxSTR_Constants:1];"PST_assistant")
	CLOSE WINDOW:C154
	If (ok=1)
		PST_SaveParameters 
		VALIDATE TRANSACTION:C240
		FLUSH CACHE:C297
	Else 
		CANCEL TRANSACTION:C241
	End if 
	UNLOAD RECORD:C212([ADT_Examenes:122])
	UNLOAD RECORD:C212([ADT_SesionesDeExamenes:123])
	UNLOAD RECORD:C212([ADT_Candidatos:49])
	READ ONLY:C145([ADT_Examenes:122])
	READ ONLY:C145([ADT_SesionesDeExamenes:123])
	READ ONLY:C145([ADT_Candidatos:49])
	CLEAR SEMAPHORE:C144("Config_postulaciones")
	PST_ReadParameters 
End if 