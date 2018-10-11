//%attributes = {}
  //ACTinit_LoadMatrixIntoArrays

READ ONLY:C145([xxACT_ItemsMatriz:180])
READ ONLY:C145([ACT_Matrices:177])
ALL RECORDS:C47([xxACT_ItemsMatriz:180])
KRL_RelateSelection (->[ACT_Matrices:177]ID:1;->[xxACT_ItemsMatriz:180]ID_Matriz:1;"")
SELECTION TO ARRAY:C260([ACT_Matrices:177]ID:1;<>alACT_MatrixID;[ACT_Matrices:177]Nombre_matriz:2;<>atACT_MatrixName;[ACT_Matrices:177]Moneda:9;<>atACT_MonedaMatriz;[ACT_Matrices:177]Monto_Neto:8;<>arACT_MontoMatriz)
SORT ARRAY:C229(<>atACT_MatrixName;<>alACT_MatrixID;<>atACT_MonedaMatriz;<>arACT_MontoMatriz;>)
UNLOAD RECORD:C212([xxACT_ItemsMatriz:180])
UNLOAD RECORD:C212([ACT_Matrices:177])