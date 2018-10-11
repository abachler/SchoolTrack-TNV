C_TEXT:C284(tempSelf;vsACT_OldBanco)

$valuebank:=""

Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		IT_Clairvoyance (Self:C308;->atACT_BankName)
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldBanco:=Self:C308->
		tempSelf:=Self:C308->
	: (Form event:C388=On Losing Focus:K2:8)
		If (Find in array:C230(atACT_BankName;Self:C308->)=-1)
			IT_Clairvoyance (Self:C308;->atACT_BankID)
			ACTcfg_LoadBancos 
			$page:=Find in array:C230(atACT_BankID;Self:C308->)
			If ($page#-1)
				$valuebank:=atACT_BankName{$page}
			Else 
				$valuebank:=""
			End if 
		Else 
			ACTcfg_LoadBancos 
			$page:=Find in array:C230(atACT_BankName;Self:C308->)
		End if 
		If ($page#-1)
			If ($valuebank#"")
				Self:C308->:=$valuebank
			End if 
			  //GOTO AREA(vtACT_BancoCuenta)
		Else 
			BEEP:C151
			If (Self:C308->#"")
				Self:C308->:=tempSelf
			Else 
				Self:C308->:=""
			End if 
		End if 
End case 