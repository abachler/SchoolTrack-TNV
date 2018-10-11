OBJECT SET VISIBLE:C603(bPrev;True:C214)
OBJECT SET VISIBLE:C603(bNext;True:C214)
OBJECT SET VISIBLE:C603(vi_Step;True:C214)
vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_step:=1
	: (vi_PageNumber=2)
		vi_step:=2
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: ((vi_PageNumber=3) | (vi_PageNumber=4))
		vi_step:=3
		_O_ENABLE BUTTON:C192(bPrev)
		If (vi_PageNumber=4)
			If ((vsACT_Glosa#"") & (vsACT_Moneda#"") & (vrACT_Monto#0))
				_O_ENABLE BUTTON:C192(bNext)
			Else 
				_O_DISABLE BUTTON:C193(bNext)
			End if 
		Else 
			_O_ENABLE BUTTON:C192(bNext)
		End if 
		
		ACTitems_FiltraItemsXPeriodo (True:C214)
		
	: (vi_PageNumber=5)
		Case of 
			: (b1=1)
				vi_step:=3
			: (b2=1)
				vi_step:=4
			: (b3=1)
				vi_step:=4
		End case 
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (vi_PageNumber=6)
		Case of 
			: (b1=1)
				vi_step:=4
			: (b2=1)
				vi_step:=5
			: (b3=1)
				vi_step:=5
		End case 
	: (vi_PageNumber=7)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		OBJECT SET VISIBLE:C603(bPrev;False:C215)
		OBJECT SET VISIBLE:C603(bNext;False:C215)
		OBJECT SET VISIBLE:C603(vi_Step;False:C215)
		Case of 
			: (b1=1)
				$t:="Se generarán cargos para <universo> La generación se hará sobre la base de las ma"+"trices de cargo "+"actualmente asignadas a esas cuentas."+"\r\r"
				$t:=$t+"Los cargos existentes <periodos> que correspondan a los items de esas "+" matrices y que no hayan sido objeto de aviso de cobranza "+"serán actualizados con las tasas vigentes al momento de la fecha de genera"+"ción."
			: (b2=1)
				$t:="Se generarán cargos para <universo>"+"\r\r"
				$t:=$t+"Los cargos serán generados sobre la base de la definición del item de cargo "+vsACT_SelectedItemName+"."+"\r\r"
				$t:=$t+"Los cargos existentes <periodos> que correspondan a ese item "+"y que no hayan sido objeto de aviso de cobranza, "+" serán actualizados con las tasas vigentes al momento de la fecha de genera"+"ción."
			: (b3=1)
				$t:="Se generarán cargos para <universo> Se utilizarán los montos, descripción y otras"+" características del cargo que usted ingresó:"+"\r\r"
				$t:=$t+"Glosa: "+vsACT_Glosa+"\r"
				If (vsACT_Moneda#<>vsACT_MonedaColegio)
					$t:=$t+"Monto: "+("-"*cbACT_EsDescuento)+String:C10(vrACT_Monto;"|Despliegue_UF")+" ("+vsACT_Moneda+(", afecto a IVA"*cbACT_Afecto_IVA)+")"+"\r\r"
				Else 
					$t:=$t+"Monto: "+("-"*cbACT_EsDescuento)+String:C10(vrACT_Monto;"|Despliegue_ACT")+" ("+vsACT_Moneda+(", afecto a IVA"*cbACT_Afecto_IVA)+")"+"\r\r"
				End if 
				$t:=$t+(("Los cargos existentes <periodos> con la misma descripción "+"y que no hayan sido emitidos"+" serán actualizados con las tasas vigentes al momento de la fecha de genera"+"ción")*bc_ReplaceSameDescription)
		End case 
		Case of 
			: (f1=1)
				If (r1=1)
					$universo:="las "+String:C10(viACT_cuentas4)+" cuentas explícitamente seleccionadas en el explorador, cualquiera sea la matriz"+" asignada."
				Else 
					$universo:="las "+String:C10(viACT_cuentas5)+" cuentas explícitamente seleccionadas en el explorador, "+"que tengan asignada la matriz "+vsACT_AsignedMatrix2+"."
				End if 
			: (f2=1)
				If (r1=1)
					$universo:="las "+String:C10(viACT_cuentas4)+" cuentas listadas en el explorador, cualquiera sea la matriz "+"asignada."
				Else 
					$universo:="las "+String:C10(viACT_cuentas5)+" cuentas listadas en el explorador, "+"que tengan asignada la matriz "+vsACT_AsignedMatrix2+"."
				End if 
			: (f3=1)
				If (r1=1)
					$universo:="las "+String:C10(viACT_cuentas4)+" cuentas activas, cualquiera sea la matriz "+"asignada."
				Else 
					$universo:="las "+String:C10(viACT_cuentas5)+" cuentas activas, "+"que tengan asignada la matriz "+vsACT_AsignedMatrix2+"."
				End if 
		End case 
		$t:=Replace string:C233($t;"<universo>";$universo)
		If (vs1=vs2)
			If (vdACT_AñoAviso=vdACT_AñoAviso2)
				$periodo:="en el mes de "+vs1+" de "+String:C10(vdACT_AñoAviso)
			Else 
				$periodo:="entre los meses de "+vs1+" de "+String:C10(vdACT_AñoAviso)+" y "+vs2+" de "+String:C10(vdACT_AñoAviso2)
			End if 
		Else 
			$periodo:="desde el mes de "+vs1+" de "+String:C10(vdACT_AñoAviso)+" hasta el mes de "+vs2+" de "+String:C10(vdACT_AñoAviso2)
		End if 
		$t:=Replace string:C233($t;"<periodos>";$periodo)
		If (cbMontosEnMonedaPago=1)
			For ($i;1;Size of array:C274(atACT_NombreMonedaEm))
				$vl_idMoneda:=alACT_IdRegistroEm{$i}
				If (KRL_GetBooleanFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Genera_Tabla_Diaria:7))
					$t:=$t+"\r\r"+"Los cargos en la moneda "+ST_Qte (atACT_NombreMonedaEm{$i})+" serán calculados con el valor del día "+String:C10(adACT_fechasEm{$i};7)+" ("+String:C10(ACTut_fValorDivisa (atACT_NombreMonedaEm{$i};adACT_fechasEm{$i});"|Despliegue_ACT")+")."
				End if 
			End for 
		End if 
		vtACT_ResumenAsistente:=$t
End case 