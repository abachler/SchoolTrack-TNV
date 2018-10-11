//%attributes = {}
  //UD_v20150414_EstadosNulos

C_LONGINT:C283($vl_records;$vl_IDFormaPago;$l_proc)
C_TEXT:C284($vt_glosa)
C_BOOLEAN:C305($vb_anula)

READ ONLY:C145([ACT_Formas_de_Pago:287])

$l_proc:=IT_UThermometer (1;0;"Verificando estados nulos...")

QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1>0)

While (Not:C34(End selection:C36([ACT_Formas_de_Pago:287])))
	$vl_IDFormaPago:=[ACT_Formas_de_Pago:287]id:1
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
	QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_forma_pago:2=$vl_IDFormaPago;*)
	QUERY:C277([ACT_EstadosFormasdePago:201]; & ;[ACT_EstadosFormasdePago:201]anula_pago:10=True:C214)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($vl_records=0)
		$vt_glosa:=__ ("Nulo")
		$vb_anula:=True:C214
		ACTcfg_OpcionesEstadosPagos ("CreateRecord";->$vt_glosa;->$vl_IDFormaPago;->$vb_anula)
	End if 
	NEXT RECORD:C51([ACT_Formas_de_Pago:287])
End while 

IT_UThermometer (-2;$l_proc)