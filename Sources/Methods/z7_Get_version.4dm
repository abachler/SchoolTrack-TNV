//%attributes = {}
C_TEXT:C284($0)

$executable_file_path_t:=z7_Get_path 
$command_t:=$executable_file_path_t+" v"

C_BLOB:C604($standard_input_x;$standard_output_x;$standard_error_x)
LAUNCH EXTERNAL PROCESS:C811($command_t;$standard_input_x;$standard_output_x;$standard_error_x)

C_LONGINT:C283($platform_l)
_O_PLATFORM PROPERTIES:C365($platform_l)

If ($platform_l=Mac OS:K25:2)
	$0:=Convert to text:C1012($standard_output_x;"utf-8")
Else 
	$0:=BLOB to text:C555($standard_output_x;Mac text without length:K22:10)
End if 
