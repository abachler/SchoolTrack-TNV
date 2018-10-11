//%attributes = {}
  //BKPs3_ObtieneXMLCredenciales
C_TEXT:C284($t_xml;$0)
C_OBJECT:C1216($ob_credenciales;$ob_raizCredenciales;$ob_prop;$ob_propDatos)

C_TEXT:C284($t_refXML;$t_subElem;$t_valor;$t_nombreespacio;$t_raiz)
C_TEXT:C284($aNSNom1;$aNSNom2;$aNSNom3;$aNSValor1;$aNSValor2;$aNSValor3)

  //Guarda las credenciales en las preferencias
OB SET:C1220($ob_credenciales;"awsAccessKeyId";"AKIAIDNBO46UN4ABMSKA")
OB SET:C1220($ob_credenciales;"awsSecretAccessKey";"AQIAh67CpEJLhse8+8TTTpiXmLUU1J6X9RDpqXAGC3wKUO2phrOQMrm9tIX3i9/3c6Wr/khZi6nKA0mdJxwnOhkBG8S6O+pZmh2aYboFxrcoiTtTTJkZivEC6OuUIrT0gIo0EbxWPD8rWEN2p0x3uHbVIPy2diwixjr50iLybptWbzTM0uOa14fIEAxYlupeFeo1OI6+4U/+h6P9uL2yC1c0m79C6TqeLnwDaPgry4vG2F0qIXPEgibEkbd"+"GOZgN2tz//26eLawAygqPtcyUbikhbwfdphdkvc0e1s9DjjEfgnhGH7oG/S6J8Xol/OlCboAl9Yt5XPWQ8kkk0yurAE3bPKiH9fxy+GDnGMsTq49zG2RFViC6DKIOykt7i79H1t33ZEHEkPx658LCmJ71nKpXWgyA95c8yPMICwU8voauE+BTWanmlflynE+Bt+6F+Sp83XmtEcPOpnKoZSwNfifZBImsEoxXxpnzi8F7DOpJl75w4waE4K"+"MbUn5ERumozcytGUNNBa3JJXGtSwIBz9K8ub7znos0yT2nAoZD7Pr/g94PVfVlDu0idhIvCWjJNfwGHbgVJUeWBdsXniyNgCPN/9nlpgia14/V0ykuq53nSOxoBdh4w8tMxn5RURH67O0rvOggxSmIn37QQ2zHbe3XYIIZc5ZovIlD/SbP1RFehPM=")
OB SET:C1220($ob_raizCredenciales;"credencialesAWS";$ob_credenciales)

$ob_prop:=PREF_fGetObject (0;"AWS_XML_Cred";$ob_raizCredenciales)
$ob_propDatos:=OB Get:C1224($ob_prop;"credencialesAWS")

  //Crea XML con los datos de acceso
$t_raiz:="awsCredentials"
$t_nombreespacio:=""
$aNSNom1:="version"
$aNSNom2:="xsi:noNamespaceSchemaLocation"
$aNSNom3:="xmlns:xsi"
$aNSValor1:="1.0"
$aNSValor2:="awsCredentials.xsd"
$aNSValor3:="http://www.w3.org/2001/XMLSchema-instance"
$t_refXML:=DOM Create XML Ref:C861($t_raiz;$t_nombreespacio;$aNSNom1;$aNSValor1;$aNSNom2;$aNSValor2;$aNSNom3;$aNSValor3)

$t_subElem:=DOM Create XML element:C865($t_refXML;"/"+$t_raiz+"/profile";"name";"default")
$t_valor:=OB Get:C1224($ob_propDatos;"awsAccessKeyId")
$t_subElem:=DOM Create XML element:C865($t_subElem;"/profile/awsAccessKeyId")
DOM SET XML ELEMENT VALUE:C868($t_subElem;$t_valor)

$t_subElem:=DOM Create XML element:C865($t_refXML;"/"+$t_raiz+"/profile/awsSecretAccessKey";"crypted";"true")
$t_valor:=OB Get:C1224($ob_propDatos;"awsSecretAccessKey")
DOM SET XML ELEMENT VALUE:C868($t_subElem;$t_valor)

DOM EXPORT TO VAR:C863($t_refXML;$t_xml)
DOM CLOSE XML:C722($t_refXML)

$0:=$t_xml
