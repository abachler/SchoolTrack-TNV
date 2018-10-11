//%attributes = {}
C_TEXT:C284($0)

C_LONGINT:C283($platform_l)
_O_PLATFORM PROPERTIES:C365($platform_l)

If ($platform_l=Mac OS:K25:2)
	$executable_file_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"7z:MacOS:7z"
Else 
	If (System folder:C487(Applications or program files:K41:17)="@\\Program Files (x86)\\")
		$executable_file_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"7z\\Windows\\x64\\7z.exe"
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	Else 
		$executable_file_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"7z\\Windows\\7z.exe"
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	End if 
End if 

$0:=LEP_Escape_path ($executable_file_path_t)