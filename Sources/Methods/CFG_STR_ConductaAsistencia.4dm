//%attributes = {}
  //CFG_STR_ConductaAsistencia

If (Semaphore:C143("ConductaAsistencia"))
	CD_Dlog (0;__ ("La configuración de Conducta y Asistencia está siendo modificada por otro usuario.\rInténtelo más tarde.");__ ("");__ ("Aceptar"))
Else 
	CFG_OpenConfigPanel (->[xxSTR_Constants:1];"STR_CFG_ConductaAsistencia")
End if 
CLEAR SEMAPHORE:C144("ConductaAsistencia")
