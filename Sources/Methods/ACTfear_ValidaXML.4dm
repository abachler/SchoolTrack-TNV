//%attributes = {}
C_TEXT:C284($t_root;$1;$t_error)
C_BOOLEAN:C305($b_XMLvalido;$0)
C_TEXT:C284($t_FchServDesde;$t_FchServHasta;$t_FchVtoPago)
C_LONGINT:C283($l_concepto)
C_BLOB:C604($xBlob)
C_REAL:C285($r_ImpTotal;$r_ImpNeto;$r_ImpTrib)
C_REAL:C285($r_ptoVenta;$r_impTotConc;$r_ImpOpEx;$r_ImpIVA)
C_LONGINT:C283($l_CbteTipo)
C_REAL:C285($r_DocTipo;$r_DocNumero)

  //implementar las validaciones lógicas
$t_root:=$1
$b_XMLvalido:=True:C214

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Concepto")
DOM GET XML ELEMENT VALUE:C731($subElem;$l_concepto)
$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/FchServDesde")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$t_FchServDesde)
End if 
$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/FchServHasta")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$t_FchServHasta)
End if 
$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/FchVtoPago")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$t_FchVtoPago)
End if 

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpTotal")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_ImpTotal)
End if 

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpNeto")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_ImpNeto)
End if 

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpOpEx")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_ImpOpEx)
End if 

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpTrib")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_ImpTrib)
End if 

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpIVA")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_ImpIVA)
End if 

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeCabReq/PtoVta")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_ptoVenta)
End if 

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/ImpTotConc")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_impTotConc)
End if 

$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeCabReq/CbteTipo")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$l_CbteTipo)
End if 

  //20160223 RCH ERROR
  //$subElem:=DOM Find XML element($t_root;"/FECAESolicitar/FeDetReq/FECAEDetRequest/DocTipo")
$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/DocTipo")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_DocTipo)
End if 

  //20160223 RCH ERROR
  //$subElem:=DOM Find XML element($t_root;"/FECAESolicitar/FeDetReq/FECAEDetRequest/DocNro")
$subElem:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/DocNro")
If ($subElem#"0000000000000000")
	DOM GET XML ELEMENT VALUE:C731($subElem;$r_DocNumero)
End if 

$subElemIVA:=DOM Find XML element:C864($t_root;"/FECAESolicitar/FeCAEReq/FeDetReq/FECAEDetRequest/Iva/AlicIva/Id")

If ($b_XMLvalido)
	  //valida que para tipo 2 o 3 vayan las fechas obligatorias
	If (($l_concepto=2) | ($l_concepto=3))
		If (($t_FchServDesde="") | ($t_FchServHasta="") | ($t_FchVtoPago=""))
			$b_XMLvalido:=False:C215
			$t_error:="Si el concepto es tipo 2 o 3, los campos FchServDesde, FchServHasta y FchVtoPago son obligatorios en formato aaaammdd."
		End if 
	End if 
End if 

If ($b_XMLvalido)
	  //valida El campo FchServDesde es obligatorio si se informa FchServHasta y/o FchVtoPago.
	If (($t_FchServHasta#"") | ($t_FchVtoPago#""))
		If ($t_FchServDesde="")
			$b_XMLvalido:=False:C215
			$t_error:="El campo FchServDesde es obligatorio si se informa FchServHasta y/o FchVtoPago"
		End if 
	End if 
End if 

If ($b_XMLvalido)
	C_REAL:C285($r_ImpTotal;$r_ImpNeto;$r_ImpTrib)
	  //El campo  'Importe Total' ImpTotal, debe ser igual  a la  suma de ImpNeto + ImpTrib. Donde ImpNeto es igual al Sub Total
	  //Importe  total  del  comprobante, Debe serigual a Importe neto no gravado+Importeexento+Importe neto gravado+todos loscampos de IVA  al XX%+Importe detributos.
	If ($r_ImpTotal#($r_ImpNeto+$r_ImpTrib+$r_ImpOpEx+$r_ImpIVA))
		$b_XMLvalido:=False:C215
		$t_error:="Importe  total  del  comprobante, Debe serigual a Importe neto no gravado+Importeexento+Importe neto gravado+todos loscampos de IVA  al XX%+Importe detributos."
	End if 
End if 

If ($b_XMLvalido)
	  //Para comprobantes tipo C el objeto IVA no debe informarse.
	If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13))  //tipo C
		If ($subElemIVA#"0000000000000000")
			$b_XMLvalido:=False:C215
			$t_error:="Para comprobantes tipo C el objeto IVA no debe informarse."
		End if 
	End if 
End if 

If ($b_XMLvalido)
	If (($r_ptoVenta<1) | ($r_ptoVenta>9998))
		$b_XMLvalido:=False:C215
		$t_error:="El punto de venta no es válido. Por favor ingréselo en la configuración de los documentos electrónicos."
	End if 
End if 

If ($b_XMLvalido)
	  //Para comprobantes tipo C debe ser igual a cero (0)
	If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13))  //tipo C
		If ($r_impTotConc>0)
			$b_XMLvalido:=False:C215
			$t_error:="Para comprobantes tipo C debe ser igual a cero (0)."
		End if 
	End if 
End if 

  //20150812 RCH
If ($b_XMLvalido)
	  //Para comprobantes tipo C debe ser igual a cero (0)
	If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13) | ($l_CbteTipo=6) | ($l_CbteTipo=7) | ($l_CbteTipo=8))  //tipo C y tipo B
		If ($r_ImpTotal>=1000)
			If (($r_DocTipo=99) | ($r_DocNumero=0))
				$b_XMLvalido:=False:C215
				$t_error:="Para comprobantes tipo B o C con monto mayor a 1000, el tipo de documento debe ser distinto de 99 y el número de documento debe ser superior a 0. Ingrese un DNI para el usuario."
			End if 
		Else 
			If ($r_DocTipo=99)
				If ($r_DocNumero#0)
					$b_XMLvalido:=False:C215
					$t_error:="Para comprobantes tipo B o C con monto menor 1000, si el tipo de documento es 99, el número de documento debe ser igual a 0."
				End if 
			End if 
		End if 
	End if 
End if 

If ($t_error#"")
	CD_Dlog (0;"Error al validar XML para factura electrónica. Error: "+$t_error)
End if 
$0:=$b_XMLvalido

