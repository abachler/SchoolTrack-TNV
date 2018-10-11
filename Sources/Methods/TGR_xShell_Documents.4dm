//%attributes = {}
  // Método: TGR_xShell_Documents
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:37:01
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[xShell_Documents:91]DocID:9:=SQ_SeqNumber (->[xShell_Documents:91]DocID:9)
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
	End if 
	SN3_MarcarRegistros (SN3_DTi_PlanesClase;SN3_SDTx_Referencias)
	SN3_MarcarRegistros (10013;-1)  //ASM 20160802 Documentos de guias
End if 



