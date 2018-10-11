$FormadePago:=FORM Get current page:C276

Case of 
		
	: ($FormadePago=2)
		
		$Fecha:=String:C10(vdACT_FechaPago;7)
		vtACT_FechaDocumento:=$Fecha
		vdACT_FechaDocumento:=vdACT_FechaPago
		
	: ($FormadePago=3)
		
		
		
	: ($FormadePago=5)
		
		
		
End case 