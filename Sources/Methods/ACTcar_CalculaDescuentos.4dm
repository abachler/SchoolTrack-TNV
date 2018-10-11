//%attributes = {}
  //ACTcar_CalculaDescuentos

  //C_LONGINT($numeroHijo;$1;$tramoIngreso;$numeroCargas;$2;$descIndividual;$3;$tramoIngreso;$4)
C_REAL:C285($numeroHijo;$1;$tramoIngreso;$numeroCargas;$2;$descIndividual;$3;$tramoIngreso;$4)  //20130625 RCH Se estaban redondeando los montos.
C_POINTER:C301($pointerNumeroHijo)
C_REAL:C285($descuento;$0)
C_TEXT:C284($vt_monedaCargo;$5)
C_REAL:C285($descuentoMaximo;$6)  //20130808 RCH

ACTcfg_OpcionesDescuentos ("DeclaraArreglosCalc")  //20161202 ASM Ticket 171933


$numeroHijo:=$1
$numeroCargas:=$2
$descIndividual:=$3
$tramoIngreso:=$4
$vt_monedaCargo:=$5
$descuentoMaximo:=$6

$monto:=[ACT_Cargos:173]Monto_Neto:5
$vr_montoOriginal:=$monto
$montoConDcto:=$monto

If ((cbUsarDescuentosFamilia=1) & ($numeroHijo>1) & ($numeroHijo<=17) & ([xxACT_Items:179]Afecto_a_descuentos:4))
	$pointerNumeroHijo:=Get pointer:C304("vr_Hijo"+String:C10($numeroHijo))
	  //$descuento:=$descuento+$pointerNumeroHijo->
	If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not:C34([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30))
		Case of 
			: ($descuentoMaximo-$pointerNumeroHijo-><=0)
				  //$descuento:=$descuento-$pointerNumeroHijo->
				$pointerNumeroHijo->:=$descuentoMaximo
				  //$descuento:=$descuento+$pointerNumeroHijo->
				$descuentoMaximo:=0
			Else 
				$descuentoMaximo:=$descuentoMaximo-$pointerNumeroHijo->
		End case 
	End if 
	$vrACT_Dcto:=Round:C94($monto*$pointerNumeroHijo->/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
	If ($vrACT_Dcto>$montoConDcto)
		$vrACT_Dcto:=$montoConDcto
	End if 
	[ACT_Cargos:173]Descuentos_Familia:26:=$vrACT_Dcto
	$montoConDcto:=$montoConDcto-$vrACT_Dcto
	If (cbUsarDescuentosXSeparado=1)
		$monto:=$monto-[ACT_Cargos:173]Descuentos_Familia:26
	End if 
	$descuento:=Round:C94([ACT_Cargos:173]Descuentos_Familia:26*100/$vr_montoOriginal;<>vlACT_decimalesDcto)
Else 
	If (cbUsarDescuentosFamilia=0)
		[ACT_Cargos:173]Descuentos_Familia:26:=0
	End if 
End if 

If ((cbUsarDescuentosIngresos=1) & ($tramoIngreso>=1) & ([xxACT_Items:179]Afecto_a_descuentos:4))
	$pointerIngresos:=Get pointer:C304("vr_Tramo"+String:C10($tramoIngreso))
	  //$descuento:=$descuento+$pointerIngresos->
	If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not:C34([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30))
		Case of 
			: ($descuentoMaximo-$pointerIngresos-><=0)
				  //$descuento:=$descuento-$pointerIngresos->
				$pointerIngresos->:=$descuentoMaximo
				  //$descuento:=$descuento+$pointerIngresos->
				$descuentoMaximo:=0
			Else 
				$descuentoMaximo:=$descuentoMaximo-$pointerIngresos->
		End case 
	End if 
	$vrACT_Dcto:=Round:C94($monto*$pointerIngresos->/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
	If ($vrACT_Dcto>$montoConDcto)
		$vrACT_Dcto:=$montoConDcto
	End if 
	[ACT_Cargos:173]Descuentos_Ingresos:25:=$vrACT_Dcto
	$montoConDcto:=$montoConDcto-$vrACT_Dcto
	If (cbUsarDescuentosXSeparado=1)
		$monto:=$monto-[ACT_Cargos:173]Descuentos_Ingresos:25
	End if 
	$descuento:=Round:C94(([ACT_Cargos:173]Descuentos_Familia:26+[ACT_Cargos:173]Descuentos_Ingresos:25)*100/$vr_montoOriginal;<>vlACT_decimalesDcto)
Else 
	If (cbUsarDescuentosIngresos=0)
		[ACT_Cargos:173]Descuentos_Ingresos:25:=0
	End if 
End if 

If ((cbUsarDescuentosCargas=1) & ($numeroCargas>1) & ($numeroCargas<=17) & ([xxACT_Items:179]Afecto_a_descuentos:4))
	$pointerCarga:=Get pointer:C304("vr_Familia"+String:C10($numeroCargas))
	  //$descuento:=$descuento+$pointerCarga->
	If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not:C34([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30))
		Case of 
			: ($descuentoMaximo-$pointerCarga-><=0)
				  //$descuento:=$descuento-$pointerCarga->
				$pointerCarga->:=$descuentoMaximo
				  //$descuento:=$descuento+$pointerCarga->
				$descuentoMaximo:=0
			Else 
				$descuentoMaximo:=$descuentoMaximo-$pointerCarga->
		End case 
	End if 
	$vrACT_Dcto:=Round:C94($monto*$pointerCarga->/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
	If ($vrACT_Dcto>$montoConDcto)
		$vrACT_Dcto:=$montoConDcto
	End if 
	[ACT_Cargos:173]Descuentos_Cargas:51:=$vrACT_Dcto
	$montoConDcto:=$montoConDcto-$vrACT_Dcto
	If (cbUsarDescuentosXSeparado=1)
		$monto:=$monto-[ACT_Cargos:173]Descuentos_Cargas:51
	End if 
	$descuento:=Round:C94(([ACT_Cargos:173]Descuentos_Familia:26+[ACT_Cargos:173]Descuentos_Ingresos:25+[ACT_Cargos:173]Descuentos_Cargas:51)*100/$vr_montoOriginal;<>vlACT_decimalesDcto)
Else 
	If (cbUsarDescuentosCargas=0)
		[ACT_Cargos:173]Descuentos_Cargas:51:=0
	End if 
End if 

  //20160730 RCH
  //If ((cbUsarDescuentosIndividual=1) & ($descIndividual>0) & ([xxACT_Items]AfectoDsctoIndividual))
  //  //$descuento:=$descuento+$descIndividual
  //If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not([ACT_CuentasCorrientes]NoAplicaMaxDcto))
  //Case of 
  //: ($descuentoMaximo-$descIndividual<=0)
  //  //$descuento:=$descuento-$descIndividual
  //$descIndividual:=$descuentoMaximo
  //  //$descuento:=$descuento+$descIndividual
  //$descuentoMaximo:=0
  //Else 
  //$descuentoMaximo:=$descuentoMaximo-$descIndividual
  //End case 
  //End if 
  //$vrACT_Dcto:=Round($monto*$descIndividual/100;Num(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
  //If ($vrACT_Dcto>$montoConDcto)
  //$vrACT_Dcto:=$montoConDcto
  //End if 
  //[ACT_Cargos]Descuentos_Individual:=$vrACT_Dcto
  //$montoConDcto:=$montoConDcto-$vrACT_Dcto
  //If (cbUsarDescuentosXSeparado=1)
  //$monto:=$monto-[ACT_Cargos]Descuentos_Individual
  //End if 
  //  //$descuento:=Round(([ACT_Cargos]Descuentos_Familia+[ACT_Cargos]Descuentos_Ingresos+[ACT_Cargos]Descuentos_Individual)*100/$vr_montoOriginal;<>vlACT_decimalesDcto)
  //$descuento:=Round(([ACT_Cargos]Descuentos_Familia+[ACT_Cargos]Descuentos_Ingresos+[ACT_Cargos]Descuentos_Cargas+[ACT_Cargos]Descuentos_Individual)*100/$vr_montoOriginal;<>vlACT_decimalesDcto)  //20140911 RCH
  //Else 
  //If ((cbUsarDescuentosIndividual=0) | ($descIndividual=0))
  //[ACT_Cargos]Descuentos_Individual:=0
  //End if 
  //End if 

C_LONGINT:C283($l_idItemDeCargo;$l_existe)
ARRAY TEXT:C222($atACT_PeriodoT;0)
ARRAY TEXT:C222($atACT_DescuentosT;0)
ARRAY REAL:C219($arACT_DescuentosT;0)
ARRAY BOOLEAN:C223($abACT_InactivosT;0)
ARRAY LONGINT:C221($alACT_DescuentosIdsT;0)
ARRAY LONGINT:C221($alACT_DescuentosIdsCFG_T;0)
ACTdctos_OnRecordLoad ([ACT_CuentasCorrientes:175]ID:1;False:C215;->$arACT_DescuentosT;->$atACT_DescuentosT;->$atACT_PeriodoT;->$abACT_InactivosT;->$alACT_DescuentosIdsT;->$alACT_DescuentosIdsCFG_T)
$r_sumaDescuentos:=Num:C11(ACTcc_OpcionesDctos ("ObtieneSumaDescuentos";->$abACT_InactivosT;->$arACT_DescuentosT))

ACTcfg_OpcionesDescuentos ("CargaConfDctoMaximo")

[ACT_Cargos:173]Descuentos_Individual:31:=0
If ((Size of array:C274($arACT_DescuentosT)>0) & ($r_sumaDescuentos>0) & (cbUsarDescuentosIndividual=1) & ([xxACT_Items:179]AfectoDsctoIndividual:17))
	For ($l_indiceDctos;1;Size of array:C274($arACT_DescuentosT))
		
		If (($l_indiceDctos<=lACTcfgdctos_maximoDescuento) | (lACTcfgdctos_maximoDescuento=0))
			
			C_BOOLEAN:C305($b_aplicaAMontoOriginal)  //20170119 RCH
			  //$l_idItemDeCargo:=KRL_GetNumericFieldData (->[ACT_DctosIndividuales_Cuentas]ID;->$alACT_DescuentosIdsCFG_T{$l_indiceDctos};->[ACT_DctosIndividuales_Cuentas]Porcentaje) //20161117 ASM ticket 170693
			$l_idItemDeCargo:=KRL_GetNumericFieldData (->[ACT_CFG_DctosIndividuales:229]ID:1;->$alACT_DescuentosIdsCFG_T{$l_indiceDctos};->[ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7)
			$b_aplicaAMontoOriginal:=KRL_GetBooleanFieldData (->[ACT_CFG_DctosIndividuales:229]ID:1;->$alACT_DescuentosIdsCFG_T{$l_indiceDctos};->[ACT_CFG_DctosIndividuales:229]Aplica_a_total:9)
			$l_existe:=Find in field:C653([xxACT_Items:179]ID:1;$l_idItemDeCargo)
			If (($l_existe>=0) | (cbUsarDescuentosXSeparado=0))
				If ($arACT_DescuentosT{$l_indiceDctos}>0)
					If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not:C34([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30))
						Case of 
							: ($descuentoMaximo-$arACT_DescuentosT{$l_indiceDctos}<=0)
								$arACT_DescuentosT{$l_indiceDctos}:=$descuentoMaximo
								$descuentoMaximo:=0
							Else 
								$descuentoMaximo:=$descuentoMaximo-$arACT_DescuentosT{$l_indiceDctos}
						End case 
					End if 
					
					  //20170119 RCH
					If ($b_aplicaAMontoOriginal)
						$r_montoItem:=$vr_montoOriginal
					Else 
						$r_montoItem:=$monto
					End if 
					
					  //$vrACT_Dcto:=Round($monto*$arACT_DescuentosT{$l_indiceDctos}/100;Num(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
					$vrACT_Dcto:=Round:C94($r_montoItem*$arACT_DescuentosT{$l_indiceDctos}/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
					If ($vrACT_Dcto>$montoConDcto)
						$vrACT_Dcto:=$montoConDcto
					End if 
					
					APPEND TO ARRAY:C911(alACT_DIId;$alACT_DescuentosIdsT{$l_indiceDctos})
					APPEND TO ARRAY:C911(alACT_DIIdItem;$l_idItemDeCargo)
					APPEND TO ARRAY:C911(arACT_DIMonto;$vrACT_Dcto)
					APPEND TO ARRAY:C911(arACT_PctDcto;$arACT_DescuentosT{$l_indiceDctos})
					APPEND TO ARRAY:C911(abACT_SobreTotal;$b_aplicaAMontoOriginal)
					
					$montoConDcto:=$montoConDcto-$vrACT_Dcto
					If (cbUsarDescuentosXSeparado=1)
						$monto:=$monto-$vrACT_Dcto
					End if 
				End if 
			Else 
				C_TEXT:C284($t_Alumno)
				$t_Alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)
				LOG_RegisterEvt ("No fue posible crear el descuento individual para el alumno: "+$t_Alumno+". Descuento a aplicar: "+$atACT_DescuentosT{$l_indiceDctos}+", por "+String:C10($arACT_DescuentosT{$l_indiceDctos})+"%.")
			End if 
			
		Else 
			If (lACTcfgdctos_maximoDescuento#0)
				C_TEXT:C284($t_Alumno)
				$t_Alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)
				LOG_RegisterEvt ("No fue posible crear el descuento individual para el alumno: "+$t_Alumno+". Descuento a aplicar: "+$atACT_DescuentosT{$l_indiceDctos}+", por "+String:C10($arACT_DescuentosT{$l_indiceDctos})+"%. Se superó el número máximo de descuentos a aplicar definido en la configuración ("+String:C10(lACTcfgdctos_maximoDescuento)+").")
			End if 
		End if 
		
	End for 
End if 

If (Size of array:C274(alACT_DIId)>0)
	[ACT_Cargos:173]Descuentos_Individual:31:=AT_GetSumArray (->arACT_DIMonto)
	$descuento:=Round:C94(([ACT_Cargos:173]Descuentos_Familia:26+[ACT_Cargos:173]Descuentos_Ingresos:25+[ACT_Cargos:173]Descuentos_Cargas:51+[ACT_Cargos:173]Descuentos_Individual:31)*100/$vr_montoOriginal;<>vlACT_decimalesDcto)  //20140911 RCH
End if 

$0:=$descuento