//%attributes = {}
  //Unused_ACTcc_SetTotalsColors

If ([ACT_CuentasCorrientes:175]Saldo_Ejercicio:21<0)
	OBJECT SET COLOR:C271([ACT_CuentasCorrientes:175]Saldo_Ejercicio:21;-3)
Else 
	OBJECT SET COLOR:C271([ACT_CuentasCorrientes:175]Saldo_Ejercicio:21;-6)
End if 
If ([ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18<0)
	OBJECT SET COLOR:C271([ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18;-3)
Else 
	OBJECT SET COLOR:C271([ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18;-6)
End if 