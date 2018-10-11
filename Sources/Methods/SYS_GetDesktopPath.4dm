//%attributes = {}
  //SYS_GetDesktopPath

C_TEXT:C284($0;$path;$4Dfolder)
C_LONGINT:C283($platform;$system;$vlSys;$i)
_O_PLATFORM PROPERTIES:C365($platform;$system)
If ($platform=3)
	$path:=System folder:C487(Desktop:K41:16)
Else 
	$vlSys:=$system\256
	If ($vlSys=16)
		$path:=System folder:C487(User preferences_user:K41:4)
		$path:=Replace string:C233($path;"Library:Preferences:";"Desktop:")
	Else 
		$4Dfolder:=System folder:C487(System:K41:1)
		For ($i;1;Length:C16($4Dfolder))
			If ($4Dfolder[[$i]]=":")
				$path:=Substring:C12($4Dfolder;1;$i)+"Desktop Folder:"
				$i:=Length:C16($4Dfolder)+1
			End if 
		End for 
	End if 
End if 
$0:=$path