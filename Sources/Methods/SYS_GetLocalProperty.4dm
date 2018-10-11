//%attributes = {}
  // Método: SYS_GetLocalProperty
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/09/10, 15:51:46
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

C_LONGINT:C283($propertySelector;$vlPlataforma;$vlSistema;$vlMachine;$l_buildNumber)
C_TEXT:C284($0;$propertyValue)
C_TEXT:C284($parameters)

Case of 
	: (Count parameters:C259=1)
		$propertySelector:=$1
	: (Count parameters:C259=2)
		$propertySelector:=$1
		$parameters:=$2
	: (Count parameters:C259=0)
		$propertySelector:=-1
End case 





  // Código principal
$vsOSVersion:=SYS_GetOSName 

Case of 
	: ($propertySelector=XS_Platform)  //plataforma
		$0:=$vsPlataforma
		
	: ($propertySelector=XS_OSversion)  //versión OS
		$0:=$vsOSVersion
		
	: ($propertySelector=XS_MachineName)  //current machine
		$0:=Current machine:C483
		
	: ($propertySelector=XS_MachineOwner)  //current machine owner
		$0:=Current system user:C484
		
	: ($propertySelector=XS_LoggedUser)  //logged user
		If (SYS_IsMacintosh )
			$username:=Current system user:C484
		Else 
			$err:=sys_GetUserName ($username)
		End if 
		$0:=$username
		
	: ($propertySelector=XS_IPConfig)  //IP_Config
		If (SYS_IsMacintosh )
			$ipConfig:=""
		Else 
			$err:=sys_GetNetworkInfo ($ipConfig)
		End if 
		$0:=$ipConfig
		
	: ($propertySelector=XS_InternetConnected)  //InternetConnected
		If (INET_Conectado )
			$0:=__ ("Si")
		Else 
			$0:=__ ("No")
		End if 
		
	: ($propertySelector=XS_MacAddress)  //mac adress
		ARRAY TEXT:C222($at_direccionMAC;0)
		$t_macAddresPrincipal:=SYS_GetServerMAC (->$at_direccionMAC)
		$0:=AT_array2text (->$at_direccionMAC;", ")
		
	: ($propertySelector=XS_IPaddress)  //IP Adress
		$err:=IT_MyTCPAddr ($ipAddress;$subNet)
		$0:=$ipAddress+","+$subNet
		
	: ($propertySelector=Currency symbol:K60:3)
		GET SYSTEM FORMAT:C994(Currency symbol:K60:3;$value)
		$0:=$value
		
	: ($propertySelector=Date separator:K60:10)
		GET SYSTEM FORMAT:C994(Date separator:K60:10;$value)
		$value:=Replace string:C233($value;" ";__ (" (espacio)"))
		$value:=Replace string:C233($value;",";__ (", (coma)"))
		$value:=Replace string:C233($value;".";__ (". (punto)"))
		$value:=Replace string:C233($value;"-";__ ("- (guión)"))
		$value:=Replace string:C233($value;"/";__ ("/ (barra división)"))
		$value:=Replace string:C233($value;":";__ (": (dos puntos)"))
		$value:=Replace string:C233($value;";";__ ("; (punto y coma)"))
		$0:=$value
		
	: ($propertySelector=Decimal separator:K60:1)
		GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$value)
		$value:=Replace string:C233($value;" ";__ (" (espacio)"))
		$value:=Replace string:C233($value;",";__ (", (coma)"))
		$value:=Replace string:C233($value;".";__ (". (punto)"))
		$value:=Replace string:C233($value;"-";__ ("- (guión)"))
		$value:=Replace string:C233($value;"/";__ ("/ (barra división)"))
		$value:=Replace string:C233($value;":";__ (": (dos puntos)"))
		$value:=Replace string:C233($value;";";__ ("; (punto y coma)"))
		$0:=$value
		
	: ($propertySelector=Short date day position:K60:12)
		GET SYSTEM FORMAT:C994(Short date day position:K60:12;$value)
		$0:=$value
		
	: ($propertySelector=Short date month position:K60:13)
		GET SYSTEM FORMAT:C994(Short date month position:K60:13;$value)
		$0:=$value
		
	: ($propertySelector=Short date year position:K60:14)
		GET SYSTEM FORMAT:C994(Short date year position:K60:14;$value)
		$0:=$value
		
	: ($propertySelector=System date long pattern:K60:9)
		GET SYSTEM FORMAT:C994(System date long pattern:K60:9;$value)
		$0:=$value
		
	: ($propertySelector=System date medium pattern:K60:8)
		GET SYSTEM FORMAT:C994(System date medium pattern:K60:8;$value)
		$0:=$value
		
	: ($propertySelector=System date short pattern:K60:7)
		GET SYSTEM FORMAT:C994(System date short pattern:K60:7;$value)
		$0:=$value
		
	: ($propertySelector=System time AM label:K60:15)
		GET SYSTEM FORMAT:C994(System time AM label:K60:15;$value)
		$0:=$value
		
	: ($propertySelector=System time long pattern:K60:6)
		GET SYSTEM FORMAT:C994(System time long pattern:K60:6;$value)
		$0:=$value
		
	: ($propertySelector=System time medium pattern:K60:5)
		GET SYSTEM FORMAT:C994(System time medium pattern:K60:5;$value)
		$0:=$value
		
	: ($propertySelector=System time PM label:K60:16)
		GET SYSTEM FORMAT:C994(System time PM label:K60:16;$value)
		$0:=$value
		
	: ($propertySelector=System time short pattern:K60:4)
		If (SYS_IsMacintosh )
			GET SYSTEM FORMAT:C994(System time short pattern:K60:4;$value)
		Else 
			$error:=sys_GetOneRegionSetting ($value;RS_TIMEFORMAT)
			$0:=$value
		End if 
		$0:=$value
		
	: ($propertySelector=Thousand separator:K60:2)
		GET SYSTEM FORMAT:C994(Thousand separator:K60:2;$value)
		$value:=Replace string:C233($value;" ";__ (" (espacio)"))
		$value:=Replace string:C233($value;",";__ (", (coma)"))
		$value:=Replace string:C233($value;".";__ (". (punto)"))
		$value:=Replace string:C233($value;"-";__ ("- (guión)"))
		$value:=Replace string:C233($value;"/";__ ("/ (barra división)"))
		$value:=Replace string:C233($value;":";__ (": (dos puntos)"))
		$value:=Replace string:C233($value;";";__ ("; (punto y coma)"))
		$0:=$value
		
	: ($propertySelector=Time separator:K60:11)
		GET SYSTEM FORMAT:C994(Time separator:K60:11;$value)
		$value:=Replace string:C233($value;" ";__ (" (espacio)"))
		$value:=Replace string:C233($value;",";__ (", (coma)"))
		$value:=Replace string:C233($value;".";__ (". (punto)"))
		$value:=Replace string:C233($value;"-";__ ("- (guión)"))
		$value:=Replace string:C233($value;"/";__ ("/ (barra división)"))
		$value:=Replace string:C233($value;":";__ (": (dos puntos)"))
		$value:=Replace string:C233($value;";";__ ("; (punto y coma)"))
		$0:=$value
		
	: (($propertySelector=109) & (SYS_IsWindows ))  //separador de lista
		$error:=sys_GetOneRegionSetting ($value;RS_LISTSEPARATOR)
		$value:=Replace string:C233($value;" ";__ (" (espacio)"))
		$value:=Replace string:C233($value;",";__ (", (coma)"))
		$value:=Replace string:C233($value;".";__ (". (punto)"))
		$value:=Replace string:C233($value;"-";__ ("- (guión)"))
		$value:=Replace string:C233($value;"/";__ ("/ (barra división)"))
		$value:=Replace string:C233($value;":";__ (": (dos puntos)"))
		$value:=Replace string:C233($value;";";__ ("; (punto y coma)"))
		$0:=$value
		
	: ($propertySelector=XS_AppVersion)  //version aplicación
		$0:=SYS_LeeVersionEstructura 
		
	: ($propertySelector=XS_LastAppUpdate)  //fecha última actualización
		C_BLOB:C604($vx_dateTimeBlob)
		C_DATE:C307($currentDate;$vl_date)
		C_TIME:C306($currentTime;$vl_Time)
		$vx_dateTimeBlob:=PREF_fGetBlob (0;"AppUDdate";$vx_dateTimeBlob)
		BLOB_Blob2Vars (->$vx_dateTimeBlob;0;->$vl_date;->$vl_Time)
		$0:=String:C10($vl_date;System date long:K1:3)+", "+String:C10($vl_Time;HH MM SS:K7:1)
		
	: ($propertySelector=XS_4DVersion)  //versión 4D
		$t_version:=Application version:C493($l_buildNumber)
		$0:=Substring:C12($t_version;1;2)+"."+Substring:C12($t_version;3;1)+"."+String:C10($l_buildNumber)
		
	: ($propertySelector=XS_lastServerStartup)  //ultimo inicio 4D Server
		C_BLOB:C604($vx_dateTimeBlob)
		C_DATE:C307($currentDate;$vl_date)
		C_TIME:C306($currentTime;$vl_Time)
		$vx_dateTimeBlob:=PREF_fGetBlob (0;"LastServerStart";$vx_dateTimeBlob)
		BLOB_Blob2Vars (->$vx_dateTimeBlob;0;->$vl_date;->$vl_Time)
		If (Current time:C178(*)>$vl_Time)
			$days:=Current date:C33(*)-$vl_date
			$timeOffset:=Current time:C178(*)-$vl_Time
		Else 
			$days:=Current date:C33(*)-$vl_date-1
			$timeOffset:=Current time:C178(*)
		End if 
		Case of 
			: ($days=1)
				$0:=String:C10($vl_date;System date short:K1:1)+", "+String:C10($vl_Time;HH MM:K7:2)+__ (", hace ")+String:C10($days)+__ (" día y ")+String:C10($timeOffset;HH MM:K7:2)
			: ($days>1)
				$0:=String:C10($vl_date;System date short:K1:1)+", "+String:C10($vl_Time;HH MM:K7:2)+__ (", hace ")+String:C10($days)+__ (" días y ")+String:C10($timeOffset;HH MM:K7:2)
			Else 
				$0:=String:C10($vl_date;System date short:K1:1)+", "+String:C10($vl_Time;HH MM:K7:2)+__ (", hace ")+String:C10($timeOffset;HH MM:K7:2)
		End case 
		
	: ($propertySelector=XS_LastBackupDate)  //ultimo respaldo
		$backupPrefsPath:=SYS_CarpetaAplicacion (CLG_Estructura)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"backup.xml"
		$xmlRef:=DOM Parse XML source:C719($backupPrefsPath)
		$t_dateValue:=DOM_GetValue ($xmlRef;"Preferences4D/Backup/DataBase/LastBackupDate/Item1")
		$t_timeValue:=DOM_GetValue ($xmlRef;"Preferences4D/Backup/DataBase/LastBackupTime/Item1")
		$value:=Substring:C12($t_dateValue;9;2)+"/"+Substring:C12($t_dateValue;6;2)+"/"+Substring:C12($t_dateValue;1;4)+" a las "+Substring:C12($t_timeValue;12)
		$0:=$value
		
		
	: ($propertySelector=XS_LastBackupPath)  //ruta ultimo respaldo
		$backupPrefsPath:=SYS_CarpetaAplicacion (CLG_Estructura)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"backup.xml"
		$xmlRef:=DOM Parse XML source:C719($backupPrefsPath)
		$value:=DOM_GetValue ($xmlRef;"Preferences4D/Backup/DataBase/LastBackupPath/Item1")
		$0:=$value
		
	: ($propertySelector=XS_LogFilePath)  //ruta log file
		$0:=Log file:C928
		
	: ($propertySelector=XS_StructureName)  //Nombre estructura
		$0:=ST_GetWord (Structure file:C489;ST_CountWords (Structure file:C489;0;Folder separator:K24:12);Folder separator:K24:12)
		
	: ($propertySelector=XS_StructureFolder)  //ruta carpeta estructura
		$0:=SYS_GetServer_4DFolder (Database folder:K5:14)
		
	: ($propertySelector=XS_DataFileName)  //base de datos actual
		$0:=ST_GetWord (Data file:C490;ST_CountWords (Data file:C490;0;Folder separator:K24:12);Folder separator:K24:12)
		
	: ($propertySelector=XS_DataFileFolder)  //ruta base de datos actual
		$0:=SYS_GetParentNme (Data file:C490)
End case 



