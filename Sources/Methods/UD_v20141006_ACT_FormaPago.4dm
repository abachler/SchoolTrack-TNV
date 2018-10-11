//%attributes = {}
  //UD_v20141006_ACT_FormaPago

If (ACT_AccountTrackInicializado )
	
	  //cambio nombre posibles formas de pago
	READ ONLY:C145([ACT_Formas_de_Pago:287])
	QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=-19)
	If (Records in selection:C76([ACT_Formas_de_Pago:287])=0)
		UD_v20171221_FormaPagoWeb 
		
		C_TEXT:C284($vt_glosa)
		C_LONGINT:C283($vl_IDFormaPago)
		
		ACTfdp_CargaFormasDePago 
		
		$vt_glosa:="Pago Web"
		
		ACTfdp_VerificaNuevaFDP ($vt_glosa)
		$vl_IDFormaPago:=Num:C11(ACTcfg_OpcionesFormasDePago ("NuevaFormaDePago";->$vt_glosa))
	End if 
End if 