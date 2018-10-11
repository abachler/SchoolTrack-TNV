//%attributes = {}
  //ACTbol_MontosFromPagos

C_POINTER:C301($ptr_recNumCargos;$ptr_montoAfectoTotal;$ptr_montoNoAfectoTotal;$ptr_transaAfectas;$ptr_transaNoAfectas;$ptr_cargosAfectos;$ptr_cargosNoAfectos)
C_LONGINT:C283($id_ctaSel;$id_pago;$vl_id_RazonSocial)
C_BOOLEAN:C305($b_porCta)

$id_pago:=$1
$ptr_recNumCargos:=$2
$id_ctaSel:=$3
$ptr_montoAfectoTotal:=$4
$ptr_montoNoAfectoTotal:=$5
$ptr_transaAfectas:=$6
$ptr_transaNoAfectas:=$7
$vl_id_RazonSocial:=$8
$b_porCta:=$9  //20160820 RCH. //20160819 RCH Cuando el apoderado pagaba cargos con id cta cte 0 se producia un problema al calcular los montos. Ticket 166316

  //If (Count parameters>=8)
  //$ptr_cargosAfectos:=$8
  //End if 
  //If (Count parameters>=9)
  //$ptr_cargosNoAfectos:=$9
  //End if 

ARRAY LONGINT:C221($al_idsProcesados;0)

For ($j;1;Size of array:C274($ptr_recNumCargos->))
	GOTO RECORD:C242([ACT_Cargos:173];$ptr_recNumCargos->{$j})
	If ($b_porCta)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$id_ctaSel)
	End if 
	ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$vl_id_RazonSocial)
	
	ACTbol_FiltraItemsCategoria ("cargosBoleta")
	
	ACTbol_FiltraItemsMoneda ("cargosBoleta")
	
	ACTbol_FiltraItemsResponsable ("cargosBoleta")  //20170712 RCH
	
	If (Records in selection:C76([ACT_Cargos:173])>0)
		ARRAY LONGINT:C221($aRecNumCargos;0)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRecNumCargos;"")
		For ($k;1;Size of array:C274($aRecNumCargos))
			GOTO RECORD:C242([ACT_Cargos:173];$aRecNumCargos{$k})
			If (Find in array:C230($al_idsProcesados;[ACT_Cargos:173]ID:1)=-1)
				APPEND TO ARRAY:C911($al_idsProcesados;[ACT_Cargos:173]ID:1)
				If (Not:C34([ACT_Cargos:173]No_Incluir_en_DocTrib:50))
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=$id_pago;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
					If (Records in selection:C76([ACT_Transacciones:178])>0)
						ARRAY LONGINT:C221($al_recNum;0)
						SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum)
						For ($uc;1;Size of array:C274($al_recNum))
							KRL_GotoRecord (->[ACT_Transacciones:178];$al_recNum{$uc})
							$b_monedaOriginal:=(cbEmitirXMonedas=1)
							  //$debito:=ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones]Debito)
							$debito:=ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6;->$b_monedaOriginal)
							KRL_GotoRecord (->[ACT_Cargos:173];$ptr_recNumCargos->{$j})
							$idTransaccion:=[ACT_Transacciones:178]ID_Transaccion:1
							If ([ACT_Cargos:173]TasaIVA:21>0)
								If ([ACT_Cargos:173]Monto_Neto:5<0)
									$ptr_montoAfectoTotal->:=$ptr_montoAfectoTotal->-Abs:C99($debito)
								Else 
									$ptr_montoAfectoTotal->:=$ptr_montoAfectoTotal->+$debito
								End if 
								INSERT IN ARRAY:C227($ptr_transaAfectas->;Size of array:C274($ptr_transaAfectas->)+1;1)
								$ptr_transaAfectas->{Size of array:C274($ptr_transaAfectas->)}:=$idTransaccion
								
								If (Not:C34(Is nil pointer:C315($ptr_cargosAfectos)))
									INSERT IN ARRAY:C227($ptr_cargosAfectos->;Size of array:C274($ptr_cargosAfectos->)+1;1)
									$ptr_cargosAfectos->{Size of array:C274($ptr_cargosAfectos->)}:=Record number:C243([ACT_Cargos:173])
								End if 
							Else 
								If ([ACT_Cargos:173]Monto_Neto:5<0)
									$ptr_montoNoAfectoTotal->:=$ptr_montoNoAfectoTotal->-Abs:C99($debito)
								Else 
									$ptr_montoNoAfectoTotal->:=$ptr_montoNoAfectoTotal->+$debito
								End if 
								INSERT IN ARRAY:C227($ptr_transaNoAfectas->;Size of array:C274($ptr_transaNoAfectas->)+1;1)
								$ptr_transaNoAfectas->{Size of array:C274($ptr_transaNoAfectas->)}:=$idTransaccion
								
								If (Not:C34(Is nil pointer:C315($ptr_cargosAfectos)))
									INSERT IN ARRAY:C227($ptr_cargosNoAfectos->;Size of array:C274($ptr_cargosNoAfectos->)+1;1)
									$ptr_cargosNoAfectos->{Size of array:C274($ptr_cargosNoAfectos->)}:=Record number:C243([ACT_Cargos:173])
								End if 
							End if 
						End for 
					End if 
				End if 
			End if 
		End for 
	End if 
End for 