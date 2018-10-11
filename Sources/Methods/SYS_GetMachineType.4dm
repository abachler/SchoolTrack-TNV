//%attributes = {}
  //SYS_GetMachineType

C_LONGINT:C283($vlPlatform;$vlsystem;$vlmachine)
C_TEXT:C284($0;$vt_machineType)
_O_PLATFORM PROPERTIES:C365($vlPlatform;$vlSystem;$vlMachine)

Case of 
	: ($vlMachine=_o_INTEL 386:K25:4)
		$vt_machineType:="INTEL 386"
	: ($vlMachine=_o_INTEL 486:K25:5)
		$vt_machineType:="INTEL 486"
	: ($vlMachine=Intel compatible:K25:6)
		$vt_machineType:="Pentium"
	: ($vlMachine=_o_PowerPC 601:K25:7)
		$vt_machineType:="PowerPC 601 "
	: ($vlMachine=_o_PowerPC 603:K25:8)
		$vt_machineType:="PowerPC 603 "
	: ($vlMachine=_o_PowerPC 604:K25:9)
		$vt_machineType:="PowerPC 604 "
	: ($vlMachine=Power PC:K25:11)
		$vt_machineType:="Other G3 and above"
End case 
$0:=$vt_machineType