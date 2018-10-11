//%attributes = {}
  //BKPs3_ObtieneXMLConfiguracion
C_TEXT:C284($t_xml;$0)
C_OBJECT:C1216($ob_credenciales;$ob_raizCredenciales;$ob_prop;$ob_propDatos)
C_TEXT:C284($t_refXML;$t_subElem;$t_valor;$t_nombreespacio;$t_raiz)
C_TEXT:C284($aNSNom1;$aNSNom2;$aNSNom3;$aNSValor1;$aNSValor2;$aNSValor3)

  //Guarda la configuración en las preferencias
OB SET:C1220($ob_credenciales;"awsDefaultRegion";"us-west-2")
OB SET:C1220($ob_raizCredenciales;"configuracionAWS";$ob_credenciales)

$ob_prop:=PREF_fGetObject (0;"AWS_XML_Conf";$ob_raizCredenciales)
$ob_propDatos:=OB Get:C1224($ob_prop;"configuracionAWS")

  //Crea XML con los datos de acceso
$t_raiz:="awsConfig"
$t_nombreespacio:=""
$aNSNom1:="version"
$aNSNom2:="xsi:noNamespaceSchemaLocation"
$aNSNom3:="xmlns:xsi"
$aNSValor1:="1.0"
$aNSValor2:="awsConfig.xsd"
$aNSValor3:="http://www.w3.org/2001/XMLSchema-instance"
$t_refXML:=DOM Create XML Ref:C861($t_raiz;$t_nombreespacio;$aNSNom1;$aNSValor1;$aNSNom2;$aNSValor2;$aNSNom3;$aNSValor3)

$t_subElem:=DOM Create XML element:C865($t_refXML;"/"+$t_raiz+"/profile";"name";"default")
$t_valor:=OB Get:C1224($ob_propDatos;"awsDefaultRegion")
$t_subElem:=DOM Create XML element:C865($t_subElem;"/profile/awsDefaultRegion")
DOM SET XML ELEMENT VALUE:C868($t_subElem;$t_valor)
DOM EXPORT TO VAR:C863($t_refXML;$t_xml)
DOM CLOSE XML:C722($t_refXML)

$0:=$t_xml
