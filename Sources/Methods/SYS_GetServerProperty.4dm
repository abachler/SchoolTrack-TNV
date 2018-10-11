//%attributes = {"executedOnServer":true}
  // SYS_GetServerProperty()
  // Por: Alberto Bachler K.: 23-09-15, 18:05:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_BLOB:C604($x_blob)
C_DATE:C307($d_fecha)
C_LONGINT:C283($error;$l_buildNumber;$l_dias;$l_error;$l_licenciasClientes;$l_productKey;$l_selector;$l_usuariosConectados)
C_TIME:C306($h_diferencia;$h_time)
C_TEXT:C284($t_backupPrefsPath;$t_dateValue;$t_direccionIP;$t_empresaRegistro;$t_macAddresPrincipal;$t_nombreOS;$t_Parametros;$t_subRed;$t_timeValue;$t_usuarioRegistro)
C_TEXT:C284($t_valorRetorno;$t_version;$t_xmlRef)

ARRAY TEXT:C222($at_direccionMAC;0)
ARRAY TEXT:C222($at_VersionAplicacion;0)



If (False:C215)
	C_TEXT:C284(SYS_GetServerProperty ;$0)
	C_LONGINT:C283(SYS_GetServerProperty ;$1)
	C_TEXT:C284(SYS_GetServerProperty ;$2)
End if 

Case of 
	: (Count parameters:C259=1)
		$l_selector:=$1
	: (Count parameters:C259=2)
		$l_selector:=$1
		$t_Parametros:=$2
	: (Count parameters:C259=0)
		$l_selector:=-1
End case 





  // Código principal
$t_nombreOS:=SYS_GetServerOS 

Case of 
	: ($l_selector=XS_Platform)  //plataforma
		$0:=Choose:C955(SYS_IsMacintosh ;"MacOS X";"Windows")
		
	: ($l_selector=XS_OSversion)  //versión OS
		$0:=$t_nombreOS
		
	: ($l_selector=XS_MachineName)  //current machine
		$0:=Current machine:C483
		
	: ($l_selector=XS_MachineOwner)  //current machine owner
		$0:=Current system user:C484
		
	: ($l_selector=XS_LoggedUser)  //logged user
		If (SYS_IsMacintosh )
			$t_valorRetorno:=Current system user:C484
		Else 
			$l_error:=sys_GetUserName ($t_valorRetorno)
		End if 
		$0:=$t_valorRetorno
		
	: ($l_selector=XS_IPConfig)  //IP_Config
		If (SYS_IsMacintosh )
			$t_valorRetorno:=""
		Else 
			$l_error:=sys_GetNetworkInfo ($t_valorRetorno)
		End if 
		$0:=$t_valorRetorno
		
	: ($l_selector=XS_InternetConnected)  //InternetConnected
		$t_valorRetorno:=Choose:C955(INET_Conectado ;__ ("Si");__ ("No"))
		
	: ($l_selector=XS_MacAddress)  //mac adress
		$t_macAddresPrincipal:=SYS_GetServerMAC (->$at_direccionMAC)
		$0:=AT_array2text (->$at_direccionMAC;", ")
		
	: ($l_selector=XS_IPaddress)  //IP Adress
		$l_error:=IT_MyTCPAddr ($t_direccionIP;$t_subRed)
		$0:=$t_direccionIP+","+$t_subRed
		
	: ($l_selector=Currency symbol:K60:3)
		GET SYSTEM FORMAT:C994(Currency symbol:K60:3;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=Date separator:K60:10)
		GET SYSTEM FORMAT:C994(Date separator:K60:10;$t_valorRetorno)
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;" ";__ (" (espacio)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;",";__ (", (coma)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;".";__ (". (punto)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"-";__ ("- (guión)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"/";__ ("/ (barra división)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;":";__ (": (dos puntos)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;";";__ ("; (punto y coma)"))
		$0:=$t_valorRetorno
		
	: ($l_selector=Decimal separator:K60:1)
		GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_valorRetorno)
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;" ";__ (" (espacio)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;",";__ (", (coma)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;".";__ (". (punto)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"-";__ ("- (guión)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"/";__ ("/ (barra división)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;":";__ (": (dos puntos)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;";";__ ("; (punto y coma)"))
		$0:=$t_valorRetorno
		
	: ($l_selector=Short date day position:K60:12)
		GET SYSTEM FORMAT:C994(Short date day position:K60:12;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=Short date month position:K60:13)
		GET SYSTEM FORMAT:C994(Short date month position:K60:13;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=Short date year position:K60:14)
		GET SYSTEM FORMAT:C994(Short date year position:K60:14;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=System date long pattern:K60:9)
		GET SYSTEM FORMAT:C994(System date long pattern:K60:9;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=System date medium pattern:K60:8)
		GET SYSTEM FORMAT:C994(System date medium pattern:K60:8;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=System date short pattern:K60:7)
		GET SYSTEM FORMAT:C994(System date short pattern:K60:7;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=System time AM label:K60:15)
		GET SYSTEM FORMAT:C994(System time AM label:K60:15;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=System time long pattern:K60:6)
		GET SYSTEM FORMAT:C994(System time long pattern:K60:6;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=System time medium pattern:K60:5)
		GET SYSTEM FORMAT:C994(System time medium pattern:K60:5;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=System time PM label:K60:16)
		GET SYSTEM FORMAT:C994(System time PM label:K60:16;$t_valorRetorno)
		$0:=$t_valorRetorno
		
	: ($l_selector=System time short pattern:K60:4)
		If (SYS_IsMacintosh )
			GET SYSTEM FORMAT:C994(System time short pattern:K60:4;$t_valorRetorno)
		Else 
			$error:=sys_GetOneRegionSetting ($t_valorRetorno;RS_TIMEFORMAT)
			$0:=$t_valorRetorno
		End if 
		$0:=$t_valorRetorno
		
	: ($l_selector=Thousand separator:K60:2)
		GET SYSTEM FORMAT:C994(Thousand separator:K60:2;$t_valorRetorno)
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;" ";__ (" (espacio)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;",";__ (", (coma)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;".";__ (". (punto)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"-";__ ("- (guión)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"/";__ ("/ (barra división)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;":";__ (": (dos puntos)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;";";__ ("; (punto y coma)"))
		$0:=$t_valorRetorno
		
	: ($l_selector=Time separator:K60:11)
		GET SYSTEM FORMAT:C994(Time separator:K60:11;$t_valorRetorno)
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;" ";__ (" (espacio)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;",";__ (", (coma)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;".";__ (". (punto)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"-";__ ("- (guión)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"/";__ ("/ (barra división)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;":";__ (": (dos puntos)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;";";__ ("; (punto y coma)"))
		$0:=$t_valorRetorno
		
	: (($l_selector=XS_ListSeparator) & (SYS_IsWindows ))  //separador de lista
		$error:=sys_GetOneRegionSetting ($t_valorRetorno;RS_LISTSEPARATOR)
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;" ";__ (" (espacio)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;",";__ (", (coma)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;".";__ (". (punto)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"-";__ ("- (guión)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;"/";__ ("/ (barra división)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;":";__ (": (dos puntos)"))
		$t_valorRetorno:=Replace string:C233($t_valorRetorno;";";__ ("; (punto y coma)"))
		$0:=$t_valorRetorno
		
	: ($l_selector=XS_AppVersion)  //version aplicación
		$0:=SYS_LeeVersionEstructura 
		
	: ($l_selector=XS_LastAppUpdate)  //fecha última actualización
		$x_blob:=PREF_fGetBlob (0;"AppUDdate";$x_blob)
		BLOB_Blob2Vars (->$x_blob;0;->$d_fecha;->$h_time)
		$0:=String:C10($d_fecha;System date long:K1:3)+", "+String:C10($h_time;HH MM SS:K7:1)
		
	: ($l_selector=XS_4DVersion)  //versión 4D
		$t_version:=Application version:C493($l_buildNumber)
		$0:=Substring:C12($t_version;1;2)+"."+Substring:C12($t_version;3;1)+"."+String:C10($l_buildNumber)+Choose:C955(Version type:C495 ?? 64 bit version:K5:25;" (64-bit)";" (32-bit)")
		
	: ($l_selector=XS_lastServerStartup)  //ultimo inicio 4D Server
		$x_blob:=PREF_fGetBlob (0;"LastServerStart";$x_blob)
		BLOB_Blob2Vars (->$x_blob;0;->$d_fecha;->$h_time)
		If (Current time:C178(*)>$h_time)
			$l_dias:=Current date:C33(*)-$d_fecha
			$h_diferencia:=Current time:C178(*)-$h_time
		Else 
			$l_dias:=Current date:C33(*)-$d_fecha-1
			$h_diferencia:=Current time:C178(*)
		End if 
		Case of 
			: ($l_dias=1)
				$0:=String:C10($d_fecha;System date short:K1:1)+", "+String:C10($h_time;HH MM:K7:2)+", hace "+String:C10($l_dias)+" día y "+String:C10($h_diferencia;HH MM:K7:2)
			: ($l_dias>1)
				$0:=String:C10($d_fecha;System date short:K1:1)+", "+String:C10($h_time;HH MM:K7:2)+", hace "+String:C10($l_dias)+" días y "+String:C10($h_diferencia;HH MM:K7:2)
			Else 
				$0:=String:C10($d_fecha;System date short:K1:1)+", "+String:C10($h_time;HH MM:K7:2)+", hace "+String:C10($h_diferencia;HH MM:K7:2)
		End case 
		
	: ($l_selector=XS_LastBackupDate)  //ultimo respaldo
		$t_backupPrefsPath:=SYS_CarpetaAplicacion (CLG_Estructura)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"backup.xml"
		$t_xmlRef:=DOM Parse XML source:C719($t_backupPrefsPath)
		$t_dateValue:=DOM_GetValue ($t_xmlRef;"Preferences4D/Backup/DataBase/LastBackupDate/Item1")
		$t_timeValue:=DOM_GetValue ($t_xmlRef;"Preferences4D/Backup/DataBase/LastBackupTime/Item1")
		$t_valorRetorno:=Substring:C12($t_dateValue;9;2)+"/"+Substring:C12($t_dateValue;6;2)+"/"+Substring:C12($t_dateValue;1;4)+" a las "+Substring:C12($t_timeValue;12)
		$0:=$t_valorRetorno
		
		
	: ($l_selector=XS_LastBackupPath)  //ruta ultimo respaldo
		$t_backupPrefsPath:=SYS_CarpetaAplicacion (CLG_Estructura)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"backup.xml"
		$t_xmlRef:=DOM Parse XML source:C719($t_backupPrefsPath)
		$t_valorRetorno:=DOM_GetValue ($t_xmlRef;"Preferences4D/Backup/DataBase/LastBackupPath/Item1")
		$0:=$t_valorRetorno
		
	: ($l_selector=XS_LogFilePath)  //ruta log file
		$0:=Log file:C928
		
	: ($l_selector=XS_StructureName)  //Nombre estructura
		$0:=ST_GetWord (Structure file:C489;ST_CountWords (Structure file:C489;0;Folder separator:K24:12);Folder separator:K24:12)
		
	: ($l_selector=XS_StructureFolder)  //ruta carpeta estructura
		$0:=Get 4D folder:C485(Database folder:K5:14)
		
	: ($l_selector=XS_DataFileName)  //base de datos actual
		$0:=ST_GetWord (Data file:C490;ST_CountWords (Data file:C490;0;Folder separator:K24:12);Folder separator:K24:12)
		
	: ($l_selector=XS_DataFileFolder)  //ruta base de datos actual
		$0:=SYS_GetParentNme (Data file:C490)
		
	: ($l_selector=XS_Licences4D)  // numero de licencias concurrentes clientes
		GET SERIAL INFORMATION:C696($l_productKey;$t_usuarioRegistro;$t_empresaRegistro;$l_usuariosConectados;$l_licenciasClientes)
		$0:=String:C10($l_licenciasClientes)
		
	: ($l_selector=XS_LicensesColegium)  // licencias clientes contratadas
		READ ONLY:C145([xShell_ApplicationData:45])
		ALL RECORDS:C47([xShell_ApplicationData:45])
		FIRST RECORD:C50([xShell_ApplicationData:45])
		$0:=String:C10([xShell_ApplicationData:45]Licenced_Users:11)
		
		
	: ($l_selector=XS_ConnectedUsers)  // usuarios conectados actualmente
		$0:=String:C10(LICENCIA_ConexionesActuales )
		
	: ($l_selector=XS_PortTCP)
		$0:=String:C10(Get database parameter:C643(Port ID:K37:15))
End case 





