//%attributes = {}
XS_SetInterface 

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])

C_TEXT:C284(vtACT_Estado)
ARRAY TEXT:C222(atACT_AdjuntosNombre;0)
ARRAY TEXT:C222(atACT_AdjuntosPath;0)

C_DATE:C307(vdACT_fechaCambioEstado)
C_TEXT:C284(vtACT_RealizadoPor)

ARRAY TEXT:C222(atACT_EstadosPagares2;0)
ARRAY TEXT:C222(atACT_EstadosPagares;0)
ARRAY LONGINT:C221(alACT_IdsEstadosPagares;0)

ACTpp_FormArraysDeclarations ("ArreglosAvisos")
ACTpp_FormArraysDeclarations ("DetallePagos")

XALSet_PP_ACT_AreasDocumentos 
xALSet_ACT_IngresoPagos 

  //ARRAY LONGINT($alACT_idsEstados;0)  // id que tiene que ser unico
  //ARRAY TEXT($atACT_estados;0)
  //ARRAY LONGINT($alACT_idsFormasPago;0)
  //ARRAY TEXT($atACT_codInterno;0)
  //ARRAY BOOLEAN($abACT_anulaPago;0)
  //ACTfdp_EstadosXDefecto ("EstadosPagares";->$alACT_idsFormasPago;->$alACT_idsEstados;->$atACT_estados;->$atACT_codInterno;->$abACT_anulaPago)

  //ARRAY TEXT(atACT_EstadosPagares;0)
  //ARRAY LONGINT(alACT_IdsEstadosPagares;0)
$vl_idFormaP:=-16  // PAGARE
READ ONLY:C145([ACT_EstadosFormasdePago:201])
QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_forma_pago:2=$vl_idFormaP)
SELECTION TO ARRAY:C260([ACT_EstadosFormasdePago:201]id:1;alACT_IdsEstadosPagares;[ACT_EstadosFormasdePago:201]Estado:3;atACT_EstadosPagares)

  //
  //ARRAY TEXT(atACT_EstadosPagares;0)
  //ARRAY LONGINT(alACT_IdsEstadosPagares;0)
  //
  //COPY ARRAY($alACT_idsEstados;alACT_IdsEstadosPagares)
  //COPY ARRAY($atACT_estados;atACT_EstadosPagares)

  //AT_Initialize (->$alACT_idsFormasPago;->$alACT_idsEstados;->$atACT_estados;->$atACT_codInterno)