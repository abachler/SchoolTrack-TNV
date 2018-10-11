//%attributes = {}
  //ACTbw_RecalcularAvisos

QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))

CREATE SET:C116([ACT_Avisos_de_Cobranza:124];$set)
ACTmnu_RecalcConIntereses (False:C215)
SET_ClearSets ($set)