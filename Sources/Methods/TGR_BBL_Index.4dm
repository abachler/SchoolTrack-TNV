//%attributes = {}
  // Método: TGR_BBL_Index
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:08:24
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
		
		If ((Trigger event:C369=On Saving Existing Record Event:K3:2) | (Trigger event:C369=On Saving New Record Event:K3:1))
			[BBL_Index:70]Shortsubject:4:=Substring:C12([BBL_Index:70]Subject:2;1;80)
			  // [Indices]Type_and_Subject:=Substring([Indices]Type_Indice+[Indices]Subject;1;80
		End if 
	End if 
End if 



