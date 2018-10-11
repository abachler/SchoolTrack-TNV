Case of 
	: (Form event:C388=On Printing Detail:K2:18)
		Case of 
			: ([xxACT_Items:179]EsRelativo:5)
				OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Pct_4DecIfNec")
			: ([xxACT_Items:179]Moneda:10#<>vsACT_MonedaColegio)
				OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Despliegue_UF")
			Else 
				OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Despliegue_ACT")
		End case 
End case 