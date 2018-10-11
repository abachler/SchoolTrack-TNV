DocsReemp:=AT_array2text (->aACT_DocsReemp)
$choice:=Pop up menu:C542(DocsReemp)
If ($choice>0)
	vsACT_DocsReemp:=aACT_DocsReemp{$choice}
	vlACT_ReempPor:=$choice
	  //SET VISIBLE(*;"th@";False)

	FORM GOTO PAGE:C247($choice)
	Case of 
			
		: ($choice=1)  //Efectivo

			vMsgReemplazador:="El documento será reemplazado por efectivo."
			OBJECT SET VISIBLE:C603(*;"Efectivo";False:C215)
		: ($choice=2)  //Mismo cheque

			vACT_BancoNombre:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
			vACT_Cuenta:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
			vACT_Serie:=[ACT_Documentos_de_Pago:176]NoSerie:12
			vACT_FechaDoc:=[ACT_Documentos_de_Pago:176]Fecha:13
			vtACT_FechaDoc:=String:C10(vACT_FechaDoc;7)
			vACT_Titular:=[ACT_Documentos_de_Pago:176]Titular:9
			vACT_RUTTitular:=[ACT_Documentos_de_Pago:176]RUTTitular:10
			vACT_BancoCodigo:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
			vMsgReemplazador:="El documento será reemplazado por el mismo."
			OBJECT SET VISIBLE:C603(*;"Efectivo";True:C214)
		: ($choice=3)  //Otro cheque

			vACT_BancoNombre:=vACT_BancoNombreTemp
			vACT_Cuenta:=vACT_CuentaTemp
			vACT_Serie:=vACT_SerieTemp
			vACT_FechaDoc:=vACT_FechaDocTemp
			vtACT_FechaDoc:=vtACT_FechaDocTemp
			vACT_Titular:=vACT_TitularTemp
			vACT_RUTTitular:=vACT_RUTTitularTemp
			vACT_BancoCodigo:=vACT_BancoCodigoTemp
			vMsgReemplazador:="El documento será reemplazado por otro documento."
			OBJECT SET VISIBLE:C603(*;"Efectivo";True:C214)
	End case 
End if 