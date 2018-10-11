//%attributes = {}
  // ACTac_EnvioACXEmail()
  //
  //
  // creado por: Alberto Bachler Klein: 08/02/17, 20:29:03
  // -----------------------------------------------------------
C_LONGINT:C283($l_opcion;$l_proceso)
C_TEXT:C284($t_rutaCarpeta)

ARRAY TEXT:C222($at_documentos;0)

If (USR_GetMethodAcces ("ACTac_EnvioACXEmail"))
	$t_rutaCarpeta:=SYS_CarpetaAplicacion (CLG_Intercambios_ACT)+"AvisosPorEnviar"+SYS_FolderDelimiterOnServer 
	SYS_CreateFolderOnServer ($t_rutaCarpeta)
	SYS_DocumentListOnServer ($t_rutaCarpeta;->$at_documentos)
	
	If (Size of array:C274($at_documentos)>0)
		$l_opcion:=CD_Dlog (0;__ ("Se enviará(n) ")+String:C10(Size of array:C274($at_documentos))+__ (" Aviso(s) de Cobranza por correo electrónico.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
		If ($l_opcion=1)
			$l_proceso:=Execute on server:C373("PCSrun_ACT_MailSender";0;"Envio de Avisos de Cobranza")
		End if 
	Else 
		CD_Dlog (0;__ ("No hay Avisos de cobranza por enviar."))
	End if 
End if 