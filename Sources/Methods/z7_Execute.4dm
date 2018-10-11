//%attributes = {}
C_TEXT:C284($1)
C_POINTER:C301($2)
C_BLOB:C604($3)
C_BOOLEAN:C305($0)

C_LONGINT:C283($count_parameters_l)
$count_parameters_l:=Count parameters:C259

C_BLOB:C604($standard_input_x;$standard_output_x;$standard_error_x)

If ($count_parameters_l>1)
	
	$argument_string_t:=$1
	$executable_file_path_t:=z7_Get_path 
	$command_t:=$executable_file_path_t+$argument_string_t
	$reponse_receiver_p:=$2
	
	If ($count_parameters_l>2)
		$standard_input_x:=$3
	End if 
	
	LAUNCH EXTERNAL PROCESS:C811($command_t;$standard_input_x;$standard_output_x;$standard_error_x)
	
	C_LONGINT:C283($platform_l)
	_O_PLATFORM PROPERTIES:C365($platform_l)
	
	If (BLOB size:C605($standard_error_x)=0)
		If ($platform_l=Mac OS:K25:2)
			$standard_output_t:=Convert to text:C1012($standard_output_x;"utf-8")
		Else 
			$standard_output_t:=BLOB to text:C555($standard_output_x;Mac text without length:K22:10)
		End if 
		
		ARRAY LONGINT:C221($pos;0)
		ARRAY LONGINT:C221($len;0)
		
		If (Match regex:C1019("(Error:|WARNING:)\\s*(.*)";$standard_output_t;1;$pos;$len))
			$error:=Substring:C12($standard_output_t;$pos{2};$len{2})
			If (Not:C34(Is nil pointer:C315($2)))
				Case of 
					: (Type:C295($2->)=Is text:K8:3)
						$2->:=$error
					: (Type:C295($2->)=Is BLOB:K8:12)
						CONVERT FROM TEXT:C1011($error;"utf-8";$2->)
				End case 
			End if 
		Else 
			$0:=True:C214
		End if 
	Else 
		$0:=False:C215
		If (Not:C34(Is nil pointer:C315($2)))
			Case of 
				: (Type:C295($2->)=Is text:K8:3)
					If ($platform_l=Mac OS:K25:2)
						$2->:=Convert to text:C1012($standard_error_x;"utf-8")
					Else 
						$2->:=BLOB to text:C555($standard_error_x;Mac text without length:K22:10)
					End if 
				: (Type:C295($2->)=Is BLOB:K8:12)
					$2->:=$standard_error_x
			End case 
		End if 
	End if 
	
End if 