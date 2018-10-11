//%attributes = {}
  //SYS_GetSystemInfos

C_BLOB:C604($blob)
C_LONGINT:C283($vlPlatform;$vlSystem;$vlMachine)
ARRAY TEXT:C222($aText;0)




_O_PLATFORM PROPERTIES:C365($vlPlatform;$vlSystem;$vlMachine)

  //TIPO APLICACION
Case of 
	: (Application type:C494=4D Server:K5:6)
		$applicationType:="4D Server"
	: (Application type:C494=4D Remote mode:K5:5)
		$applicationType:="4D Client"
	: (Application type:C494=4D Volume desktop:K5:2)
		$applicationType:="4D Volume Desktop"
	: (Application type:C494=4D Local mode:K5:1)
		$applicationType:="4th Dimension"
End case 
$applicationversion:=Application version:C493
$application:=$applicationType+" "+$applicationversion

  //COMPUTADOR
If ($vlPlatform=3)
	$sep:=Char:C90(92)
	$subKey:="HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0"
	$ERR:=sys_GetRegText (GR_HKEY_LOCAL_MACHINE;$subKey;"ProcessorNameString";$machineType)
	$machineType:=ST_GetCleanString ($machineType)
Else 
	$error:=_O_Gestalt:C488("mach";$vlMachine)
	If ($vlMachine#0)
		$machineType:="Macintosh: "+String:C10($vlMachine)
	Else 
		$machineType:="Macintosh (modelo desconocido)"
	End if 
End if 

  //SISTEMA OPERATIVO
$version:=SYS_GetOSName 


  //CONFIGURACION DE RED
If ($vlPlatform=3)
	ARRAY TEXT:C222($tempTextArray;0)
	$error:=sys_GetNetworkInfo ($networkInfo)
	AT_Text2Array (->$tempTextArray;$networkInfo;",")
	$text:="Host : "+$tempTextArray{1}
	$text:=$text+"\rDominio: "+$tempTextArray{2}
	$text:=$text+"\rIP of domain server:"+$tempTextArray{3}
	  //$text:=$text+"\rTipo: "+$aText{4}
	$text:=$text+"\r"+$tempTextArray{5}
	$text:=$text+"\r"+$tempTextArray{6}
	$text:=$text+"\rServidores de Nombres:"
	For ($i;7;Size of array:C274($tempTextArray))
		$text:=$text+$tempTextArray{$i}+", "
	End for 
	$netWorkInfo:=Substring:C12($text;1;Length:C16($text)-2)
Else 
	$netWorkInfo:=""
End if 

  //CONFIGURACION REGIONAL
$regionalSettings:="Formato de fecha: "+<>tXS_RS_DateFormat+"\rSeparador para fechas: "+<>tXS_RS_DateSeparator+"\rSeparador decimal: "+<>tXS_RS_DecimalSeparator+"\rSeparador de miles: "+<>tXS_RS_ThousandsSeparator
If ($vlPlatform=3)
	ARRAY TEXT:C222($aRegionSetting;0)
	ARRAY TEXT:C222($aSettingDescription;0)
	$error:=sys_GetRegionSettings ($aRegionSetting;$aSettingDescription)
	$regionalSettings:=$regionalSettings+"\r"+"DETALLES CONFIGURACION REGIONAL (Windows)\r"
	For ($i;1;Size of array:C274($aRegionSetting))
		$regionalSettings:=$regionalSettings+$aSettingDescription{$i}+": "+$aRegionSetting{$i}+"\r"
	End for 
	$regionalSettings:=Substring:C12($regionalSettings;1;Length:C16($regionalSettings)-1)
End if 


  //NOMBRE DEL COMPUTADOR 
$machineName:=Current machine:C483


  //NOMBRE DEL USUARIO ACTIVO
If ($vlPlatform=3)
	$error:=sys_GetUserName ($user)
Else 
	$user:=Current system user:C484
End if 

  //MONITOR
$width:=Screen width:C187(*)
$height:=Screen height:C188(*)
$resolution:=String:C10($width)+"/"+String:C10($height)

  //MEMORIA COMPUTADOR
SYS_GetMemory 
$serverMemory:=""
$format:="# ### ##0 Mb"
$cache:=String:C10(Get database parameter:C643(_o_Database cache size:K37:9)/1024/1024;$format)
If (Application type:C494=4D Remote mode:K5:5)
	  //<>lTotalMemory:=vlTotalMemory
	  //<>lPhysicalMemory:=vlPhysicalMemory
	  //<>lFreeMemory:=vlFreeMemory
	  //<>vlStackMemory:=vlSTackMemory
	$serverMemory:="SERVIDOR\rRAM instalada: "+String:C10(<>lPhysicalMemory;$format)
	$serverMemory:=$serverMemory+"\rMemoria disponible: "+String:C10(<>lFreeMemory;$format)
	$clientMemory:="\r\rCLIENTE\rRAM instalada::"+String:C10(vlPhysicalMemory;$format)
	$clientMemory:=$clientMemory+"\rMemoria disponible: "+String:C10(vlFreeMemory;$format)
	$memory:=$serverMemory+$clientMemory+"\r\r"+"Caché 4D: "+$cache
Else 
	$clientMemory:="RAM instalada:"+String:C10(vlPhysicalMemory;$format)
	$clientMemory:=$clientMemory+"\rMemoria disponible: "+String:C10(vlFreeMemory;$format)
	$memory:=$clientMemory+"\r"+"Cache 4D: "+$cache
End if 



  //DISCOS DUROS
If ($vlPlatform=3)
	$volumeSYS:=Substring:C12(System folder:C487;1;2)
Else 
	$volumeSYS:=Substring:C12(System folder:C487;1;Position:C15(":";System folder:C487)-1)
End if 
VOLUME ATTRIBUTES:C472($volumeSYS;$size;$used;$free)
$volumes:=ST_Uppercase ($volumeSYS)
$volumes:=$volumes+"\rCapacidad total: "+String:C10($size/1024/1024/1024;"# ### Gb")
$volumes:=$volumes+"\rUtilizado: "+String:C10($used/1024/1024/1024;"# ###"+<>tXS_RS_DecimalSeparator+"00 Gb")
$volumes:=$volumes+"\rLibre: "+String:C10($free/1024/1024/1024;"# ###"+<>tXS_RS_DecimalSeparator+"00 Gb")

If ($vlPlatform=3)
	If (Application type:C494=4D Remote mode:K5:5)
		$volumeDB:=Substring:C12(Application file:C491;1;2)
	Else 
		$volumeDB:=Substring:C12(Data file:C490;1;2)
	End if 
Else 
	If (Application type:C494=4D Remote mode:K5:5)
		$volumeDB:=Substring:C12(Application file:C491;1;Position:C15(":";Application file:C491)-1)
	Else 
		$volumeDB:=Substring:C12(Data file:C490;1;Position:C15(":";Data file:C490)-1)
	End if 
End if 
If ($volumeDB#$VolumeSYS)
	VOLUME ATTRIBUTES:C472($volumeDB;$size;$used;$free)
	$volumes:=$volumes+"\r\r"+ST_Uppercase ($volumeDB)
	$volumes:=$volumes+"\rCapacidad total: "+String:C10($size/1024/1024/1024;"# ### Gb")
	$volumes:=$volumes+"\rUtilizado: "+String:C10($used/1024/1024/1024;"# ###"+<>tXS_RS_DecimalSeparator+"00 Gb")
	$volumes:=$volumes+"\rLibre: "+String:C10($free/1024/1024/1024;"# ###"+<>tXS_RS_DecimalSeparator+"00 Gb")
End if 


If (Count parameters:C259=1)
	Case of 
		: ($1="4D Blob")
			
			TEXT TO BLOB:C554("INFORMACIONES SYSTEMA: "+String:C10(Current date:C33(*))+", "+String:C10(Current time:C178(*))+"\r\r\r";$blob;Mac text without length:K22:10)
			TEXT TO BLOB:C554("NOMBRE COMPUTADOR\r"+$machineName+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("USUARIO COMPUTADOR\r"+$user+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("COMPUTADOR\r"+$machinetype+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("SISTEMA OPERATIVO\r"+$version+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("MEMORIA\r"+$memory+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("DISCOS\r"+$volumes+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("RESOLUCION PANTALLA\r"+$resolution+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("CONFIGURACION REGIONAL\r"+$regionalSettings+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("RED\r"+$networkInfo+"\r\r";$blob;Mac text without length:K22:10;*)
			TEXT TO BLOB:C554("APLICACION\r"+$application+"\r\r";$blob;Mac text without length:K22:10;*)
			If (Application type:C494#4D Server:K5:6)
				TEXT TO BLOB:C554("VERSION SCHOOLTRACK\r"+SYS_LeeVersionEstructura +"\r\r";$blob;Mac text without length:K22:10;*)
			End if 
			TEXT TO BLOB:C554("USUARIO SCHOOLTRACK\r"+<>tUSR_CurrentUser+"\r\r";$blob;Mac text without length:K22:10;*)
			$0:=$blob
			
		: ($1="OT Blob")
			$otRef:=OT New 
			OT PutText ($otRef;"FECHA";String:C10(Current date:C33(*)))
			OT PutText ($otRef;"HORA";String:C10(Current time:C178(*)))
			OT PutText ($otRef;"APLICACION";$application)
			OT PutText ($otRef;"COMPUTADOR";$machinetype)
			OT PutText ($otRef;"SISTEMA OPERATIVO";$version)
			OT PutText ($otRef;"RED";$networkInfo)
			OT PutText ($otRef;"CONFIGURACION REGIONAL";$regionalSettings)
			OT PutText ($otRef;"NOMBRE COMPUTADOR";$machineName)
			OT PutText ($otRef;"USUARIO COMPUTADOR";$user)
			OT PutText ($otRef;"RESOLUCION PANTALLA";$resolution)
			OT PutText ($otRef;"MEMORIA";$memory)
			OT PutText ($otRef;"DISCOS";$volumes)
			OT PutText ($otRef;"VERSION SCHOOLTRACK";SYS_LeeVersionEstructura )
			If (Application type:C494#4D Server:K5:6)
				OT PutText ($otRef;"USUARIO SCHOOLTRACK";<>tUSR_CurrentUser)
			Else 
				OT PutText ($otRef;"USUARIO SCHOOLTRACK";"")
			End if 
			$blob:=OT ObjectToNewBLOB ($otRef)
			OT Clear ($otRef)
			$0:=$blob
	End case 
End if 


