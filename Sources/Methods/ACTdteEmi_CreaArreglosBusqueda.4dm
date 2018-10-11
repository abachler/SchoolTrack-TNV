//%attributes = {}
  //ACTdteEmi_CreaArreglosBusqueda

C_LONGINT:C283($l_indice)
ARRAY DATE:C224($adACT_fechaEmision;0)

ACTcfg_DeclaraArreglos ("ACTdteEmitidos_Busqueda")

READ ONLY:C145([ACT_Boletas:181])

QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=vlACT_RSSel)

QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];(([ACT_Boletas:181]documento_electronico:29=True:C214) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 3) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 4))))

DISTINCT VALUES:C339([ACT_Boletas:181]FechaEmision:3;$adACT_fechaEmision)

For ($l_indice;1;Size of array:C274($adACT_fechaEmision))
	APPEND TO ARRAY:C911(atACTdteEmi_Periodo;String:C10(Year of:C25($adACT_fechaEmision{$l_indice})))
	atACTdteEmi_Periodo{Size of array:C274(atACTdteEmi_Periodo)}:=atACTdteEmi_Periodo{Size of array:C274(atACTdteEmi_Periodo)}+"-"+String:C10(Month of:C24($adACT_fechaEmision{$l_indice});"00")
End for 

AT_DistinctsArrayValues (->atACTdteEmi_Periodo)
SORT ARRAY:C229(atACTdteEmi_Periodo;<)

AT_Insert (1;1;->atACTdteEmi_Periodo)
atACTdteEmi_Periodo{1}:=" -"