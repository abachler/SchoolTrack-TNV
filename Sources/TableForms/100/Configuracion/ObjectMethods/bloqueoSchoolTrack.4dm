If (Self:C308->=1)
	<>vd_FechaBloqueoSchoolTrack:=PERIODOS_FinAñoPeriodosSTrack +14
	PREF_Set (0;"BloqueoRecalculosSchoolTrack";String:C10(<>vd_FechaBloqueoSchoolTrack))
	LOG_RegisterEvt ("Bloqueo de modificaciones a situación final activado a contar del: "+String:C10(<>vd_FechaBloqueoSchoolTrack))
	STR_VerificaBloqueoSitFinal 
	If (Application type:C494=4D Remote mode:K5:5)
		$p:=Execute on server:C373("STR_VerificaBloqueoSitFinal";Pila_256K)
		KRL_ExecuteOnConnectedClients ("STR_VerificaBloqueoSitFinal")
	End if 
	OBJECT SET ENTERABLE:C238(<>vd_FechaBloqueoSchoolTrack;True:C214)
Else 
	<>vd_FechaBloqueoSchoolTrack:=!00-00-00!
	PREF_Set (0;"BloqueoRecalculosSchoolTrack";String:C10(<>vd_FechaBloqueoSchoolTrack))
	OBJECT SET ENTERABLE:C238(<>vd_FechaBloqueoSchoolTrack;False:C215)
	STR_VerificaBloqueoSitFinal 
	If (Application type:C494=4D Remote mode:K5:5)
		$p:=Execute on server:C373("STR_VerificaBloqueoSitFinal";Pila_256K)
		KRL_ExecuteOnConnectedClients ("STR_VerificaBloqueoSitFinal")
	End if 
	LOG_RegisterEvt ("Bloqueo de modificaciones a situación final desactivado.")
End if 
