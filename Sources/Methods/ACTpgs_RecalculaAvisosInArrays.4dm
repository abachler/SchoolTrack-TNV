//%attributes = {}
  //ACTpgs_RecalculaAvisosInArrays

  //método que recalcula los arreglos a desplegar en el área de ingreso de pagos. Acá se calculan los saldos anteriores cuando se genereraron arreglos con los nuevos intereses
C_DATE:C307($vd_fecha)
C_REAL:C285($vr_interesesNuevos)
ARRAY REAL:C219($ar_interesesNuevos;Size of array:C274(arACT_AIntereses))
ARRAY REAL:C219($ar_descuentosNuevos;Size of array:C274(arACT_AIntereses))
C_REAL:C285($r_anterior)

Case of 
	: (Count parameters:C259=1)
		$vd_fecha:=$1
	Else 
		$vd_fecha:=Current date:C33(*)
End case 

For ($m;1;Size of array:C274(alACT_AIDAviso))
	$r_montoIntereses:=0
	$r_montoDescuentos:=0
	$vl_idAviso:=alACT_AIDAviso{$m}
	ARRAY LONGINT:C221($alACT_RecNumsCargos2;0)
	alACT_CIdsAvisos{0}:=$vl_idAviso
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->alACT_CIdsAvisos;"=";->$DA_Return)
	For ($i;1;Size of array:C274($DA_Return))
		If (alACT_RecNumsCargos{$DA_Return{$i}}<=-1)
			APPEND TO ARRAY:C911($alACT_RecNumsCargos2;$DA_Return{$i})
		End if 
	End for 
	For ($i;1;Size of array:C274($alACT_RecNumsCargos2))  //para sumar los posibles cargos que se generen en arreglos
		Case of 
			: (alACT_CRefs{$alACT_RecNumsCargos2{$i}}=-100)
				$r_montoIntereses:=$r_montoIntereses+arACT_CMontoNeto{$alACT_RecNumsCargos2{$i}}
			: ((alACT_CRefs{$alACT_RecNumsCargos2{$i}}=-140) | (alACT_CRefs{$alACT_RecNumsCargos2{$i}}=-141))
				$r_montoDescuentos:=$r_montoDescuentos+arACT_CMontoNeto{$alACT_RecNumsCargos2{$i}}
		End case 
	End for 
	
	
	
	arACT_AIntereses{$m}:=$r_montoIntereses
	$ar_interesesNuevos{$m}:=$r_montoIntereses
	If (cb_IncluirSaldosAnteriores=1)
		$r_anterior:=AT_GetSumArray (->$ar_interesesNuevos)
		arACT_AMontoMoneda{$m}:=arACT_AMontoMoneda{$m}+$r_anterior
	Else 
		arACT_AMontoMoneda{$m}:=arACT_AMontoMoneda{$m}+$r_montoIntereses
	End if 
	
	  //20170714
	$ar_descuentosNuevos{$m}:=$r_montoDescuentos
	If (cb_IncluirSaldosAnteriores=1)
		$r_anterior:=AT_GetSumArray (->$ar_descuentosNuevos)
		arACT_AMontoMoneda{$m}:=arACT_AMontoMoneda{$m}+$r_anterior
	Else 
		arACT_AMontoMoneda{$m}:=arACT_AMontoMoneda{$m}+$r_montoDescuentos
	End if 
	
	  //20140408 RCH Para WP
	  //arACT_AIntereses{$m}:=arACT_AIntereses{$m}+$intereses
	
End for 

  //recalculo de montos totales por si existen intereses calculados al ingresar pagos
ARRAY REAL:C219(arACT_MontoXItem;0)
For ($i;1;Size of array:C274(alACT_RefItem))
	APPEND TO ARRAY:C911(arACT_MontoXItem;ACTpgs_RetornaMontoXAviso ("MontoDesdeNoItem";False:C215;String:C10(alACT_RefItem{$i});$vd_fecha))
End for 

ARRAY REAL:C219(arACT_AMontoXAlumno;0)
For ($i;1;Size of array:C274(alACT_AIdsCtas))
	APPEND TO ARRAY:C911(arACT_AMontoXAlumno;ACTpgs_RetornaMontoXAviso ("MontoDesdeNoCta";False:C215;String:C10(alACT_AIdsCtas{$i});$vd_fecha))
End for 

ARRAY REAL:C219(arACT_AMontoXAgrupado;0)
For ($i;1;Size of array:C274(atACT_YearMonthAgrupado))
	APPEND TO ARRAY:C911(arACT_AMontoXAgrupado;ACTpgs_RetornaMontoXAviso ("MontoDesdeAgrupado";False:C215;atACT_YearMonthAgrupado{$i};$vd_fecha))
End for 