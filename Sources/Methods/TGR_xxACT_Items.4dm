//%attributes = {}
  // Método: TGR_xxACT_Items
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:50:26
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If (([xxACT_Items:179]Periodo:42="") & (<>gNombreAgnoEscolar#""))  //20130926 RCH
					[xxACT_Items:179]Periodo:42:=<>gNombreAgnoEscolar
				End if 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				ACTcfg_ItemsMatricula ("EliminacionItem";->[xxACT_Items:179]ID:1)
				ACTter_Datos_ALP ("EliminaRegistrosItems";->[xxACT_Items:179]ID:1)
		End case 
	End if 
End if 



