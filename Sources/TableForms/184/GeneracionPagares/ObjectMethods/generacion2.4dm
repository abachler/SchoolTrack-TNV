If (cbMontosEnMonedaPago=1)
	  //ARRAY TEXT(atACT_NombreMonedaEm;0)
	  //ARRAY REAL(arACT_ValorMonedaEm;0)
	  //ARRAY LONGINT(alACT_IdRegistroEm;0)
	  //ARRAY DATE(adACT_fechasEm;0)
	  //ARRAY BOOLEAN(abACT_MontosFijosEm;0)
	LISTBOX GET CELL POSITION:C971(lb_monedas;$vl_Column;$vl_row)
	$vd_fecha:=Current date:C33(*)
	Case of 
		: ($vl_Column=2)
			
		: ($vl_Column=3)
			If (abACT_MontosFijosEm{$vl_row})
				$vl_idMoneda:=alACT_IdRegistroEm{$vl_row}
				If (KRL_GetBooleanFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Genera_Tabla_Diaria:7))
					$vd_fecha:=DT_PopCalendar 
					If ($vd_fecha#!00-00-00!)
						arACT_ValorMonedaEm{$vl_row}:=ACTut_fValorDivisa (atACT_NombreMonedaEm{$vl_row};$vd_fecha)
						adACT_fechasEm{$vl_row}:=$vd_fecha
					End if 
				End if 
			End if 
	End case 
End if 