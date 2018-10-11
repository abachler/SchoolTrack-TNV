//%attributes = {}
  //KRL_DeleteDuplicates

$file:=Table:C252(Table:C252($1))
$field:=$1
$type:=Type:C295($field->)
ALL RECORDS:C47($file->)
ORDER BY:C49($file->;$field->)
CREATE EMPTY SET:C140($file->;"duplis")
$value:=""
While (Not:C34(End selection:C36($file->)))
	If (($type#0) & ($type#2))
		$fldValue:=String:C10($field->)
	Else 
		$fldValue:=$field->
	End if 
	If ($fldValue=$value)
		ADD TO SET:C119($file->;"duplis")
	End if 
	If (($type#0) & ($type#2))
		$Value:=String:C10($field->)
	Else 
		$Value:=$field->
	End if 
	NEXT RECORD:C51($file->)
End while 
USE SET:C118("Duplis")
CLEAR SET:C117("duplis")
READ WRITE:C146($file->)
DELETE SELECTION:C66($file->)
READ ONLY:C145($file->)