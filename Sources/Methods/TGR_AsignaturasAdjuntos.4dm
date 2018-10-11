//%attributes = {}
  //TGR_AsignaturasAdjuntos

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	SN3_MarcarRegistros (10013)
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[Asignaturas_Adjuntos:230]fecha_adjunto:5:=Current date:C33(*)
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				  // debo eliminar los archivos adjuntos del disco
				  //XDOC_RemoveAttachedDocument (Record number([Asignaturas_Adjuntos]);"DocsGuias") //se borran en STWA2_OWC_deletefileguias
		End case 
		
	End if 
End if 