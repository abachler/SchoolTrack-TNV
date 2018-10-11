ARRAY TEXT:C222($atACT_monedas;0)
ACTcfgmyt_OpcionesGenerales ("CargaMonedasPago";->$atACT_monedas)

$choice:=IT_PopUpMenu (->$atACT_monedas;->vtACTpgs_Moneda)
If ($choice#0)
	vtACTpgs_Moneda:=$atACT_monedas{$choice}
	ACTcfgmyt_OpcionesGenerales ("OpcionesFormulario")
End if 