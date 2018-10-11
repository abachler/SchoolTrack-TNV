//%attributes = {}
  //ACTmnu_RecalcularAvisos

$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
USE SET:C118($set)
BWR_SearchRecords 


If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos)
	ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos)
	AT_Initialize (->alACT_RecNumsAvisos)
	POST KEY:C465(-96)
End if 