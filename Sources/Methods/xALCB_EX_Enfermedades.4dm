//%attributes = {}
  //xALCB_EX_Enfermedades

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Enfermedades)=1)
		$stop:=False:C215
		vl_ModSalud:=vl_ModSalud ?+ 0
		AL_GetCurrCell (xALP_Enfermedades;$Col;$Row)
		AL_ExitCell (xALP_Enfermedades)
		If ($Col=1)
			C_TEXT:C284($text)
			$text:=aEnfermedad{$row}
			$text:=TBL_GetValue (-><>aEnfermedades;->$text;"Ficha Médica: Enfermedades")
			aEnfermedad{$row}:=$text
			AL_SetEnterable (xALP_Enfermedades;3;3;<>aEnfermedades)
			AL_UpdateArrays (xALP_Enfermedades;-2)
		End if 
	End if 
End if 
