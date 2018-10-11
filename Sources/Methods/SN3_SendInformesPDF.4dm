//%attributes = {}
  // SN3_SendInformesPDF()
  // Por: ??
  //  ---------------------------------------------
  //
  //  ---------------------------------------------
  // Alberto Bachler K.: 20-10-14, 18:39:59
  // Reescritura del método
  // normalización de nombres de variable
  // declaración de variables
  // uso de SYS_CompresionDescompresion para la compresión del archivo
  // ---------------------------------------------


C_BOOLEAN:C305($b_archivoComprimido)
C_LONGINT:C283($i;$l_errorFTP;$l_idConexionFTP;$l_proceso;$l_puertoActual;$l_timeout)
C_TEXT:C284($path;$rutaArchivoRemoto;$t_archivo7z;$t_archivoZip;$t_codigoPais;$t_errorEnvio;$t_nombreArchivoComprimido;$t_resultadoCompresion;$t_rolBD;$t_rutaCarpeta)
C_TEXT:C284($t_rutaDirectorioRemoto;$t_rutaLocalPDFs)

ARRAY TEXT:C222($at_documentos;0)
ARRAY TEXT:C222($at_rutaLocalPDFs;0)

  //MONO 215628 : agrego un objeto de salida para control de errores
C_OBJECT:C1216($0;$o_result)
C_BOOLEAN:C305($b_archivoComprimido;$2;$b_comprimirArchivo)

$t_rutaLocalPDFs:=$1
$b_comprimirArchivo:=$2

If ($b_comprimirArchivo)  //MONO 215628
	$t_archivoZip:=SYS_GetParentNme ($t_rutaLocalPDFs)+"inf_"+DTS_MakeFromDateTime +".zip"
	DOCUMENT LIST:C474($t_rutaLocalPDFs;$at_documentos;Absolute path:K24:14+Ignore invisible:K24:16)
	If (Size of array:C274($at_documentos)>0)
		$b_archivoComprimido:=SYS_CompresionDescompresion ($t_rutaLocalPDFs;$t_archivoZip;"";->$t_resultadoCompresion)
	End if 
Else 
	  //La idea de esto es que reutilizamos el mismo archivo Zip, para un reintento de de envío al ftp.
	$t_archivoZip:=$3
	$b_archivoComprimido:=True:C214
End if 

If ($b_archivoComprimido)
	OB SET:C1220($o_result;"compresion";True:C214)  //MONO 215628
	OB SET:C1220($o_result;"archivoZip";$t_archivoZip)  //MONO 215628
	
	SN3_LoadGeneralSettings 
	$l_errorFTP:=IT_GetTimeOut ($l_timeout)
	$l_errorFTP:=IT_SetTimeOut (127)
	$l_errorFTP:=IT_GetPort (1;$l_puertoActual)
	$l_errorFTP:=IT_SetPort (1;SN3_FTP_Port)
	
	$l_errorFTP:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$l_idConexionFTP)
	If ($l_errorFTP=0)
		$t_codigoPais:=<>vtXS_CountryCode
		$t_rolBD:=<>gRolBD
		  //$l_errorFTP:=FTP_SetPassive ($l_idConexionFTP;<>ftp_UsePassive)
		$l_errorFTP:=FTP_SetPassive ($l_idConexionFTP;1)  //20170520 RCH. Se cambia a pedido de JHB
		$t_rutaDirectorioRemoto:="/documentos3/"+$t_codigoPais+"."+$t_rolBD
		$l_errorFTP:=FTP_CreatePath ($l_idConexionFTP;$t_rutaDirectorioRemoto)
		
		If ($l_errorFTP=0)
			OB SET:C1220($o_result;"conexionFTP";True:C214)  //MONO 215628
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*<>ftp_UsePassive)+") iniciada en el cliente "+Current machine:C483+"/"+Current system user:C484)
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión establecida, identificación aceptada.")
			
			$l_proceso:=IT_UThermometer (1;0;__ ("Enviando Informes en PDF…"))
			$rutaArchivoRemoto:=$t_rutaDirectorioRemoto+"/"+SYS_Path2FileName ($t_archivoZip)
			$t_errorEnvio:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$t_rutaDirectorioRemoto;$t_archivoZip;$rutaArchivoRemoto;True:C214;->$l_idConexionFTP;False:C215)
			If ($t_errorEnvio="")
				OB SET:C1220($o_result;"transferenciaFTP";True:C214)  //MONO 215628
				SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+SYS_Path2FileName ($t_archivoZip)+" ha sido transferido exitósamente.")
				
			Else 
				OB SET:C1220($o_result;"transferenciaFTP";False:C215)  //MONO 215628
				OB SET:C1220($o_result;"transferenciaFTPError";$t_errorEnvio)  //MONO 215628
				SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+SYS_Path2FileName ($t_archivoZip)+" no pudo ser transferido a causa de un error FTP: "+$t_errorEnvio)
				
			End if 
			IT_UThermometer (-2;$l_proceso)
			$l_errorFTP:=FTP_Logout ($l_idConexionFTP)
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP terminada.")
		End if 
		
	Else 
		OB SET:C1220($o_result;"conexionFTP";False:C215)  //MONO 215628
		SN3_RegisterLogEntry (SN3_Log_Error;"Conexión FTP imposible desde esta máquina.")
		
	End if 
	$l_errorFTP:=IT_SetTimeOut ($l_timeout)
	$l_errorFTP:=IT_SetPort (1;$l_puertoActual)
Else 
	OB SET:C1220($o_result;"compresion";False:C215)  //MONO 215628
End if 

$0:=$o_result