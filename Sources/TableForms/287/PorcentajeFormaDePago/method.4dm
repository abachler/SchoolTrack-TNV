Case of 
	: (Form event:C388=On Load:K2:1)
		C_REAL:C285(vl_porcentaje_pago)
		vl_porcentaje_pago:=0
		QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=vlACT_idFormaDePago)
		vl_porcentaje_pago:=[ACT_Formas_de_Pago:287]porcentaje_Pago:18
End case 