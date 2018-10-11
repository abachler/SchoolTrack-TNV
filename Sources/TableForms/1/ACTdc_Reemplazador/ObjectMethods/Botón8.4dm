$CurrentPage:=FORM Get current page:C276
$Fechafecha:=Current date:C33(*)
$fecha:=String:C10($Fechafecha;7)
Case of 
	: ($CurrentPage=2)
		vtACT_FechaDoc:=$fecha
		vACT_FechaDoc:=$Fechafecha
	: ($CurrentPage=3)
		vtACT_FechaDoc:=$fecha
		vACT_FechaDoc:=$Fechafecha
	: ($CurrentPage=5)
		vtACT_LFechaEmision:=$fecha
		vdACT_LFechaEmision:=$Fechafecha
End case 
