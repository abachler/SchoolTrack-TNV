//%attributes = {}
  //ACTbol_BuscaDctosAsociados

  //metodo que busca las notas de credito o las boletas asociadas a una seleccion original de registros

CREATE SET:C116([ACT_Boletas:181];"boletas1")

  //busco notas de credito
QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19#0)
KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID_DctoAsociado:19;"")
CREATE SET:C116([ACT_Boletas:181];"boletas2")

UNION:C120("boletas1";"boletas2";"boletas1")
USE SET:C118("boletas1")

  //busco dctos asociados
KRL_RelateSelection (->[ACT_Boletas:181]ID_DctoAsociado:19;->[ACT_Boletas:181]ID:1;"")
CREATE SET:C116([ACT_Boletas:181];"boletas2")

UNION:C120("boletas1";"boletas2";"boletas1")
USE SET:C118("boletas1")

SET_ClearSets ("boletas1";"boletas2")