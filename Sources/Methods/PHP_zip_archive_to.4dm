//%attributes = {"shared":true}
C_TEXT:C284($1;$2)
C_BOOLEAN:C305($0)

ASSERT:C1129((Count parameters:C259>0);Get localized string:C991("a file path was expected."))
ASSERT:C1129((Count parameters:C259>1);Get localized string:C991("a directory path was expected."))

$php_script_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"PHP"+Folder separator:K24:12+"zip_archive_to.php"

If (Substring:C12($1;Length:C16($1))=Folder separator:K24:12)
	$1:=Substring:C12($1;1;Length:C16($1)-1)
End if 

If (Substring:C12($2;Length:C16($2))=Folder separator:K24:12)
	$2:=Substring:C12($2;1;Length:C16($2)-1)
End if 

SET ENVIRONMENT VARIABLE:C812("ZIP_SOURCE";Convert path system to POSIX:C1106($1))
SET ENVIRONMENT VARIABLE:C812("ZIP_DESTINATION";Convert path system to POSIX:C1106($2))

C_BOOLEAN:C305($result_bool)

If (PHP Execute:C1058($php_script_path_t;"";$result_bool))
	$0:=$result_bool
End if 