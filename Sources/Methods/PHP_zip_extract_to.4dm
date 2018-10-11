//%attributes = {"shared":true}
C_TEXT:C284($1;$2)
C_POINTER:C301($3)
C_BOOLEAN:C305($0)

ASSERT:C1129((Count parameters:C259>0);Get localized string:C991("a file path was expected."))
ASSERT:C1129((Count parameters:C259>1);Get localized string:C991("a directory path was expected."))

$php_script_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"PHP"+Folder separator:K24:12+"zip_extract_to.php"

If (Count parameters:C259>2)
	If (Not:C34(Is nil pointer:C315($3)))
		If (Type:C295($3->)=Text array:K8:16)
			C_LONGINT:C283($i)
			For ($i;1;Size of array:C274($3->))
				$3->{$i}:=Convert path system to POSIX:C1106($3->{$i})
			End for 
			$entries:=PHP_util_array_to_json ($3)
		End if 
	End if 
Else 
	$entries:=""
End if 

SET ENVIRONMENT VARIABLE:C812("ZIP_SOURCE";Convert path system to POSIX:C1106($1))
SET ENVIRONMENT VARIABLE:C812("ZIP_DESTINATION";Convert path system to POSIX:C1106($2))
SET ENVIRONMENT VARIABLE:C812("ZIP_ENTRIES";$entries)

C_BOOLEAN:C305($result_bool)

If (PHP Execute:C1058($php_script_path_t;"";$result_bool))
	$0:=$result_bool
End if 