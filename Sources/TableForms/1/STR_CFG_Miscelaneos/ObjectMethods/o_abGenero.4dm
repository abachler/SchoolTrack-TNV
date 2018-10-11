Case of 
	: (Form event:C388=On Data Change:K2:15)
		  // 20181008 Patricio Aliaga Ticket N° 204363
		C_OBJECT:C1216($o_conf;$o_in)
		OB SET:C1220($o_in;"validar";"o_abGenero")
		$o_conf:=STR_ordenNominas ("updateInterfaz";$o_in)
	: (Form event:C388=On Before Data Entry:K2:39)
		  // 20181008 Patricio Aliaga Ticket N° 204363
		$y_uso:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abUso")
		If (Not:C34($y_uso->{Self:C308->}))
			$0:=-1
		End if 
End case 