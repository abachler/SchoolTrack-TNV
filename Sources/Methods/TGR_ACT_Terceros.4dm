//%attributes = {}
  // Método: TGR_ACT_Terceros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:52:39
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
				[ACT_Terceros:138]DTS_Creacion:22:=DTS_MakeFromDateTime 
				[ACT_Terceros:138]DTS_Modificacion:23:=DTS_MakeFromDateTime 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[ACT_Terceros:138]DTS_Modificacion:23:=DTS_MakeFromDateTime 
				If ([ACT_Terceros:138]DTS_Creacion:22="")
					[ACT_Terceros:138]DTS_Creacion:22:=DTS_MakeFromDateTime 
				End if 
				If ([ACT_Terceros:138]Modo_de_Pago:30="")
					[ACT_Terceros:138]Modo_de_Pago:30:=ACTcfgfdp_OpcionesGenerales ("fdpXDefecto")
				End if 
				If (KRL_FieldChanges (->[ACT_Terceros:138]Nombre_Completo:9))
					ACTac_ActualizaNombre ("DesdeTerceros";->[ACT_Terceros:138]Id:1)
				End if 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
		End case 
	End if 
End if 



