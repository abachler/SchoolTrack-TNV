Case of 
	: (Self:C308->>100)
		CD_Dlog (0;__ ("La tasa de IVA no puede superar el 100%."))
		Self:C308->:=100
		<>vrACT_FactorIVA:=2
	: (Self:C308-><0)
		CD_Dlog (0;__ ("La tasa de IVA no puede ser inferior a 0%."))
		Self:C308->:=0
		<>vrACT_FactorIVA:=1
	Else 
		<>vrACT_FactorIVA:=1+(Self:C308->/100)
End case 
If (Self:C308->#vrACT_IVAInicial)
	CD_Dlog (0;__ ("Recuerde regenerar los cargos proyectados para utilizar la nueva tasa de IVA."))
	LOG_RegisterEvt ("Cambio en la tasa de IVA de "+String:C10(vrACT_IVAInicial;"|Pct_4DecIfNec")+" a "+String:C10(Self:C308->;"|Pct_4DecIfNec"))
	vrACT_IVAInicial:=Self:C308->
End if 