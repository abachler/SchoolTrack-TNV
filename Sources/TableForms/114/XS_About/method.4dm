Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284($t_versionEstructura;$t_dts)
		$t_versionEstructura:=SYS_LeeVersionEstructura ("dts";->$t_dts)
		$t_dts:=Replace string:C233($t_dts;"T";", ")
		$t_dts:=Replace string:C233($t_dts;"Z";" (GMT)")
		$t_versionEstructura:="Version: "+$t_versionEstructura+"\r"+$t_dts
		sAppVers:=$t_versionEstructura
		sCopyright:="© 2000 - "+String:C10(Year of:C25(Current date:C33(*));"0000")+" Colegium"+"\r"
		sCopyright:=sCopyright+"info@colegium.com"+"\r"
		sCopyright:=sCopyright+"http://www.colegium.com"
		
		SYS_GetMemory 
		vt_DataFilePath:=SYS_GetDataPath 
		
		vText:=ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;SchoolTrack);"SchoolTrack\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;MediaTrack);"MediaTrack\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;AdmissionTrack);"AdmissionTrack\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;AccountTrack);"AccounTrack\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;TransportTrack);"TransportTrack\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;SchoolNet);"SchoolNet\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;SchoolCenter);"SchoolCenter\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access);"SchoolTrack Web Access\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;CommTrack);"CommTrack\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;AdmissionNet);"AdmissionNet\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;CommTrack Light);"SchoolTrack Sender\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;14);"Edunet (Matemática)\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;15);"Edunet (Lenguaje y Comunicación)\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;13);"Google Apps Para Educación\r";"")
		vText:=vText+ST_Boolean2Str (LICENCIA_esModuloAutorizado (1;12);"Documento Tributario Electrónico\r";"")
		
		$t_nombreProducto:="Main"
		vMaxCon:=KRL_GetNumericFieldData (->[xShell_ApplicationData:45]ProductName:16;->$t_nombreProducto;->[xShell_ApplicationData:45]Licenced_Users:11)
		vActCon:=LICENCIA_ConexionesActuales 
		If (Application type:C494=4D Remote mode:K5:5)
			OBJECT SET VISIBLE:C603(*;"conect@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"conect@";False:C215)
			OBJECT SET VISIBLE:C603(*;"servidor@";False:C215)
		End if 
		
	: ((Form event:C388=On Deactivate:K2:10) | (Form event:C388=On Close Box:K2:21))
		CANCEL:C270
		
End case 