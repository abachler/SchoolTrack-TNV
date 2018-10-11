Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		WEB_LoadSettings 
		NET_Configuration ("Read")
		
		C_TEXT:C284($dts)
		
		If (LICENCIA_esModuloAutorizado (1;CommTrack))
			OBJECT SET ENABLED:C1123(*;"obj_vl_CMT_OnOff";True:C214)
		Else 
			<>vl_CMT_OnOff:=0
			PREF_Set (0;"CMT_ONOFF";String:C10(<>vl_CMT_OnOff))
			OBJECT SET ENABLED:C1123(*;"obj_vl_CMT_OnOff";False:C215)
		End if 
		
		aHL_CMT_ConfigLog:=LOC_LoadList ("SNT_ConfigLogs")
		
		hl_ConfigItemsCMT:=AT_Array2ReferencedList (-><>atCMT_Config;-><>alCMT_Config;0;False:C215;True:C214)
		aHL_CMT_Config:=AT_Array2ReferencedList (-><>atCMT_PaginasConfig;-><>alCMT_PaginasConfig;0;False:C215;True:C214)
		
		  // Nuevo RCB
		
		$schedule:=PREF_fGet (0;"CommTrack Updates";"3")
		$dts:=PREF_fGet (0;"CommTrack NextSend";DTS_MakeFromDateTime (Current date:C33(*);?00:00:00?))
		vh_NextExec:=String:C10(DTS_GetTime ($dts))
		SELECT LIST ITEMS BY POSITION:C381(aHL_schedule;Num:C11($schedule))
		
		vlCMT_SelOptsPage:=1
		vlCMT_SelLogPage:=1
		SELECT LIST ITEMS BY POSITION:C381(aHL_CMT_Config;vlCMT_SelOptsPage)
		SELECT LIST ITEMS BY POSITION:C381(aHL_CMT_ConfigLog;vlCMT_SelLogPage)
		
		vbCMT_LoadedSNLog:=False:C215
		vbCMT_LoadedSTLog:=False:C215
		
		FORM GOTO PAGE:C247(1)
		
		ARRAY DATE:C224(adCMT_Log_Fecha;0)
		ARRAY TEXT:C222(atCMT_Log_Evento;0)
		ARRAY LONGINT:C221(alCMT_Log_Hora;0)
		ARRAY DATE:C224(adCMT_Log_FechaST;0)
		ARRAY TEXT:C222(atCMT_Log_EventoST;0)
		ARRAY LONGINT:C221(alCMT_Log_HoraST;0)
		ARRAY DATE:C224(adCMT_Log_FechaCMT;0)
		ARRAY TEXT:C222(atCMT_Log_EventoCMT;0)
		ARRAY LONGINT:C221(alCMT_Log_HoraCMT;0)
		
		C_LONGINT:C283($vl_Error)
		
		$vl_Error:=ALP_DefaultColSettings (xALP_CMT_LogList;1;"adCMT_Log_Fecha";__ ("Fecha");50;"7")
		$vl_Error:=ALP_DefaultColSettings (xALP_CMT_LogList;2;"alCMT_Log_Hora";__ ("Hora");50;"&/2")
		$vl_Error:=ALP_DefaultColSettings (xALP_CMT_LogList;3;"atCMT_Log_Evento";__ ("Evento");403)
		
		ALP_SetDefaultAppareance (xALP_CMT_LogList)
		AL_SetColOpts (xALP_CMT_LogList;1;1;1;0;0)
		AL_SetRowOpts (xALP_CMT_LogList;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_CMT_LogList;0;1;1)
		AL_SetMiscOpts (xALP_CMT_LogList;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_CMT_LogList;"";"")
		AL_SetScroll (xALP_CMT_LogList;0;-3)
		
		
		ARRAY TEXT:C222(at_CMT_UserType;0)
		ARRAY TEXT:C222(at_CMT_UserName;0)
		ARRAY TEXT:C222(at_CMT_Login;0)
		ARRAY TEXT:C222(at_CMT_Password;0)
		ARRAY BOOLEAN:C223(ab_CMT_UserInactivo;0)
		
		AT_Inc (0)
		$vl_Error:=ALP_DefaultColSettings (xALP_CMTUsers;AT_Inc ;"at_CMT_UserType";__ ("Tipo");75)
		$vl_Error:=ALP_DefaultColSettings (xALP_CMTUsers;AT_Inc ;"at_CMT_UserName";__ ("Apellidos y Nombres");190)
		$vl_Error:=ALP_DefaultColSettings (xALP_CMTUsers;AT_Inc ;"at_CMT_Login";__ ("Usuario");80)
		$vl_Error:=ALP_DefaultColSettings (xALP_CMTUsers;AT_Inc ;"at_CMT_Password";__ ("Contraseña");140)
		$vl_Error:=ALP_DefaultColSettings (xALP_CMTUsers;AT_Inc ;"ab_CMT_UserInactivo";"";0)
		
		ALP_SetDefaultAppareance (xALP_CMTUsers)
		AL_SetColOpts (xALP_CMTUsers;1;1;1;1;0)
		AL_SetRowOpts (xALP_CMTUsers;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_CMTUsers;0;1;1)
		AL_SetMiscOpts (xALP_CMTUsers;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_CMTUsers;"";"")
		AL_SetScroll (xALP_CMTUsers;0;-3)
		
		vtGNC_searchString:=""
		
		cs_envioDesdeColegium:=0
		If (SN3_CheckNotColegium )
			OBJECT SET VISIBLE:C603(*;"cs_envioDesdeColegium";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"cs_envioDesdeColegium";True:C214)
			cs_envioDesdeColegium:=Num:C11(PREF_fGet (0;"CMT_SOPORTE_ENVIOAUT";"0"))
		End if 
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 