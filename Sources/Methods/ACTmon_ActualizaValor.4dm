//%attributes = {}
  // Método: ACTmon_ActualizaValor
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 10-03-10, 19:05:46
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




C_LONGINT:C283($vl_idMoneda;$vl_year;$vl_month;$vl_day)
C_REAL:C285($vr_valor)

$vl_idMoneda:=$1
$vl_year:=$2
$vl_month:=$3
$vl_day:=$4
$vr_valor:=$5

READ WRITE:C146([xxACT_Monedas:146])
$index:=Find in field:C653([xxACT_Monedas:146]Id_Moneda:1;$vl_idMoneda)
If ($index#-1)
	GOTO RECORD:C242([xxACT_Monedas:146];$index)
	If (Not:C34([xxACT_Monedas:146]Genera_Tabla_Diaria:7))
		[xxACT_Monedas:146]Valor:3:=$vr_valor
		SAVE RECORD:C53([xxACT_Monedas:146])
	Else 
		$vt_key:=String:C10($vl_year;"0000")+String:C10($vl_month;"00")+String:C10($vl_day;"00")+String:C10($vl_idMoneda)
		$index:=Find in field:C653([xxACT_MonedaParidad:147]Key:7;$vt_key)
		If ($index=-1)  //por si la tabla no fue generada...
			ACTmon_CreaTablaDiaria ($vt_key)
			ACTmon_ActualizaValor ($vl_idMoneda;$vl_year;$vl_month;$vl_day;$vr_valor)
		Else 
			READ WRITE:C146([xxACT_MonedaParidad:147])
			GOTO RECORD:C242([xxACT_MonedaParidad:147];$index)
			[xxACT_MonedaParidad:147]Valor:6:=$vr_valor
			SAVE RECORD:C53([xxACT_MonedaParidad:147])
			If (DT_GetDateFromDayMonthYear ($vl_day;$vl_month;$vl_year)=Current date:C33(*))
				[xxACT_Monedas:146]Valor:3:=$vr_valor  //el valor del campo Monedas debe siempre mantener el valor del día actual cuando tiene tabla diaria
				SAVE RECORD:C53([xxACT_Monedas:146])
			End if 
			KRL_UnloadReadOnly (->[xxACT_MonedaParidad:147])
		End if 
	End if 
End if 
KRL_UnloadReadOnly (->[xxACT_Monedas:146])