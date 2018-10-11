//%attributes = {}
  //ACTcc_OpcionesCalculoCtaCte

C_TEXT:C284($accion;$1)
C_BOOLEAN:C305($0)
C_LONGINT:C283($vl_idApdo)
C_POINTER:C301($ptr1)

$accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($accion="InitArrays")
		ARRAY LONGINT:C221(alACTpp_idsPersonas;0)
		ARRAY LONGINT:C221(alACTter_idsTerceros;0)
		C_BOOLEAN:C305(vbACTcc_AgregarElementos)
		vbACTcc_AgregarElementos:=True:C214
		
	: ($accion="InitArraysAndAgregarElemento")
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";$ptr1)
		
	: ($accion="PermitidoAgregarElementos")
		C_BOOLEAN:C305(vbACTcc_AgregarElementos)
		$0:=vbACTcc_AgregarElementos
		
	: ($accion="AgregarElemento")
		If (ACTcc_OpcionesCalculoCtaCte ("PermitidoAgregarElementos"))
			If (Find in array:C230(alACTpp_idsPersonas;$ptr1->)=-1) & ($ptr1->#0)
				APPEND TO ARRAY:C911(alACTpp_idsPersonas;$ptr1->)
			End if 
			$vl_valor:=0
			RESOLVE POINTER:C394($ptr1;$varName;$tableNum;$fieldNum)
			If (($tableNum>0) & ($fieldNum>0))
				Case of 
					: ($tableNum=Table:C252(->[ACT_Cargos:173]))
						$vl_valor:=[ACT_Cargos:173]ID_Tercero:54
						
					: ($tableNum=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
						$vl_valor:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
						
					: ($tableNum=Table:C252(->[ACT_Documentos_de_Pago:176]))
						$vl_valor:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
						
					: ($tableNum=Table:C252(->[ACT_Pagos:172]))
						$vl_valor:=[ACT_Pagos:172]ID_Tercero:26
						
				End case 
				If (Find in array:C230(alACTter_idsTerceros;$vl_valor)=-1) & ($vl_valor#0)
					APPEND TO ARRAY:C911(alACTter_idsTerceros;$vl_valor)
				End if 
			End if 
		End if 
		
	: ($accion="RecalcularCtas")
		If (Not:C34(Is nil pointer:C315($ptr1)))
			If ($ptr1->)
				$l_ProgressProcID:=IT_Progress (1;0;0;__ ("Calculando saldos de las cuentas..."))
			End if 
		End if 
		
		For ($i;1;Size of array:C274(alACTpp_idsPersonas))
			$vl_idApdo:=alACTpp_idsPersonas{$i}
			READ ONLY:C145([Personas:7])
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$vl_idApdo)
			$vl_recNum:=Record number:C243([Personas:7])
			$done:=ACTpp_RecalculaSaldoApdo ($vl_recNum)
			If (Not:C34($done))
				BM_CreateRequest ("ACTpp_Calcula_Montos_Ejercicio";String:C10($vl_recNum);String:C10($vl_recNum))
			End if 
			If (Not:C34(Is nil pointer:C315($ptr1)))
				If ($ptr1->)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACTpp_idsPersonas);__ ("Calculando saldos de las cuentas..."))
				End if 
			End if 
		End for 
		ACTter_RecalculaSaldo (->alACTpp_idsPersonas)
		If (Not:C34(Is nil pointer:C315($ptr1)))
			If ($ptr1->)
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
		End if 
		
		If (Not:C34(Is nil pointer:C315($ptr1)))
			If ($ptr1->)
				$l_ProgressProcID:=IT_Progress (1;0;0;__ ("Calculando saldos de terceros..."))
			End if 
		End if 
		
		For ($i;1;Size of array:C274(alACTter_idsTerceros))
			READ ONLY:C145([ACT_Terceros:138])
			$done:=ACTter_ActualizaValores (alACTter_idsTerceros{$i})
			If (Not:C34($done))
				BM_CreateRequest ("ACTter_ActualizaValores";String:C10(alACTter_idsTerceros{$i});String:C10(alACTter_idsTerceros{$i}))
			End if 
			If (Not:C34(Is nil pointer:C315($ptr1)))
				If ($ptr1->)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACTter_idsTerceros);__ ("Calculando saldos de terceros..."))
				End if 
			End if 
		End for 
		
		If (Not:C34(Is nil pointer:C315($ptr1)))
			If ($ptr1->)
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
		End if 
		
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		vbACTcc_AgregarElementos:=False:C215
		
	: ($accion="RecalcularCtasBash")
		For ($i;1;Size of array:C274(alACTpp_idsPersonas))
			$vl_idPersona:=alACTpp_idsPersonas{$i}
			READ ONLY:C145([Personas:7])
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$vl_idPersona)
			BM_CreateRequest ("ACTpp_Calcula_Montos_Ejercicio";String:C10(Record number:C243([Personas:7]));String:C10(Record number:C243([Personas:7])))
		End for 
		ACTter_RecalculaSaldo (->alACTpp_idsPersonas;True:C214)
		
		For ($i;1;Size of array:C274(alACTter_idsTerceros))
			BM_CreateRequest ("ACTter_ActualizaValores";String:C10(alACTter_idsTerceros{$i});String:C10(alACTter_idsTerceros{$i}))
		End for 
		
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		vbACTcc_AgregarElementos:=False:C215
		
End case 