Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284(mensajeError)
		C_BOOLEAN:C305(vb_PeriodosValidado;salir)
		salir:=False:C215
		vb_PeriodosValidado:=True:C214
		vt_mensajeError:=""
		
		XS_SetConfigInterface 
		CFG_STR_PeriodosEscolares_NEW ("LoadConfig")
		
		<>vd_FechaBloqueoSchoolTrack:=Date:C102(PREF_fGet (0;"BloqueoRecalculosSchoolTrack";String:C10(!00-00-00!)))
		If (<>vd_FechaBloqueoSchoolTrack>!00-00-00!)
			bBloquearSchoolTrack:=1
			<>vb_BloquearModifSituacionFinal:=True:C214
			OBJECT SET ENTERABLE:C238(<>vd_FechaBloqueoSchoolTrack;True:C214)
		Else 
			<>vb_BloquearModifSituacionFinal:=False:C215
			bBloquearSchoolTrack:=0
			OBJECT SET ENTERABLE:C238(<>vd_FechaBloqueoSchoolTrack;False:C215)
		End if 
		If (vlBWR_CurrentModuleRef=1)
			_O_ENABLE BUTTON:C192(*;"bloqueoSchoolTrack@")
		End if 
		
		OBJECT GET COORDINATES:C663(*;"Separador1";leftSP;$top;$right;$bottom)
		ALL RECORDS:C47([xxSTR_Constants:1])
		READ WRITE:C146([xxSTR_Constants:1])
		FIRST RECORD:C50([xxSTR_Constants:1])
		
		vdST_FechaActual:=Current date:C33(*)
		
		b1_PaginaPeriodos:=1
		If ((USR_GetUserID <0) & (USR_GetUserID >-100))
			OBJECT SET VISIBLE:C603(*;"ID_config@";True:C214)
		End if 
		
		If (([xxSTR_Periodos:100]HoraInicioJornada:6=?00:00:00?) | ([xxSTR_Periodos:100]DuracionHoraEstandar:12=?00:00:00?))
			OBJECT SET ENTERABLE:C238([xxSTR_Periodos:100]Horas_Jornada:9;False:C215)
		Else 
			OBJECT SET ENTERABLE:C238([xxSTR_Periodos:100]Horas_Jornada:9;True:C214)
		End if 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (([xxSTR_Periodos:100]HoraInicioJornada:6=?00:00:00?) | ([xxSTR_Periodos:100]DuracionHoraEstandar:12=?00:00:00?))
			OBJECT SET ENTERABLE:C238([xxSTR_Periodos:100]Horas_Jornada:9;False:C215)
		Else 
			OBJECT SET ENTERABLE:C238([xxSTR_Periodos:100]Horas_Jornada:9;True:C214)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hl_Configuraciones)
		KRL_ReloadAsReadOnly (->[xxSTR_Constants:1])
		STR_ReadGlobals 
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 