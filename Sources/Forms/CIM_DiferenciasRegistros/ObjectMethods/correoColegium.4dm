  // CIM_DiferenciasRegistros.correoColegium()
  // Por: Alberto Bachler K.: 28-09-14, 17:57:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TIME:C306($h_RefDoc)
C_POINTER:C301($y_diferencia;$y_nombreTabla;$y_numeroTabla;$y_registrosAntes;$y_registrosDespues)
C_TEXT:C284($t_Cuerpo;$t_docXLS;$t_dts;$t_Encabezados;$t_error;$t_jsonPerdidaRegistros;$t_logFolder;$t_nombreEstructura;$t_refJson;$t_rutaConteoDespues)
C_TEXT:C284($t_texto2;$t_versionBaseDeDatos;$t_versionEstructura)

ARRAY TEXT:C222($at_adjuntos;0)
C_OBJECT:C1216($ob)

$y_numeroTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"numeroTabla")
$y_nombreTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreTabla")
$y_registrosAntes:=OBJECT Get pointer:C1124(Object named:K67:5;"registrosAntes")
$y_registrosDespues:=OBJECT Get pointer:C1124(Object named:K67:5;"registrosDespues")
$y_diferencia:=OBJECT Get pointer:C1124(Object named:K67:5;"diferencia")


$t_jsonPerdidaRegistros:=vt_jsonPerdidaRegistros


  // Modificado por: Alexis Bustamante (10-06-2017)
  //Ticket 179869


$ob:=JSON Parse:C1218($t_jsonPerdidaRegistros)
OB_GET ($ob;$y_numeroTabla;"numeroTabla")
OB_GET ($ob;$y_nombreTabla;"nombreTabla")
OB_GET ($ob;$y_registrosAntes;"registrosAntes")
OB_GET ($ob;$y_registrosDespues;"registrosDespues")
OB_GET ($ob;$y_diferencia;"registrosPerdidos")

  //$t_refJson:=JSON Parse text ($t_jsonPerdidaRegistros)
  //JSON_ExtraeValorElemento ($t_refJson;$y_numeroTabla;"numeroTabla")
  //JSON_ExtraeValorElemento ($t_refJson;$y_nombreTabla;"nombreTabla")
  //JSON_ExtraeValorElemento ($t_refJson;$y_registrosAntes;"registrosAntes")
  //JSON_ExtraeValorElemento ($t_refJson;$y_registrosDespues;"registrosDespues")
  //JSON_ExtraeValorElemento ($t_refJson;$y_diferencia;"registrosPerdidos")
  //JSON CLOSE ($t_refJson)

$t_rutaConteoDespues:=Temporary folder:C486+"Comparacion registros - DTS"+$t_dts+".xls"
$h_RefDoc:=Create document:C266($t_rutaConteoDespues)
$t_Encabezados:="Nº Tabla\tNombre de la tabla\tRegistros antes\tRegistros despues\tDiferencia\r"
SEND PACKET:C103($h_RefDoc;$t_Encabezados)
$t_docXLS:=AT_Arrays2Text ("\r";"\t";$y_numeroTabla;$y_nombreTabla;$y_registrosAntes;$y_registrosDespues;$y_diferencia)
SEND PACKET:C103($h_RefDoc;$t_docXLS)
CLOSE DOCUMENT:C267($h_RefDoc)

APPEND TO ARRAY:C911($at_adjuntos;$t_rutaConteoDespues)


$t_versionEstructura:=SYS_LeeVersionEstructura 
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos 
$t_Cuerpo:=__ ("Se detectó pérdida de registros en algunas tablas después de la verificación o compactación previa a la actualización la aplicación desde ^0 a ^1 de la base de datos de ")+<>gCustom+": \r\r"
$t_Cuerpo:=$t_Cuerpo+__ ("Se adjunta un documento con el detalle de las diferencias.")
$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("La base de datos se encuentra en el servidor SchoolTrack del colegio en la ruta siguiente:\r")+Data file:C490+"\r\r"
$t_cuerpo:=Replace string:C233($t_Cuerpo;"^0";$t_versionBaseDeDatos)
$t_cuerpo:=Replace string:C233($t_Cuerpo;"^1";$t_versionEstructura)
$t_asunto:="Reporte de pérdida de registros en base de datos de "+<>gCustom
$t_destinatario:="soporte@colegium.com"
$t_copia:="qa@colegium.com"
$t_copiaOculta:="abachler@colegium.com"

$t_mensaje:=__ ("Perdida de registros detectada...")+"\r"+__ ("Enviando informe a Colegium...")
$t_Error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaOculta;->$at_adjuntos;$t_mensaje)

If ($t_error="")
	$t_texto2:=__ ("Se envió un informe Colegium. Si necesita apoyo por favor pongase en contacto con la mesa de ayuda.")
Else 
	$t_texto2:=__ ("No fue posible enviar automáticamente el informe a Colegium. Si necesita apoyo por favor envíe el informe y pongase en contacto con la mesa de ayuda.")
End if 
OBJECT SET TITLE:C194(*;"textoApoyo";$t_texto2)

