//%attributes = {}
  //ACTcfg_loadMatrixItems

ACTcfg_OpcionesArraysItemsM ("InitArrays")
$matrixID:=$1
READ ONLY:C145([xxACT_ItemsMatriz:180])
READ ONLY:C145([xxACT_Items:179])
QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$matrixID)
SELECTION TO ARRAY:C260([xxACT_ItemsMatriz:180];alACT_RecNumItems;[xxACT_ItemsMatriz:180]ID_Item:2;alACT_IdItemMatriz)
ACTcfg_OpcionesArraysItemsM ("InsertaElementosDesdeArreglo";->alACT_IdItemMatriz)

vl_ItemsEnMatriz:=Size of array:C274(alACT_ItemRecNum)
COPY ARRAY:C226(atACT_MonedaItem;atACT_MonedaItemMatriz)