
Case of 
	: (Form event:C388=On Close Box:K2:21)
		C_TEXT:C284($t_resultado)
		  //MONO ticket 144984
		C_OBJECT:C1216($ob_request;$ob_response)
		C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json;$t_resultado)
		C_LONGINT:C283($httpStatus_l)
		C_BOOLEAN:C305($b_errorResponse)
		
		$ob_request:=OB_Create 
		OB_SET ($ob_request;-><>GROLBD;"rolbd")
		OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")
		OB_SET ($ob_request;->vt_MailAddresses;"mails")
		$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
		$httpStatus_l:=Intranet3_LlamadoWS ("WSset_EncargadosSTWA";$t_jsonRequest;->$t_json)
		
		If ($httpStatus_l=200)
			$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
			OB_GET ($ob_response;->$b_errorResponse;"error")
			OB_GET ($ob_response;->$t_errormsg;"mensaje")
			OB_GET ($ob_response;->$t_resultado;"resultado")
			
			If ($b_errorResponse)
				LOG_RegisterEvt (__ ("Error al registrar email de encargado en Intranet: ")+$t_errormsg)
			End if 
		End if 
		
		  //guardo las propiedades del blob
		C_BLOB:C604($xblob)
		BLOB_Variables2Blob (->$xblob;0;->atSTWA2_nombreCS;->atSTWA2_IPs;->abSTWA2_Activo)
		PREF_SetBlob (0;"STWA2_SERVICIO_SSO";$xblob)
		PREF_Set (0;"STWA2_SERVICIO_SSO";Choose:C955(<>b_STWA2_ssoActivo;"SI";"NO"))
		
		If ((Macintosh option down:C545 | Windows Alt down:C563))
			CANCEL:C270
		Else 
			HIDE PROCESS:C324(Current process:C322)
		End if 
		
		
		  //guardo las opciones de reemplazo
		STWA2_ReemplazaUsuario ("GuardarConfiguracionBlob")
		CANCEL:C270
	: (Form event:C388=On Load:K2:1)
		
		  //STWA2
		hl_Tab_STWA2:=AT_Array2ReferencedList (-><>atSTWA2_Configuracion;-><>alSTWA2_Configuracion;0;False:C215;True:C214)
		
		C_BLOB:C604($blob)
		ARRAY TEXT:C222(atSTWA2_nombreCS;0)
		ARRAY TEXT:C222(atSTWA2_IPs;0)
		ARRAY BOOLEAN:C223(abSTWA2_Activo;0)
		$blob:=PREF_fGetBlob (0;"STWA2_SERVICIO_SSO")
		If (BLOB size:C605($blob)>0)
			BLOB_Blob2Vars (->$blob;0;->atSTWA2_nombreCS;->atSTWA2_IPs;->abSTWA2_Activo)
		End if 
		<>b_STWA2_ssoActivo:=Choose:C955(PREF_fGet (0;"STWA2_SERVICIO_SSO";"NO")="SI";True:C214;False:C215)
		vl_habiitar:=Choose:C955(<>b_STWA2_ssoActivo;1;0)
		
		vt_MailAddresses:=PREF_fGet (0;"EncargadosSTWA";"")
		vlSTWA2_Timeout:=(Num:C11(PREF_fGet (0;"TimeoutSTWA";"600"))/60)
		  //<>vlSTWA2_Timeout:=vlSTWA2_Timeout*60
		
		STWA2_ManejaTiempoDeSesion ("setArrayListbox")
		
		
		
		SET TIMER:C645(60)
		ARRAY LONGINT:C221(alSTWA2_EstiloLB;0)
		ARRAY TEXT:C222(atSTWA2_Usuarios;0)
		ARRAY TEXT:C222(atSTWA2_TiempoRestante;0)
		ARRAY TEXT:C222(atSTWA2_IP;0)
		ARRAY TEXT:C222(atSTWA2_Ultima;0)
		ARRAY TEXT:C222(atSTWA2_SessionUUID;0)
		ARRAY LONGINT:C221($restante;0)
		ARRAY LONGINT:C221($userID;0)
		ARRAY LONGINT:C221($ultima;0)
		ARRAY LONGINT:C221(alSTWA2_DeleteGhostSession;0)
		cb_DeshabillitarSTWA:=Num:C11(PREF_fGet (0;"DeshabilitarSTWA";"0"))
		cb_DeshabillitarPredictivo:=Num:C11(PREF_fGet (0;"DeshabillitarPredictivo";"0"))
		cb_habilitarReemplazo:=Num:C11(PREF_fGet (0;"HabilitaReemplazo";"0"))  //ASM 20151209 opcion reemplazo
		If (cb_DeshabillitarSTWA=1)
			OBJECT SET ENTERABLE:C238(vlSTWA2_Timeout;False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(vlSTWA2_Timeout;True:C214)
		End if 
		READ ONLY:C145([STWA2_SessionManager:290])
		QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]Activa:7=True:C214)
		SELECTION TO ARRAY:C260([STWA2_SessionManager:290]Auto_UUID:1;atSTWA2_SessionUUID;[STWA2_SessionManager:290]User_ID:2;$userID;[STWA2_SessionManager:290]Last_Seen:4;$ultima;\
			[STWA2_SessionManager:290]IP_Browser:6;atSTWA2_IP)
		$currTime:=Current time:C178*1
		For ($i;1;Size of array:C274($userID))
			$l_Timeout:=STWA2_ManejaTiempoDeSesion ("cargaVariableTimeout";$userID{$i})
			APPEND TO ARRAY:C911(atSTWA2_Usuarios;USR_GetUserName ($userID{$i}))
			APPEND TO ARRAY:C911(atSTWA2_Ultima;Time string:C180($ultima{$i}))
			APPEND TO ARRAY:C911(atSTWA2_TiempoRestante;Time string:C180($L_Timeout-STWA2_Session_CalcRemaining ($currTime;$ultima{$i})))
			APPEND TO ARRAY:C911($restante;$L_Timeout-STWA2_Session_CalcRemaining ($currTime;$ultima{$i}))
			APPEND TO ARRAY:C911(alSTWA2_EstiloLB;Plain:K14:1)
			APPEND TO ARRAY:C911(alSTWA2_DeleteGhostSession;0)
		End for 
		SORT ARRAY:C229($restante;atSTWA2_TiempoRestante;atSTWA2_Usuarios;atSTWA2_IP;atSTWA2_Ultima;atSTWA2_SessionUUID;>)
		OBJECT SET ENABLED:C1123(bDesconectar;False:C215)
		
		  // acá llamo al metodo para validar todas las opciones de Reemplazo
		STWA2_ReemplazaUsuario ("inicializa")
		
		  // para cargar interfaz y manejo de imagenes
		STWA2_ManejaImagenResponsive ("init")
		
	: (Form event:C388=On Timer:K2:25)
		ARRAY LONGINT:C221($DA_Return;0)
		ARRAY TEXT:C222($selectedUUIDs;0)
		lb_UsuariosSTWA2{0}:=True:C214
		AT_SearchArray (->lb_UsuariosSTWA2;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)>0)
			For ($i;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($selectedUUIDs;atSTWA2_SessionUUID{$DA_Return{$i}})
			End for 
		End if 
		ARRAY LONGINT:C221(alSTWA2_EstiloLB;0)
		ARRAY TEXT:C222($atSTWA2_Usuarios;0)
		ARRAY TEXT:C222($atSTWA2_TiempoRestante;0)
		ARRAY TEXT:C222($atSTWA2_IP;0)
		ARRAY TEXT:C222($atSTWA2_Ultima;0)
		ARRAY TEXT:C222($atSTWA2_SessionUUID;0)
		ARRAY LONGINT:C221($alSTWA2_DeleteGhostSession;0)
		COPY ARRAY:C226(atSTWA2_Usuarios;$atSTWA2_Usuarios)
		COPY ARRAY:C226(atSTWA2_SessionUUID;$atSTWA2_SessionUUID)
		COPY ARRAY:C226(atSTWA2_IP;$atSTWA2_IP)
		COPY ARRAY:C226(atSTWA2_Ultima;$atSTWA2_Ultima)
		COPY ARRAY:C226(alSTWA2_DeleteGhostSession;$alSTWA2_DeleteGhostSession)
		ARRAY TEXT:C222(atSTWA2_Usuarios;0)
		ARRAY TEXT:C222(atSTWA2_TiempoRestante;0)
		ARRAY TEXT:C222(atSTWA2_IP;0)
		ARRAY TEXT:C222(atSTWA2_Ultima;0)
		ARRAY TEXT:C222(atSTWA2_SessionUUID;0)
		ARRAY LONGINT:C221($restante;0)
		ARRAY LONGINT:C221($userID;0)
		ARRAY LONGINT:C221($ultima;0)
		ARRAY LONGINT:C221(alSTWA2_DeleteGhostSession;0)
		cb_DeshabillitarSTWA:=Num:C11(PREF_fGet (0;"DeshabilitarSTWA";"0"))
		If (cb_DeshabillitarSTWA=1)
			OBJECT SET ENTERABLE:C238(vlSTWA2_Timeout;False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(vlSTWA2_Timeout;True:C214)
		End if 
		READ ONLY:C145([STWA2_SessionManager:290])
		ALL RECORDS:C47([STWA2_SessionManager:290])
		QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]Activa:7=True:C214)
		SELECTION TO ARRAY:C260([STWA2_SessionManager:290]Auto_UUID:1;atSTWA2_SessionUUID;[STWA2_SessionManager:290]User_ID:2;$userID;[STWA2_SessionManager:290]Last_Seen:4;$ultima;\
			[STWA2_SessionManager:290]IP_Browser:6;atSTWA2_IP)
		$currTime:=Current time:C178*1
		For ($i;1;Size of array:C274($userID))
			$l_Timeout:=STWA2_ManejaTiempoDeSesion ("cargaVariableTimeout";$userID{$I})
			APPEND TO ARRAY:C911(atSTWA2_Usuarios;USR_GetUserName ($userID{$i}))
			APPEND TO ARRAY:C911(atSTWA2_Ultima;Time string:C180($ultima{$i}))
			APPEND TO ARRAY:C911(atSTWA2_TiempoRestante;Time string:C180($l_Timeout-STWA2_Session_CalcRemaining ($currTime;$ultima{$i})))
			APPEND TO ARRAY:C911($restante;$l_Timeout-STWA2_Session_CalcRemaining ($currTime;$ultima{$i}))
			APPEND TO ARRAY:C911(alSTWA2_EstiloLB;Plain:K14:1)
			APPEND TO ARRAY:C911(alSTWA2_DeleteGhostSession;0)
		End for 
		SORT ARRAY:C229($restante;atSTWA2_TiempoRestante;atSTWA2_Usuarios;atSTWA2_IP;atSTWA2_Ultima;atSTWA2_SessionUUID;<)
		For ($i;1;Size of array:C274($atSTWA2_SessionUUID))
			$el:=Find in array:C230(atSTWA2_SessionUUID;$atSTWA2_SessionUUID{$i})
			If ($el=-1)
				If ($alSTWA2_DeleteGhostSession{$i}<15)
					APPEND TO ARRAY:C911(atSTWA2_SessionUUID;$atSTWA2_SessionUUID{$i})
					APPEND TO ARRAY:C911(atSTWA2_Usuarios;$atSTWA2_Usuarios{$i})
					APPEND TO ARRAY:C911(atSTWA2_IP;$atSTWA2_IP{$i})
					APPEND TO ARRAY:C911(atSTWA2_Ultima;$atSTWA2_Ultima{$i})
					APPEND TO ARRAY:C911(atSTWA2_TiempoRestante;"00:00:00")
					APPEND TO ARRAY:C911(alSTWA2_EstiloLB;Italic:K14:3)
					APPEND TO ARRAY:C911(alSTWA2_DeleteGhostSession;$alSTWA2_DeleteGhostSession{$i}+1)
				End if 
			End if 
		End for 
		If (Size of array:C274($selectedUUIDs)>0)
			For ($i;1;Size of array:C274($selectedUUIDs))
				$el:=Find in array:C230(atSTWA2_SessionUUID;$selectedUUIDs{$i})
				If ($el#-1)
					LISTBOX SELECT ROW:C912(lb_UsuariosSTWA2;$el;lk add to selection:K53:2)
				End if 
			End for 
		End if 
End case 