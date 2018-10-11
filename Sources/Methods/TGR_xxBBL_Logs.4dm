//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 21-07-14, 16:05:56
  // ----------------------------------------------------
  // Método: TGR_xxBBL_Logs
  // Descripción
  // 20140721 RCH Método que escribe el campo fecha del log. No se estaba guardando info en este campo.
  //
  // Parámetros
  // ----------------------------------------------------



C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[xxBBL_Logs:41]Date_log:1:=DTS_GetDate ([xxBBL_Logs:41]DTS:2)
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ([xxBBL_Logs:41]Date_log:1=!00-00-00!)
					[xxBBL_Logs:41]Date_log:1:=DTS_GetDate ([xxBBL_Logs:41]DTS:2)
				End if 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
				
		End case 
	End if 
	
End if 