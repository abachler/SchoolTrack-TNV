//%attributes = {}
  //ACTbw_EstadoDocsenCartera

  //QUERY([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]id_forma_de_pago=-4)
  //SELECTION TO ARRAY([ACT_Documentos_en_Cartera];$aDCRecNums)
  //For ($i;1;Size of array($aDCRecNums))
  //If ($aDCRecNums{$i}>-1)
  //ACTdc_EstadoCheque ($aDCRecNums{$i})
  //End if 
  //End for 

READ ONLY:C145([ACT_Documentos_en_Cartera:182])

QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4)

  //20120528 RCH Se filtra que solo se actualicen los documentos que tienen id estado 0 o son cheques a fecha o estan vencidos
QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21=0;*)
QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182]; | ;[ACT_Documentos_en_Cartera:182]id_estado:21=-4;*)  // a fecha
QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182]; | ;[ACT_Documentos_en_Cartera:182]id_estado:21=-5)  // vencido

SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182];$aDCRecNums)
For ($i;1;Size of array:C274($aDCRecNums))
	If ($aDCRecNums{$i}>-1)
		ACTdc_EstadoCheque ($aDCRecNums{$i})
	End if 
End for 