//%attributes = {}
  // TGR_BBL_Registros()
  // Por: Alberto Bachler: 17/09/13, 13:45:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
			If ([BBL_Registros:66]StatusID:34=0)
				[BBL_Registros:66]StatusID:34:=Disponible
			End if 
			$l_indiceStatus:=Find in array:C230(<>aCpyStatusId;[BBL_Registros:66]StatusID:34)
			If ($l_indiceStatus>0)
				[BBL_Registros:66]Status:10:=<>aCpyStatus{$l_indiceStatus}
			Else 
				[BBL_Registros:66]StatusID:34:=Disponible
				$l_indiceStatus:=Find in array:C230(<>aCpyStatusId;[BBL_Registros:66]StatusID:34)
				If ($l_indiceStatus>0)
					[BBL_Registros:66]Status:10:=<>aCpyStatus{$l_indiceStatus}
				End if 
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			READ WRITE:C146([BBL_Prestamos:60])
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=[BBL_Registros:66]ID:3)
			
			  //20161130 ASM Ticket 170035
			While (Not:C34(End selection:C36([BBL_Prestamos:60])))
				SN3_MarcarRegistros (SN3_DTi_Prestamos)
				NEXT RECORD:C51([BBL_Prestamos:60])
			End while 
			
			
			DELETE SELECTION:C66([BBL_Prestamos:60])
			READ ONLY:C145([BBL_Prestamos:60])
	End case 
	
End if 






