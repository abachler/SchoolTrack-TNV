//%attributes = {}
  //ACTcfg_OpcionesEliminacionDctos

C_TEXT:C284($vt_accion;$1;$0;$vt_retorno;$vt_ref)
C_DATE:C307($vd_fecha;$vd_fechaFiltro)
C_BOOLEAN:C305($vb_filtraXVencimiento)
C_REAL:C285($vr_monto)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3;$vy_pointer4;$vy_pointer5)
C_LONGINT:C283($vl_records;$vl_idCargo;$vl_idApdo)
C_BOOLEAN:C305($vb_obtenerDctoDelArreglo)
C_REAL:C285($vr_tipoDcto)

$vt_accion:=$1

If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
If (Count parameters:C259>=5)
	$vy_pointer4:=$5
End if 
If (Count parameters:C259>=6)
	$vy_pointer5:=$6
End if 
Case of 
	: ($vt_accion="VerificaEliminacionDctosInicio")
		READ ONLY:C145([xxACT_Items:179])
		SET QUERY LIMIT:C395(1)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Eliminar_descuentos_al_venc:39=True:C214)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(0)
		If ($vl_records>0)
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Eliminar_descuentos_al_venc:39=True:C214)
			If (Not:C34(Is nil pointer:C315($vy_pointer1)))
				SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$vy_pointer1->)
				
				For ($i;Size of array:C274($vy_pointer1->);1;-1)
					$vb_obtenerDctoDelArreglo:=False:C215
					$vl_idItem:=$vy_pointer1->{$i}
					$vr_suma:=Num:C11(ACTcfg_OpcionesEliminacionDctos ("ObtieneSumaDescuentosXItem";->$vl_idItem;->$vb_obtenerDctoDelArreglo))
					If ($vr_suma=0)
						$vr_suma:=Num:C11(ACTcfg_OpcionesEliminacionDctos ("ObtieneDescuentosXCta";->$vl_idItem))
						If ($vr_suma=0)
							AT_Delete ($i;1;$vy_pointer1)
						End if 
					End if 
				End for 
				
			End if 
		End if 
		$vt_retorno:=String:C10($vl_records)
		
	: ($vt_accion="ObtieneDescuentosXCta")
		C_LONGINT:C283($vl_records)
		ARRAY LONGINT:C221($alACT_idsCtasCtes;0)
		
		$vl_idItem:=$vy_pointer1->
		$vb_afectoDctos:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vl_idItem;->[xxACT_Items:179]AfectoDsctoIndividual:17)
		If ($vb_afectoDctos)
			  // Modificado por: Saúl Ponce (25-09-2018)  Ticket Nº 216418, para almacenar el valor en el check de eliminación de dctos aunque no existan cargos generados.
			  //READ ONLY([ACT_Cargos])
			  //READ ONLY([ACT_CuentasCorrientes])
			  //QUERY([ACT_Cargos];[ACT_Cargos]Ref_Item=$vl_idItem)
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Año>=<>gYear)
			  //DISTINCT VALUES([ACT_Cargos]ID_CuentaCorriente;$alACT_idsCtasCtes)
			  //QUERY WITH ARRAY([ACT_CuentasCorrientes]ID;$alACT_idsCtasCtes)
			  //QUERY SELECTION([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]Descuento#0)
			  //If (Records in selection([ACT_CuentasCorrientes])>0)
			  //$vt_retorno:="1"
			  //Else 
			  //$vt_retorno:="0"
			  //End if 
			$vt_retorno:="1"
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="ObtieneSumaDescuentosXItem")
		  //si el ítem no tiene configurado descuentos, no se buscan los cargos
		ACTdesc_OpcionesVariables ("DeclaraVars")
		
		C_LONGINT:C283($vl_idItem)
		ARRAY TEXT:C222($atACT_vars;0)
		APPEND TO ARRAY:C911($atACT_vars;"vr_Hijo")
		APPEND TO ARRAY:C911($atACT_vars;"vr_Familia")
		
		$vl_idItem:=$vy_pointer1->
		$vb_obtenerDctoDelArreglo:=$vy_pointer2->
		
		$vr_suma:=0
		If ($vb_obtenerDctoDelArreglo)
			$vr_suma:=$vr_suma+AT_GetSumArray (->arACT_DesctoPorHijo)
			$vr_suma:=$vr_suma+AT_GetSumArray (->arACT_DesctoPorFamilia)
			  //$vr_suma:=$vr_suma+AT_GetSumArray (->arACT_DesctoTramo)
		Else 
			ACTdesc_OpcionesVariables ("LeeConfItem";->$vl_idItem)
			For ($j;1;Size of array:C274($atACT_vars))
				$vt_text:=$atACT_vars{$j}
				For ($r;2;17)
					$vy_ptr:=Get pointer:C304($vt_text+String:C10($r))
					$vr_suma:=$vr_suma+$vy_ptr->
				End for 
			End for 
		End if 
		
		$vt_retorno:=String:C10($vr_suma)
		
	: ($vt_accion="VerificaEliminacionDctosEmisionAC")
		  //$vl_time:=IT_StartTimer 
		ARRAY LONGINT:C221($alACT_idsItemsDelDctos;0)
		ARRAY LONGINT:C221(al_RecNumsCargos;0)  //utilizados al ingresar pagos
		ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)  //utilizados al ingresar pagos
		
		$vd_fecha:=$vy_pointer2->
		If (ACTcfg_OpcionesEliminacionDctos ("VerificaEliminacionDctosInicio";->$alACT_idsItemsDelDctos)="1")
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Cargos:173])
			CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$vy_pointer1->;"")
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItemsDelDctos)
			If (Records in selection:C76([ACT_Cargos:173])>0)
				$vb_filtraXVencimiento:=True:C214
				ACTcfg_OpcionesEliminacionDctos ("EliminacionDctos";->$vd_fecha;->$vb_filtraXVencimiento)
			End if 
		End if 
		  //IT_StopTimer ($vl_time)
		  //ACTcc_EmisionAvisos
		
	: ($vt_accion="VerificaEliminacionDctosFinDeDia")
		  //$vl_time:=IT_StartTimer 
		ARRAY LONGINT:C221($alACT_idsItemsDelDctos;0)
		ARRAY LONGINT:C221(al_RecNumsCargos;0)  //utilizados al ingresar pagos
		ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)  //utilizados al ingresar pagos
		
		$vd_fecha:=$vy_pointer1->
		
		$vd_fechaFiltro:=Add to date:C393(Current date:C33(*);-2;0;0)
		If (ACTcfg_OpcionesEliminacionDctos ("VerificaEliminacionDctosInicio";->$alACT_idsItemsDelDctos)="1")
			READ ONLY:C145([ACT_Cargos:173])
			QUERY WITH ARRAY:C644([ACT_Cargos:173]Ref_Item:16;$alACT_idsItemsDelDctos)
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaFiltro)  // se filtran cargos de hasta 2 años hacia atras
			If (Records in selection:C76([ACT_Cargos:173])>0)
				$vb_filtraXVencimiento:=True:C214
				ACTcfg_OpcionesEliminacionDctos ("EliminacionDctos";->$vd_fecha;->$vb_filtraXVencimiento)
			End if 
		End if 
		  //IT_StopTimer ($vl_time)
		  //dhBM_EndOfTheDayTasks
		
	: ($vt_accion="VerificaEliminacionDctosIngresoDePagos")
		  //$vl_time:=IT_StartTimer 
		ARRAY LONGINT:C221($alACT_idsItemsDelDctos;0)
		$vd_fecha:=$vy_pointer1->
		
		If (ACTcfg_OpcionesEliminacionDctos ("VerificaEliminacionDctosInicio";->$alACT_idsItemsDelDctos)="1")
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];al_RecNumsCargos;"")
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItemsDelDctos)
			If (Records in selection:C76([ACT_Cargos:173])>0)
				$vb_filtraXVencimiento:=False:C215
				ACTcfg_OpcionesEliminacionDctos ("EliminacionDctos";->$vd_fecha;->$vb_filtraXVencimiento)
			End if 
		End if 
		  //IT_StopTimer ($vl_time)
		  //ACTpgs_CargaAvisosDeuda
		
	: ($vt_accion="EliminacionDctos")
		ARRAY LONGINT:C221($alACT_idsItemsDelDctos;0)
		C_BOOLEAN:C305($vb_thermo)
		
		$vd_fecha:=$vy_pointer1->
		$vb_filtraXVencimiento:=$vy_pointer2->
		
		$vd_fechaFiltro:=Add to date:C393(Current date:C33(*);-2;0;0)
		
		If (ACTcfg_OpcionesEliminacionDctos ("VerificaEliminacionDctosInicio")="1")
			DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$alACT_idsItemsDelDctos)  //aca deberiamos llegar siempre con los cargos filtrados
			C_LONGINT:C283($i;$vl_proc)
			ARRAY LONGINT:C221($alACT_idsAvisos2Recalc;0)
			  //$vl_proc:=IT_UThermometer (1;0;__ ("Verificando descuentos..."))
			
			CREATE SET:C116([ACT_Cargos:173];"setCargosInicio")
			For ($i;1;Size of array:C274($alACT_idsItemsDelDctos))
				USE SET:C118("setCargosInicio")
				
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$alACT_idsItemsDelDctos{$i};*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
				
				$vb_thermo:=False:C215
				If (Records in selection:C76([ACT_Cargos:173])>100)
					$vb_thermo:=True:C214
					$vl_proc:=IT_UThermometer (1;0;__ ("Verificando descuentos para "+KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$alACT_idsItemsDelDctos{$i};->[xxACT_Items:179]Glosa:2)+"..."))
				End if 
				
				CREATE SET:C116([ACT_Cargos:173];"setCargosProcesados")
				DIFFERENCE:C122("setCargosInicio";"setCargosProcesados";"setCargosInicio")
				SET_ClearSets ("setCargosProcesados")
				  //para filtrar que en las tareas de fdd no se busquen muchos cargos. Se valida si el cargo corresponde o no al ingresar un pago
				If ($vb_filtraXVencimiento)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7<$vd_fecha)
				End if 
				
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaFiltro)  // se filtran cargos de hasta 2 años hacia atras
				
				ARRAY LONGINT:C221($alACT_idCargos;0)
				ARRAY DATE:C224($adACT_fechaVencimiento;0)
				ARRAY REAL:C219($arACT_descuentoFamilia;0)
				ARRAY REAL:C219($arACT_descuentoCargas;0)
				ARRAY REAL:C219($arACT_descuentoIndividual;0)
				
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idCargos;[ACT_Cargos:173]Fecha_de_Vencimiento:7;$adACT_fechaVencimiento;[ACT_Cargos:173]Descuentos_Familia:26;$arACT_descuentoFamilia;[ACT_Cargos:173]Descuentos_Cargas:51;$arACT_descuentoCargas;[ACT_Cargos:173]Descuentos_Individual:31;$arACT_descuentoIndividual)
				
				For ($j;1;Size of array:C274($alACT_idCargos))
					$vl_idCargo:=$alACT_idCargos{$j}
					If ($vd_fecha>$adACT_fechaVencimiento{$j})
						$vb_descuentosMismaLinea:=False:C215
						
						If ($arACT_descuentoIndividual{$j}>0)
							$vr_tipoDcto:=-130
							$vb_descuentosMismaLinea:=True:C214
							ACTcfg_OpcionesEliminacionDctos ("GeneraCargo";->$vl_idCargo;->$arACT_descuentoIndividual{$j};->$vd_fecha;->$alACT_idsAvisos2Recalc;->$vr_tipoDcto)
						End if 
						If ($arACT_descuentoFamilia{$j}>0)
							$vr_tipoDcto:=-131
							ACTcfg_OpcionesEliminacionDctos ("GeneraCargo";->$vl_idCargo;->$arACT_descuentoFamilia{$j};->$vd_fecha;->$alACT_idsAvisos2Recalc;->$vr_tipoDcto)
							$vb_descuentosMismaLinea:=True:C214
						End if 
						If ($arACT_descuentoCargas{$j}>0)
							$vr_tipoDcto:=-132
							ACTcfg_OpcionesEliminacionDctos ("GeneraCargo";->$vl_idCargo;->$arACT_descuentoCargas{$j};->$vd_fecha;->$alACT_idsAvisos2Recalc;->$vr_tipoDcto)
							$vb_descuentosMismaLinea:=True:C214
						End if 
						
						If (Not:C34($vb_descuentosMismaLinea))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargo)
							If (Records in selection:C76([ACT_Cargos:173])>0)
								CREATE SET:C116([ACT_Cargos:173];"setCargos1")
								$vr_tipoDcto:=-130
								USE SET:C118("setCargos1")
								  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item=$vr_tipoDcto)  //descuento por cuenta
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]id_DescuentoIndividual:68#0)  //descuento individual
								If (Records in selection:C76([ACT_Cargos:173])>0)
									ARRAY LONGINT:C221($alACT_CargosID;0)
									ARRAY REAL:C219($arACT_cargoMontoNeto;0)
									ARRAY LONGINT:C221($alACT_tipoDescuento;0)
									
									SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_CargosID;[ACT_Cargos:173]Monto_Neto:5;$arACT_cargoMontoNeto;[ACT_Cargos:173]Ref_Item:16;$alACT_tipoDescuento)
									For ($l_indice;1;Size of array:C274($alACT_CargosID))
										ACTcfg_OpcionesEliminacionDctos ("GeneraCargo";->$alACT_CargosID{$l_indice};->$arACT_cargoMontoNeto{$l_indice};->$vd_fecha;->$alACT_idsAvisos2Recalc;->$alACT_tipoDescuento{$l_indice})
									End for 
									  //$vl_idCargo:=[ACT_Cargos]ID
									  //ACTcfg_OpcionesEliminacionDctos ("GeneraCargo";->$vl_idCargo;->[ACT_Cargos]Monto_Neto;->$vd_fecha;->$alACT_idsAvisos2Recalc;->$vr_tipoDcto)
								End if 
								
								$vr_tipoDcto:=-131
								USE SET:C118("setCargos1")
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$vr_tipoDcto)  // descuento por número de hijo
								If (Records in selection:C76([ACT_Cargos:173])=1)
									$vl_idCargo:=[ACT_Cargos:173]ID:1
									ACTcfg_OpcionesEliminacionDctos ("GeneraCargo";->$vl_idCargo;->[ACT_Cargos:173]Monto_Neto:5;->$vd_fecha;->$alACT_idsAvisos2Recalc;->$vr_tipoDcto)
								End if 
								
								$vr_tipoDcto:=-132
								USE SET:C118("setCargos1")
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$vr_tipoDcto)  //descuento por número de cargas
								If (Records in selection:C76([ACT_Cargos:173])=1)
									$vl_idCargo:=[ACT_Cargos:173]ID:1
									ACTcfg_OpcionesEliminacionDctos ("GeneraCargo";->$vl_idCargo;->[ACT_Cargos:173]Monto_Neto:5;->$vd_fecha;->$alACT_idsAvisos2Recalc;->$vr_tipoDcto)
								End if 
								
								SET_ClearSets ("setCargos1")
							End if 
						End if 
					Else 
						ACTcfg_OpcionesEliminacionDctos ("EliminaCargo";->$vl_idCargo;->$vd_fecha;->$alACT_idsAvisos2Recalc)
					End if 
				End for 
				
				If ($vb_thermo)
					IT_UThermometer (-2;$vl_proc)
				End if 
				
			End for 
			
			SET_ClearSets ("setCargosInicio")
			
			
			AT_DistinctsArrayValues (->$alACT_idsAvisos2Recalc)
			$vb_mostrarThermo:=(Size of array:C274($alACT_idsAvisos2Recalc)>10)
			If ($vb_mostrarThermo)
				$vl_proc:=IT_UThermometer (1;0;"Recalculando Avisos de Cobranza...")
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recalculando Avisos de Cobranza...")
			End if 
			For ($i;1;Size of array:C274($alACT_idsAvisos2Recalc))
				ACTac_Recalcular (Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAvisos2Recalc{$i}))
				If ($vb_mostrarThermo)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_idsAvisos2Recalc))
				End if 
			End for 
			If ($vb_mostrarThermo)
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
			
			  //si se considera el saldo anterior en los avisos, se recalculan todos...
			ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
			If ((cb_IncluirSaldosAnteriores=1) & (Size of array:C274($alACT_idsAvisos2Recalc)>0))
				ARRAY LONGINT:C221($alACT_recNumAvisos;0)
				QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAvisos2Recalc)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumAvisos;"")
				ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumAvisos;$vd_fecha)
			End if 
			
			If ($vb_mostrarThermo)
				IT_UThermometer (2;$vl_proc)
			End if 
			  //
			  //  //20120710 RCH Cuando se calculaban multas que se creaban en nuevos avisos, podian no aparecer...
			  //ACTac_OpcionesGenerales ("CreaArregloDesdeRecNumCargo";->al_RecNumsCargos;->alACT_RecNumsAvisos)
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision>=!01-12-2012!)
			  //SET TEXT TO PASTEBOARD(AT_array2text (->al_RecNumsCargos;<>cr;"#############"))
			
		End if 
		
	: ($vt_accion="ObtieneRef")
		$vl_idCargo:=$vy_pointer1->
		$vl_refItem:=$vy_pointer2->
		$vr_tipoDcto:=$vy_pointer3->
		$vt_retorno:=ST_RigthChars (("0"*10)+String:C10($vl_idCargo);10)+ST_RigthChars (("0"*10)+String:C10($vl_refItem);10)+ST_RigthChars (("0"*10)+String:C10($vr_tipoDcto);10)
		
	: ($vt_accion="ObtieneIDItem")
		$vl_idCargo:=$vy_pointer1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
		$vt_retorno:=String:C10(Choose:C955([ACT_Cargos:173]TasaIVA:21#0;-138;-139))
		
	: ($vt_accion="GeneraCargo")
		C_LONGINT:C283($vl_refItem;$vl_idDocCargo;$vl_recNum;$vl_idCta;$vl_idItem)
		$vl_idCargo:=$vy_pointer1->
		$vr_monto:=Abs:C99($vy_pointer2->)
		$vd_fecha:=$vy_pointer3->
		$vr_tipoDcto:=$vy_pointer5->
		
		$vl_records:=Num:C11(ACTcfg_OpcionesEliminacionDctos ("ExisteCargo";->$vl_idCargo;->$vr_tipoDcto))
		  //If ($vl_records=0)
		If ($vl_records=-1)
			$vl_recNum:=KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
			$vl_idDocCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
			$vl_idCta:=[ACT_Cargos:173]ID_CuentaCorriente:2
			$vl_idApdo:=[ACT_Cargos:173]ID_Apoderado:18
			$vd_vencimientoCargo:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
			$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
			$vl_refItem:=Num:C11(ACTcfg_OpcionesEliminacionDctos ("ObtieneRefItem";->$vl_idCargo))
			$vl_idItem:=Num:C11(ACTcfg_OpcionesEliminacionDctos ("ObtieneIDItem";->$vl_idCargo))
			$vt_ref:=ACTcfg_OpcionesEliminacionDctos ("ObtieneRef";->$vl_idCargo;->$vl_idItem;->$vr_tipoDcto)
			
			If (ACTpgs_OpcionesCargosEliminados ("VerificaEliminacionDctos";->$vt_ref)="1")  //20120710 RCH
				
				READ ONLY:C145([xxACT_Items:179])
				ACTqry_CargoEspecial ($vl_refItem)
				
				$vl_recNum:=ACTcc_DuplicaCargoDcto ($vl_refItem;$vl_recNum;$vr_monto;True:C214;[xxACT_Items:179]Glosa:2)
				  //ajusto el saldo que no se calcula dentro del metodo anterior
				KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNum;True:C214)
				[ACT_Cargos:173]MontosPagados:8:=0
				[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
				[ACT_Cargos:173]Ref_RecargoDcto:64:=$vt_ref
				SAVE RECORD:C53([ACT_Cargos:173])
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
				
				ACTcc_CalculaDocumentoCargo (Find in field:C653([ACT_Documentos_de_Cargo:174]ID_Documento:1;$vl_idDocCargo);$vd_fecha)
				APPEND TO ARRAY:C911($vy_pointer4->;$vl_idAviso)
				ACTcfg_OpcionesEliminacionDctos ("CalculaSaldos";->$vl_idCta;->$vl_idApdo;->$vr_monto;->$vd_vencimientoCargo)
				
				  //para compatibilidad con ingreso de pagos
				If (Size of array:C274(al_RecNumsCargos)>0)
					If (Find in array:C230(al_RecNumsCargos;$vl_recNum)=-1)
						APPEND TO ARRAY:C911(al_RecNumsCargos;$vl_recNum)
					End if 
				End if 
				  //para compatibilidad con ingreso de pagos
			End if 
			
		End if 
		
	: ($vt_accion="ObtieneRefItem")
		$vl_idCargo:=$vy_pointer1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
		$vt_retorno:=Choose:C955([ACT_Cargos:173]TasaIVA:21#0;"18";"19")
		
	: ($vt_accion="ExisteCargo")
		C_LONGINT:C283($vl_idItem)
		$vl_idCargo:=$vy_pointer1->
		$vr_tipoDcto:=$vy_pointer2->
		
		READ WRITE:C146([ACT_Cargos:173])
		
		$vl_idItem:=Num:C11(ACTcfg_OpcionesEliminacionDctos ("ObtieneIDItem";->$vl_idCargo))
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargo)
		CREATE SET:C116([ACT_Cargos:173];"$setCargosRelacionados")
		
		$vt_ref:=ACTcfg_OpcionesEliminacionDctos ("ObtieneRef";->$vl_idCargo;->$vl_idItem;->$vr_tipoDcto)
		$vt_retorno:=String:C10(Find in field:C653([ACT_Cargos:173]Ref_RecargoDcto:64;$vt_ref))
		If ($vt_retorno="-1")
			If (Records in set:C195("$setCargosRelacionados")>0)
				USE SET:C118("$setCargosRelacionados")
				FIRST RECORD:C50([ACT_Cargos:173])
				$vl_idCargo:=[ACT_Cargos:173]ID:1
				$vt_retorno:=ACTcfg_OpcionesEliminacionDctos ("ExisteCargo";->$vl_idCargo;->$vr_tipoDcto)
				SET_ClearSets ("$setCargosRelacionados")
			End if 
		End if 
		
	: ($vt_accion="EliminaCargo")
		C_LONGINT:C283($vl_boleta;$vl_idAviso;$vl_idPagare;$vl_idApdo;$vl_idCta;$vl_recNum;$vl_pos)
		C_DATE:C307($vd_vencimientoCargo)
		
		$vl_idCargo:=$vy_pointer1->
		$vd_fecha:=$vy_pointer2->
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
		If ($vd_fecha<[ACT_Cargos:173]Fecha_de_Vencimiento:7)
			C_BOOLEAN:C305($vb_existe)
			$vb_existe:=False:C215
			
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargo)
			If (Records in selection:C76([ACT_Cargos:173])>0)
				ARRAY LONGINT:C221($alACT_idsCargos;0)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idsCargos)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-138;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-139)
				If (Records in selection:C76([ACT_Cargos:173])>0)
					ARRAY LONGINT:C221($alACT_recNumCargos;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumCargos;"")
					
					For ($i;1;Size of array:C274($alACT_recNumCargos))
						GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargos{$i})
						SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_boleta)
						$vl_idCargo:=[ACT_Cargos:173]ID:1
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$vl_idCargo;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If ($vl_boleta=0)
							$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							$vl_idPagare:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30)
							If ($vl_idPagare=0)
								If ([ACT_Cargos:173]MontosPagados:8=0)
									$vl_idCta:=[ACT_Cargos:173]ID_CuentaCorriente:2
									$vl_idApdo:=[ACT_Cargos:173]ID_Apoderado:18
									$vr_monto:=[ACT_Cargos:173]Monto_Neto:5
									$vd_vencimientoCargo:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
									$vl_recNum:=Find in field:C653([ACT_Cargos:173]ID:1;$vl_idCargo)
									APPEND TO ARRAY:C911($vy_pointer3->;$vl_idAviso)
									ACTcc_EliminaCargosLoop 
									$vr_monto:=Abs:C99($vr_monto)*-1  // para restar los saldos
									ACTcfg_OpcionesEliminacionDctos ("CalculaSaldos";->$vl_idCta;->$vl_idApdo;->$vr_monto;->$vd_vencimientoCargo)
									
									  //para compatibilidad con ingreso de pagos
									If (Size of array:C274(al_RecNumsCargos)>0)
										$vl_pos:=Find in array:C230(al_RecNumsCargos;$vl_recNum)
										If ($vl_pos#-1)
											AT_Delete ($vl_pos;1;->al_RecNumsCargos)
										End if 
									End if 
									  //para compatibilidad con ingreso de pagos
									
								Else 
									LOG_RegisterEvt ("El cargo no puede ser eliminado porque se encuentra parcial o totalmente pagado.")
								End if 
							Else 
								LOG_RegisterEvt ("El cargo no puede ser eliminado porque se encuentra asociado a un Pagaré.")
							End if 
						Else 
							LOG_RegisterEvt ("El cargo no puede ser eliminado porque se encuentra asociado a un Documento Tributario.")
						End if 
					End for 
				Else 
					For ($i;1;Size of array:C274($alACT_idsCargos))
						ACTcfg_OpcionesEliminacionDctos ("EliminaCargo";->$alACT_idsCargos{$i};->$vd_fecha;$vy_pointer3)
					End for 
				End if 
			End if 
		Else 
			  //LOG_RegisterEvt ("El cargo id "+String($vl_idCargo)+" no puede ser eliminado porque la fecha "+String($vd_fecha)+" no es superior a "+String([ACT_Cargos]Fecha_de_Vencimiento)+".")
		End if 
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		
	: ($vt_accion="CalculaSaldos")
		C_LONGINT:C283($vl_recNum;$vl_idCta;$vl_idApdo)
		C_REAL:C285($vr_monto)
		C_DATE:C307($vd_vencimientoCargo)
		$vl_idCta:=$vy_pointer1->
		$vl_idApdo:=$vy_pointer2->
		$vr_monto:=$vy_pointer3->
		$vd_vencimientoCargo:=$vy_pointer4->
		
		$vl_recNum:=KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCta;True:C214)
		If (ok=1)
			$vl_recNum:=KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$vl_idApdo;True:C214)
			If (ok=1)
				If ((Current date:C33(*)>$vd_vencimientoCargo) & ($vr_monto#0))
					[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18:=[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18+($vr_monto*-1)
					[ACT_CuentasCorrientes:175]MontosVencidos_Ejercicio:15:=[ACT_CuentasCorrientes:175]MontosVencidos_Ejercicio:15+($vr_monto*-1)
				End if 
				[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16:=[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16+$vr_monto
				[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21:=[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17+([ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16*-1)
				[ACT_CuentasCorrientes:175]Total_emitidos:5:=[ACT_CuentasCorrientes:175]Total_emitidos:5+$vr_monto
				[ACT_CuentasCorrientes:175]Total_Saldos:8:=[ACT_CuentasCorrientes:175]Total_pagados:6-[ACT_CuentasCorrientes:175]Total_emitidos:5
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
				
				[Personas:7]MontosEmitidos_Ejercicio:82:=[Personas:7]MontosEmitidos_Ejercicio:82+$vr_monto
				If ((Current date:C33(*)>$vd_vencimientoCargo))
					[Personas:7]DeudaVencida_Ejercicio:83:=[Personas:7]DeudaVencida_Ejercicio:83+$vr_monto
				End if 
				[Personas:7]Saldo_Ejercicio:85:=[Personas:7]MontosPagados_Ejercicio:84-[Personas:7]MontosEmitidos_Ejercicio:82
				SAVE RECORD:C53([Personas:7])
			Else 
				BM_CreateRequest ("ACTpp_Calcula_Montos_Ejercicio";String:C10($vl_recNum);String:C10($vl_recNum))
			End if 
		Else 
			$vl_recNum:=Find in field:C653([Personas:7]No:1;$vl_idApdo)
			BM_CreateRequest ("ACTpp_Calcula_Montos_Ejercicio";String:C10($vl_recNum);String:C10($vl_recNum))
		End if 
		
		KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
		KRL_UnloadReadOnly (->[Personas:7])
		
End case 
$0:=$vt_retorno

