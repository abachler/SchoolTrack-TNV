//%attributes = {}
  //xAL_CMT_CBExit_CamposTransf

C_LONGINT:C283($1;$2;$3)
C_LONGINT:C283($col;$line)
C_BOOLEAN:C305($0)
alProEvt:=AL_GetLine ($1)
AL_GetCurrCell ($1;$col;$line)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	$change:=AL_GetCellMod ($1)
	If ($change=1)
		Case of 
			: ($col=6)
				alCM_TablaBase{$line}:=Find in array:C230(aTableNames;atCM_TablaBase{$line})
				CMT_Transferencia ("ValidaRegistroTabla")
			: ($col=7)
				$vt_validado:=CMT_Transferencia ("ValidaEtiquetas";->$line)
				If ($vt_validado="0")
					BEEP:C151
					atCM_TextAliasCampo{$line}:=""
				End if 
		End case 
	End if 
End if 