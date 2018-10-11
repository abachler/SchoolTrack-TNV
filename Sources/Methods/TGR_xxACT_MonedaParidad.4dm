//%attributes = {}
  // Método: TGR_xxACT_MonedaParidad
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:51:20
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_LONGINT:C283($records;$records2)
C_LONGINT:C283($rn;$rn2)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_dontCallOnTrigger)

If (Not:C34(<>vb_AvoidTriggerExecution))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xxACT_MonedaParidad:147]ID:1:=SQ_SeqNumber (->[xxACT_MonedaParidad:147]ID:1)
			[xxACT_MonedaParidad:147]DTS_Creacion:9:=DTS_MakeFromDateTime 
			[xxACT_MonedaParidad:147]DTS_Modificacion:10:=DTS_MakeFromDateTime 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xxACT_MonedaParidad:147]DTS_Modificacion:10:=DTS_MakeFromDateTime 
			If (Old:C35([xxACT_MonedaParidad:147]Valor:6)#[xxACT_MonedaParidad:147]Valor:6)
				C_TEXT:C284($vt_cambio)
				$vt_cambio:=DTS_MakeFromDateTime +": "+String:C10(Old:C35([xxACT_MonedaParidad:147]Valor:6))+"->"+String:C10([xxACT_MonedaParidad:147]Valor:6)+"\r"
				[xxACT_MonedaParidad:147]Log_Cambios:11:=[xxACT_MonedaParidad:147]Log_Cambios:11+$vt_cambio
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 




