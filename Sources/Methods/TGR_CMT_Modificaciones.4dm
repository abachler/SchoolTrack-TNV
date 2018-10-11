//%attributes = {}
  // Método: TGR_CMT_Modificaciones
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:15:50
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
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([CMT_Modificaciones:159]id:1=0)
				[CMT_Modificaciones:159]id:1:=SQ_SeqNumber (->[CMT_Modificaciones:159]id:1)
			End if 
			[CMT_Modificaciones:159]DTS_Creacion:4:=DTS_MakeFromDateTime 
			[CMT_Modificaciones:159]Fecha_Creacion:5:=Current date:C33(*)
			[CMT_Modificaciones:159]Key:7:=String:C10([CMT_Modificaciones:159]id_Transferencia:2)+"."+[CMT_Modificaciones:159]ID_Registro:3
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[CMT_Modificaciones:159]DTS_Modificacion:6:=DTS_MakeFromDateTime 
			[CMT_Modificaciones:159]Key:7:=String:C10([CMT_Modificaciones:159]id_Transferencia:2)+"."+[CMT_Modificaciones:159]ID_Registro:3
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 



