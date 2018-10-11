//%attributes = {}
  //ACTpagares_CargaArregloEstados

ARRAY TEXT:C222(<>atACT_EstadosPagares;0)

READ ONLY:C145([ACT_EstadosFormasdePago:201])

QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_forma_pago:2=-16)
SELECTION TO ARRAY:C260([ACT_EstadosFormasdePago:201]Estado:3;<>atACT_EstadosPagares)

SORT ARRAY:C229(<>atACT_EstadosPagares;>)