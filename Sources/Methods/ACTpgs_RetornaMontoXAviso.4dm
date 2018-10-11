//%attributes = {}
  //ACTpgs_RetornaMontoXAviso

ARRAY LONGINT:C221($al_idsCargosAviso;0)
C_BOOLEAN:C305($emitidoSegunMonedaCargo)
C_LONGINT:C283($vl_idCargo)
C_POINTER:C301($ptrACT_SeleccionadoAfecto;$ptrACT_SeleccionadoExento)
C_REAL:C285($vrACT_SeleccionadoAfecto;$vrACT_SeleccionadoExento;$0)
C_DATE:C307($vd_fecha)
C_TEXT:C284($vt_accion;$vt_valorABuscar)

READ ONLY:C145([ACT_Cargos:173])

$vt_accion:=$1
$vb_validateElementSelected:=$2
$vt_valorABuscar:=$3
$vd_fecha:=$4
If (Count parameters:C259=6)
	$ptrACT_SeleccionadoAfecto:=$5
	$ptrACT_SeleccionadoExento:=$6
Else 
	$ptrACT_SeleccionadoAfecto:=->$vrACT_SeleccionadoAfecto
	$ptrACT_SeleccionadoExento:=->$vrACT_SeleccionadoExento
End if 

  //PROCESS PROPERTIES(Current process;$ProcName;$ProcState;$ProcTime)
C_BOOLEAN:C305($vb_desdeTemp)
Case of 
	: ($vt_accion="MontoDesdeNoAvisos")
		If (Size of array:C274(alACT_CIdsAvisosTemp)>0)
			$ptr1:=->alACT_CIdsAvisosTemp
			$vb_desdeTemp:=True:C214
		Else 
			$ptr1:=->alACT_CIdsAvisos
		End if 
		
	: ($vt_accion="MontoDesdeNoItem")
		If (Size of array:C274(alACT_CRefsTemp)>0)
			$ptr1:=->alACT_CRefsTemp
			$vb_desdeTemp:=True:C214
		Else 
			$ptr1:=->alACT_CRefs
		End if 
		
	: ($vt_accion="MontoDesdeNoCta")
		If (Size of array:C274(alACT_CIDCtaCteTemp)>0)
			$ptr1:=->alACT_CIDCtaCteTemp
			$vb_desdeTemp:=True:C214
		Else 
			$ptr1:=->alACT_CIDCtaCte
		End if 
		
	: ($vt_accion="MontoDesdeAgrupado")
		If (Size of array:C274(adACT_CFechaEmisionTemp)>0)
			$ptr1:=->adACT_CFechaEmisionTemp
			$vb_desdeTemp:=True:C214
		Else 
			$ptr1:=->adACT_CFechaEmision
		End if 
		
End case 

If ($vt_accion="MontoDesdeAgrupado")
	ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valorABuscar;$ptr1;->$al_idsCargosAviso)
Else 
	$ptr1->{0}:=Num:C11($vt_valorABuscar)
	AT_SearchArray ($ptr1;"=";->$al_idsCargosAviso)
End if 

For ($j;1;Size of array:C274($al_idsCargosAviso))
	If ($vb_desdeTemp)
		If ($vb_validateElementSelected)
			$vb_continue:=abACT_ASelectedCargoTemp{$al_idsCargosAviso{$j}}
		Else 
			$vb_continue:=True:C214
		End if 
		If ($vb_continue)
			$vl_idCargo:=alACT_CIdsCargosTemp{$al_idsCargosAviso{$j}}
			$emitidoSegunMonedaCargo:=KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
			If ($emitidoSegunMonedaCargo)
				$vr_saldo:=ACTut_retornaMontoEnMoneda (Abs:C99(arACT_CSaldoTemp{$al_idsCargosAviso{$j}});atACT_MonedaCargoTemp{$al_idsCargosAviso{$j}};$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";");$vd_fecha)
			Else 
				$vr_saldo:=Abs:C99(arACT_CSaldoTemp{$al_idsCargosAviso{$j}})
			End if 
			If (arACT_MontoIVATemp{$al_idsCargosAviso{$j}}#0)
				If (arACT_CMontoNetoTemp{$al_idsCargosAviso{$j}}>0)
					$ptrACT_SeleccionadoAfecto->:=$ptrACT_SeleccionadoAfecto->+$vr_saldo
				Else 
					$ptrACT_SeleccionadoAfecto->:=$ptrACT_SeleccionadoAfecto->-$vr_saldo
				End if 
			Else 
				If (arACT_CMontoNetoTemp{$al_idsCargosAviso{$j}}>0)
					$ptrACT_SeleccionadoExento->:=$ptrACT_SeleccionadoExento->+$vr_saldo
				Else 
					$ptrACT_SeleccionadoExento->:=$ptrACT_SeleccionadoExento->-$vr_saldo
				End if 
			End if 
		End if 
	Else 
		If ($vb_validateElementSelected)
			$vb_continue:=abACT_ASelectedCargo{$al_idsCargosAviso{$j}}
		Else 
			$vb_continue:=True:C214
		End if 
		If ($vb_continue)
			$vl_idCargo:=alACT_CIdsCargos{$al_idsCargosAviso{$j}}
			$emitidoSegunMonedaCargo:=KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
			If ($emitidoSegunMonedaCargo)
				$vr_saldo:=ACTut_retornaMontoEnMoneda (Abs:C99(arACT_CSaldo{$al_idsCargosAviso{$j}});atACT_MonedaCargo{$al_idsCargosAviso{$j}};$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";");$vd_fecha)
			Else 
				$vr_saldo:=Abs:C99(arACT_CSaldo{$al_idsCargosAviso{$j}})
			End if 
			If (arACT_MontoIVA{$al_idsCargosAviso{$j}}#0)
				If (arACT_CMontoNeto{$al_idsCargosAviso{$j}}>0)
					$ptrACT_SeleccionadoAfecto->:=$ptrACT_SeleccionadoAfecto->+$vr_saldo
				Else 
					$ptrACT_SeleccionadoAfecto->:=$ptrACT_SeleccionadoAfecto->-$vr_saldo
				End if 
			Else 
				If (arACT_CMontoNeto{$al_idsCargosAviso{$j}}>0)
					$ptrACT_SeleccionadoExento->:=$ptrACT_SeleccionadoExento->+$vr_saldo
				Else 
					$ptrACT_SeleccionadoExento->:=$ptrACT_SeleccionadoExento->-$vr_saldo
				End if 
			End if 
		End if 
	End if 
End for 
$0:=$ptrACT_SeleccionadoAfecto->+$ptrACT_SeleccionadoExento->