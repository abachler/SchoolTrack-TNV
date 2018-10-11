If (r_ST=1)
	SN3_Log_LoadST (vd_Log_SelectedFecha;cb_Log_VerErrores;cb_Log_VerInfo;cb_Log_VerGeneracion;cb_Log_VerEnvios)
Else 
	SN3_Log_ManageSNLog (vd_Log_SelectedFecha;cb_Log_VerErrores;cb_Log_VerInfo;cb_Log_VerGeneracion;cb_Log_VerEnvios)
End if 