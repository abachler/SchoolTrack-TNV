Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (Abs:C99(vrACTdte_DescuentoAfecto)>100)
			vrACTdte_DescuentoAfecto:=0
		End if 
		
		ARRAY LONGINT:C221($DA_Return;0)
		abACT_afecto{0}:=True:C214
		AT_SearchArray (->abACT_afecto;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)>0)
			  //For ($i;1;Size of array($DA_Return))
			  //arACT_descuento{$DA_Return{$i}}:=vrACTdte_DescuentoAfecto
			  //ACTdte_setPruebasOpcionesGen ("Calculalineas";->$DA_Return{$i})
			  //End for 
			ACTdte_setPruebasOpcionesGen ("CalculaTotales")
		Else 
			BEEP:C151
			vrACTdte_DescuentoAfecto:=0
		End if 
		  //vr_DescuentoGlobal:=0
		
End case 