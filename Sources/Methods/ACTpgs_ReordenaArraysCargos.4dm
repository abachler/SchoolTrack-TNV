//%attributes = {}
  //ACTpgs_ReordenaArraysCargos

  //20081111 RCH Antiguamente se ordenaban los cargos a pagar para dejar los RXA al final, pero debido al ordenamiento de ítems a pagar se saca

ACTcfg_OpcionesRecargosCaja ("InsertaCargoXCaja4Pago")

  //20120709 ASM código agregado  por nueva funcionalidad "Recargo en formas de Pago"
C_REAL:C285(vrACT_MontoRecargo)
If (vrACT_MontoRecargo>0)
	ACTfdp_OpcionesRecargos ("CreaItemRecargo";->vlACT_FormasdePago;->vrACT_MontoRecargo)
End if 

ACTpgs_OpcionesVR ("InsertaCargoAPagar")

ACTcfgmyt_OpcionesGenerales ("InsertaCargo")