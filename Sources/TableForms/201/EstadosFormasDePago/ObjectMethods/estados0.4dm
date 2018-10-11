If (Form event:C388=On Clicked:K2:4)
	KRL_FindAndLoadRecordByIndex (->[ACT_Formas_de_Pago:287]id:1;->vlACT_idFormaDePago;True:C214)
	If (ok=1)
		[ACT_Formas_de_Pago:287]id_estado_por_defecto:14:=alACT_estadosID{atACT_estados2}
		SAVE RECORD:C53([ACT_Formas_de_Pago:287])
	End if 
	KRL_UnloadReadOnly (->[ACT_Formas_de_Pago:287])
End if 