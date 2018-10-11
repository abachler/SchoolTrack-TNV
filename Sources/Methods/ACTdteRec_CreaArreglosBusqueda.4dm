//%attributes = {}
  //ACTdteRec_CreaArreglosBusqueda

  //ARRAY TEXT(atACTdteRec_RazonSocial;0)
  //ARRAY TEXT(atACTdteRec_RutEmisor;0)
  //ARRAY TEXT(atACTdteRec_Periodo;0)

C_TEXT:C284($t_rutReceptor)
C_LONGINT:C283($l_indice)
ARRAY DATE:C224($adACT_fechaEmision;0)
ARRAY DATE:C224($adACT_fechaRecepcion;0)

ACTcfg_DeclaraArreglos ("ACTdteRecibidos_Busqueda")

READ ONLY:C145([ACT_DTEs_Recibidos:238])

$t_rutReceptor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;->[ACT_RazonesSociales:279]RUT:3)

QUERY:C277([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]rut_receptor:4=$t_rutReceptor)

DISTINCT VALUES:C339([ACT_DTEs_Recibidos:238]razon_social_emiror:3;atACTdteRec_RazonSocial)
DISTINCT VALUES:C339([ACT_DTEs_Recibidos:238]rut_emisor:2;atACTdteRec_RutEmisor)
DISTINCT VALUES:C339([ACT_DTEs_Recibidos:238]fecha_emision:7;$adACT_fechaEmision)
DISTINCT VALUES:C339([ACT_DTEs_Recibidos:238]fecha_registro:8;$adACT_fechaRecepcion)

For ($l_indice;1;Size of array:C274($adACT_fechaEmision))
	APPEND TO ARRAY:C911(atACTdteRec_Periodo;String:C10(Year of:C25($adACT_fechaEmision{$l_indice})))
	atACTdteRec_Periodo{Size of array:C274(atACTdteRec_Periodo)}:=atACTdteRec_Periodo{Size of array:C274(atACTdteRec_Periodo)}+"-"+String:C10(Month of:C24($adACT_fechaEmision{$l_indice});"00")
End for 

For ($l_indice;1;Size of array:C274($adACT_fechaRecepcion))
	APPEND TO ARRAY:C911(atACTdteRec_Recepcion;String:C10(Year of:C25($adACT_fechaRecepcion{$l_indice})))
	atACTdteRec_Recepcion{Size of array:C274(atACTdteRec_Recepcion)}:=atACTdteRec_Recepcion{Size of array:C274(atACTdteRec_Recepcion)}+"-"+String:C10(Month of:C24($adACT_fechaRecepcion{$l_indice});"00")
End for 

For ($l_indice;1;Size of array:C274(atACTdteRec_RutEmisor))
	atACTdteRec_RutEmisor{$l_indice}:=SR_FormatoRUT2 (atACTdteRec_RutEmisor{$l_indice})
End for 

AT_DistinctsArrayValues (->atACTdteRec_Periodo)
SORT ARRAY:C229(atACTdteRec_Periodo;<)

AT_DistinctsArrayValues (->atACTdteRec_Recepcion)
SORT ARRAY:C229(atACTdteRec_Recepcion;<)


AT_Insert (1;1;->atACTdteRec_RazonSocial;->atACTdteRec_RutEmisor;->atACTdteRec_Periodo;->atACTdteRec_Recepcion)
atACTdteRec_RazonSocial{1}:=" -"  // ojo que esto se verifica en 
atACTdteRec_RutEmisor{1}:=" -"
atACTdteRec_Periodo{1}:=" -"
atACTdteRec_Recepcion{1}:=" -"