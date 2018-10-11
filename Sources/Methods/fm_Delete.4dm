//%attributes = {}
  //fm_Delete

C_LONGINT:C283($0)

If (USR_checkRights ("D";->[Familia:78]))
	If (Size of array:C274(aBthrName)>0)
		CD_Dlog (0;__ ("La familia no puede ser eliminada mientras no sean eliminados los alumnos."))
	Else 
		$r:=CD_Dlog (0;__ ("Desea Ud. realmente eliminar esta familia y las personas asociadas ?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			  //QRY_QueryWithArray (->[Personas]No;->aPersID)
			$recNum:=Record number:C243([Familia:78])
			CREATE EMPTY SET:C140([Personas:7];"toDelete")
			fm_BuscaPersonasAEliminar ("toDelete";->aPersID)
			USE SET:C118("toDelete")
			CLEAR SET:C117("toDelete")
			GOTO RECORD:C242([Familia:78];$recNum)
			START TRANSACTION:C239
			ok:=KRL_DeleteSelection (->[Personas:7])
			If (ok=1)
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
				ok:=KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77])
				If (ok=1)
					DELETE RECORD:C58([Familia:78])
				End if 
			End if 
			If (ok=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
			$0:=OK
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 


