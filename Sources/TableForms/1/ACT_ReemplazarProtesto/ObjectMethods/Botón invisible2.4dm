DocsReemp:=AT_array2text (->aACT_DocsReemp)

$choice:=Pop up menu:C542(DocsReemp)

If ($choice>0)
	
	vsACT_DocsReemp:=aACT_DocsReemp{$choice}
	vlACT_ReempPor:=$choice
	
	FORM GOTO PAGE:C247($choice)
	
	Case of 
			
		: ($choice=1)  //Efectivo

			
		: ($choice=2)  //Mismo cheque

			
			vACT_BancoNombre:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
			vACT_Cuenta:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
			vACT_Serie:=[ACT_Documentos_de_Pago:176]NoSerie:12
			vACT_FechaDoc:=[ACT_Documentos_de_Pago:176]Fecha:13
			vACT_Titular:=[ACT_Documentos_de_Pago:176]Titular:9
			vACT_RUTTitular:=[ACT_Documentos_de_Pago:176]RUTTitular:10
			vACT_BancoCodigo:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
			
		: ($choice=3)  //Otro cheque

			
			vACT_BancoNombre:=vACT_BancoNombreTemp
			vACT_Cuenta:=vACT_CuentaTemp
			vACT_Serie:=vACT_SerieTemp
			vACT_FechaDoc:=vACT_FechaDocTemp
			vACT_Titular:=vACT_TitularTemp
			vACT_RUTTitular:=vACT_RUTTitularTemp
			vACT_BancoCodigo:=vACT_BancoCodigoTemp
			
	End case 
	
End if 