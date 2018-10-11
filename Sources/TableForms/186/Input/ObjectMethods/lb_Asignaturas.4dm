C_POINTER:C301($srcObject)
C_LONGINT:C283($srcElement;$srcProcess;$row;$column)

Case of 
	: (Form event:C388=On Drop:K2:12)
		If (MPAcfg_Area_EsValida )
			DRAG AND DROP PROPERTIES:C607($srcObject;$srcElement;$srcProcess)
			If ($srcObject->=lb_AsignaturasArea)
				LISTBOX GET CELL POSITION:C971($srcObject->;$column;$row;$columnVar)
				READ WRITE:C146([xxSTR_Materias:20])
				$l_transaccionOK:=MPAcfg_Area_AsignaAsignatura ($columnVar->{$srcElement};"")
				If ($l_transaccionOK=1)
					AT_Delete ($srcElement;1;$columnVar)
					MPAcfg_Area_AlGuardar 
					SAVE RECORD:C53([MPA_DefinicionAreas:186])
				End if 
			End if 
		End if 
End case 