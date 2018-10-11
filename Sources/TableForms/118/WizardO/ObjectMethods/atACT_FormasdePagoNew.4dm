If (Form event:C388=On Clicked:K2:4)
	vlACT_id_modo_pago:=alACT_FormasdePagoID{atACT_FormasdePagoNew}
	vt_tipoArchivo:=atACT_FormasdePagoNew{atACT_FormasdePagoNew}
	viTypeFile:=vt_tipoArchivo  // por compatibilidad
	vt_pg3:=__ ("El nuevo archivo será para exportar según modo de pago")+" "+atACT_FormasdePagoNew{atACT_FormasdePagoNew}
	vb_modificadoTf:=True:C214
End if 