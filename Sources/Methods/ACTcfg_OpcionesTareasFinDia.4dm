//%attributes = {}
  //ACTcfg_OpcionesTareasFinDia
C_TEXT:C284($vt_accion;$1)
$vt_accion:=$1


Case of 
	: ($vt_accion="CreateDefPrefsDBNew")
		C_BLOB:C604(xBlob)
		ACTcfg_OpcionesTareasFinDia ("DeclaraVars")
		cbActualizaVencido:=1
		cbActualizaTodosSaldos:=1
		cbRecalcularAvisos:=1
		cbVerificaIntegridadPagos:=1
		ACTcfg_OpcionesTareasFinDia ("GuardaBlob")
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($vt_accion="DeclaraVars")
		C_REAL:C285(cbActualizaVencido;cbActualizaTodosSaldos;cbRecalcularAvisos;cbVerificaIntegridadPagos)
		
	: ($vt_accion="InitVars")
		ACTcfg_OpcionesTareasFinDia ("DeclaraVars")
		cbActualizaVencido:=0
		cbActualizaTodosSaldos:=0
		cbRecalcularAvisos:=0
		cbVerificaIntegridadPagos:=0
		
	: ($vt_accion="LeeBlob")
		ACTcfg_LeeBlob ("ACTcfg_TareasFinDia")
		
	: ($vt_accion="GuardaBlob")
		ACTcfg_GuardaBlob ("ACTcfg_TareasFinDia")
		
	: ($vt_accion="CreaBlob")
		BLOB_Variables2Blob (->xBlob;0;->cbActualizaVencido;->cbActualizaTodosSaldos;->cbRecalcularAvisos;->cbVerificaIntegridadPagos)
		
	: ($vt_accion="CargaBlob")
		BLOB_Blob2Vars (->xBlob;0;->cbActualizaVencido;->cbActualizaTodosSaldos;->cbRecalcularAvisos;->cbVerificaIntegridadPagos)
		
	: ($vt_accion="EjecutaTareasInicioDia")
		ACTcfg_OpcionesTareasFinDia ("LeeBlob")
		  //ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		ACTcfg_OpcionesRazonesSociales ("CargaPrincipal")
		  //ARRAY LONGINT(alACTtid_IdsApdos2Recalc;0)
		  //ARRAY LONGINT(alACTtid_IdsApdos2Recalc2;0)
		  //
		  //READ ONLY([Personas])
		  //QUERY([Personas];[Personas]ES_Apoderado_de_Cuentas=True)
		  //SELECTION TO ARRAY([Personas]No;alACTtid_IdsApdos2Recalc2)
		
		If (cbActualizaVencido=1)
			ACTbm_UpdateMontoVencido 
			LOG_RegisterEvt ("Actualización de montos vencidos terminado.")
		End if 
		
		If (cbRecalcularAvisos=1)
			ACTbm_UpdateAvisos 
			LOG_RegisterEvt ("Actualización de montos de Avisos de Cobranza terminado.")
		End if 
		
		If (cbActualizaTodosSaldos=1)
			ACTbm_UpdateSaldosApdosCtas 
			LOG_RegisterEvt ("Actualización de saldos de apoderados y cuentas terminado.")
		End if 
		If (cbVerificaIntegridadPagos=1)
			C_DATE:C307($vd_fecha)
			$vd_fecha:=Current date:C33(*)-1
			dbuACT_VerificaIntegridadPagos ("Ignorar";Year of:C25($vd_fecha);Month of:C24($vd_fecha);Day of:C23($vd_fecha))
			$subject:="VERIFICACIÓN INTEGRIDAD PAGOS DÍA "+String:C10($vd_fecha)+":"
			If (Size of array:C274(aQR_Longint1)>0)
				$mailAddress:=<>vsACT_EMailContacto
				If (SMTP_VerifyEmailAddress ($mailAddress;False:C215)#"")
					$body:="Estimado(a) usuario:"+"\r\r"+"A continuación se encuentra un listado de pagos con problemas encontrados en la v"+"erificación de datos del día "+String:C10($vd_fecha)+"."+"\r\r"
					$body:=$body+"Pagos Número:"+"\r"+AT_array2text (->aQR_Longint1;"\r";"#######")
					$body:=$body+"\r\r"+"Atentamente,"+"\r\r"+"AccountTrack"
					$from:="<AccountTrack@colegium.com>"
					$password:="quasimodo"
					If (SYS_IsWindows )
						ARRAY TEXT:C222($at_textArray;0)
						$error:=sys_GetNetworkInfo ($networkInfo)
						AT_Text2Array (->$at_textArray;$networkInfo;",")
						$domaine:=$at_textArray{2}
					Else 
						$domaine:=""
					End if 
					$userName:=Current system user:C484
					$machineName:=Current machine:C483
					If (($userName="aBachler") | ($userName="Jaime") | ($machineName="Colegium-@") | ($domaine="lester.colegium.com") | ($machineName="U2") | (Not:C34(Is compiled mode:C492)))
						$mailAddress:="rcatalan@colegium.com"
					End if 
					$userName:="appSchoolTrack@colegium.com"
					$err:=SMTP_Send_Text ("mail.colegium.com";$from;$mailAddress;$subject;$body;$userName;$password;1)
				End if 
				LOG_RegisterEvt ($subject+" Hay "+String:C10(Size of array:C274(aQR_Longint1))+" pago(s) con problema(s), id(s) pago(s): "+AT_array2text (->aQR_Longint1;";";"# ### ###"))
			End if 
			LOG_RegisterEvt ($subject+" Terminado.")
		End if 
		  //ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")  //nos aseguramos de que se limpie arreglo y seteen variables
		  //AT_Initialize (->alACTtid_IdsApdos2Recalc)
End case 