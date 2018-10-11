READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
ARRAY LONGINT:C221(alACT_IDAviso;0)
ARRAY DATE:C224(adACT_FechaEAviso;0)
ARRAY DATE:C224(adACT_FechaVAviso;0)
ARRAY REAL:C219(arACT_Monto;0)
ARRAY REAL:C219(arACT_Monto2;0)
ARRAY TEXT:C222(atACT_Monto2;0)

QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=[ACT_Pagares:184]ID:12)
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;adACT_FechaEAviso;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;adACT_FechaVAviso)
  //SELECTION TO ARRAY([ACT_Avisos_de_Cobranza]ID_Aviso;alACT_IDAviso;[ACT_Avisos_de_Cobranza]Monto_Neto;arACT_Monto;[ACT_Avisos_de_Cobranza]Monto_a_Pagar;arACT_Monto2)
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_IDAviso;[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;arACT_Monto2)

For ($i;1;Size of array:C274(arACT_Monto2))
	APPEND TO ARRAY:C911(atACT_Monto2;String:C10(arACT_Monto2{$i};"|Despliegue_ACT"))
End for 

  //SORT ARRAY(adACT_FechaEAviso;adACT_FechaVAviso;alACT_IDAviso;arACT_Monto;arACT_Monto2;>)
SORT ARRAY:C229(adACT_FechaEAviso;adACT_FechaVAviso;alACT_IDAviso;atACT_Monto2;>)

ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;4)
<>aChoicePtrs{1}:=->alACT_IDAviso
<>aChoicePtrs{2}:=->adACT_FechaEAviso
<>aChoicePtrs{3}:=->adACT_FechaVAviso
  //<>aChoicePtrs{4}:=->arACT_Monto
<>aChoicePtrs{4}:=->atACT_Monto2
TBL_ShowChoiceList (0;"Avisos asociados";0;->vtACT_Estado;False:C215)
AT_Initialize (->alACT_IDAviso;->adACT_FechaEAviso;->adACT_FechaVAviso;->arACT_Monto;->arACT_Monto2;->atACT_Monto2)