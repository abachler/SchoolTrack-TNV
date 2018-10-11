//%attributes = {}
  // CIM_FTP_ConnectionData()
  // Por: Alberto Bachler: 07/08/13, 16:59:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_Blob)
C_LONGINT:C283($l_otRef;$l_IdProcesoProgreso)


vtWS_Schoolnet_URL:="http://www.colegium.com/4DSOAP"
vtWS_SchoolNet_SoapAction:="SchoolNet_WebServices"
vtWS_Schoolnet_Namespace:="http://www.colegium.com/namespace_colegium"
vtFTP_Url:="ftp.colegium.com"
vlFTP_ConexionPasiva:=1
vtWS_ftpDirectory:="/"
vtWS_ftpLoginName:=""
vtWS_ftpPassword:=""
$l_otRef:=OT New 
OT PutText ($l_otRef;"vtWS_Schoolnet_URL";vtWS_Schoolnet_URL)
OT PutText ($l_otRef;"vtWS_SchoolNet_SoapAction";vtWS_SchoolNet_SoapAction)
OT PutText ($l_otRef;"vtWS_Schoolnet_Namespace";vtWS_Schoolnet_Namespace)
OT PutText ($l_otRef;"vtFTP_Url";vtFTP_Url)
OT PutText ($l_otRef;"vtWS_ftpDirectory";vtWS_ftpDirectory)
OT PutText ($l_otRef;"vtWS_ftpLoginName";vtWS_ftpLoginName)
OT PutText ($l_otRef;"vtWS_ftpPassword";vtWS_ftpPassword)
OT PutLong ($l_otRef;"vlFTP_ConexionPasiva";vlFTP_ConexionPasiva)
$x_Blob:=OT ObjectToNewBLOB ($l_otRef)
OT Clear ($l_otRef)
$x_Blob:=PREF_fGetBlob (0;"Config_Soporte";$x_Blob)
$l_otRef:=OT BLOBToObject ($x_Blob)
vtWS_Schoolnet_URL:=OT GetText ($l_otRef;"vtWS_Schoolnet_URL")
vtWS_SchoolNet_SoapAction:=OT GetText ($l_otRef;"vtWS_SchoolNet_SoapAction")
vtWS_Schoolnet_Namespace:=OT GetText ($l_otRef;"vtWS_Schoolnet_Namespace")
vtFTP_Url:=OT GetText ($l_otRef;"vtFTP_Url")
vtWS_ftpDirectory:=OT GetText ($l_otRef;"vtWS_ftpDirectory")
vtWS_ftpLoginName:=OT GetText ($l_otRef;"vtWS_ftpLoginName")
vtWS_ftpPassword:=OT GetText ($l_otRef;"vtWS_ftpPassword")
vlFTP_ConexionPasiva:=OT GetLong ($l_otRef;"vlFTP_ConexionPasiva")
OT Clear ($l_otRef)

vlFTP_ConectionID:=0

If (INET_Conectado )
	vbTS_ConectionAvailable:=True:C214
	$l_IdProcesoProgreso:=IT_UThermometer (1;$l_IdProcesoProgreso;__ ("Obteniendo información de conexión a servicios FTP Colegium...");-5)
	WS_GetFtpLoginInfo 
	If (ok=1)
		$l_otRef:=OT New 
		OT PutText ($l_otRef;"vtWS_Schoolnet_URL";vtWS_Schoolnet_URL)
		OT PutText ($l_otRef;"vtWS_SchoolNet_SoapAction";vtWS_SchoolNet_SoapAction)
		OT PutText ($l_otRef;"vtWS_Schoolnet_Namespace";vtWS_Schoolnet_Namespace)
		OT PutText ($l_otRef;"vtFTP_Url";vtFTP_Url)
		OT PutText ($l_otRef;"vtWS_ftpDirectory";vtWS_ftpDirectory)
		OT PutText ($l_otRef;"vtWS_ftpLoginName";vtWS_ftpLoginName)
		OT PutText ($l_otRef;"vtWS_ftpPassword";vtWS_ftpPassword)
		OT PutLong ($l_otRef;"vlFTP_ConexionPasiva";vlFTP_ConexionPasiva)
		$x_Blob:=OT ObjectToNewBLOB ($l_otRef)
		PREF_SetBlob (0;"Config_Soporte";$x_Blob)
	End if 
	IT_UThermometer (-2;$l_IdProcesoProgreso)
Else 
	vbTS_ConectionAvailable:=False:C215
End if 