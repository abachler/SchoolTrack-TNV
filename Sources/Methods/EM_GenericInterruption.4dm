//%attributes = {}
  //EM_GenericInterruption

C_BOOLEAN:C305(vbEM_LogError;vbEM_DisplayAlertOnError)
vl_ErrorCode:=error

If (False:C215=True:C214)
	  //para forzar un llamado al kernel y evitar que la ejecución se interrumpa despues de un llamado fallido al kernel
End if 

If (vbEM_DisplayAlertOnError)
	EM_ErrorManager ("DisplayAlert")
End if 
If (vbEM_LogError)
	EM_ErrorManager ("LogError";String:C10(vl_ErrorCode))
End if 
