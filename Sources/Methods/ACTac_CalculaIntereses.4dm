//%attributes = {}
  //ACTac_CalculaIntereses

C_BOOLEAN:C305(vb_interesBorrado)
  //20120629 RCH
C_LONGINT:C283(vlACT_idACIntereses)
ACTcfg_LoadConfigData (1)
ACTcfg_ItemsMatricula ("InicializaYLee")
$0:=True:C214
$idAviso:=0
vlACT_idACIntereses:=0
Case of 
	: (Count parameters:C259=1)
		$idAviso:=$1
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$idAviso)
		$display:=False:C215
		$fecha:=Current date:C33(*)
	: (Count parameters:C259=2)
		If ($1#0)
			$idAviso:=$1
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$idAviso)
		End if 
		$display:=$2
		$fecha:=Current date:C33(*)
	: (Count parameters:C259=3)
		If ($1#0)
			$idAviso:=$1
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$idAviso)
		End if 
		$display:=$2
		$fecha:=$3
	Else 
		$display:=True:C214
		$fecha:=Current date:C33(*)
End case 
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0;*)
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<Current date:C33(*))
If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	
	  //20120629 RCH
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
	
	
	$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];$set)
	ARRAY LONGINT:C221($RNAvisos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$RNAvisos;"")
	If ($display)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando intereses por atraso..."))
	End if 
	ACTcc_OpcionesCalculoCtaCte ("InitArraysAndAgregarElemento";->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	For ($i;1;Size of array:C274($RNAvisos))
		READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$RNAvisos{$i})
		If (Not:C34(Locked:C147([ACT_Avisos_de_Cobranza:124])))
			READ ONLY:C145([xxACT_Items:179])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ WRITE:C146([ACT_Cargos:173])
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-100;*)
			  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0;*)
			  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]LastInterestsUpdate<$fecha)
			  //ARRAY LONGINT($aRNCargos;0)
			  //LONGINT ARRAY FROM SELECTION([ACT_Cargos];$aRNCargos;"")
			
			ARRAY LONGINT:C221($aRNCargos;0)
			ARRAY LONGINT:C221($alACT_idsCargos;0)
			ARRAY LONGINT:C221($alACT_refItems;0)
			ARRAY REAL:C219($arACT_saldos;0)
			ARRAY DATE:C224($adACT_fechas;0)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRNCargos;[ACT_Cargos:173]ID:1;$alACT_idsCargos;[ACT_Cargos:173]Ref_Item:16;$alACT_refItems;[ACT_Cargos:173]Saldo:23;$arACT_saldos;[ACT_Cargos:173]LastInterestsUpdate:42;$adACT_fechas)
			For ($x;Size of array:C274($aRNCargos);1;-1)
				$idCargo:=$alACT_idsCargos{$x}
				If (($alACT_refItems{$x}#-100) & ($arACT_saldos{$x}#0) & ($adACT_fechas{$x}<$fecha))
					  //se calcula interes...
				Else 
					If ($alACT_refItems{$x}#-100)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$idCargo;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=-100)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If ($vl_records=0)
							AT_Delete ($x;1;->$aRNCargos)
						End if 
					Else 
						AT_Delete ($x;1;->$aRNCargos)
					End if 
				End if 
			End for 
			
			For ($g;1;Size of array:C274($aRNCargos))
				READ WRITE:C146([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];$aRNCargos{$g})
				  //If ($fecha>[ACT_Cargos]LastInterestsUpdate)
				If (($fecha>[ACT_Cargos:173]LastInterestsUpdate:42) & ($fecha>[ACT_Cargos:173]Fecha_de_Vencimiento:7))  //20140825 RCH Intereses
					$daysSinceLast:=$fecha-[ACT_Cargos:173]LastInterestsUpdate:42
					[ACT_Cargos:173]LastInterestsUpdate:42:=$fecha
					SAVE RECORD:C53([ACT_Cargos:173])
				Else 
					$daysSinceLast:=0
				End if 
				  //$ctaAfecta:=[ACT_CuentasCorrientes]AfectoIntereses
				If ([ACT_Cargos:173]ID_CuentaCorriente:2#0)  //para el caso de los cargos asociados solo al tercero
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
					$ctaAfecta:=[ACT_CuentasCorrientes:175]AfectoIntereses:28
				Else 
					$ctaAfecta:=True:C214
				End if 
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
				If (Records in selection:C76([xxACT_Items:179])=1)
					$afectoInt:=[xxACT_Items:179]AfectoInteres:26
					$tipo:=[xxACT_Items:179]TipoInteres:29
					$go:=True:C214
					If ($daysSinceLast>0)
						If (($afectoInt) & ($ctaAfecta))
							$tasaMensual:=[xxACT_Items:179]TasaInteresMensual:25/100
							$months:=$daysSinceLast/30
						Else 
							$go:=False:C215
						End if 
					Else 
						$go:=False:C215
					End if 
					If ($go)
						If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
							$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28))
							$vt_moneda:=[ACT_Cargos:173]Moneda:28
						Else 
							$vl_decimales:=<>vlACT_Decimales
							$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
						End if 
						$idCargo:=[ACT_Cargos:173]ID:1
						$lastIntUpdate:=[ACT_Cargos:173]LastInterestsUpdate:42
						
						C_DATE:C307($d_fechaCalculo)
						If (<>b_usarFechaVencimiento=1)
							$d_fechaCalculo:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
						Else 
							$d_fechaCalculo:=$fecha
						End if 
						
						If ($tipo)  //verdadero corresponde a interes simple
							
							  //20161011 RCH Se buscan los cargos asociados no intereses.
							  //$saldo:=[ACT_Cargos]Saldo*-1
							  //$intereses:=Round($saldo*$months*$tasaMensual;$vl_decimales)
							
							PUSH RECORD:C176([ACT_Cargos:173])
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$idCargo;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-100)
							$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$fecha)
							$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;ST_GetWord (ACT_DivisaPais ;1;";");$fecha;$vt_moneda)
							POP RECORD:C177([ACT_Cargos:173])
							$saldo:=([ACT_Cargos:173]Saldo:23+$vr_montoMoneda)*-1
							$intereses:=Round:C94($saldo*$months*$tasaMensual;$vl_decimales)
							
						Else 
							PUSH RECORD:C176([ACT_Cargos:173])
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$idCargo;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
							
							  //20161011 RCH Se comenta línea siguiente porque ahora se puede usar cualquier cargo para descuentos
							  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0;*)
							  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item<0)  //para incluir todos los cargos relacionados...
							
							  //$porInt:=Sum([ACT_Cargos]Saldo)
							  //POP RECORD([ACT_Cargos])
							  //$saldo:=([ACT_Cargos]Saldo+$porInt)*-1
							
							  //$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;$fecha)
							  //$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;ST_GetWord (ACT_DivisaPais ;1;";");$fecha;$vt_moneda)
							
							$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$d_fechaCalculo)
							$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;ST_GetWord (ACT_DivisaPais ;1;";");$d_fechaCalculo;$vt_moneda)
							POP RECORD:C177([ACT_Cargos:173])
							$saldo:=([ACT_Cargos:173]Saldo:23+$vr_montoMoneda)*-1
							$intereses:=Round:C94($saldo*(((1+$tasaMensual)^$months)-1);$vl_decimales)
							
						End if 
						  //$intereses:=ACTut_retornaMontoEnMoneda ($intereses;$vt_moneda;$fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
						
						$intereses:=ACTut_retornaMontoEnMoneda ($intereses;$vt_moneda;$d_fechaCalculo;ST_GetWord (ACT_DivisaPais ;1;";"))
						
						ACTac_CreateCargoDocCargo4Int ($idCargo;$lastIntUpdate;$intereses)
					End if 
				End if 
			End for 
		Else 
			BM_CreateRequest ("ACTac_CalculaInteres";String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1))
		End if 
		If ($display)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($RNAvisos);__ ("Calculando intereses por atraso..."))
		End if 
	End for 
	ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
	If ($display)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	USE SET:C118($set)
	ARRAY LONGINT:C221($al_idsAvisos2Recalc;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_idsAvisos2Recalc)
	ACTmnu_RecalcularSaldosAvisos (->$al_idsAvisos2Recalc;$fecha)
	SET_ClearSets ($set)
	
	  //20120629 RCH
	vlACT_idACIntereses:=0
End if 