//%attributes = {}
  //ACTxx_RepararMatrices

READ WRITE:C146([ACT_Matrices:177])
ALL RECORDS:C47([ACT_Matrices:177])
APPLY TO SELECTION:C70([ACT_Matrices:177];[ACT_Matrices:177]Moneda:9:="Peso Chileno")
UNLOAD RECORD:C212([ACT_Matrices:177])
READ ONLY:C145([ACT_Matrices:177])