//%attributes = {}
  //ACTcar_CalculaSaldo

C_POINTER:C301($4;$3)
C_TEXT:C284($vt_accion;$1)
C_DATE:C307($vd_date;$2)
C_REAL:C285($0)

$vt_accion:=$1
$vd_date:=$2
If (Count parameters:C259>=3)
	$ptr1:=$3
End if 
If (Count parameters:C259>=4)
	$ptr2:=$4
End if 


Case of 
	: ($vt_accion="retornaSaldoMonedaPago")
		$0:=ACTut_retornaMontoEnMoneda ($ptr1->;$ptr2->;$vd_date;ST_GetWord (ACT_DivisaPais ;1;";");$vd_date)
		
	: ($vt_accion="retornaPagoMonedaCargo")
		$0:=ACTut_retornaMontoEnMoneda ($ptr1->;ST_GetWord (ACT_DivisaPais ;1;";");$vd_date;$ptr2->)
		
	: ($vt_accion="retornaPagoMonedaEmision")
		$0:=ACTut_retornaMontoEnMoneda ($ptr1->;ST_GetWord (ACT_DivisaPais ;1;";");$vd_date)
		
	: ($vt_accion="retornaSaldoMonedaEmision")
		$0:=ACTut_retornaMontoEnMoneda ($ptr1->;$ptr2->;$vd_date)
		
	: (($vt_accion="retornaPagoMonedaEmisionSegunFecha") | ($vt_accion="retornaPagoMonedaEmisionSegunFechaMPago"))
		ARRAY LONGINT:C221($al_recNumCargos;0)
		ARRAY TEXT:C222($at_moneda;0)
		ARRAY REAL:C219($ar_monto;0)
		ARRAY DATE:C224($ad_fecha;0)
		
		USE SET:C118($ptr1->)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNumCargos)
		For ($j;1;Size of array:C274($al_recNumCargos))
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCargos{$j})
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Pago con Descuento";*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento")
			ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1;>)
			ARRAY LONGINT:C221($al_recNumTransacciones;0)
			SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNumTransacciones)
			For ($i;1;Size of array:C274($al_recNumTransacciones))
				KRL_GotoRecord (->[ACT_Transacciones:178];$al_recNumTransacciones{$i})
				APPEND TO ARRAY:C911($at_moneda;[ACT_Cargos:173]Moneda:28)
				APPEND TO ARRAY:C911($ar_monto;[ACT_Transacciones:178]Debito:6)
				APPEND TO ARRAY:C911($ad_fecha;[ACT_Transacciones:178]Fecha:5)
			End for 
		End for 
		COPY ARRAY:C226($ad_fecha;$ad_fechaT)
		AT_DistinctsArrayValues (->$ad_fechaT)
		For ($i;1;Size of array:C274($ad_fechaT))
			$ad_fecha{0}:=$ad_fechaT{$i}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$ad_fecha;"=";->$DA_Return)
			ARRAY TEXT:C222($at_moneda2;0)
			ARRAY REAL:C219($ar_monto2;0)
			ARRAY DATE:C224($ad_fecha2;0)
			
			For ($j;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($at_moneda2;$at_moneda{$DA_Return{$j}})
				APPEND TO ARRAY:C911($ar_monto2;$ar_monto{$DA_Return{$j}})
				APPEND TO ARRAY:C911($ad_fecha2;$ad_fecha{$DA_Return{$j}})
			End for 
			ARRAY TEXT:C222($at_moneda3;0)
			COPY ARRAY:C226($at_moneda2;$at_moneda3)
			AT_DistinctsArrayValues (->$at_moneda3)
			For ($k;1;Size of array:C274($at_moneda3))
				ARRAY LONGINT:C221($al_result;0)
				$at_moneda2{0}:=$at_moneda3{$k}
				AT_SearchArray (->$at_moneda2;"=";->$al_result)
				$monto:=0
				For ($x;1;Size of array:C274($al_result))
					$monto:=$monto+$ar_monto2{$al_result{$x}}
				End for 
				If ($vt_accion="retornaPagoMonedaEmisionSegunFechaMPago")
					$0:=$0+ACTut_retornaMontoEnMoneda ($monto;$at_moneda3{$k};$ad_fecha{$i};ST_GetWord (ACT_DivisaPais ;1;";"))
				Else 
					$0:=$0+ACTut_retornaMontoEnMoneda ($monto;$at_moneda3{$k};$ad_fecha{$i})
				End if 
			End for 
		End for 
End case 