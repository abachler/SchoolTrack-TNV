//%attributes = {}

C_LONGINT:C283($dataType;$2)
C_TEXT:C284($firstTag;$charSet;$3)
C_BOOLEAN:C305($modoP;$configedP;$cualesP;$insertUserConfig;$4;$5;$6)
C_TEXT:C284($modo;$cuales;$vt_maquina;$vt_user)

$refXMLDoc:=$1
$dataType:=$2
$firstTag:=$3
$cualesP:=$4
$configedP:=$5
$insertUserConfig:=False:C215
If (Count parameters:C259=6)
	$insertUserConfig:=$6
End if 

$modoP:=vb_ModoEnvio
  //$charSet:="ISO-8859-1"
  //20120426 RCH desde v11 se generaran los XML en UTF-8. Pruebas de proceso realizadas por CMC
If (Application version:C493>="11@")
	$charSet:="UTF-8"
Else 
	$charSet:="ISO-8859-1"
End if 

$cuales:=ST_Boolean2Text (($cualesP);"todos";"modificados")
$configurado:=ST_Boolean2Text (($configedP);"configurado";"no configurado")
$modo:=ST_Boolean2Text (($modoP);"manual";"automatico")

SAX_OpenRoot ($refXMLDoc;"colegium";$charSet;False:C215)

$vt_RefVersion:=SYS_LeeVersionBaseDeDatos 
$vt_RefContenido:=String:C10($dataType)

SAX_CreateNode ($refXMLDoc;"ref_vers";True:C214;$vt_RefVersion)
SAX_CreateNode ($refXMLDoc;"ref_cont";True:C214;$vt_RefContenido)
SAX_CreateNode ($refXMLDoc;"file_year";True:C214;String:C10(<>gYear;"0000"))

If ($insertUserConfig)
	SN3_InsertUsersConfig ($refXMLDoc)
End if 

SAX_CreateNode ($refXMLDoc;"cuales";True:C214;$cuales)
SAX_CreateNode ($refXMLDoc;"configurado";True:C214;$configurado)
SAX_CreateNode ($refXMLDoc;"modo";True:C214;$modo)

SAX_CreateNode ($refXMLDoc;"xml_data")
  ///agrego datos para saber que realiza envio de datos
  //161818 JVP 20160524
$vt_maquina:=Current machine:C483
$vt_user:=<>tUSR_CurrentUser
SAX_CreateNode ($refXMLDoc;"Equipo";True:C214;$vt_maquina)
SAX_CreateNode ($refXMLDoc;"usuario";True:C214;$vt_user)
SAX_CreateNode ($refXMLDoc;"owner";True:C214;Current system user:C484)  //20160601 RCH
SN3_InsertDTS ($refXMLDoc)
SAX_CreateNode ($refXMLDoc;$firstTag)
