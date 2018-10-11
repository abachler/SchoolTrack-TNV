//%attributes = {}
  // WSout_EnviaInfoMaquinas()
  // Por: Alberto Bachler K.: 18-08-14, 10:08:56
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($httpStatus_l;$l_error)
C_TEXT:C284($t_codigoPais;$t_dominio;$t_Error;$t_errorWS;$t_infoRed;$t_json;$t_json;$t_nombreMaquinaActual;$t_nombreUsuarioSesion;$t_refJson)
C_TEXT:C284($t_RolBD;$t_versionSchoolTrack)
C_OBJECT:C1216($ob_raiz)

ARRAY BOOLEAN:C223($ab_EsServidor;0)
ARRAY DATE:C224($ad_fechaUltimaInfo;0)
ARRAY LONGINT:C221($al_capacidadDiscoAplicacion;0)
ARRAY LONGINT:C221($al_capacidadDiscoSistema;0)
ARRAY LONGINT:C221($al_libreDiscoAplicacion;0)
ARRAY LONGINT:C221($al_libreDiscoSistema;0)
ARRAY LONGINT:C221($al_memoriaInstalada;0)
ARRAY LONGINT:C221($al_memoriaTotal;0)
ARRAY TEXT:C222($at_MacAddress;0)
ARRAY TEXT:C222($at_nombreMaquina;0)
ARRAY TEXT:C222($at_resolucionPantalla;0)
ARRAY TEXT:C222($at_sistemaOperativo;0)
ARRAY TEXT:C222($at_tipoMaquina;0)
ARRAY TEXT:C222($at_version4D;0)

If (SYS_IsWindows )
	$l_error:=sys_GetNetworkInfo ($t_infoRed)
	If (ST_CountWords ($t_infoRed;1;",")>=2)
		$t_dominio:=ST_GetWord ($t_infoRed;2;",")
	End if 
End if 
$t_nombreUsuarioSesion:=Current system user:C484
$t_nombreMaquinaActual:=Current machine:C483

If (($t_nombreUsuarioSesion#"aBachler") & ($t_nombreMaquinaActual#"Colegium-@") & ($t_dominio#"lester.colegium.com") & ($t_nombreMaquinaActual#"U2") & ($t_nombreMaquinaActual#"ZEUS") & ($t_nombreMaquinaActual#"Condor")) & (<>lUSR_CurrentUserID>=0)
	
	READ ONLY:C145([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	$t_codigoPais:=[Colegio:31]Codigo_Pais:31
	$t_RolBD:=[Colegio:31]Rol Base Datos:9
	$t_versionSchoolTrack:=SYS_LeeVersionEstructura 
	
	QUERY:C277([xShell_InfoMachines:151];[xShell_InfoMachines:151]LastInfo:4>=(Current date:C33-180))
	SELECTION TO ARRAY:C260([xShell_InfoMachines:151]MachineName:2;$at_nombreMaquina;[xShell_InfoMachines:151]MacAddress:1;$at_MacAddress;[xShell_InfoMachines:151]IsServer:3;$ab_EsServidor;[xShell_InfoMachines:151]Version_4D:5;$at_version4D;[xShell_InfoMachines:151]MachineType:6;$at_tipoMaquina;[xShell_InfoMachines:151]OS:7;$at_sistemaOperativo;[xShell_InfoMachines:151]ScreenResolution:9;$at_resolucionPantalla;[xShell_InfoMachines:151]Physical_RAM:10;$al_memoriaInstalada;[xShell_InfoMachines:151]Total_RAM:11;$al_memoriaTotal;[xShell_InfoMachines:151]SystemDisk_Capacity_Gb:12;$al_capacidadDiscoSistema;[xShell_InfoMachines:151]SystemDisk_FreeSpace_Gb:13;$al_libreDiscoSistema;[xShell_InfoMachines:151]AppDisk_Capacity_Gb:14;$al_capacidadDiscoAplicacion;[xShell_InfoMachines:151]AppDisk_FreeSpace_Gb:15;$al_libreDiscoAplicacion;[xShell_InfoMachines:151]LastInfo:4;$ad_fechaUltimaInfo)
	
	
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->$t_RolBD;"rolBD")
	OB_SET ($ob_raiz;->$t_codigoPais;"codigoPais")
	OB_SET ($ob_raiz;->$t_versionSchoolTrack;"versionSchoolTrack")
	OB_SET ($ob_raiz;->$at_nombreMaquina;"maquinas")
	OB_SET ($ob_raiz;->$at_MacAddress;"macaddress")
	OB_SET ($ob_raiz;->$ab_EsServidor;"esServidor")
	OB_SET ($ob_raiz;->$at_version4D;"version4D")
	OB_SET ($ob_raiz;->$at_tipoMaquina;"tipoMaquina")
	OB_SET ($ob_raiz;->$at_sistemaOperativo;"sistemaOperativo")
	OB_SET ($ob_raiz;->$at_resolucionPantalla;"resolucionPantalla")
	OB_SET ($ob_raiz;->$al_memoriaInstalada;"memoriaInstalada")
	OB_SET ($ob_raiz;->$al_memoriaTotal;"memoriaTotal")
	OB_SET ($ob_raiz;->$al_capacidadDiscoSistema;"capacidadDiscoSistema")
	OB_SET ($ob_raiz;->$al_libreDiscoSistema;"espacioLibreDiscoSistema")
	OB_SET ($ob_raiz;->$al_capacidadDiscoAplicacion;"espacioDiscoAplicacion")
	OB_SET ($ob_raiz;->$al_libreDiscoAplicacion;"espacioLibreDiscoAplicacion")
	OB_SET ($ob_raiz;->$ad_fechaUltimaInfo;"fechaUltimaInfo")
	$t_json:=OB_Object2Json ($ob_raiz)
	
	SET TEXT TO PASTEBOARD:C523($t_json)
	WEB SERVICE SET PARAMETER:C777("json";$t_json)
	
	$t_errorWS:=WS_CallIntranetWebService ("WSin_InfoMaquinas")
	If ($t_errorWS="")
		WEB SERVICE GET RESULT:C779($t_Error;"";*)  //20180514 RCH Ticket 206788
		If ($t_Error="")
			LOG_RegisterEvt ("Configuración de entorno SchoolTrack enviada.")
		Else 
			LOG_RegisterEvt ("No fue posible enviar la Configuración de entorno SchoolTrack.")
		End if 
	Else 
		LOG_RegisterEvt ("Imposible conectar con intranet para envío de la Configuración de entorno SchoolTrack. Error: "+$t_errorWS)
	End if 
End if 

