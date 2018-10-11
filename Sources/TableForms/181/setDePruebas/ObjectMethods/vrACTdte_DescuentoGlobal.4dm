Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (Abs:C99(vrACTdte_DescuentoGlobal)>100)
			vrACTdte_DescuentoGlobal:=0
		End if 
		
		  //For ($i;1;Size of array(abACT_afecto))
		  //arACT_descuento{$i}:=vrACTdte_DescuentoGlobal
		  //ACTdte_setPruebasOpcionesGen ("Calculalineas";->$i)
		  //End for 
		ACTdte_setPruebasOpcionesGen ("CalculaTotales")
		
End case 