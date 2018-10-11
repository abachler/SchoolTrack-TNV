//%attributes = {}
  //ACTcc_EmisionAvisosEnMoneda

$Emitir:=True:C214
CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];aLong1)
KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9;"")
SELECTION TO ARRAY:C260([Personas:7]No:1;al_IDApoderados)
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
KRL_RelateSelection (->[ACT_Matrices:177]ID:1;->[ACT_CuentasCorrientes:175]ID_Matriz:7;"")
SELECTION TO ARRAY:C260([ACT_Matrices:177]Moneda:9;$atACT_MonedasMatrices)
SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)

For ($i_Apoderados;1;Size of array:C274(al_IDApoderados))
	
	
	
	For ($Especiales;1;NoMonedasEspeciales)
		
		ArregloMoneda:=Get pointer:C304("alACT_MonedaEsp"+String:C10($Especiales))
		ACTcc_EmisionAvisos (2;Generar;ArregloMoneda)
		
	End for 
	
	For ($NoMatriz;1;NoMonedaNoMatriz)
		
		ArregloMoneda:=Get pointer:C304("alACT_MonedaNM"+String:C10($NoMatriz))
		ACTcc_EmisionAvisos (2;Generar;ArregloMoneda)
		
	End for 
	
End for 