//%attributes = {}
  // Método: ACTmon_ActualizaValorMoneda
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 10-03-10, 19:15:44
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_REAL:C285($vr_valor;$0)
C_LONGINT:C283($vl_IdMoneda;$1;$index)
C_DATE:C307($vd_fecha;$2)

$vl_IdMoneda:=$1
$vd_fecha:=$2
If (Count parameters:C259=3)
	$vr_valor:=$3
End if 

READ ONLY:C145([xxACT_Monedas:146])
$index:=Find in field:C653([xxACT_Monedas:146]Id_Moneda:1;$vl_IdMoneda)
If ($index#-1)
	GOTO RECORD:C242([xxACT_Monedas:146];$index)
	If ($vr_valor#0)
		[xxACT_Monedas:146]Valor:3:=$vr_valor
	Else 
		$vr_valor:=[xxACT_Monedas:146]Valor:3
	End if 
	If ([xxACT_Monedas:146]Genera_Tabla_Diaria:7)
		ACTmon_ActualizaValor ($vl_IdMoneda;Year of:C25($vd_fecha);Month of:C24($vd_fecha);Day of:C23($vd_fecha);$vr_valor)
	End if 
End if 
$0:=$vr_valor

