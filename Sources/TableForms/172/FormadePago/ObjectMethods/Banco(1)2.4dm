C_TEXT:C284(tempSelf;vsACT_OldBanco)

$valuebank:=""
$valueID:=""

Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		IT_Clairvoyance (Self:C308;->atACT_BankName)
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldBanco:=Self:C308->
		tempSelf:=Self:C308->
		tempID:=vtACT_BancoID
	: (Form event:C388=On Losing Focus:K2:8)
		If (Find in array:C230(atACT_BankName;Self:C308->)=-1)
			IT_Clairvoyance (Self:C308;->atACT_BankID)
			ACTcfg_LoadBancos 
			$page:=Find in array:C230(atACT_BankID;Self:C308->)
			If ($page#-1)
				$valuebank:=atACT_BankName{$page}
				$valueID:=atACT_BankID{$page}
			Else 
				$valuebank:=""
			End if 
		Else 
			ACTcfg_LoadBancos 
			$page:=Find in array:C230(atACT_BankName;Self:C308->)
			vtACT_BancoID:=atACT_BankID{$page}
		End if 
		If ($page#-1)
			If ($valuebank#"")
				Self:C308->:=$valuebank
				vtACT_BancoID:=$valueID
			End if 
			GOTO OBJECT:C206(vtACT_BancoCuenta)
		Else 
			BEEP:C151
			Self:C308->:=tempSelf
			vtACT_BancoID:=tempID
		End if 
		vbSpell_StopChecking:=True:C214
End case 