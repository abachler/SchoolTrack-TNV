//%attributes = {}
  // Método: TGR_AsignaturasHistorico
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:05:46
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Asignaturas_Historico:84]LlavePrimaria:9:=String:C10([Asignaturas_Historico:84]ID_institucion:8)+"."+String:C10([Asignaturas_Historico:84]Año:5)+"."+String:C10([Asignaturas_Historico:84]ID_AsignaturaOriginal:30)
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[Asignaturas_Historico:84]LlavePrimaria:9:=String:C10([Asignaturas_Historico:84]ID_institucion:8)+"."+String:C10([Asignaturas_Historico:84]Año:5)+"."+String:C10([Asignaturas_Historico:84]ID_AsignaturaOriginal:30)
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 