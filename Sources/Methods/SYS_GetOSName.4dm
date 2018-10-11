//%attributes = {}
  //SYS_GetOSName

C_TEXT:C284($0;$t_version;$t_moreInfo;$t_version)
C_LONGINT:C283($l_plataforma;$l_versionNum;$error;$l_plataforma;$l_sistema;$l_maquina)

<>sys_is64bitOS_B:=UTIL_isOS64bit 
_O_PLATFORM PROPERTIES:C365($l_plataforma;$l_sistema;$l_maquina)
If (($l_plataforma<2) | ($l_plataforma>3))
	$t_version:=""
Else 
	If ($l_plataforma=Windows:K25:3)
		$error:=sys_GetOSVersion ($l_versionNum;$t_moreInfo)
		$t_version:=""
		If ($l_sistema<6)
			$t_version:="Windows version too old"
		Else 
			$l_versionMayor:=$l_sistema%256
			$l_versionMenor:=($l_sistema\256)%256
			Case of 
				: ($l_versionNum=OS_SERVER2K8)
					$t_version:="Windows 2008 Server (no certificado)"
					
				: ($l_versionNum=OS_SERVER2K8R2)
					$t_version:="Windows Server 2008 R2"
					
				: ($l_versionNum=OS_SERVER2012)
					$t_version:="Windows Server 2012"
					
				: ($l_versionNum=OS_SERVER2012R2)
					$t_version:="Windows Server 2012 R2"
					
				: ($l_versionNum=OS_WIN8)
					$t_version:="Windows 8.0"
					
				: ($l_versionNum=OS_WIN81)
					$t_version:="Windows 8.1"
					
				: (($l_versionMayor=10) | ($l_versionNum=1000))
					$t_version:="Windows 10"
					
				: ($l_versionMayor=6)
					Case of 
						: ($l_versionMenor=0)
							$t_version:="Windows Vista"
						: ($l_versionMenor=1)
							$t_version:="Windows 7"
						: ($l_versionMenor=2)
							$t_version:="Windows 10"
						: ($l_versionMenor=3)
							$t_version:="Windows 8.1"
						Else 
							$t_version:="Windows (undetermined version)"
					End case 
				: ($l_versionMayor=10)
					$t_version:="Windows 10"
			End case 
		End if 
		If (($l_versionMenor>0) & ($t_version=""))
			$t_version:="Windows "+String:C10($l_versionMayor)+"."+String:C10($l_versionMenor)
		End if 
	Else 
		$t_version:="macOS "
		If (($l_sistema\256)=16)
			$t_version:=$t_version+"10"
		Else 
			$t_version:=$t_version+String:C10($l_sistema\256)
		End if 
		$t_version:=$t_version+"."+String:C10(($l_sistema\16)%16)+(("."+String:C10($l_sistema%16))*Num:C11(($l_sistema%16)#0))
	End if 
End if 
$0:=$t_version+Choose:C955(<>sys_is64bitOS_B;" (64 bits)";" (32 bits)")