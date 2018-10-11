//%attributes = {}
  //ACTcc_OpcionesAlertas

C_TEXT:C284($vt_accion;$1)
$vt_accion:=$1

Case of 
	: ($vt_accion="DeclaraVars")
		C_TEXT:C284(vtACT_subject;vtACT_Body;vtACT_To;vtACT_CC;vtACT_BCC)
		C_BOOLEAN:C305(vbACTSM_SubjectDesh;vbACTSM_BodyDesh)
		C_BOOLEAN:C305(vbACTSM_ToDesh;vbACTSM_CCDesh;vbACTSM_BCCDesh)
		C_BOOLEAN:C305(vbACT_formPDFs)
		
	: ($vt_accion="InitVars")
		vtACT_subject:=""
		vtACT_Body:=""
		vtACT_To:=""
		vtACT_CC:=""
		vtACT_BCC:=""
		vbACTSM_SubjectDesh:=False:C215
		vbACTSM_BodyDesh:=False:C215
		vbACTSM_ToDesh:=False:C215
		vbACTSM_CCDesh:=False:C215
		vbACTSM_BCCDesh:=False:C215
		
	: ($vt_accion="LlenaAsuntoYCuerpo")
		ACTcc_OpcionesAlertas ("DeclaraVars")
		ACTcc_OpcionesAlertas ("LlenaAsunto")
		ACTcc_OpcionesAlertas ("LlenaCuerpo")
		
	: ($vt_accion="LlenaAsunto")
		If (vbACT_formPDFs)
			vtACT_subject:=__ ("Problemas en la generación de PDFs de avisos de cobranza")
		Else 
			vtACT_subject:=__ ("Problemas en emisión de avisos de cobranza")
		End if 
		
	: ($vt_accion="LlenaCuerpo")
		ARRAY TEXT:C222($at_motivo;0)
		If (vbACT_formPDFs)
			vtACT_Body:="Estimado Administrador:"+"\r\r"+"El proceso de generación de PDFs de Avisos de Cobranza, para "+String:C10(Size of array:C274(alACT_AvisosImprimir))+" Aviso(s) de Cobranza, comenzado el día: "+String:C10(Current date:C33(*))+" a las: "+String:C10(Current time:C178(*);HH MM AM PM:K7:5)
			vtACT_Body:=vtACT_Body+" por el usuario "+<>tUSR_CurrentUser+", encontró problemas en "+String:C10(Size of array:C274(aDeletedNames))+ST_Boolean2Str (Size of array:C274(aDeletedNames)>1;" avisos:";" aviso:")+"\r\r"
		Else 
			vtACT_Body:="Estimado Administrador:"+"\r\r"+"El proceso de emisión de avisos de cobranza"+", para "+String:C10(Size of array:C274(aLong1))+ST_Boolean2Str (Size of array:C274(aLong1)>1;" cuentas corrientes";" cuenta corriente")+", comenzado el día: "+String:C10(Current date:C33(*))+" a las: "+String:C10(Current time:C178(*);HH MM AM PM:K7:5)
			vtACT_Body:=vtACT_Body+" por el usuario "+<>tUSR_CurrentUser+", encontró problemas en "+String:C10(Size of array:C274(aDeletedNames))+ST_Boolean2Str (Size of array:C274(aDeletedNames)>1;" cuentas:";" cuenta:")+"\r\r"
		End if 
		COPY ARRAY:C226(aMotivo;$at_motivo)
		AT_DistinctsArrayValues (->$at_motivo)
		For ($i;1;Size of array:C274($at_motivo))
			aMotivo{0}:=$at_motivo{$i}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->aMotivo;"=";->$DA_Return)
			vtACT_Body:=vtACT_Body+$at_motivo{$i}+"\r"
			For ($j;1;Size of array:C274($DA_Return))
				vtACT_Body:=vtACT_Body+"\t"+aDeletedNames{$DA_Return{$j}}+"\r"
			End for 
			vtACT_Body:=vtACT_Body+"\r"
		End for 
		vtACT_Body:=vtACT_Body+"\r"+"Atentamente,"+"\r\r"+"Sistema automático de Alertas de AccountTrack "+<>vsACT_RazonSocial
		
	: ($vt_accion="EnviaMail")
		TRACE:C157
		If ((vtACT_To#"") | (vtACT_CC#"") | (vtACT_BCC#""))
			C_BOOLEAN:C305(vbACT_NoMostrarThermo)
			C_LONGINT:C283($pcsID)
			C_TEXT:C284($userName;$pass;$from;$errorString)
			$userName:="accountTrack@colegium.com"
			$pass:="alertasact"
			$from:="AccountTrack - "+<>vsACT_RazonSocial+"<accountTrack@colegium.com>"
			If (Not:C34(vbACT_NoMostrarThermo))
				$pcsID:=IT_UThermometer (1;0;__ ("Enviando mail a ")+<>tUSR_CurrentUser+__ ("..."))
			End if 
			$errorString:=SMTP_Send_Text ("mail.colegium.com";$from;vtACT_to;vtACT_subject;vtACT_Body;$userName;$pass;1;"";vtACT_CC;vtACT_BCC)
			IT_UThermometer (-2;$pcsID)
			If ($errorString#"")
				If ((Not:C34(vbACT_NoMostrarThermo)))
					CD_Dlog (0;$errorString)
				Else 
					LOG_RegisterEvt ($errorString)
				End if 
			End if 
		Else 
			LOG_RegisterEvt ("Se produjeron problemas durante la emisión de avisos de cobranza. El mail automát"+"ico no pudo ser enviado porque no están configuradas las cuentas desde la Configu"+"ración/Generales.")
		End if 
		vbACT_NoMostrarThermo:=False:C215
		
	: ($vt_accion="LlenaDatosEnvio")
		ACTcfg_LeeBlob ("ACTcfg_AlertasYOtros")
		vtACT_To:=vtACTcfg_MailTo
		vtACT_CC:=vtACTcfg_MailCC
		vtACT_BCC:=vtACTcfg_MailBCC
		
End case 