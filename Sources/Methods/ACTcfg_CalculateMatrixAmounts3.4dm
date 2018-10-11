//%attributes = {}
  //ACTcfg_CalculateMatrixAmounts3

If (Count parameters:C259=0)
	$date:=Current date:C33(*)
Else 
	$date:=$1
End if 

If (Count parameters:C259=2)
	$month:=$2
Else 
	$month:=0
End if 

$montoTotal:=0
$montoBase:=0
$percentPlus:=0
$percentMinus:=0
$amountMinus:=0

  //tabla UF  
  //SET BLOB SIZE(xBlob;0)
  //$currentUFRef:="ACT_UF"+String(Year of($date);"/0000")+"/"+String(Month of($date);"00")
  //xBlob:=PREF_fGetBlob (0;$currentUFRef;xBlob)
  //BLOB_Blob2Vars (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUFstored)
  //COPY ARRAY(arACT_ValorUFstored;arACT_ValorUF)
  //For ($i;1;Size of array(arACT_ValorUF))
  //arACT_ValorUF{$i}:=Round(arACT_ValorUFstored{$i};2)
  //End for 
  //SET BLOB SIZE(xBlob;0)
  //$el:=Find in array(aiACT_DiaUF;Day of($date))
  //If ($el>0)
  //$valorUF:=arACT_ValorUF{$el}
  //Else 
  //$valorUF:=0
  //End if 
$valorUF:=ACTut_fValorUF ($date)
  //Monedas
ACTcfgmyt_OpcionesGenerales ("LeeMonedas")


If ($month=0)
	For ($i;1;Size of array:C274(alACT_IdItemMatriz))
		If ((Not:C34(abACT_IsDiscountItemMatriz{$i})) & (Not:C34(abACT_isPercentItemMatriz{$i})))
			Case of 
				: (atACT_MonedaItem{$i}="UF")
					$monto:=arACT_AmountItemMatriz{$i}*$valorUF
				: ((atACT_MonedaItem{$i}#"Peso Chileno") & (atACT_MonedaItem{$i}#""))
					$el:=Find in array:C230(atACT_NombreMoneda;atACT_MonedaItem{$i})
					If ($el>0)
						$monto:=arACT_AmountItemMatriz{$i}*arACT_ValorMoneda{$el}
					Else 
						$monto:=0
					End if 
				Else 
					$monto:=arACT_AmountItemMatriz{$i}
			End case 
			$montoTotal:=$montoTotal+$monto
			If (abACT_esDescontable{$i})
				$montoBase:=$montoBase+$monto
			End if 
		End if 
	End for 
	[ACT_Matrices:177]Monto_afecto:4:=$montoBase
	[ACT_Matrices:177]Monto_total:5:=$montoTotal
	
	For ($i;1;Size of array:C274(alACT_IdItemMatriz))
		If (abACT_IsDiscountItemMatriz{$i})
			If (abACT_isPercentItemMatriz{$i})
				$percentMinus:=$percentMinus+(arACT_AmountItemMatriz{$i}/100)
			Else 
				$amountMinus:=$amountMinus+arACT_AmountItemMatriz{$i}
			End if 
		Else 
			If (abACT_isPercentItemMatriz{$i})
				$percentPlus:=$percentPlus+arACT_AmountItemMatriz{$i}/100
			End if 
		End if 
	End for 
	[ACT_Matrices:177]Recargos:6:=Round:C94([ACT_Matrices:177]Monto_afecto:4*$percentPlus;0)
	[ACT_Matrices:177]Descuentos:7:=Round:C94([ACT_Matrices:177]Monto_afecto:4*$percentMinus;0)+$amountMinus
	[ACT_Matrices:177]Monto_Neto:8:=[ACT_Matrices:177]Monto_total:5+[ACT_Matrices:177]Recargos:6-[ACT_Matrices:177]Descuentos:7
	
Else 
	
	For ($i;1;Size of array:C274(alACT_IdItemMatriz))
		If (alACT_MesDeCargo{$i} ?? $month)
			If ((Not:C34(abACT_IsDiscountItemMatriz{$i})) & (Not:C34(abACT_isPercentItemMatriz{$i})))
				Case of 
					: (atACT_MonedaItem{$i}="UF")
						$monto:=arACT_AmountItemMatriz{$i}*$valorUF
					: ((atACT_MonedaItem{$i}#"Peso Chileno") & (atACT_MonedaItem{$i}#""))
						$el:=Find in array:C230(atACT_NombreMoneda;atACT_MonedaItem{$i})
						If ($el>0)
							$monto:=arACT_AmountItemMatriz{$i}*arACT_ValorMoneda{$el}
						Else 
							$monto:=0
						End if 
					Else 
						$monto:=arACT_AmountItemMatriz{$i}
				End case 
				$montoTotal:=$montoTotal+$monto
				If (abACT_esDescontable{$i})
					$montoBase:=$montoBase+$monto
				End if 
			End if 
		End if 
	End for 
	[ACT_Matrices:177]Monto_afecto:4:=$montoBase
	[ACT_Matrices:177]Monto_total:5:=$montoTotal
	
	For ($i;1;Size of array:C274(alACT_IdItemMatriz))
		If (alACT_MesDeCargo{$i} ?? $month)
			If (abACT_IsDiscountItemMatriz{$i})
				If (abACT_isPercentItemMatriz{$i})
					$percentMinus:=$percentMinus+(arACT_AmountItemMatriz{$i}/100)
				Else 
					$amountMinus:=$amountMinus+arACT_AmountItemMatriz{$i}
				End if 
			Else 
				If (abACT_isPercentItemMatriz{$i})
					$percentPlus:=$percentPlus+arACT_AmountItemMatriz{$i}/100
				End if 
			End if 
		End if 
	End for 
End if 

[ACT_Matrices:177]Recargos:6:=Round:C94([ACT_Matrices:177]Monto_afecto:4*$percentPlus;0)
[ACT_Matrices:177]Descuentos:7:=Round:C94([ACT_Matrices:177]Monto_afecto:4*$percentMinus;0)+$amountMinus
[ACT_Matrices:177]Monto_Neto:8:=[ACT_Matrices:177]Monto_total:5+[ACT_Matrices:177]Recargos:6-[ACT_Matrices:177]Descuentos:7
