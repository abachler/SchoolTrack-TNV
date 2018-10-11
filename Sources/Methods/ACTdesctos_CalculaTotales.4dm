//%attributes = {}
  //ACTdesctos_CalculaTotales

C_REAL:C285($vr_montoNeto;$desctoCta;$desctoCtaMCargo;$vr_montoNetoPesos;$col;$i;$vr_descuentoTotal;$vr_descuentoTotalMCargo;$vr_descuentoTotalMPais)
C_TEXT:C284($vt_monedaItem)

AT_Populate (->arACT_Totales;->$col)
AT_Populate (->aFooterL1;->$col)
AT_Populate (->aFooterL2;->$col)
AT_Populate (->aFooterL3;->$col)
For ($col;4;Size of array:C274(apACT_Glosas)+3)
	For ($i;3;Size of array:C274(apACT_Glosas{$col-3}->);3)
		$vt_monedaItem:=atACT_DesctosMoneda{Find in array:C230(alACT_RefsCargos;alACT_GlosasIDs{$col-3})}
		$vr_montoNeto:=apACT_Glosas{$col-3}->{$i-1}
		If (b2=1)
			$desctoCta:=arACT_DesctoXAlumno{$i-1}
			$desctoCtaMCargo:=ACTut_retornaMontoEnMoneda ($desctoCta;ST_GetWord (ACT_DivisaPais ;1;";");Current date:C33(*);$vt_monedaItem)
			
			$vr_descuentoTotal:=$desctoCtaMCargo+apACT_Glosas{$col-3}->{1}+apACT_Glosas{$col-3}->{$i}
			If ($vr_descuentoTotal>apACT_Glosas{$col-3}->{$i-1})
				$vr_descuentoTotal:=apACT_Glosas{$col-3}->{$i-1}
			End if 
			$vr_descuentoTotalMCargo:=$vr_descuentoTotal
			$vr_descuentoTotalMPais:=ACTut_retornaMontoEnMoneda ($vr_descuentoTotalMCargo;$vt_monedaItem;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
		Else 
			$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaItem))
			$vr_descuentoTotal:=arACT_DesctoXAlumno{$i-1}+apACT_Glosas{$col-3}->{1}+apACT_Glosas{$col-3}->{$i}
			If ($vr_descuentoTotal>100)
				$vr_descuentoTotal:=100
			End if 
			$vr_descuentoTotalMCargo:=Round:C94(($vr_montoNeto*$vr_descuentoTotal)/100;$vl_decimales)
			$vr_descuentoTotalMPais:=ACTut_retornaMontoEnMoneda ($vr_descuentoTotalMCargo;$vt_monedaItem;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
		End if 
		$vr_montoNetoPesos:=ACTut_retornaMontoEnMoneda ($vr_montoNeto;$vt_monedaItem;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
		arACT_Totales{$i-1}:=arACT_Totales{$i-1}+$vr_montoNetoPesos
		arACT_Totales{$i}:=arACT_Totales{$i}+$vr_descuentoTotalMPais
		arACT_Totales{$i+1}:=arACT_Totales{$i+1}+($vr_montoNetoPesos-$vr_descuentoTotalMPais)
		aFooterL1{$col-3}:=aFooterL1{$col-3}+$vr_montoNeto
		aFooterL2{$col-3}:=aFooterL2{$col-3}+$vr_descuentoTotalMCargo
		aFooterL3{$col-3}:=aFooterL3{$col-3}+($vr_montoNeto-$vr_descuentoTotalMCargo)
		aFooterL1{Size of array:C274(aFooterL1)}:=aFooterL1{Size of array:C274(aFooterL1)}+$vr_montoNetoPesos
		aFooterL2{Size of array:C274(aFooterL2)}:=aFooterL2{Size of array:C274(aFooterL2)}+$vr_descuentoTotalMPais
		aFooterL3{Size of array:C274(aFooterL3)}:=aFooterL3{Size of array:C274(aFooterL3)}+($vr_montoNetoPesos-$vr_descuentoTotalMPais)
	End for 
End for 

