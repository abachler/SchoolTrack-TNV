//%attributes = {}
  //CFG_CMT_Admin

If (LICENCIA_esModuloAutorizado (1;CommTrack))
	If (Semaphore:C143("CMTADM"))
		CD_Dlog (0;__ ("La administración y configuración de CommTrack está en uso por otro usuario."))
	Else 
		CFG_OpenConfigPanel (->[xxSTR_Constants:1];"CMT_Administracion")
	End if 
	CLEAR SEMAPHORE:C144("CMTADM")
Else 
	CD_Dlog (0;__ ("Lo siento, su licencia no le permite ejecutar el módulo CommTrack."))
End if 