//%attributes = {}
  //ACTwiz_GenerarXDTs

C_REAL:C285($decimales)

  // Modificado por: Saúl Ponce (29-05-2018) Ticket Nº 207841, evitar que aparezca error (línea 102) por estar indefinido el array.
ARRAY LONGINT:C221(DA_Return;0)

AT_Initialize (->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
AT_Initialize (->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([ACT_Cargos:173])
Case of 
	: (b1=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$day:=Day of:C23(Current date:C33(*))
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3=Current date:C33(*))
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
	: (b3=1)
		$year:=viAño
		$dateIni:=DT_GetDateFromDayMonthYear (1;vi_SelectedMonth;$year)
		$lastDay:=DT_GetLastDay (vi_SelectedMonth;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;vi_SelectedMonth;$year)
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$DateIni;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$DateEnd)
		$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
	: (b5=1)
		$year:=viAño2
		$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
		$lastDay:=DT_GetLastDay (12;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;12;$year)
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$DateIni;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$DateEnd)
		$fileName:=String:C10($year)
	: (b6=1)
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=vd_Fecha1;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=vd_Fecha2)
		$vt_Fecha1:=Replace string:C233(vt_Fecha1;<>tXS_RS_DateSeparator;"")
		$vt_Fecha2:=Replace string:C233(vt_Fecha2;<>tXS_RS_DateSeparator;"")
		$fileName:=$vt_Fecha1+"al"+$vt_Fecha2
End case 
  //$fileName:="Facturacion"+$fileName
$fileName:="Facturacion"+vtACT_Documento+$fileName
If (SYS_IsWindows )
	$fileName:=$fileName+".txt"
End if 
If (Records in selection:C76([ACT_Boletas:181])>0)
	ARRAY LONGINT:C221($aMontosDif;0)
	$diffBoleta:=0
	ARRAY LONGINT:C221($alACT_recNums;0)
	
	Case of 
		: ((vlACT_idDocumento=-1) | (vlACT_idDocumento>0))
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=0)
			CREATE SET:C116([ACT_Boletas:181];"boletas")
			COPY SET:C600("boletas";"setBoletas1")
			
			  //KRL_RelateSelection (->[ACT_Boletas]ID_DctoAsociado;->[ACT_Boletas]ID;"")
			  //CREATE SET([ACT_Boletas];"setBoletas2")
			  //
			  //UNION("setBoletas1";"setBoletas2";"setBoletas1")
			  //USE SET("setBoletas1")
			  //SET_ClearSets ("setBoletas1";"setBoletas2")
			
		: (vlACT_idDocumento=-4)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19#0;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Categoria:12=vlACT_idDocumento)
			
	End case 
	
	If (Records in selection:C76([ACT_Boletas:181])>0)
		CREATE SET:C116([ACT_Boletas:181];"boletas")
		
		LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$alACT_recNums;"")
		If (cbResumidoF=0)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información de facturación...")
			For ($y;1;Size of array:C274($alACT_recNums))
				GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNums{$y})
				
				vrACT_ProcBoleta:=0
				
				  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
				  //CREATE SET([ACT_Transacciones];"Transacciones")
				  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
				
				ACTbol_BuscaCargosCargaSet ("Transacciones";[ACT_Boletas:181]ID:1)
				
				ARRAY LONGINT:C221($al_recNum;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNum)
				For ($i;1;Size of array:C274($al_recNum))
					GOTO RECORD:C242([ACT_Cargos:173];$al_recNum{$i})
					AT_Insert (0;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
					$existeccta:=Find in array:C230(acampocc1;Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18))
					If ($existeccta=-1)
						$ccta:=ACTwiz_InsertCCtaLine ("fact")
					Else 
						acampocc1{0}:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)
						AT_SearchArray (->acampocc1;"=")
						If (Size of array:C274(DA_Return)#0)
							$createNew:=True:C214
							For ($xx;1;Size of array:C274(DA_Return))
								If (acampocc19{DA_Return{$xx}}=[ACT_Cargos:173]CodAuxCCta:44)
									If (acampocc16{DA_Return{$xx}}=Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;8))
										$monto:=ACTbol_GetMontoLinea ("Transacciones")
										vrACT_ProcBoleta:=vrACT_ProcBoleta+$monto
										  //acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+$monto   `MOD DSCTO POR CAJA 20070817
										
										  //20110829 RCH Solicitud del grange
										  //If ($monto>=0)
										  //acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+$monto
										  //Else 
										  //  `acampocc3{DA_Return{$xx}}:=acampocc3{DA_Return{$xx}}+Abs($monto)
										  //APPEND TO ARRAY(arACT_Rebajas;Abs($monto))
										  //APPEND TO ARRAY(alACT_idsCarRebajas;[ACT_Cargos]ID)
										  //End if 
										acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+$monto
										
										$ccta:=aCCID{DA_Return{$xx}}
										$xx:=Size of array:C274(DA_Return)
										$createNew:=False:C215
									End if 
								End if 
							End for 
							If ($createNew)
								$ccta:=ACTwiz_InsertCCtaLine ("fact")
							End if 
						Else 
							$ccta:=ACTwiz_InsertCCtaLine ("fact")
						End if 
					End if 
					acampo1{Size of array:C274(acampo1)}:=Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18)
					$monto:=ACTbol_GetMontoLinea ("Transacciones")
					If ([ACT_Cargos:173]TasaIVA:21>0)
						$factor:=1+([ACT_Boletas:181]TasaIVA:16/100)
						$decimales:=$decimales+Dec:C9($monto/$factor)
						$monto:=Round:C94($monto/$factor;<>vlACT_Decimales)
					End if 
					  //acampo3{Size of array(acampo3)}:=$monto `MOD DSCTO POR CAJA 20070817
					If ($monto>=0)
						acampo3{Size of array:C274(acampo3)}:=$monto
					Else 
						  //acampo2{Size of array(acampo2)}:=Abs($monto) ´se comenta por descuentos por item del grange
					End if 
					acampo4{Size of array:C274(acampo4)}:=Substring:C12([ACT_Cargos:173]Glosa:12;1;60)
					acampo16{Size of array:C274(acampo16)}:=Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;8)
					acampo19{Size of array:C274(acampo19)}:=Substring:C12([ACT_Cargos:173]CodAuxCta:43;1;12)
					aenccuenta{Size of array:C274(aenccuenta)}:=$ccta
					aID{Size of array:C274(aID)}:=[ACT_Cargos:173]ID:1
				End for 
				If (vrACT_ProcBoleta#[ACT_Boletas:181]Monto_Total:6)
					INSERT IN ARRAY:C227($aMontosDif;1;1)
					$aMontosDif{1}:=[ACT_Boletas:181]Monto_Total:6-vrACT_ProcBoleta
					$diffBoleta:=$diffBoleta+$aMontosDif{1}
				End if 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/Size of array:C274($alACT_recNums);"Recopilando información de facturación...")
				
			End for 
			SET_ClearSets ("Transacciones")
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		Else 
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información de facturación...")
			
			$vr_monto2:=0
			
			ARRAY TEXT:C222($atACT_arrayUnico;0)
			ARRAY TEXT:C222($atACT_arrayUnico2;0)
			
			  //20120113 RCH Se deja en preferencia la forma de generar el archivo
			$vb_nuevoCodigo:=(PREF_fGet (0;"ACT_ACTwiz_GeneraXDTs";"1")="1")
			
			For ($y;1;Size of array:C274($alACT_recNums))
				GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNums{$y})
				
				vrACT_ProcBoleta:=0
				  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
				  //CREATE SET([ACT_Transacciones];"Transacciones")
				  //
				  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
				ACTbol_BuscaCargosCargaSet ("Transacciones";[ACT_Boletas:181]ID:1)
				
				
				ARRAY LONGINT:C221($al_recNum;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNum)
				For ($i;1;Size of array:C274($al_recNum))
					GOTO RECORD:C242([ACT_Cargos:173];$al_recNum{$i})
					
					If ($vb_nuevoCodigo)
						$vt_key:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)+"|"+Substring:C12([ACT_Cargos:173]CodAuxCCta:44;1;18)+"|"+Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;18)
						$existeccta:=Find in array:C230($atACT_arrayUnico;$vt_key)
					Else 
						$existeccta:=Find in array:C230(acampocc1;Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18))
					End if 
					
					If ($existeccta=-1)
						If ($vb_nuevoCodigo)
							AT_Insert (1;1;->$atACT_arrayUnico)
							$atACT_arrayUnico{1}:=$vt_key
							  //APPEND TO ARRAY($atACT_arrayUnico;$vt_key)
						End if 
						$ccta:=ACTwiz_InsertCCtaLine ("fact")
						
					Else 
						If ($vb_nuevoCodigo)
							$monto:=ACTbol_GetMontoLinea ("Transacciones")
							vrACT_ProcBoleta:=vrACT_ProcBoleta+$monto
							acampocc2{$existeccta}:=acampocc2{$existeccta}+$monto
							
							$ccta:=aCCID{$existeccta}
							$createNew:=False:C215
						Else 
							acampocc1{0}:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)
							AT_SearchArray (->acampocc1;"=")
							If (Size of array:C274(DA_Return)#0)
								$createNew:=True:C214
								For ($xx;1;Size of array:C274(DA_Return))
									If (acampocc19{DA_Return{$xx}}=[ACT_Cargos:173]CodAuxCCta:44)
										If (acampocc16{DA_Return{$xx}}=Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;8))
											$monto:=ACTbol_GetMontoLinea ("Transacciones")
											vrACT_ProcBoleta:=vrACT_ProcBoleta+$monto
											  //acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+$monto   `MOD DSCTO POR CAJA 20070817
											
											  //20110829 RCH Solicitud del grange
											  //If ($monto>=0)
											  //acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+$monto
											  //Else 
											  //  `acampocc3{DA_Return{$xx}}:=acampocc3{DA_Return{$xx}}+Abs($monto)
											  //APPEND TO ARRAY(arACT_Rebajas;Abs($monto))
											  //APPEND TO ARRAY(alACT_idsCarRebajas;[ACT_Cargos]ID)
											  //End if 
											acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+$monto
											
											$ccta:=aCCID{DA_Return{$xx}}
											$xx:=Size of array:C274(DA_Return)
											$createNew:=False:C215
										End if 
									End if 
								End for 
								If ($createNew)
									$ccta:=ACTwiz_InsertCCtaLine ("fact")
								End if 
							Else 
								$ccta:=ACTwiz_InsertCCtaLine ("fact")
							End if 
						End if 
					End if 
					
					If ($vb_nuevoCodigo)
						$vt_key:=Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18)+"|"+Substring:C12([ACT_Cargos:173]CodAuxCta:43;1;18)+"|"+Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;18)
						$estacta:=Find in array:C230($atACT_arrayUnico2;$vt_key)
					Else 
						$estacta:=Find in array:C230(acampo1;Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18))
					End if 
					
					If ($estacta=-1)
						If ($vb_nuevoCodigo)
							AT_Insert (1;1;->$atACT_arrayUnico2)
							$atACT_arrayUnico2{1}:=$vt_key
							  //APPEND TO ARRAY($atACT_arrayUnico2;$vt_key)
						End if 
						ACTwiz_InsertCtaLine ("fact";$ccta)
					Else 
						If ($vb_nuevoCodigo)
							
							$monto:=ACTbol_GetMontoLinea ("Transacciones")
							If ([ACT_Cargos:173]TasaIVA:21>0)
								$factor:=1+([ACT_Boletas:181]TasaIVA:16/100)
								$monto:=Round:C94($monto/$factor;<>vlACT_Decimales)
							End if 
							acampo3{$estacta}:=acampo3{$estacta}+$monto
							$createNew:=False:C215
							
						Else 
							acampo1{0}:=Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18)
							AT_SearchArray (->acampo1;"=")
							If (Size of array:C274(DA_Return)#0)
								$createNew:=True:C214
								For ($xx;1;Size of array:C274(DA_Return))
									If (acampo19{DA_Return{$xx}}=[ACT_Cargos:173]CodAuxCta:43)
										If (acampo16{DA_Return{$xx}}=Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;8))
											$monto:=ACTbol_GetMontoLinea ("Transacciones")
											If ([ACT_Cargos:173]TasaIVA:21>0)
												$factor:=1+([ACT_Boletas:181]TasaIVA:16/100)
												$monto:=Round:C94($monto/$factor;<>vlACT_Decimales)
											End if 
											  //acampo3{DA_Return{$xx}}:=acampo3{DA_Return{$xx}}+$monto   `MOD DSCTO POR CAJA 20070817
											
											  //20110829 RCH Solicitud del grange
											  //If ($monto>=0)
											  //acampo3{DA_Return{$xx}}:=acampo3{DA_Return{$xx}}+$monto
											  //Else 
											  //  `acampo2{DA_Return{$xx}}:=acampo2{DA_Return{$xx}}+Abs($monto)
											  //  `APPEND TO ARRAY(arACT_Rebajas;Abs($monto))
											  //End if 
											acampo3{DA_Return{$xx}}:=acampo3{DA_Return{$xx}}+$monto
											
											$xx:=Size of array:C274(DA_Return)+1
											$createNew:=False:C215
										End if 
									End if 
								End for 
								If ($createNew)
									ACTwiz_InsertCtaLine ("fact";$ccta)
								End if 
							Else 
								ACTwiz_InsertCtaLine ("fact";$ccta)
							End if 
						End if 
					End if 
				End for 
				
				GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNums{$y})
				If (vrACT_ProcBoleta#[ACT_Boletas:181]Monto_Total:6)
					INSERT IN ARRAY:C227($aMontosDif;1;1)
					$aMontosDif{1}:=[ACT_Boletas:181]Monto_Total:6-vrACT_ProcBoleta
					$diffBoleta:=$diffBoleta+$aMontosDif{1}
				End if 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/Size of array:C274($alACT_recNums);"Recopilando información de facturación...")
			End for 
			
			SET_ClearSets ("Transacciones")
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			Case of 
				: (fo2=1)
					SORT ARRAY:C229(acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo16;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;>)
				: (fo3=1)
					SORT ARRAY:C229(acampo16;acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;>)
			End case 
			
		End if 
		
		TRACE:C157
		ACTcbl_EliminaLineasCero 
		ACTwiz_GeneraArchContable ("Ingreso de contra cuentas para archivo de facturación";"Generando archivo de facturación...";$fileName;"Facturación")
		CLEAR SET:C117("boletas")
	Else 
		CD_Dlog (0;"No hay documentos tributarios emitidos para el tipo de documento seleccionado.")
	End if 
Else 
	CD_Dlog (0;"No hay documentos tributarios emitidos en el rango de fechas especificado.")
End if 
KRL_UnloadReadOnly (->[ACT_Transacciones:178])
KRL_UnloadReadOnly (->[ACT_Boletas:181])
KRL_UnloadReadOnly (->[ACT_Cargos:173])