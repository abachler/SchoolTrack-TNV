//%attributes = {}
  //ACTac_AjustaSaldo

  //ahora no se utiliza

  //método que calcula la diferencia entre el monto a pagar con los cargos sumados y el monto a pagar con cada cargo redondeado. Si hay diferencia crea un cargo o un descuento para compensar
C_REAL:C285($vr_diferenciaMaxima;$vr_montoPago;$Montos;$vr_monto;$montoAviso)
C_TEXT:C284($vt_accion;$vt_moneda)
C_REAL:C285($montoRedondeado;$montoAPagar)
C_LONGINT:C283($vl_idAviso)

$vr_diferenciaMaxima:=5
$vt_accion:=$1
If (Count parameters:C259>=2)
	C_POINTER:C301($ptr1)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	C_POINTER:C301($ptr2)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	C_POINTER:C301($ptr3)
	$ptr3:=$4
End if 

ARRAY LONGINT:C221($alACT_RecNumsCargos;0)
ARRAY LONGINT:C221($al_idsAvisos;0)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Cargos:173])

Case of 
	: ($vt_accion="validaMontos")
		$vr_montoPago:=$ptr1->
		$Montos:=0
		For ($i;1;Size of array:C274(alACT_RecNumsCargos))
			KRL_GotoRecord (->[ACT_Cargos:173];alACT_RecNumsCargos{$i})
			$vr_monto:=Abs:C99(arACT_CSaldo{$i})
			$vt_moneda:=atACT_MonedaCargo{$i}
			If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
				$Montos:=$Montos+ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";$ptr3->;->$vr_monto;->$vt_moneda)
			Else 
				$Montos:=$Montos+$vr_monto
			End if 
			
			If ($Montos<=$vr_montoPago)
				APPEND TO ARRAY:C911($alACT_RecNumsCargos;alACT_RecNumsCargos{$i})
				If (Find in array:C230($al_idsAvisos;alACT_CIdsAvisos{$i})=-1)
					APPEND TO ARRAY:C911($al_idsAvisos;alACT_CIdsAvisos{$i})
				End if 
			Else 
				If ((($vr_montoPago-$Montos)<=($vr_diferenciaMaxima*Size of array:C274($al_idsAvisos))) & (($vr_montoPago-$Montos)>=(-$vr_diferenciaMaxima*Size of array:C274($al_idsAvisos))))
					APPEND TO ARRAY:C911($alACT_RecNumsCargos;alACT_RecNumsCargos{$i})
					If (Find in array:C230($al_idsAvisos;alACT_CIdsAvisos{$i})=-1)
						APPEND TO ARRAY:C911($al_idsAvisos;alACT_CIdsAvisos{$i})
					End if 
				End if 
				$i:=Size of array:C274(alACT_RecNumsCargos)
			End if 
		End for 
		
		$montoAviso:=0
		For ($i;1;Size of array:C274($al_idsAvisos))
			ARRAY LONGINT:C221($al_recNum2Process;0)
			$vl_idAviso:=$al_idsAvisos{$i}
			alACT_CIdsAvisos{0}:=$vl_idAviso
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alACT_CIdsAvisos;"=";->$DA_Return)
			For ($j;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($al_recNum2Process;alACT_RecNumsCargos{$DA_Return{$j}})
			End for 
			$montoRedondeado:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNum2Process;->[ACT_Cargos:173]Saldo:23;$ptr3->))
			$montoAPagar:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromRecNumArrayMCobro";->$al_recNum2Process;->[ACT_Cargos:173]Saldo:23;$ptr3->))
			$montoAviso:=$montoAviso+Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAviso";->$vl_idAviso;->[ACT_Cargos:173]Saldo:23;$ptr3->))
			$vr_monto:=0
			
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_recNum2Process)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_Apoderado:18;$al_idApdo;[ACT_Cargos:173]Fecha_de_Vencimiento:7;$ad_vencimiento)
			AT_DistinctsArrayValues (->$al_idApdo)
			AT_DistinctsArrayValues (->$ad_vencimiento)
			SORT ARRAY:C229($al_idApdo;>)
			SORT ARRAY:C229($ad_vencimiento;>)
			
			If ((($montoAviso-$montoAPagar)<=$vr_diferenciaMaxima) & (($montoAviso-$montoAPagar)>=-$vr_diferenciaMaxima))
				If ($montoAviso<=$vr_montoPago)
					$continuar:=False:C215
					$vr_monto:=$montoAPagar-$montoRedondeado  //si paga de más se crea un cargo. Si paga menos de lo que debe se hace un descuento
					If ($vr_monto#0)
						$continuar:=True:C214
						If ($vr_monto>0)
							ACTcfg_LoadCargosEspeciales (6)
						Else 
							ACTcfg_LoadCargosEspeciales (5)
						End if 
						$vr_monto:=Abs:C99($vr_monto)
					End if 
					If ($continuar)
						KRL_GotoRecord (->[ACT_Cargos:173];alACT_RecNumsCargos{1})
						$enBoleta:=[ACT_Cargos:173]No_Incluir_en_DocTrib:50
						$vl_idApdo:=$al_idApdo{Size of array:C274($al_idApdo)}
						$vd_vencimiento:=$ad_vencimiento{Size of array:C274($ad_vencimiento)}
						$recNumCargo:=ACTpgs_CreaCargo (False:C215;$vl_idApdo;$vr_monto;vl_idIE;True:C214;$vd_vencimiento;$enBoleta)
						If ($recNumCargo#-1)
							ACTpgs_AppendCarToArray ($vl_rNCargo)
						End if 
					End if 
				End if 
			End if 
		End for 
End case 