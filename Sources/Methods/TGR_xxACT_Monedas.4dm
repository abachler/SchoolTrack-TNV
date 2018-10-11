//%attributes = {}
  // Método: TGR_xxACT_Monedas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:51:55
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283($records;$records2)
C_LONGINT:C283($rn;$rn2)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_dontCallOnTrigger)

  // Código principal
If (Not:C34(<>vb_AvoidTriggerExecution))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xxACT_Monedas:146]Key:10:=[xxACT_Monedas:146]Codigo_Pais:6+"."+[xxACT_Monedas:146]Nombre_Moneda:2
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xxACT_Monedas:146]Key:10:=[xxACT_Monedas:146]Codigo_Pais:6+"."+[xxACT_Monedas:146]Nombre_Moneda:2
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			READ WRITE:C146([xxACT_MonedaParidad:147])
			QUERY:C277([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Id_Moneda:2=[xxACT_Monedas:146]Id_Moneda:1)
			DELETE SELECTION:C66([xxACT_MonedaParidad:147])
			KRL_UnloadReadOnly (->[xxACT_MonedaParidad:147])
			
	End case 
End if 
