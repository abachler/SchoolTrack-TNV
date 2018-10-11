//%attributes = {}
  //CFG_ACT_Contabilidad

If (Test semaphore:C652("ProcesoACT"))
	CD_Dlog (0;__ ("Se están ejecutando procesos que no permiten la modificación de la configuración de AccountTrack. Inténtelo de nuevo más tarde."))
Else 
	If (Semaphore:C143("ConfigACT"))
		CD_Dlog (0;__ ("La configuración de AccountTrack está siendo modificada por otro usuario.\rInténtelo más tarde.");__ ("");__ ("Aceptar"))
	Else 
		CFG_OpenConfigPanel (->[xxSTR_Constants:1];"ACTcfg_Contabilidad")
		ACTcfg_SaveConfig (10)
		CLEAR SEMAPHORE:C144("ConfigACT")
	End if 
End if 