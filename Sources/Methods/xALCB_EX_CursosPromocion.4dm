//%attributes = {}
  //xALCB_EX_CursosPromocion

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;vRow)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Promo)=1)
		AL_GetCurrCell (xALP_Promo;$Col;$Row)
		If ($col=6)
			KRL_GotoRecord (->[Alumnos:2];al_RecordNumber{$row};False:C215)
			KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
			[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9:=at_ObservacionesActas{$row}
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
		End if 
		
	End if 
End if 