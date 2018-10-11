//%attributes = {}
  //Unused_ACTpp_SetTotalsColors

If ([Personas:7]Saldo_Ejercicio:85<0)
	OBJECT SET COLOR:C271([Personas:7]Saldo_Ejercicio:85;-3)
Else 
	OBJECT SET COLOR:C271([Personas:7]Saldo_Ejercicio:85;-6)
End if 
If ([Personas:7]DeudaVencida_Ejercicio:83<0)
	OBJECT SET COLOR:C271([Personas:7]DeudaVencida_Ejercicio:83;-3)
Else 
	OBJECT SET COLOR:C271([Personas:7]DeudaVencida_Ejercicio:83;-6)
End if 