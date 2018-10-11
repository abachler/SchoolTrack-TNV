//%attributes = {}
  // Método: ACTmon_ObtieneValor
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 10-03-10, 19:16:35
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_REAL:C285($0;$vr_montoMoneda;$vr_montoDia)
C_TEXT:C284($vt_moneda;$1)

$vt_moneda:=$1
$vd_fecha:=$2

READ ONLY:C145([xxACT_MonedaParidad:147])
READ ONLY:C145([xxACT_Monedas:146])

$vt_key:=<>gCountryCode+"."+$vt_moneda
$index:=Find in field:C653([xxACT_Monedas:146]Key:10;$vt_key)
If ($index#-1)
	GOTO RECORD:C242([xxACT_Monedas:146];$index)
	$vl_idMoneda:=[xxACT_Monedas:146]Id_Moneda:1
	$vr_montoMoneda:=[xxACT_Monedas:146]Valor:3
	
	$vt_key:=String:C10(Year of:C25($vd_fecha);"0000")+String:C10(Month of:C24($vd_fecha);"00")+String:C10(Day of:C23($vd_fecha);"00")+String:C10($vl_idMoneda)
	$index:=Find in field:C653([xxACT_MonedaParidad:147]Key:7;$vt_key)
	If ($index#-1)
		GOTO RECORD:C242([xxACT_MonedaParidad:147];$index)
		If ([xxACT_MonedaParidad:147]Valor:6#0)
			$vr_montoDia:=[xxACT_MonedaParidad:147]Valor:6
		Else 
			$vr_montoDia:=ACTmon_ActualizaValorMoneda ($vl_idMoneda;$vd_fecha)
		End if 
	Else 
		If ($vr_montoMoneda#0)
			$vr_montoDia:=$vr_montoMoneda
		Else 
			$vr_montoDia:=ACTmon_ActualizaValorMoneda ($vl_idMoneda;$vd_fecha)
		End if 
	End if 
End if 
$0:=$vr_montoDia