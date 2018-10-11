Case of 
	: (Form event:C388=On Data Change:K2:15)
		  // 20181008 Patricio Aliaga Ticket N° 204363
		C_OBJECT:C1216($o_conf;$o_in)
		OB SET:C1220($o_in;"validar";"o_abNombres")
		$o_conf:=STR_ordenNominas ("updateInterfaz";$o_in)
End case 