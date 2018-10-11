Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		HIGHLIGHT TEXT:C210(Self:C308->;1;80)
	: (Form event:C388=On Data Change:K2:15)
		  //◊vd_FechaBloqueoSchoolTrack:=PERIODOS_FinAñoPeriodosSTrack +14
		PREF_Set (0;"BloqueoRecalculosSchoolTrack";String:C10(<>vd_FechaBloqueoSchoolTrack))
		If (<>vd_FechaBloqueoSchoolTrack=!00-00-00!)
			bBloquearSchoolTrack:=0
		Else 
			LOG_RegisterEvt ("Bloqueo de modificaciones a situación final activado a contar del: "+String:C10(<>vd_FechaBloqueoSchoolTrack))
		End if 
		STR_VerificaBloqueoSitFinal 
		If (Application type:C494=4D Remote mode:K5:5)
			$p:=Execute on server:C373("STR_VerificaBloqueoSitFinal";Pila_256K)
			KRL_ExecuteOnConnectedClients ("STR_VerificaBloqueoSitFinal")
		End if 
		STR_VerificaBloqueoSitFinal 
End case 