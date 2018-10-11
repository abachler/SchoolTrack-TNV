//%attributes = {}
  // Método: TGR_ACT_DocumentosCargo
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:47:05
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				If ([ACT_Documentos_de_Cargo:174]ID_Documento:1=0)
					[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
				End if 
				[ACT_Documentos_de_Cargo:174]Key_Emision:25:=String:C10([ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)+"."+String:C10([ACT_Documentos_de_Cargo:174]Año:14)+"."+String:C10([ACT_Documentos_de_Cargo:174]Mes:13)+"."+String:C10([ACT_Documentos_de_Cargo:174]ID_Matriz:2)
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[ACT_Documentos_de_Cargo:174]Key_Emision:25:=String:C10([ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)+"."+String:C10([ACT_Documentos_de_Cargo:174]Año:14)+"."+String:C10([ACT_Documentos_de_Cargo:174]Mes:13)+"."+String:C10([ACT_Documentos_de_Cargo:174]ID_Matriz:2)
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				  //READ WRITE([ACT_Cargos])
				  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento)
				  //DELETE SELECTION([ACT_Cargos])
		End case 
	End if 
End if 



