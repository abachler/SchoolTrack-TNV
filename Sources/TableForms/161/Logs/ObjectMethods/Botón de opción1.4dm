OBJECT SET VISIBLE:C603(*;"bReload@";(r_SN=1))
If (r_ST=1)
	SN3_Log_LoadST (vd_Log_SelectedFecha;cb_Log_VerErrores;cb_Log_VerInfo;cb_Log_VerGeneracion;cb_Log_VerEnvios)
	OBJECT SET TITLE:C194(cb_Log_VerGeneracion;__ ("Generación de Archivos"))
	OBJECT SET TITLE:C194(cb_Log_VerEnvios;__ ("Envío de Archivos"))
Else 
	SN3_Log_ManageSNLog (vd_Log_SelectedFecha;cb_Log_VerErrores;cb_Log_VerInfo;cb_Log_VerGeneracion;cb_Log_VerEnvios)
End if 