//%attributes = {}
  //SYS_SaveMachineInfos
C_BLOB:C604($blob)
C_LONGINT:C283($l_plataforma;$vlSystem;$vlMachine)
ARRAY TEXT:C222($aText;0)

If (SYS_IsWindows )
	ARRAY TEXT:C222($at_infomacionRed;0)
	$l_error:=sys_GetNetworkInfo ($t_informacionRed)
	AT_Text2Array (->$at_infomacionRed;$t_informacionRed;",")
	If (Size of array:C274($at_infomacionRed)>=2)
		$domaine:=$at_infomacionRed{2}
	Else 
		$domaine:=""
	End if 
Else 
	$domaine:=""
End if 
$userName:=Current system user:C484
$machineName:=Current machine:C483

If (($userName#"aBachler") & ($machineName#"Colegium-@") & ($domaine#"lester.colegium.com") & ($machineName#"U2")) & (<>lUSR_CurrentUserID>=0)
	
	  //NOMBRE DEL COMPUTADOR 
	$machineName:=Current machine:C483
	_O_ARRAY STRING:C218(12;$aMacAddress;0)
	
	  // MAC ADDRESS
	ARRAY TEXT:C222($at_direccionMAC;0)
	$vtXS_MacAddress:=SYS_GetServerMAC (->$at_direccionMAC)
	$0:=AT_array2text (->$at_direccionMAC;", ")
	
	READ WRITE:C146([xShell_InfoMachines:151])
	QUERY:C277([xShell_InfoMachines:151];[xShell_InfoMachines:151]MacAddress:1;=;$vtXS_MacAddress;*)
	QUERY:C277([xShell_InfoMachines:151]; & ;[xShell_InfoMachines:151]MachineName:2;=;$machineName)
	
	If (Records in selection:C76([xShell_InfoMachines:151])=0)
		CREATE RECORD:C68([xShell_InfoMachines:151])
	End if 
	[xShell_InfoMachines:151]MachineName:2:=$machineName
	[xShell_InfoMachines:151]MacAddress:1:=$vtXS_MacAddress
	
	_O_PLATFORM PROPERTIES:C365($l_plataforma;$vlSystem;$vlMachine)
	
	  //TIPO APLICACION y SISTEMA OPERATIVO
	[xShell_InfoMachines:151]IsServer:3:=False:C215
	Case of 
		: (Application type:C494=4D Server:K5:6)
			$t_tipoApplicacion:="4D Server"
			$t_nombreOS:=SYS_GetServerOS 
		: (Application type:C494=4D Remote mode:K5:5)
			$t_tipoApplicacion:="4D Client"
			$t_nombreOS:=SYS_GetOSName 
		: (Application type:C494=4D Volume desktop:K5:2)
			$t_tipoApplicacion:="4D Volume Desktop"
			$t_nombreOS:=SYS_GetOSName 
		: (Application type:C494=4D Local mode:K5:1)
			$t_tipoApplicacion:="4th Dimension"
			$t_nombreOS:=SYS_GetOSName 
	End case 
	$t_version4D:=Application version:C493
	[xShell_InfoMachines:151]Version_4D:5:=$t_tipoApplicacion+" "+$t_version4D
	[xShell_InfoMachines:151]OS:7:=$t_nombreOS
	
	
	  //COMPUTADOR
	If ($l_plataforma=3)
		$t_llaveRegistroWin:="HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0"
		$ERR:=sys_GetRegText (GR_HKEY_LOCAL_MACHINE;$t_llaveRegistroWin;"ProcessorNameString";$machineType)
		[xShell_InfoMachines:151]MachineType:6:=ST_GetCleanString ($machineType)
	Else 
		$l_error:=_O_Gestalt:C488("mach";$vlMachine)
		If ($vlMachine#0)
			[xShell_InfoMachines:151]MachineType:6:="Macintosh: "+String:C10($vlMachine)
		Else 
			[xShell_InfoMachines:151]MachineType:6:="Macintosh (modelo desconocido)"
		End if 
	End if 
	
	
	  //CONFIGURACION DE RED
	If ($l_plataforma=3)
		ARRAY TEXT:C222($at_infomacionRed;0)
		$l_error:=sys_GetNetworkInfo ($t_informacionRed)
		If ($t_informacionRed#"")
			AT_Text2Array (->$at_infomacionRed;$t_informacionRed;",")
			If (Size of array:C274($at_infomacionRed)>0)
				$t_textoInfoRed:="Host : "+$at_infomacionRed{1}
				$t_textoInfoRed:=$t_textoInfoRed+"\rDominio: "+$at_infomacionRed{2}
				If (Size of array:C274($at_infomacionRed)>=2)  //Para evitar errores en windows 98 No segunda edicion
					$t_textoInfoRed:=$t_textoInfoRed+"\rIP of domain server:"+$at_infomacionRed{3}
					  //$t_textoInfoRed:=$t_textoInfoRed+"\rTipo: "+$aText{4}
					$t_textoInfoRed:=$t_textoInfoRed+"\r"+$at_infomacionRed{5}
					$t_textoInfoRed:=$t_textoInfoRed+"\r"+$at_infomacionRed{6}
					$t_textoInfoRed:=$t_textoInfoRed+"\rServidores de Nombres:"
					For ($i;7;Size of array:C274($at_infomacionRed))
						$t_textoInfoRed:=$t_textoInfoRed+$at_infomacionRed{$i}+", "
					End for 
					[xShell_InfoMachines:151]NetworkInfo:8:=Substring:C12($t_textoInfoRed;1;Length:C16($t_textoInfoRed)-2)
				Else 
					[xShell_InfoMachines:151]NetworkInfo:8:=$t_textoInfoRed
				End if 
			Else 
				[xShell_InfoMachines:151]NetworkInfo:8:=""
			End if 
		Else 
			[xShell_InfoMachines:151]NetworkInfo:8:=""
		End if 
	Else 
		[xShell_InfoMachines:151]NetworkInfo:8:=""
	End if 
	
	  //MONITOR
	[xShell_InfoMachines:151]ScreenResolution:9:=String:C10(Screen width:C187(*))+"/"+String:C10(Screen height:C188(*))
	
	  //MEMORIA COMPUTADOR
	SYS_GetMemory 
	[xShell_InfoMachines:151]Physical_RAM:10:=vlPhysicalMemory
	
	
	
	  //DISCOS DUROS
	If ($l_plataforma=3)
		$t_volumenSistema:=Substring:C12(System folder:C487;1;2)
	Else 
		$t_volumenSistema:=Substring:C12(System folder:C487;1;Position:C15(":";System folder:C487)-1)
	End if 
	VOLUME ATTRIBUTES:C472($t_volumenSistema;$l_capacidadDisco;$l_capacidadUtilizada;$l_disponibleEnDisco)
	[xShell_InfoMachines:151]SystemDisk_Capacity_Gb:12:=$l_capacidadDisco/1024/1024/1024
	[xShell_InfoMachines:151]SystemDisk_FreeSpace_Gb:13:=$l_disponibleEnDisco/1024/1024/1024
	
	If ($l_plataforma=3)
		If (Application type:C494=4D Remote mode:K5:5)
			$t_volumenBD:=Substring:C12(Application file:C491;1;2)
		Else 
			$t_volumenBD:=Substring:C12(Data file:C490;1;2)
		End if 
	Else 
		If (Application type:C494=4D Remote mode:K5:5)
			$t_volumenBD:=Substring:C12(Application file:C491;1;Position:C15(":";Application file:C491)-1)
		Else 
			$t_volumenBD:=Substring:C12(Data file:C490;1;Position:C15(":";Data file:C490)-1)
		End if 
	End if 
	VOLUME ATTRIBUTES:C472($t_volumenBD;$l_capacidadDisco;$l_capacidadUtilizada;$l_disponibleEnDisco)
	[xShell_InfoMachines:151]AppDisk_Capacity_Gb:14:=$l_capacidadDisco/1024/1024/1024
	[xShell_InfoMachines:151]AppDisk_FreeSpace_Gb:15:=$l_disponibleEnDisco/1024/1024/1024
	
	[xShell_InfoMachines:151]LastInfo:4:=Current date:C33(*)
	SAVE RECORD:C53([xShell_InfoMachines:151])
	UNLOAD RECORD:C212([xShell_InfoMachines:151])
End if 


