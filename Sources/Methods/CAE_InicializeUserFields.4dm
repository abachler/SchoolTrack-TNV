//%attributes = {}
  //CAE_InicializeUserFields

If (Count parameters:C259=1)
	$module:=$1
Else 
	$module:=""
End if 

QUERY:C277([xShell_Tables:51];[xShell_Tables:51]TieneCamposPropios:33=True:C214)
If (Records in selection:C76([xShell_Tables:51])>0)
	SELECTION TO ARRAY:C260([xShell_Tables:51];$aRecNums)
	For ($y;1;Records in selection:C76([xShell_Tables:51]))
		GOTO RECORD:C242([xShell_Tables:51];$aRecNums{$y})
		$tableName:=[xShell_Tables:51]NombreDeTabla:1
		$tablePtr:=Table:C252([xShell_Tables:51]NumeroDeTabla:5)
		$wasInReadOnly:=True:C214
		If (Read only state:C362($tablePtr->))
			$wasInReadOnly:=Read only state:C362($tablePtr->)
			READ WRITE:C146($tablePtr->)
		End if 
		QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=[xShell_Tables:51]NumeroDeTabla:5;*)
		QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]InicializaalCierre:11=True:C214;*)
		If ($module="")
			QUERY:C277([xShell_Userfields:76])
		Else 
			QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]ModuleName:10=$module)
		End if 
		FIRST RECORD:C50([xShell_Userfields:76])
		While (Not:C34(End selection:C36([xShell_Userfields:76])))
			$code:=String:C10([xShell_Userfields:76]FieldID:7;"00000")+"/@"
			vField:="["+$tableName+"]UserFields"
			EXECUTE FORMULA:C63("vy_SubFieldPtr:=->"+vField)
			vValue:=vField+"'Value"
			EXECUTE FORMULA:C63("vt_SubValue:=->"+vValue)
			ALL RECORDS:C47($tablePtr->)
			FIRST RECORD:C50($tablePtr->)
			$Process:=IT_UThermometer (1;0;__ ("Inicializando campos propios..."))
			While (Not:C34(End selection:C36($tablePtr->)))
				_O_QUERY SUBRECORDS:C108(vy_SubFieldPtr->;vt_SubValue->=$code)
				While (Not:C34(_O_End subselection:C37(vy_SubFieldPtr->)))
					vt_SubValue->:=Substring:C12($code;1;Length:C16($code)-1)
					_O_NEXT SUBRECORD:C62(vy_SubFieldPtr->)
				End while 
				SAVE RECORD:C53($tablePtr->)
				NEXT RECORD:C51($tablePtr->)
			End while 
			IT_UThermometer (-2;$Process)
			NEXT RECORD:C51([xShell_Userfields:76])
		End while 
		If ($wasInReadOnly)
			READ ONLY:C145($tablePtr->)
		End if 
	End for 
End if 