//%attributes = {}
  //QA_Pruebas 
  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 05-07-17, 13:05:05
  // ----------------------------------------------------
  // Método: QA_Pruebas
  // Descripción
  // Método para agregar código que ayude a automatizar pruebas
  // Si funciona se trabajará en la captura de errores para la alimentación de un archivo con el resultado de las pruebas
  // Parámetros
  // ----------------------------------------------------

  //XSHELL
  //***** Prueba Verifica valor en variables de proceso con separadores decimales y de miles
ASSERT:C1129(<>tXS_RS_DecimalSeparator#"";"Separador decimal vacío")
ASSERT:C1129(<>tXS_RS_ThousandsSeparator#"";"Separador de miles cacío")
ASSERT:C1129(<>tXS_RS_DateSeparator#"";"Separador de fechas vacío")
ASSERT:C1129(<>tXS_RS_DateFormat#"";"Formato de fechas vacío")

If (Application type:C494=4D Remote mode:K5:5)
	C_TEXT:C284($t_decimal;$t_miles;$t_separadorFechas;$t_formatoFecha)
	GET PROCESS VARIABLE:C371(-1;<>tXS_RS_DecimalSeparator;$t_decimal)
	GET PROCESS VARIABLE:C371(-1;<>tXS_RS_ThousandsSeparator;$t_miles)
	GET PROCESS VARIABLE:C371(-1;<>tXS_RS_DateSeparator;$t_separadorFechas)
	GET PROCESS VARIABLE:C371(-1;<>tXS_RS_DateFormat;$t_formatoFecha)
	
	ASSERT:C1129($t_decimal#"";"Separador decimal vacío")
	ASSERT:C1129($t_miles#"";"Separador de miles cacío")
	ASSERT:C1129($t_separadorFechas#"";"Separador de fechas vacío")
	ASSERT:C1129($t_formatoFecha#"";"Formato de fechas vacío")
End if 

  //***** Prueba Verifica formato "|Despliegue_ACT"
C_TEXT:C284($t_numConformato)
$t_numConformato:=String:C10(1000000;"|Despliegue_ACT")
ASSERT:C1129($t_numConformato#"<<<<<<<";"Problema en formato Despliegue_ACT. Instrucción: String(1000000;"+ST_Qte (" | Despliegue_ACT")+"), formato entregado: "+$t_numConformato+".")

  //Plugins


  //Servicios


  //ST


  //ACT


  //Componente xShell //20171110 RCH
ARRAY TEXT:C222($at_arreglo;0)
$t_texto:="item1;item2;item3"
AT_Text2Array (->$at_arreglo;$t_texto;";")
$l_largo:=Size of array:C274($at_arreglo)
ASSERT:C1129(($l_largo=3);"Error en AT_Text2Array. Largo arreglo: "+String:C10($l_largo)+".")


ARRAY TEXT:C222($at_arreglo;0)
C_TEXT:C284($t_nombresCat)
C_LONGINT:C283($l_largo)
$t_nombresCat:="categoria1;categoria2;categoria3"
AT_AppendItems2TextArray (->$at_arreglo;$t_nombresCat)
$l_largo:=Size of array:C274($at_arreglo)
ASSERT:C1129(($l_largo=3);"Error en AT_AppendItems2TextArray. Largo arreglo: "+String:C10($l_largo)+".")
