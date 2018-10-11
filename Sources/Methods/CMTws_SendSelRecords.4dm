//%attributes = {}
  //CMTws_SendSelRecords

  // 
  // reception_search_st
  // http://www.commtrack.cl/webservice/servicio.php?wsdl
  // 
  // M?todo generado autom‡ticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_POINTER:C301($5)  // type ARRAY TEXT
C_TEXT:C284($6)
C_TEXT:C284($0)
C_TEXT:C284(vtCMT_Retorno)

WEB SERVICE SET PARAMETER:C777("id_institucion";$1)
WEB SERVICE SET PARAMETER:C777("id_tabla";$2)
WEB SERVICE SET PARAMETER:C777("dts_creacion";$3)
WEB SERVICE SET PARAMETER:C777("nombre_busqueda";$4)
WEB SERVICE SET PARAMETER:C777("usuarios_receptores";$5->)
WEB SERVICE SET PARAMETER:C777("usuario_emisor";$6)

EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
WEB SERVICE CALL:C778("http://www.commtrack.cl/webservice/servicio.php";"http://www.commtrack.cl/webservice/servicio.php/reception_search_st";"reception_search_st";"http://www.commtrack.cl/webservice/servicio.php?wsdl";Web Service dynamic:K48:1)
If (OK=1)
	WEB SERVICE GET RESULT:C779(vtCMT_Retorno;"return";*)  // Liberar la memoria tras recibir el valor.
End if 
EM_ErrorManager ("Clear")
$0:=vtCMT_Retorno
