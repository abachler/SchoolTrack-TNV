//%attributes = {}
  //SYS_GetOS

C_LONGINT:C283($vlPlatform;$vlsystem;$vlmachine)
_O_PLATFORM PROPERTIES:C365($vlPlatform;$vlSystem;$vlMachine)
If (($vlPlatform<1) | (3<$vlPlatform))
	$vsPlatformOS:=""
Else 
	If ($vlPlatform=3)
		$vsPlatformOS:=""
		If ($vlSystem<0)
			$winMajVers:=((2^31)+$vlSystem)%256
			$winMinVers:=(((2^31)+$vlSystem)\256)%256
			If ($winMinVers=0)
				$vsPlatformOS:="Windows 95"
			Else 
				$vsPlatformOS:="Windows 98"
			End if 
		Else 
			$winMajVers:=$vlSystem%256
			$winMinVers:=($vlSystem\256)%256
			Case of 
				: ($winMajVers=4)
					$vsPlatformOS:="Windows NT"
				: ($winMajVers=5)
					If ($winMinVers=0)
						$vsPlatformOS:="Windows 2000"
					Else 
						$vsPlatformOS:="Windows XP"
					End if 
			End case 
		End if 
		$vsPlatformOS:=$vsPlatformOS+" version "+String:C10($winMajVers)+"."+String:C10($winMinVers)
	Else 
		$vsPlatformOS:="MacOS version "
		If (($vlSystem\256)=16)
			$vsPlatformOS:=$vsPlatformOS+"10"
		Else 
			$vsPlatformOS:=$vsPlatformOS+String:C10($vlSystem\256)
		End if 
		$vsPlatformOS:=$vsPlatformOS+"."+String:C10(($vlSystem\16)%16)+(("."+String:C10($vlSystem%16))*Num:C11(($vlSystem%16)#0))
	End if 
End if 
$0:=$vsPlatformOS