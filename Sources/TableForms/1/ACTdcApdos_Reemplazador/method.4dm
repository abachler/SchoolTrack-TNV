Case of 
		
	: (Form event:C388=On Load:K2:1)
		vsACT_DocsReemp:=aACT_DocsReemp{1}
		aACT_DocsReemp:=1
		vlACT_ReempPor:=1
		vdACT_FechaCheque:=[ACT_Documentos_de_Pago:176]Fecha:13
		vsACT_Banco:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
		vsACT_Titular:=[ACT_Documentos_de_Pago:176]Titular:9
		vsACT_RUT:=[ACT_Documentos_de_Pago:176]RUTTitular:10
		vsACT_Cuenta:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
		vsACT_NoSerie:=[ACT_Documentos_de_Pago:176]NoSerie:12
		vrACT_Monto:=[ACT_Documentos_de_Pago:176]MontoPago:6
		vdACT_FechaVencimiento:=[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10
		vdACT_FechaProrroga:=Current date:C33(*)
		  //SET VISIBLE(*;"th@";True)
		vMsgReemplazador:="El documento será reemplazado por efectivo."
		OBJECT SET VISIBLE:C603(*;"Efectivo";False:C215)
		FORM GOTO PAGE:C247(1)
		If ([ACT_Documentos_en_Cartera:182]Reemplazado:14)
			Reemplazado:=True:C214
			vMsgReemplazador:="Este documento ya fue reemplazado."
			vsACT_DocsReemp:="Doc. ya reemplazado"
			_O_DISABLE BUTTON:C193(bDocReemp)
			If (Size of array:C274(abrSelect)>1)
				OBJECT SET TITLE:C194(*;"@Ingresar@";__ ("Reemplazar"))
			Else 
				OBJECT SET TITLE:C194(*;"@Ingresar@";__ ("Terminar"))
			End if 
		Else 
			Reemplazado:=False:C215
			vtACT_Msg:=""
			vsACT_DocsReemp:=aACT_DocsReemp{1}
			aACT_DocsReemp:=1
		End if 
		i_Doc:=1
		OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
		OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
