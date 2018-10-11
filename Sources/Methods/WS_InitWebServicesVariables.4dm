//%attributes = {}
  //WS_InitWebServicesVariables

  //Intranet
<>urlIntranet:="https://intranet.colegium.com/4DSOAP/"
<>soapActionIntranet:="SchoolNetII_WebServices"
<>nameSpaceIntranet:="https://intranet.colegium.com/namespace_SchoolNetII"
<>timeoutIntranet:=30

  //SchoolNet
<>urlSchoolNet:="http://schoolnet.colegium.com/4DSOAP/"
<>soapActionSchoolNet:="SchoolNet_WebServices"
<>nameSpaceSchoolNet:="http://www.colegium.com/namespace_colegium"
<>timeoutSchoolNet:=240

  //SchoolTrack Web Access
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
$t_codigoPais:=[Colegio:31]Codigo_Pais:31
<>urlSTWA:=[Colegio:31]STWA_URLHost:54
<>soapActionSTWA:=[Colegio:31]STWA_URLHost:54+"/"
<>nameSpaceSTWA:=[Colegio:31]STWA_URLHost:54+"?wsdl"
<>timeoutSTWA:=30

  //CommTrack: Esto hay que cambiarlo a un soap a la intranet que nos diga el hosting para el colegio
Case of 
	: ($t_codigoPais="co")
		<>urlCommTrack:="http://www.commtrack.cl/webservice/servicio.php"
		<>soapActionCommTrack:="http://www.commtrack.cl/webservice/servicio.php/"
		<>nameSpaceCommTrack:="http://www.commtrack.cl/webservice/servicio.php?wsdl"
		<>timeoutCommTrack:=240
	Else 
		<>urlCommTrack:="http://www.commtrack.cl/webservice/servicio.php"
		<>soapActionCommTrack:="http://www.commtrack.cl/webservice/servicio.php/"
		<>nameSpaceCommTrack:="http://www.commtrack.cl/webservice/servicio.php?wsdl"
		<>timeoutCommTrack:=240
End case 

<>urlSchoolNet3:="http://sn3ws.colegium.com/servicios.php"
<>soapActionSchoolNet3:="http://sn3ws.colegium.com/servicios.php/"
<>nameSpaceSchoolNet3:="http://sn3ws.colegium.com/servicios.php?wsdl"
<>timeoutSchoolNet3:=180

<>urlSchoolNet3PG:="http://bsn3ws.colegium.com:8080/serviciosPG.php"
<>soapActionSchoolNet3PG:="http://bsn3ws.colegium.com:8080/serviciosPG.php/"
<>nameSpaceSchoolNet3PG:="http://bsn3ws.colegium.com:8080/serviciosPG.php?wsdl"
<>timeoutSchoolNet3PG:=180