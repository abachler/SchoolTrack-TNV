//%attributes = {}
  //ACTdxt_ObtieneMontosDesdeSetCar

C_OBJECT:C1216($ob_retorno;$0)
C_TEXT:C284($t_set)
C_BOOLEAN:C305($b_fijo;$b_generaDescuentosSeparados;$b_dividir)
C_REAL:C285($r_valor;$r_montoDescuento;$r_montoSaldoCargos;$r_acumulado)
C_DATE:C307($d_fecha)
C_LONGINT:C283($l_decimales;$i)

$t_set:=$1
$b_fijo:=$2
$r_valor:=$3
$d_fecha:=$4
$b_generaDescuentosSeparados:=$5
$b_dividir:=$6


  //genera descuento afecto
$l_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";-><>vtACT_monedaPais))  //descuentos en moneda país

$r_montoDescuento:=0
If ($b_fijo)
	$r_montoDescuento:=$r_valor
Else 
	USE SET:C118($t_set)
	$r_montoSaldoCargos:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$d_fecha))
	$r_montoDescuento:=Round:C94($r_montoSaldoCargos*($r_valor/100);$l_decimales)
End if 

ARRAY LONGINT:C221($al_idCtaR;0)
ARRAY REAL:C219($ar_montoR;0)

USE SET:C118($t_set)
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
If (($b_generaDescuentosSeparados) & (Records in selection:C76([ACT_CuentasCorrientes:175])>1))  //si genera cargos por separado y hay mas de una cuenta, calculo
	ARRAY LONGINT:C221($al_idCta;0)
	SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_idCta)
	If (Size of array:C274($al_idCta)>0)
		$r_acumulado:=0
		For ($i;1;Size of array:C274($al_idCta))
			$r_montoDescuento:=0
			If ($b_fijo)
				  //para no tener problemas con redondeo ni decimales
				If ($i<Size of array:C274($al_idCta))
					$r_montoDescuento:=Round:C94($r_valor*(1/Size of array:C274($al_idCta));$l_decimales)
					If ($b_dividir)
						$r_montoDescuento:=Round:C94($r_montoDescuento/2;$l_decimales)  //Se divide porque hay descuento afecto y exento
					End if 
					$r_acumulado:=$r_acumulado+$r_montoDescuento
				Else 
					$r_montoDescuento:=Round:C94($r_valor-$r_acumulado;$l_decimales)
				End if 
			Else 
				USE SET:C118($t_set)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$al_idCta{$i})
				$r_montoSaldoCargos:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$d_fecha))
				$r_montoDescuento:=Round:C94($r_montoSaldoCargos*($r_valor/100);$l_decimales)
			End if 
			$r_montoDescuento:=$r_montoDescuento*-1
			APPEND TO ARRAY:C911($al_idCtaR;$al_idCta{$i})
			APPEND TO ARRAY:C911($ar_montoR;$r_montoDescuento)
		End for 
	Else   //si no hay cargos de Ctas ctes se crea 1
		$r_montoDescuento:=$r_montoDescuento*-1
		APPEND TO ARRAY:C911($al_idCtaR;[ACT_CuentasCorrientes:175]ID:1)
		APPEND TO ARRAY:C911($ar_montoR;$r_montoDescuento)
	End if 
Else 
	$r_montoDescuento:=$r_montoDescuento*-1
	APPEND TO ARRAY:C911($al_idCtaR;[ACT_CuentasCorrientes:175]ID:1)
	APPEND TO ARRAY:C911($ar_montoR;$r_montoDescuento)
End if 

OB SET ARRAY:C1227($ob_retorno;"ids_cuentas";$al_idCtaR)
OB SET ARRAY:C1227($ob_retorno;"montos_cuentas";$ar_montoR)

$0:=$ob_retorno