//%attributes = {}
  //UFLD_GetUserFieldValue


_O_C_STRING:C293(30;$1;$uName)
C_TEXT:C284($0)
$0:=""
If ($1="")
	$0:="ERROR. Falta el nombre del campo"
Else 
	$uName:=$1
	QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]UserFieldName:1=$uName)
	If (Records in selection:C76([xShell_Userfields:76])=0)
		$0:="ERROR. Campo propio inexistente."
	Else 
		$file:=[xShell_Userfields:76]FileNo:6
		$tablePointer:=Table:C252([xShell_Userfields:76]FileNo:6)
		$subtablePointer:=KRL_GetFieldPointer ($tablePointer;"UserFields")
		$subFieldPointer:=KRL_GetFieldPointer ($tablePointer;"UserFields'Value")
		$UF:=String:C10([xShell_Userfields:76]FieldID:7;"00000/")+"@"
		_O_QUERY SUBRECORDS:C108($subtablePointer->;$subFieldPointer->=$UF)
		While (Not:C34(_O_End subselection:C37($subtablePointer->)))
			If ($subFieldPointer->#"")
				Case of 
					: ([xShell_Userfields:76]FieldType:2=0)
						$0:=$0+Substring:C12($subFieldPointer->;7;80)+", "
					: ([xShell_Userfields:76]FieldType:2=4)
						$string:=Substring:C12($subFieldPointer->;7;80)
						$0:=String:C10(DT_Num2date (Num:C11($string));7)+", "
					: ([xShell_Userfields:76]FieldType:2=1)
						$0:=$0+String:C10(Num:C11(Substring:C12($subFieldPointer->;7;80));"########0,00")+", "  //RCH al modificar este formato, hacerlo también en el método xALCB_EX_UserFields
					: ([xShell_Userfields:76]FieldType:2=9)
						$0:=$0+String:C10(Num:C11(Substring:C12($subFieldPointer->;7;80));"#########0")+", "
				End case 
			End if 
			_O_NEXT SUBRECORD:C62($subtablePointer->)
		End while 
		If ($0#"")
			$0:=Substring:C12($0;1;Length:C16($0)-2)
		End if 
	End if 
End if 

