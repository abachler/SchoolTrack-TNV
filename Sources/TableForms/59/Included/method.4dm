If (_O_During:C30)
	If (Not:C34([BBL_Transacciones:59]is_Paiement:5))
		OBJECT SET COLOR:C271([BBL_Transacciones:59]Fecha:3;-3)
		OBJECT SET COLOR:C271([BBL_Transacciones:59]Glosa:6;-3)
		OBJECT SET COLOR:C271([BBL_Transacciones:59]Monto:2;-3)
	Else 
		OBJECT SET COLOR:C271([BBL_Transacciones:59]Fecha:3;-5)
		OBJECT SET COLOR:C271([BBL_Transacciones:59]Glosa:6;-5)
		OBJECT SET COLOR:C271([BBL_Transacciones:59]Monto:2;-5)
	End if 
End if 
