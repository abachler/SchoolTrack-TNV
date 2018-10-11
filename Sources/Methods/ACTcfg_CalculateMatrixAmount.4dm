//%attributes = {}
  // Método: ACTcfg_CalculateMatrixAmount
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 17:10:35
  // ---------------------------------------------
  // Modificado por: Alberto Bachler Klein: 15-12-16, 09:26:39
  // Corección de error en interpretado, declaración de variables
  // -----------------------------------------------------------


C_LONGINT:C283($1)

C_BOOLEAN:C305($b_error)
C_DATE:C307($d_fecha)
C_LONGINT:C283($i;$l_elemento;$l_idMatriz;$l_matrizSeleccionada;$l_mes)
C_REAL:C285($r_monto;$r_montoBase;$r_montoMinus;$r_montoPesos;$r_montoTotal;$r_porcentajeMas;$r_PorcentajeMinus;$r_valorMoneda;$r_valorUF)
C_TEXT:C284($t_moneda)


If (False:C215)
	C_LONGINT:C283(ACTcfg_CalculateMatrixAmount ;$1)
End if 



$l_idMatriz:=$1

If ($l_idMatriz>0)
	$l_matrizSeleccionada:=Find in array:C230(alACT_IdMatriz;$l_idMatriz)
	$t_moneda:=atACT_MonedaMatriz{$l_matrizSeleccionada}
Else 
	If (Size of array:C274(alACT_IdMatriz)>0)
		$t_moneda:=atACT_MonedaMatriz{1}
	Else 
		$l_idMatriz:=0
	End if 
End if 


If ($l_idMatriz#0)
	$d_fecha:=Current date:C33(*)
	$l_mes:=0
	$r_montoTotal:=0
	$r_montoBase:=0
	$r_porcentajeMas:=0
	$r_PorcentajeMinus:=0
	$r_montoMinus:=0
	
	
	$r_valorUF:=ACTut_fValorUF ($d_fecha)
	
	  //Monedas
	ACTcfgmyt_OpcionesGenerales ("LeeMonedas")
	
	READ WRITE:C146([ACT_Matrices:177])
	QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=$l_idMatriz)
	
	If ($l_mes=0)
		For ($i;1;Size of array:C274(alACT_IdItemMatriz))
			If ((Not:C34(abACT_IsDiscountItemMatriz{$i})) & (Not:C34(abACT_isPercentItemMatriz{$i})))
				$l_elemento:=Find in array:C230(atACT_NombreMoneda;atACT_MonedaItem{$i})
				If ($l_elemento>0)
					$b_error:=False:C215
					If (atACT_MonedaItem{$i}="UF")
						$r_valorMoneda:=$r_valorUF
					Else 
						$r_valorMoneda:=arACT_ValorMoneda{$l_elemento}
					End if 
					$r_montoPesos:=arACT_AmountItemMatriz{$i}*$r_valorMoneda
					Case of 
						: ($t_moneda="UF")
							If ($r_valorUF>0)
								$r_monto:=$r_montoPesos/$r_valorUF
							Else 
								$r_monto:=0
							End if 
							OBJECT SET FORMAT:C236([ACT_Matrices:177]Recargos:6;"|Despliegue_UF")
							OBJECT SET FORMAT:C236([ACT_Matrices:177]Descuentos:7;"|Despliegue_UF")
							OBJECT SET FORMAT:C236([ACT_Matrices:177]Monto_afecto:4;"|Despliegue_UF")
							OBJECT SET FORMAT:C236([ACT_Matrices:177]Monto_Neto:8;"|Despliegue_UF")
							
						: (($t_moneda#<>vsACT_MonedaColegio) & ($t_moneda#""))
							$l_elemento:=Find in array:C230(atACT_NombreMoneda;$t_moneda)
							If ($l_elemento>0)
								If (arACT_ValorMoneda{$l_elemento}>0)
									$r_monto:=$r_montoPesos/arACT_ValorMoneda{$l_elemento}
								Else 
									$r_monto:=0
								End if 
								OBJECT SET FORMAT:C236([ACT_Matrices:177]Recargos:6;"|Despliegue_UF")
								OBJECT SET FORMAT:C236([ACT_Matrices:177]Descuentos:7;"|Despliegue_UF")
								OBJECT SET FORMAT:C236([ACT_Matrices:177]Monto_afecto:4;"|Despliegue_UF")
								OBJECT SET FORMAT:C236([ACT_Matrices:177]Monto_Neto:8;"|Despliegue_UF")
							Else 
								$r_monto:=0
							End if 
						Else 
							$r_monto:=$r_montoPesos
					End case 
					$r_montoTotal:=$r_montoTotal+$r_monto
					If (abACT_esDescontable{$i})
						$r_montoBase:=$r_montoBase+$r_monto
					End if 
				Else 
					$b_error:=True:C214
					CD_Dlog (0;__ ("Error")+". "+__ ("El ítem de cargo")+" "+ST_Qte (atACT_GlosaItemMatriz{$i})+" tiene asociado una moneda que no existe en la configuración ("+atACT_MonedaItem{$i}+")"+". "+__ ("Por favor modifique la moneda del ítem de cargo."))
				End if 
			End if 
		End for 
		If (Not:C34($b_error))
			[ACT_Matrices:177]Monto_afecto:4:=$r_montoBase
			[ACT_Matrices:177]Monto_total:5:=$r_montoTotal
			
			For ($i;1;Size of array:C274(alACT_IdItemMatriz))
				$l_elemento:=Find in array:C230(atACT_NombreMoneda;atACT_MonedaItem{$i})
				If (atACT_MonedaItem{$i}="UF")
					$r_valorMoneda:=$r_valorUF
				Else 
					$r_valorMoneda:=arACT_ValorMoneda{$l_elemento}
				End if 
				$r_montoPesos:=arACT_AmountItemMatriz{$i}*$r_valorMoneda
				Case of 
					: ($t_moneda="UF")
						If ($r_valorUF>0)
							$r_monto:=$r_montoPesos/$r_valorUF
						Else 
							$r_monto:=0
						End if 
						
					: (($t_moneda#<>vsACT_MonedaColegio) & ($t_moneda#""))
						$l_elemento:=Find in array:C230(atACT_NombreMoneda;$t_moneda)
						If ($l_elemento>0)
							If (arACT_ValorMoneda{$l_elemento}>0)
								$r_monto:=$r_montoPesos/arACT_ValorMoneda{$l_elemento}
							Else 
								$r_monto:=0
							End if 
						Else 
							$r_monto:=0
						End if 
					Else 
						$r_monto:=$r_montoPesos
				End case 
				If (abACT_IsDiscountItemMatriz{$i})
					If (abACT_isPercentItemMatriz{$i})
						$r_PorcentajeMinus:=$r_PorcentajeMinus+(arACT_AmountItemMatriz{$i}/100)
					Else 
						$r_montoMinus:=$r_montoMinus+$r_monto
					End if 
				Else 
					If (abACT_isPercentItemMatriz{$i})
						$r_porcentajeMas:=$r_porcentajeMas+arACT_AmountItemMatriz{$i}/100
					End if 
				End if 
			End for 
			[ACT_Matrices:177]Recargos:6:=[ACT_Matrices:177]Monto_afecto:4*$r_porcentajeMas
			[ACT_Matrices:177]Descuentos:7:=([ACT_Matrices:177]Monto_afecto:4*$r_PorcentajeMinus)+$r_montoMinus
			[ACT_Matrices:177]Monto_Neto:8:=[ACT_Matrices:177]Monto_total:5+[ACT_Matrices:177]Recargos:6-[ACT_Matrices:177]Descuentos:7
			
		End if 
	Else 
		
		For ($i;1;Size of array:C274(alACT_IdItemMatriz))
			If (alACT_MesDeCargo{$i} ?? $l_mes)
				If ((Not:C34(abACT_IsDiscountItemMatriz{$i})) & (Not:C34(abACT_isPercentItemMatriz{$i})))
					$l_elemento:=Find in array:C230(atACT_NombreMoneda;atACT_MonedaItem{$i})
					If (atACT_MonedaItem{$i}="UF")
						$r_valorMoneda:=$r_valorUF
					Else 
						$r_valorMoneda:=arACT_ValorMoneda{$l_elemento}
					End if 
					$r_montoPesos:=arACT_AmountItemMatriz{$i}*$r_valorMoneda
					Case of 
						: ($t_moneda="UF")
							If ($r_valorUF>0)
								$r_monto:=$r_montoPesos/$r_valorUF
							Else 
								$r_monto:=0
							End if 
							OBJECT SET FORMAT:C236([ACT_Matrices:177]Recargos:6;"|Despliegue_UF")
							OBJECT SET FORMAT:C236([ACT_Matrices:177]Descuentos:7;"|Despliegue_UF")
							OBJECT SET FORMAT:C236([ACT_Matrices:177]Monto_afecto:4;"|Despliegue_UF")
							OBJECT SET FORMAT:C236([ACT_Matrices:177]Monto_Neto:8;"|Despliegue_UF")
							
						: (($t_moneda#<>vsACT_MonedaColegio) & ($t_moneda#""))
							$l_elemento:=Find in array:C230(atACT_NombreMoneda;$t_moneda)
							If ($l_elemento>0)
								If (arACT_ValorMoneda{$l_elemento}>0)
									$r_monto:=$r_montoPesos/arACT_ValorMoneda{$l_elemento}
								Else 
									$r_monto:=0
								End if 
								OBJECT SET FORMAT:C236([ACT_Matrices:177]Recargos:6;"|Despliegue_UF")
								OBJECT SET FORMAT:C236([ACT_Matrices:177]Descuentos:7;"|Despliegue_UF")
								OBJECT SET FORMAT:C236([ACT_Matrices:177]Monto_afecto:4;"|Despliegue_UF")
								OBJECT SET FORMAT:C236([ACT_Matrices:177]Monto_Neto:8;"|Despliegue_UF")
							Else 
								$r_monto:=0
							End if 
						Else 
							$r_monto:=$r_montoPesos
					End case 
					$r_montoTotal:=$r_montoTotal+$r_monto
					If (abACT_esDescontable{$i})
						$r_montoBase:=$r_montoBase+$r_monto
					End if 
				End if 
			End if 
		End for 
		[ACT_Matrices:177]Monto_afecto:4:=$r_montoBase
		[ACT_Matrices:177]Monto_total:5:=$r_montoTotal
		
		For ($i;1;Size of array:C274(alACT_IdItemMatriz))
			If (alACT_MesDeCargo{$i} ?? $l_mes)
				If (abACT_IsDiscountItemMatriz{$i})
					If (abACT_isPercentItemMatriz{$i})
						$r_PorcentajeMinus:=$r_PorcentajeMinus+(arACT_AmountItemMatriz{$i}/100)
					Else 
						$r_montoMinus:=$r_montoMinus+arACT_AmountItemMatriz{$i}
					End if 
				Else 
					If (abACT_isPercentItemMatriz{$i})
						$r_porcentajeMas:=$r_porcentajeMas+arACT_AmountItemMatriz{$i}/100
					End if 
				End if 
			End if 
		End for 
	End if 
	If (Not:C34($b_error))
		[ACT_Matrices:177]Recargos:6:=[ACT_Matrices:177]Monto_afecto:4*$r_porcentajeMas
		[ACT_Matrices:177]Descuentos:7:=([ACT_Matrices:177]Monto_afecto:4*$r_PorcentajeMinus)+$r_montoMinus
		[ACT_Matrices:177]Monto_Neto:8:=[ACT_Matrices:177]Monto_total:5+[ACT_Matrices:177]Recargos:6-[ACT_Matrices:177]Descuentos:7
		
		REDRAW WINDOW:C456
		SAVE RECORD:C53([ACT_Matrices:177])
	End if 
End if 

