//%attributes = {}
  //ACTmnu_RecalcSaldosAvisosOnServ

ARRAY LONGINT:C221($al_idsAvisos;0)

  //****DECLARACIONES****
ARRAY LONGINT:C221($al_recNumsAvisos;0)
C_DATE:C307(vd_fecha)
C_LONGINT:C283($vencidos)
C_BOOLEAN:C305($InProcess)
ARRAY LONGINT:C221(al_recNumsAvisos;0)
C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
C_LONGINT:C283($vl_num;$vl_numAvisoCalc)
C_TEXT:C284($ProcName)
C_REAL:C285($ProcState;$ProcTime)
C_REAL:C285($saldoAcumulado;$saldoInteresesAcumulado;$saldoCargosAcumulado)
C_BOOLEAN:C305($vb_noRecalcularCtas)
ARRAY TEXT:C222($atACT_uuid;0)  //20160407 RCH Se quita arreglo con recNum
C_LONGINT:C283($l_indice;$l_fif)
vd_fecha:=!00-00-00!

$0:=True:C214
xBlob:=$1
  //BLOB_Blob2Vars (->xBlob;0;->al_recNumsAvisos;->vd_fecha;->$vb_noRecalcularCtas)
BLOB_Blob2Vars (->xBlob;0;->$atACT_uuid;->vd_fecha;->$vb_noRecalcularCtas)


  //****CUERPO****

If (Application type:C494=4D Remote mode:K5:5)
	
	  //20120326 RCH Se mostrara un thermo cuando se recalculen muchos avisos
	C_LONGINT:C283($vlACT_pctProgreso)
	C_BOOLEAN:C305($vb_showThermo)
	$vb_showThermo:=(Records in selection:C76([ACT_Avisos_de_Cobranza:124])>75)
	
	$pID:=Execute on server:C373(Current method name:C684;Pila_256K;"Recalculo de avisos de cobranza";xBlob)
	PROCESS PROPERTIES:C336(Current process:C322;$ProcName;$ProcState;$ProcTime)
	If ($ProcName#"Batch Tasks Processor")
		$uThermPID:=IT_UThermometer (1;0;__ ("Recalculando avisos de cobranza..."))
		If ($vb_showThermo)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando avisos de cobranza..."))
		End if 
	End if 
	DELAY PROCESS:C323(Current process:C322;60)
	$InProcess:=True:C214
	While ($InProcess)
		If ($vb_showThermo)
			GET PROCESS VARIABLE:C371($pID;<>vlACT_pctProgreso;$vlACT_pctProgreso)
			If ($vlACT_pctProgreso>0)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vlACT_pctProgreso)
			End if 
		End if 
		DELAY PROCESS:C323(Current process:C322;15)
		$InProcess:=Test semaphore:C652("ACInProcess")
	End while 
	If ($ProcName#"Batch Tasks Processor")
		If ($vb_showThermo)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		IT_UThermometer (-2;$uThermPID)
	End if 
Else 
	$semaphoreSet:=Semaphore:C143("ACInProcess")
	If (Not:C34($vb_noRecalcularCtas))
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
	End if 
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
	
	ARRAY LONGINT:C221($al_recNumsAvisos;0)
	
	For ($l_indice;1;Size of array:C274($atACT_uuid))
		$l_fif:=Find in field:C653([ACT_Avisos_de_Cobranza:124]Auto_UUID:32;$atACT_uuid{$l_indice})
		If ($l_fif#-1)
			APPEND TO ARRAY:C911($al_recNumsAvisos;$l_fif)
		End if 
	End for 
	
	  //CREATE SELECTION FROM ARRAY([ACT_Avisos_de_Cobranza];al_recNumsAvisos)
	CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$al_recNumsAvisos)
	$saldo:=0
	$intereses:=0
	$saldoIntereses:=0
	$saldoCargos:=0
	ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
	ACTcfg_LeeBlob ("ACTcfg_MonedasYTasas")
	ARRAY LONGINT:C221(alACT_ApdosAlumnos;0)
	ARRAY LONGINT:C221($alACT_idTerceros;0)
	C_POINTER:C301($fieldAvisos)
	
	ACT_LeeMoneda   //20160509 RCH
	
	C_LONGINT:C283(<>vlACT_pctProgreso)
	<>vlACT_pctProgreso:=0
	
	AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26;->$alACT_idTerceros)
	Case of 
		: (bAvisoApoderado=1)
			AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->alACT_ApdosAlumnos;1)
			$fieldAvisos:=->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
		: (bAvisoAlumno=1)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"ACT_Avisos2Recalc")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;->alACT_ApdosAlumnos;1)
				$fieldAvisos:=->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2
			Else 
				USE SET:C118("ACT_Avisos2Recalc")
				AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->alACT_ApdosAlumnos;1)
				$fieldAvisos:=->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
			End if 
			CLEAR SET:C117("ACT_Avisos2Recalc")
	End case 
	alACT_ApdosAlumnos{0}:=0
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->alACT_ApdosAlumnos;"=";->$DA_Return)
	For ($i;Size of array:C274($DA_Return);1;-1)
		AT_Delete ($DA_Return{$i};1;->alACT_ApdosAlumnos)
	End for 
	$alACT_idTerceros{0}:=0
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->$alACT_idTerceros;"=";->$DA_Return)
	For ($i;Size of array:C274($DA_Return);1;-1)
		AT_Delete ($DA_Return{$i};1;->$alACT_idTerceros)
	End for 
	
	ARRAY TEXT:C222($atACT_tipoResponsable;Size of array:C274(alACT_ApdosAlumnos))
	For ($i;1;Size of array:C274($alACT_idTerceros))
		APPEND TO ARRAY:C911(alACT_ApdosAlumnos;$alACT_idTerceros{$i})
		APPEND TO ARRAY:C911($atACT_tipoResponsable;"Terceros")
	End for 
	
	C_LONGINT:C283($vl_noTotalAvisos;$vl_noAvisosAcumulado)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_noTotalAvisos)
	QUERY WITH ARRAY:C644($fieldAvisos->;alACT_ApdosAlumnos)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	  //If (Size of array(alACT_ApdosAlumnos)>5)
	  //$procid:=0
	  //CD_THERMOMETREXSEC (1;0;"Recalculando saldos de avisos de cobranza...")
	  //Else 
	  //$procid:=IT_UThermometer (1;0;"Recalculando saldos de avisos de cobranza...")
	  //End if 
	For ($j;1;Size of array:C274(alACT_ApdosAlumnos))
		  //20180506 RCH Se inicializan variables. Ticket 205998
		$saldoAcumulado:=0
		$saldoInteresesAcumulado:=0
		$saldoCargosAcumulado:=0
		ARRAY LONGINT:C221($al_idsAvisos;0)
		If ($atACT_tipoResponsable{$j}="")
			QUERY:C277([ACT_Avisos_de_Cobranza:124];$fieldAvisos->=alACT_ApdosAlumnos{$j};*)
			QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=0)
		Else 
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=alACT_ApdosAlumnos{$j})
		End if 
		$vl_noAvisosAcumulado:=$vl_noAvisosAcumulado+Records in selection:C76([ACT_Avisos_de_Cobranza:124])
		If (Not:C34($vb_noRecalcularCtas))
			ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		End if 
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];$fieldAvisos->;>;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
		If (cb_CalcularParaTodosLosAvisos=0)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_num)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<vd_fecha)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$vl_numAvisoCalc:=$vl_num+1
		End if 
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"ac2rec")
		FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
		$continuar:=True:C214
		While ((Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))) & ($continuar))
			If ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
				$continuar:=False:C215
			Else 
				REMOVE FROM SET:C561([ACT_Avisos_de_Cobranza:124];"ac2rec")
				If ($vl_numAvisoCalc#0)
					$vl_numAvisoCalc:=$vl_numAvisoCalc-1
				End if 
			End if 
			NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
		End while 
		USE SET:C118("ac2rec")
		CLEAR SET:C117("ac2rec")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];$fieldAvisos->;>;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumsAvisos;"")
		For ($i;1;Size of array:C274($al_recNumsAvisos))
			ACTac_Recalcular ($al_recNumsAvisos{$i};vd_fecha)
			KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$al_recNumsAvisos{$i};True:C214)
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				$set:="cargos2Recalc"
				CREATE SET:C116([ACT_Cargos:173];$set)
				
				If ($i=1)
					[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=0
					[ACT_Avisos_de_Cobranza:124]Intereses_Anteriores:21:=0
					[ACT_Avisos_de_Cobranza:124]Cargos_Anteriores:22:=0
				Else 
					If (cb_IncluirSaldosAnteriores=1)
						  //20120327 RCH Cuando no se tiene marcada la opcion calcular para todos, solo se calcula el saldo anterior
						  //...en los avisos que estan vencidos...
						  //20120426 ASM Se realizan modificaciones en el calculo en los saldos de los avisos vencidos.
						$vb_continuar:=True:C214
						If ((cb_CalcularParaTodosLosAvisos=0) & ([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5>=vd_fecha))
							  //$vb_continuar:=False
							  //[ACT_Avisos_de_Cobranza]Saldo_anterior:=0
							  //[ACT_Avisos_de_Cobranza]Intereses_Anteriores:=0
							  //[ACT_Avisos_de_Cobranza]Cargos_Anteriores:=0
							If ($saldoAcumulado=0) & ($i>2)
								$vb_continuar:=False:C215
								[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=0
								[ACT_Avisos_de_Cobranza:124]Intereses_Anteriores:21:=0
								[ACT_Avisos_de_Cobranza:124]Cargos_Anteriores:22:=0
							Else 
								$vb_continuar:=True:C214
							End if 
						End if 
						If ($vb_continuar)
							If ($vl_numAvisoCalc=0) | ($i<=$vl_numAvisoCalc)
								If ([ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24)
									$saldo:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMEmsion";->$al_idsAvisos;->[ACT_Cargos:173]Saldo:23;vd_fecha))
									$saldoIntereses:=ACTcar_CalculaMontos ("calcMontoInteresesFromArrNumAvisoMEmsion";->$al_idsAvisos;->[ACT_Cargos:173]Saldo:23;vd_fecha)*-1
								Else 
									$saldo:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMPago";->$al_idsAvisos;->[ACT_Cargos:173]Saldo:23;vd_fecha))
									$saldoIntereses:=ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMPago";->$al_idsAvisos;->[ACT_Cargos:173]Saldo:23;vd_fecha)*-1
								End if 
								$saldoCargos:=$saldo-$saldoIntereses
								If ($saldo>0)
									$saldoAcumulado:=$saldo
									$saldoInteresesAcumulado:=$saldoIntereses
									$saldoCargosAcumulado:=$saldoCargos
								End if 
								
								[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=$saldoAcumulado
								[ACT_Avisos_de_Cobranza:124]Intereses_Anteriores:21:=$saldoInteresesAcumulado
								[ACT_Avisos_de_Cobranza:124]Cargos_Anteriores:22:=$saldoCargosAcumulado
							Else 
								$saldo:=0
								$saldoIntereses:=0
								[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=$saldoAcumulado
								[ACT_Avisos_de_Cobranza:124]Intereses_Anteriores:21:=$saldoInteresesAcumulado
								[ACT_Avisos_de_Cobranza:124]Cargos_Anteriores:22:=$saldoCargosAcumulado
							End if 
							  //$saldoCargos:=$saldo-$saldoIntereses
							  //[ACT_Avisos_de_Cobranza]Saldo_anterior:=$saldo
							  //[ACT_Avisos_de_Cobranza]Intereses_Anteriores:=$saldoIntereses
							  //[ACT_Avisos_de_Cobranza]Cargos_Anteriores:=$saldoCargos
						End if 
					Else 
						[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=0
						[ACT_Avisos_de_Cobranza:124]Intereses_Anteriores:21:=0
						[ACT_Avisos_de_Cobranza:124]Cargos_Anteriores:22:=0
					End if 
					If ([ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24)
						If (ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vd_fecha;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;->[ACT_Avisos_de_Cobranza:124]Moneda:17)<Num:C11(ACTcar_OpcionesGenerales ("pagoMinimo")))
							[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=0
						End if 
					End if 
					[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14+[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12
				End if 
				APPEND TO ARRAY:C911($al_idsAvisos;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
				If (cb_IncluirSaldosAnteriores=1)
					[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMPago";->$al_idsAvisos;->[ACT_Cargos:173]Saldo:23;vd_fecha))
				End if 
				SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
				CLEAR SET:C117($set)
			End if 
			KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
		End for 
		  //If ($procid=0)
		  //CD_THERMOMETREXSEC (0;$vl_noAvisosAcumulado/$vl_noTotalAvisos*100;"Recalculando saldos de avisos de cobranza...")
		  //End if 
		
		<>vlACT_pctProgreso:=$vl_noAvisosAcumulado/$vl_noTotalAvisos*100
		
	End for 
	If (Not:C34($vb_noRecalcularCtas))
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtasBash")
	End if 
	  //If ($procid=0)
	  //CD_THERMOMETREXSEC (-1)
	  //Else 
	  //IT_UThermometer (-2;$procid)
	  //End if 
	For ($j;1;Size of array:C274($alACT_idTerceros))
		$done:=ACTter_ActualizaValores ($alACT_idTerceros{$j})
		If (Not:C34($done))
			BM_CreateRequest ("ACTter_ActualizaValores";String:C10($alACT_idTerceros{$j});String:C10($alACT_idTerceros{$j}))
		End if 
	End for 
	
	AT_Initialize (->alACT_ApdosAlumnos)
	CLEAR SEMAPHORE:C144("ACInProcess")
	<>vlACT_pctProgreso:=0
End if 