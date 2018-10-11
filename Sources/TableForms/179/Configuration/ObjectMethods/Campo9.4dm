If ([xxACT_Items:179]EsRelativo:5)
	If (Self:C308->>100)
		If (Not:C34([xxACT_Items:179]EsDescuento:6))
			CD_Dlog (0;__ ("El porcentaje de cargo sobre el total no puede ser mayor que 100%.");"";__ ("Aceptar"))
			[xxACT_Items:179]Monto:7:=100
		Else 
			CD_Dlog (0;__ ("El porcentaje de descuento sobre el total no puede ser mayor que 100%.");"";__ ("Aceptar"))
			[xxACT_Items:179]Monto:7:=100
		End if 
	End if 
	[xxACT_Items:179]Monto:7:=Round:C94([xxACT_Items:179]Monto:7;4)
Else 
	If ([xxACT_Items:179]Monto:7<0)
		CD_Dlog (0;__ ("El monto no puede ser negativo.\rPara realizar un descuento seleccione la opción más arriba.");"";__ ("Aceptar"))
		[xxACT_Items:179]Monto:7:=0
	End if 
	If ((<>gCountryCode="cl") & ([xxACT_Items:179]Moneda:10="UF@"))
		[xxACT_Items:179]Monto:7:=Round:C94([xxACT_Items:179]Monto:7;4)
	Else 
		$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[xxACT_Items:179]Moneda:10))
		[xxACT_Items:179]Monto:7:=Round:C94([xxACT_Items:179]Monto:7;$vl_decimales)
		  //[xxACT_Items]Monto:=Round([xxACT_Items]Monto;<>vlACT_Decimales)
	End if 
End if 
If (Form event:C388=On Data Change:K2:15)
	ACTcfgit_OpcionesGenerales ("ValidaCambioMontoOMoneda")
End if 