
$l_minimo:=SQ_RetornaNuevoID (->[BBL_Registros:66]No_Registro:25)
If (MTi_BarCode>$l_minimo)
	GOTO OBJECT:C206(xALP_PrefijosItems)
	SQ_EstableceSecuencia (->[BBL_Registros:66]No_Registro:25;MTi_BarCode-1)
	OBJECT SET ENTERABLE:C238(Mti_BarCode;False:C215)
	bEstableceNumeroRegistro:=0
Else 
	bEstableceNumeroRegistro:=0
	$t_mensaje:=__ ("El próximo número de registro no puede ser inferior a ^0")
	$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10($l_minimo))
	CD_Dlog (0;$t_mensaje)
	MTi_BarCode:=$l_minimo
	REDRAW:C174(Mti_BarCode)
	GOTO OBJECT:C206(Mti_BarCode)
	HIGHLIGHT TEXT:C210(*;"NextNumber";MAXTEXTLENBEFOREV11:K35:3;MAXTEXTLENBEFOREV11:K35:3)
End if 

