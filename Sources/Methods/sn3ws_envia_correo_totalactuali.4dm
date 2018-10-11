//%attributes = {}
  // 
  // sn3ws_envia_correo_totalactualizaciones
  // http://sn3ws.colegium.com/servicios.php?wsdl
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($0)
C_TEXT:C284($vtWS_ErrorString)

WEB SERVICE SET PARAMETER:C777("rol";$1)
WEB SERVICE SET PARAMETER:C777("codigopais";$2)
WEB SERVICE SET PARAMETER:C777("personas";$3)

$vtWS_ErrorString:=SN3_CallWebService ("sn3ws_ActualizacionDatos_proceso.envia_correo_totalactualizaciones")

If ((OK=1) & ($vtWS_ErrorString=""))
	WEB SERVICE GET RESULT:C779($0;"resultado";*)  // Liberar la memoria tras recibir el valor.
Else 
	$0:=$vtWS_ErrorString
End if 
