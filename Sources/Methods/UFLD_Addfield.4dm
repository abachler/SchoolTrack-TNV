//%attributes = {}
  //UFLD_Addfield

sUFValue:=""
WDW_OpenFormWindow (->[xShell_Userfields:76];"Input";-1;Movable form dialog box:K39:8;__ ("Nuevo campo propio");"WDW_Closedlog")
READ WRITE:C146([xShell_Userfields:76])
FORM SET INPUT:C55([xShell_Userfields:76];"Input")
ADD RECORD:C56([xShell_Userfields:76];*)
CLOSE WINDOW:C154
$tempID:=[xShell_Userfields:76]FieldID:7
UNLOAD RECORD:C212([xShell_Userfields:76])
READ ONLY:C145([xShell_Userfields:76])
AL_UpdateArrays (XALP_UserFields;0)
UFLD_LoadArrays 
AL_UpdateArrays (XALP_UserFields;-2)
AL_SetSort (XALP_UserFields;2;1)
$LocInList:=Find in array:C230(aUFid;$tempID)
If ($LocInList>0)
	AL_SetLine (XALP_UserFields;$LocInList)
	aUFName:=$LocInList
	IT_SetButtonState (aUFName#0;->bDelUF;->bEdit)
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
			tInfos:="Utilizado en un "+$ratio+" de los registros del archivo."
		Else 
			tInfos:="No utilizado."
		End if 
		
		  //20170927 ASM creo los registros en el campo correspondiente
		UFDL_CreaRegistroUserFieldEnTab 
		
	Else 
		tInfos:=""
	End if 
End if 