//%attributes = {}
  //ACTbw_RecalculaAvisos

ACTinit_LoadPrefs 
QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	ARRAY LONGINT:C221($tempArray;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$tempArray;"")
	ACTpgs_RecalcularAvisos (->$tempArray)
	ACTpgs_RecalculaSaldosAvisos (->$tempArray)
End if 