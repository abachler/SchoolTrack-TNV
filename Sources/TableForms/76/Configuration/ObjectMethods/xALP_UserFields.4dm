aUFname:=AL_GetLine (XALP_UserFields)
aUFid:=aUFname
Case of 
	: (alProEvt=2)
		UFLD_Edit 
	: (alProEvt=1)
		If (aUFName>0)
			C_LONGINT:C283($f;$t)
			$id:=String:C10(aUFid{aUFname};"00000/"+"@")
			READ ONLY:C145([xShell_Userfields:76])
			QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FieldID:7=aUFid{aUFname})
			vField:="["+Table name:C256([xShell_Userfields:76]FileNo:6)+"]Userfields'Value"
			EXECUTE FORMULA:C63("vPointer:=»"+vField)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$f)
			QUERY:C277(Table:C252([xShell_Userfields:76]FileNo:6)->;vPointer->=$id)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			  //$f:=Records in selection(Table([xShell_Userfields]FileNo)->)
			If ($f>0)
				$t:=Records in table:C83(Table:C252([xShell_Userfields:76]FileNo:6)->)
				$ratio:=String:C10(Round:C94($f/$t*100;2);"##0,00%")
				tInfos:=__ ("Utilizado en un ")+$ratio+__ (" de los registros del archivo.")
			Else 
				tInfos:=__ ("No utilizado.")
			End if 
		Else 
			tInfos:=""
		End if 
End case 
aUFname:=AL_GetLine (XALP_UserFields)
IT_SetButtonState (aUFName#0;->bDelUF;->bEdit)