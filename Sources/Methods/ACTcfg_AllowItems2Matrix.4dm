//%attributes = {}
  //ACTcfg_AllowItems2Matrix
C_BOOLEAN:C305($vb_noExisteMon)

$selectedMatrix:=$1
If ($selectedMatrix>0)
	$idMatrix:=alACT_IdMatriz{$selectedMatrix}
	$moneda:=atACT_MonedaMatriz{$selectedMatrix}
Else 
	If (Size of array:C274(alACT_IdMatriz)>0)
		$idMatrix:=alACT_IdMatriz{1}
		$moneda:=atACT_MonedaMatriz{1}
	Else 
		$idMatrix:=0
	End if 
End if 
If ($idMatrix#0)
	If (Count parameters:C259=2)
		$date:=$2
	Else 
		$date:=Current date:C33(*)
	End if 
	
	If (Count parameters:C259=3)
		$month:=$3
	Else 
		$month:=0
	End if 
	
	If (Count parameters:C259=4)
		$displayMsg:=$4
	Else 
		$displayMsg:=True:C214
	End if 
	$montoTotal:=0
	$montoBase:=0
	$percentPlus:=0
	$percentMinus:=0
	$amountMinus:=0
	$AfectoIVA:=0
	$ExentoIVA:=0
	$AfectoIVAAmount:=0
	$ExentoIVAAmount:=0
	
	  //  `tabla UF  
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
	SET BLOB SIZE:C606(xBlob;0)
	xBlob:=PREF_fGetBlob (0;"ACT_Monedas";xBlob)
	BLOB_Blob2Vars (->xBlob;0;->atACT_NombreMoneda;->arACT_ValorMoneda)
	SET BLOB SIZE:C606(xBlob;0)
	
	If ($month=0)
		For ($i;1;Size of array:C274(alACT_IdItemMatriz))
			If ((Not:C34(abACT_IsDiscountItemMatriz{$i})) & (Not:C34(abACT_isPercentItemMatriz{$i})))
				$el:=Find in array:C230(atACT_NombreMoneda;atACT_MonedaItem{$i})
				If ($el>0)
					$vb_noExisteMon:=False:C215
					If (atACT_MonedaItem{$i}="UF")
						$valormoneda:=$valorUF
					Else 
						$valormoneda:=arACT_ValorMoneda{$el}
					End if 
					$montopesos:=arACT_AmountItemMatriz{$i}*$valormoneda
					Case of 
						: ($moneda="UF")
							If ($valorUF>0)
								$monto:=$montopesos/$valorUF
							Else 
								$monto:=0
							End if 
							  //: (($moneda#"Peso Chileno") & ($moneda#""))
						: (($moneda#<>vsACT_MonedaColegio) & ($moneda#""))
							$el:=Find in array:C230(atACT_NombreMoneda;$moneda)
							If ($el>0)
								If (arACT_ValorMoneda{$el}>0)
									$monto:=$montopesos/arACT_ValorMoneda{$el}
								Else 
									$monto:=0
								End if 
							Else 
								$monto:=0
							End if 
						Else 
							$monto:=$montopesos
					End case 
					$montoTotal:=$montoTotal+$monto
					If (abACT_esDescontable{$i})
						$montoBase:=$montoBase+$monto
					End if 
					If (abACT_ItemAfectoIVA{$i})
						$AfectoIVA:=$AfectoIVA+$monto
					Else 
						$ExentoIVA:=$ExentoIVA+$monto
					End if 
				Else 
					$vb_noExisteMon:=True:C214
				End if 
			End if 
		End for 
		If (Not:C34($vb_noExisteMon))
			For ($i;1;Size of array:C274(alACT_IdItemMatriz))
				$el:=Find in array:C230(atACT_NombreMoneda;atACT_MonedaItem{$i})
				If (atACT_MonedaItem{$i}="UF")
					$valormoneda:=$valorUF
				Else 
					$valormoneda:=arACT_ValorMoneda{$el}
				End if 
				$montopesos:=arACT_AmountItemMatriz{$i}*$valormoneda
				Case of 
					: ($moneda="UF")
						If ($valorUF>0)
							$monto:=$montopesos/$valorUF
						Else 
							$monto:=0
						End if 
						  //: (($moneda#"Peso Chileno") & ($moneda#""))
					: (($moneda#<>vsACT_MonedaColegio) & ($moneda#""))
						$el:=Find in array:C230(atACT_NombreMoneda;$moneda)
						If ($el>0)
							If (arACT_ValorMoneda{$el}>0)
								$monto:=$montopesos/arACT_ValorMoneda{$el}
							Else 
								$monto:=0
							End if 
						Else 
							$monto:=0
						End if 
					Else 
						$monto:=$montopesos
				End case 
				If (abACT_IsDiscountItemMatriz{$i})
					If (abACT_isPercentItemMatriz{$i})
						$percentMinus:=$percentMinus+(arACT_AmountItemMatriz{$i}/100)
					Else 
						If (abACT_ItemAfectoIVA{$i})
							$AfectoIVAAmount:=$AfectoIVAAmount+$monto
						Else 
							$ExentoIVAAmount:=$ExentoIVAAmount+$monto
						End if 
						$amountMinus:=$amountMinus+$monto
					End if 
				Else 
					If (abACT_isPercentItemMatriz{$i})
						$percentPlus:=$percentPlus+arACT_AmountItemMatriz{$i}/100
					End if 
				End if 
			End for 
		End if 
	Else 
		If (Not:C34($vb_noExisteMon))
			For ($i;1;Size of array:C274(alACT_IdItemMatriz))
				If (alACT_MesDeCargo{$i} ?? $month)
					If ((Not:C34(abACT_IsDiscountItemMatriz{$i})) & (Not:C34(abACT_isPercentItemMatriz{$i})))
						$el:=Find in array:C230(atACT_NombreMoneda;atACT_MonedaItem{$i})
						If (atACT_MonedaItem{$i}="UF")
							$valormoneda:=$valorUF
						Else 
							$valormoneda:=arACT_ValorMoneda{$el}
						End if 
						$montopesos:=arACT_AmountItemMatriz{$i}*$valormoneda
						Case of 
							: ($moneda="UF")
								If ($valorUF>0)
									$monto:=$montopesos/$valorUF
								Else 
									$monto:=0
								End if 
								  //: (($moneda#"Peso Chileno") & ($moneda#""))
							: (($moneda#<>vsACT_MonedaColegio) & ($moneda#""))
								$el:=Find in array:C230(atACT_NombreMoneda;$moneda)
								If ($el>0)
									If (arACT_ValorMoneda{$el}>0)
										$monto:=$montopesos/arACT_ValorMoneda{$el}
									Else 
										$monto:=0
									End if 
									
								Else 
									$monto:=0
								End if 
							Else 
								$monto:=$montopesos
						End case 
						$montoTotal:=$montoTotal+$monto
						If (abACT_esDescontable{$i})
							$montoBase:=$montoBase+$monto
						End if 
					End if 
				End if 
			End for 
			
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
	End if 
	
	If (($AfectoIVAAmount>$AfectoIVA) | ($ExentoIVAAmount>$ExentoIVA))
		$0:=False:C215
		If ($displayMsg)
			Case of 
				: ($AfectoIVAAmount>$AfectoIVA)
					CD_Dlog (0;__ ("El item no puede ser agregado o retirado de la matriz debido a que los descuentos afectos a IVA superarían a los items afectos a IVA."))
				: ($ExentoIVAAmount>$ExentoIVA)
					CD_Dlog (0;__ ("El item no puede ser agregado o retirado de la matriz debido a que los descuentos exentos de IVA superarían a los items exentos de IVA."))
			End case 
		End if 
	Else 
		$0:=True:C214
	End if 
	If ($vb_noExisteMon)
		$0:=True:C214
	End if 
End if 