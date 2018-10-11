  //preguntar si se asigna a todos los documentos electrónicos

If (Form event:C388=On Data Change:K2:15)
	If ((Self:C308-><0) | (Self:C308->>9999))
		CD_Dlog (0;"El rango de códigos para puntos de venta va de entre 1 y 9999. Por favor verifique el punto de venta en la AFIP.")
	End if 
End if 