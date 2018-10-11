//%attributes = {}
  //xALP_ACT_CB_ModDocTrib

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_WizDocTrib)=1)
		AL_GetCurrCell (xALP_WizDocTrib;$col;$row)
		Case of 
			: ($col=1)
				If (alACT_WDTNumero{$row}#alACT_WDTNumero{0})
					modbol:=True:C214
					abACT_WDTModificada{$row}:=True:C214
					ACTbol_WDTAnalize 
				End if 
			: ($col=4)
				If (adACT_WDTFecha{$row}#adACT_WDTFecha{0})
					If (DT_StrDateIsOK (String:C10(adACT_WDTFecha{$row});False:C215)#dt_GetNullDateString )
						modbol:=True:C214
						abACT_WDTModificada{$row}:=True:C214
						ACTbol_WDTAnalize 
					Else 
						CD_Dlog (0;__ ("La fecha ingresada no parece correcta. El sistema volverá a la fecha anterior."))
						adACT_WDTFecha{$row}:=adACT_WDTFecha{0}
					End if 
				End if 
		End case 
	End if 
End if 