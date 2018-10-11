//%attributes = {}
  // Método: TGR_ACT_Pagos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:49:10
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
		
		  //SNT_ACT_Avisos:=5001
		  //SNT_ACT_Cargos:=5002
		  //SNT_ACT_Pagos:=5003
		  //SNT_MT_Prestamos:=5004
		  //If (Not(<>vb_AvoidTriggerExecution))
		  //Case of 
		  //: (Database event=On Saving New Record Event )
		  //SNT_CreaReferencia (SNT_ACT_Pagos;[ACT_Pagos]ID;SNT_Accion_Actualizar )
		  //
		  //: (Database event=On Saving Existing Record Event )
		  //If (([ACT_Pagos]ID#Old([ACT_Pagos]ID)) | ([ACT_Pagos]Fecha#Old([ACT_Pagos]Fecha)) | ([ACT_Pagos]Monto_Pagado#Old([ACT_Pagos]Monto_Pagado)) | ([ACT_Pagos]Saldo#Old([ACT_Pagos]Saldo)) | ([ACT_Pagos]FormaDePago#Old([ACT_Pagos]FormaDePago)))
		  //SNT_CreaReferencia (SNT_ACT_Pagos;[ACT_Pagos]ID;SNT_Accion_Actualizar )
		  //End if 
		  //
		  //: (Database event=On Deleting Record Event )
		  //SNT_CreaReferencia (SNT_ACT_Pagos;[ACT_Pagos]ID;SNT_Accion_Eliminar )
		  //
		  //End case 
		  //End if 
		
	End if 
	SN3_MarcarRegistros (SN3_DTi_Pagos)
End if 



