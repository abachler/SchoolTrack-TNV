//%attributes = {}
  //ACTwiz_GenerarXDTsWTrf

ACTcfg_LoadConfigData (10)  //para leer las cuentas contables
ARRAY LONGINT:C221(alACT_IdsBoletas;0)
C_REAL:C285($decimales)
C_POINTER:C301(vp_tabla)
C_LONGINT:C283(vl_correlativo)
vl_correlativo:=0
vp_tabla:=->[ACT_Boletas:181]
AT_Initialize (->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID;->alACT_IdsBoletas)
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
$fileName:="Facturacion"+$fileName
If (SYS_IsWindows )
	$fileName:=$fileName+".txt"
End if 

If (Records in selection:C76([ACT_Boletas:181])>0)
	
	Case of 
		: ((vlACT_idDocumento=-1) | (vlACT_idDocumento>0))
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=0)
			CREATE SET:C116([ACT_Boletas:181];"boletas")
			COPY SET:C600("boletas";"setBoletas1")
			
			KRL_RelateSelection (->[ACT_Boletas:181]ID_DctoAsociado:19;->[ACT_Boletas:181]ID:1;"")
			CREATE SET:C116([ACT_Boletas:181];"setBoletas2")
			
			UNION:C120("setBoletas1";"setBoletas2";"setBoletas1")
			USE SET:C118("setBoletas1")
			SET_ClearSets ("setBoletas1";"setBoletas2")
			
		: (vlACT_idDocumento=-4)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19#0;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Categoria:12=vlACT_idDocumento)
			
	End case 
	CREATE SET:C116([ACT_Boletas:181];"boletas")
	
	ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;>)
	ARRAY LONGINT:C221($aMontosDif;0)
	$diffBoleta:=0
	CREATE SET:C116([ACT_Boletas:181];"boletas")
	If (cbResumidoF=0)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de facturación..."))
		ARRAY LONGINT:C221($al_recNumBoletas;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$al_recNumBoletas;"")
		  //FIRST RECORD([ACT_Boletas])
		  //While (Not(End selection([ACT_Boletas])))
		For ($y;1;Size of array:C274($al_recNumBoletas))
			GOTO RECORD:C242([ACT_Boletas:181];$al_recNumBoletas{$y})
			If (cbAgrupadoDTF=1)
				_O_ARRAY STRING:C218(18;$acampo1;0)
				ARRAY REAL:C219($acampo3;0)
				ARRAY REAL:C219($acampo2;0)
				_O_ARRAY STRING:C218(60;$acampo4;0)
				_O_ARRAY STRING:C218(8;$acampo16;0)
				_O_ARRAY STRING:C218(12;$acampo19;0)
				ARRAY LONGINT:C221($aenccuenta;0)
				ARRAY LONGINT:C221($aID;0)
			End if 
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
			CREATE SET:C116([ACT_Transacciones:178];"Transacciones")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			ARRAY LONGINT:C221($al_recNumCargos;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumCargos;"")
			If (Size of array:C274($al_recNumCargos)>0)
				For ($i;1;Size of array:C274($al_recNumCargos))
					READ ONLY:C145([ACT_Cargos:173])
					KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCargos{$i})
					$existeccta:=Find in array:C230(acampocc1;Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18))
					If ($existeccta=-1)
						$ccta:=ACTwiz_InsertCCtaLine ("fact")
					Else 
						acampocc1{0}:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->acampocc1;"=";->$DA_Return)
						If (Size of array:C274($DA_Return)#0)
							$createNew:=True:C214
							For ($xx;1;Size of array:C274($DA_Return))
								If (acampocc19{$DA_Return{$xx}}=[ACT_Cargos:173]CodAuxCCta:44)
									If (acampocc16{$DA_Return{$xx}}=Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;8))
										$monto:=ACTbol_GetMontoLinea ("Transacciones")
										If ($monto>=0)
											acampocc2{$DA_Return{$xx}}:=acampocc2{$DA_Return{$xx}}+$monto
										Else 
											acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+Abs:C99($monto)
										End if 
										$ccta:=aCCID{$DA_Return{$xx}}
										$xx:=Size of array:C274($DA_Return)
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
					$monto:=ACTbol_GetMontoLinea ("Transacciones")
					If ([ACT_Cargos:173]TasaIVA:21>0)
						$factor:=1+([ACT_Boletas:181]TasaIVA:16/100)
						$decimales:=$decimales+Dec:C9($monto/$factor)
						$monto:=Round:C94($monto/$factor;<>vlACT_Decimales)
					End if 
					If (cbAgrupadoDTF=0)
						AT_Insert (0;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID;->alACT_IdsBoletas)
						acampo1{Size of array:C274(acampo1)}:=Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18)
						If ($monto>=0)
							acampo3{Size of array:C274(acampo3)}:=$monto
						Else 
							acampo2{Size of array:C274(acampo2)}:=Abs:C99($monto)
						End if 
						acampo4{Size of array:C274(acampo4)}:=Substring:C12([ACT_Cargos:173]Glosa:12;1;60)
						acampo16{Size of array:C274(acampo16)}:=Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;8)
						acampo19{Size of array:C274(acampo19)}:=Substring:C12([ACT_Cargos:173]CodAuxCta:43;1;12)
						aenccuenta{Size of array:C274(aenccuenta)}:=$ccta
						aID{Size of array:C274(aID)}:=[ACT_Cargos:173]ID:1
						
						alACT_IdsBoletas{Size of array:C274(alACT_IdsBoletas)}:=[ACT_Boletas:181]ID:1
						  //APPEND TO ARRAY(alACT_IdsBoletas;[ACT_Boletas]id)
					Else 
						APPEND TO ARRAY:C911($acampo1;Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18))
						If ($monto>=0)
							APPEND TO ARRAY:C911($acampo3;$monto)
						Else 
							APPEND TO ARRAY:C911($acampo2;Abs:C99($monto))
						End if 
						APPEND TO ARRAY:C911($acampo4;Substring:C12([ACT_Cargos:173]Glosa:12;1;60))
						APPEND TO ARRAY:C911($acampo16;Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;8))
						APPEND TO ARRAY:C911($acampo19;Substring:C12([ACT_Cargos:173]CodAuxCta:43;1;12))
						APPEND TO ARRAY:C911($aenccuenta;$ccta)
						APPEND TO ARRAY:C911($aID;[ACT_Cargos:173]ID:1)
					End if 
				End for 
				If (cbAgrupadoDTF=1)
					AT_Insert (0;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID;->alACT_IdsBoletas)
					AT_DistinctsArrayValues (->$acampo1)
					AT_DistinctsArrayValues (->$acampo4)
					AT_DistinctsArrayValues (->$acampo16)
					AT_DistinctsArrayValues (->$acampo19)
					AT_DistinctsArrayValues (->$aenccuenta)
					AT_DistinctsArrayValues (->$aID)
					
					acampo1{Size of array:C274(acampo1)}:=Substring:C12(AT_array2text (->$acampo1;"-");1;18)  //$acampo1{1}
					acampo3{Size of array:C274(acampo3)}:=AT_GetSumArray (->$acampo3)
					acampo2{Size of array:C274(acampo2)}:=Abs:C99(AT_GetSumArray (->$acampo2))
					acampo4{Size of array:C274(acampo4)}:=Substring:C12(AT_array2text (->$acampo4;"-");1;60)
					acampo16{Size of array:C274(acampo16)}:=Substring:C12(AT_array2text (->$acampo16;"-");1;8)  //$acampo16{1}
					acampo19{Size of array:C274(acampo19)}:=Substring:C12(AT_array2text (->$acampo19;"-");1;12)  //$acampo19{1}
					aenccuenta{Size of array:C274(aenccuenta)}:=$aenccuenta{1}
					aID{Size of array:C274(aID)}:=$aID{1}
					
					alACT_IdsBoletas{Size of array:C274(alACT_IdsBoletas)}:=[ACT_Boletas:181]ID:1
					  //APPEND TO ARRAY(alACT_IdsBoletas;[ACT_Boletas]id)
				End if 
			Else 
				AT_Insert (0;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID;->alACT_IdsBoletas)
				alACT_IdsBoletas{Size of array:C274(alACT_IdsBoletas)}:=[ACT_Boletas:181]ID:1
			End if 
			NEXT RECORD:C51([ACT_Boletas:181])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/Size of array:C274($al_recNumBoletas);__ ("Recopilando información de facturación..."))
			  //End while 
		End for 
		SET_ClearSets ("Transacciones")
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de facturación..."))
		FIRST RECORD:C50([ACT_Boletas:181])
		While (Not:C34(End selection:C36([ACT_Boletas:181])))
			vrACT_ProcBoleta:=0
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
			CREATE SET:C116([ACT_Transacciones:178];"Transacciones")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			ARRAY LONGINT:C221($al_recNum;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNum)
			For ($i;1;Size of array:C274($al_recNum))
				GOTO RECORD:C242([ACT_Cargos:173];$al_recNum{$i})
				$existeccta:=Find in array:C230(acampocc1;Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18))
				If ($existeccta=-1)
					$ccta:=ACTwiz_InsertCCtaLine ("fact")
				Else 
					acampocc1{0}:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->acampocc1;"=";->$DA_Return)
					If (Size of array:C274($DA_Return)#0)
						$createNew:=True:C214
						For ($xx;1;Size of array:C274($DA_Return))
							If (acampocc19{$DA_Return{$xx}}=[ACT_Cargos:173]CodAuxCCta:44)
								If (acampocc16{$DA_Return{$xx}}=Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;8))
									$monto:=ACTbol_GetMontoLinea ("Transacciones")
									vrACT_ProcBoleta:=vrACT_ProcBoleta+$monto
									  //acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+$monto
									If ($monto>=0)
										acampocc2{$DA_Return{$xx}}:=acampocc2{$DA_Return{$xx}}+$monto
									Else 
										acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+Abs:C99($monto)
									End if 
									$ccta:=aCCID{$DA_Return{$xx}}
									$xx:=Size of array:C274($DA_Return)
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
				$estacta:=Find in array:C230(acampo1;Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18))
				If ($estacta=-1)
					ACTwiz_InsertCtaLine ("fact";$ccta)
				Else 
					acampo1{0}:=Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18)
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->acampo1;"=";->$DA_Return)
					If (Size of array:C274($DA_Return)#0)
						$createNew:=True:C214
						For ($xx;1;Size of array:C274($DA_Return))
							If (acampo19{$DA_Return{$xx}}=[ACT_Cargos:173]CodAuxCta:43)
								If (acampo16{$DA_Return{$xx}}=Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;8))
									$monto:=ACTbol_GetMontoLinea ("Transacciones")
									If ([ACT_Cargos:173]TasaIVA:21>0)
										$factor:=1+([ACT_Boletas:181]TasaIVA:16/100)
										$monto:=Round:C94($monto/$factor;<>vlACT_Decimales)
									End if 
									  //acampo3{DA_Return{$xx}}:=acampo3{DA_Return{$xx}}+$monto
									If ($monto>=0)
										acampo3{$DA_Return{$xx}}:=acampo3{$DA_Return{$xx}}+$monto
									Else 
										acampo2{$DA_Return{$xx}}:=acampo2{$DA_Return{$xx}}+Abs:C99($monto)
									End if 
									$xx:=Size of array:C274($DA_Return)+1
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
			End for 
			If (vrACT_ProcBoleta#[ACT_Boletas:181]Monto_Total:6)
				INSERT IN ARRAY:C227($aMontosDif;1;1)
				$aMontosDif{1}:=[ACT_Boletas:181]Monto_Total:6-vrACT_ProcBoleta
				$diffBoleta:=$diffBoleta+$aMontosDif{1}
			End if 
			NEXT RECORD:C51([ACT_Boletas:181])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ACT_Boletas:181])/Records in selection:C76([ACT_Boletas:181]);__ ("Recopilando información de facturación..."))
		End while 
		SET_ClearSets ("Transacciones")
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		Case of 
			: (fo2=1)
				SORT ARRAY:C229(acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo16;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;alACT_IdsBoletas;>)
			: (fo3=1)
				SORT ARRAY:C229(acampo16;acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;alACT_IdsBoletas;>)
		End case 
	End if 
	TRACE:C157
	ACTcbl_EliminaLineasCero 
	C_LONGINT:C283($indice)
	$indice:=Find in array:C230(aSoftwares;vSoftware)
	If ($indice#-1)
		$id:=al_idsArchivosContables{$indice}
		vp_tabla:=->[ACT_Boletas:181]
		ptr_Id:=->[ACT_Boletas:181]ID:1
		ACTtrf_Master (1)  //inicializa arreglos 
		ACTtrf_Master (2;String:C10($id))  //carga datos del archivo de transferencia
		ARRAY TEXT:C222(at_textoFijoTf;0)
		ARRAY TEXT:C222(at_titulosAreaContabilidad;Size of array:C274(al_Numero))
		For ($xx;1;Size of array:C274(al_Numero))  //titulos del area
			at_titulosAreaContabilidad{$xx}:=at_HeaderAC{$xx}
		End for 
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando información asociada..."))
		For ($i;1;Size of array:C274(acampo1))  //busca información del cuerpo según lo configurado
			For ($r;1;Size of array:C274(al_Numero))
				$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($r))
				AT_Insert ($i;1;$ptr)
				$ptr->{$i}:=ACTtrf_Master (3;String:C10($r);String:C10($i))
				$ptr->{$i}:=ACTtrf_Master (5;at_formato{$r};$ptr->{$i})
			End for 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(acampo1);__ ("Buscando información asociada..."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		For ($i;1;Size of array:C274(acampocc1))  //busca información de las contracuentas según lo configurado
			For ($r;1;Size of array:C274(al_Numero))
				$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
				AT_Insert ($i;1;$ptr)
				$ptr->{$i}:=ACTtrf_Master (4;String:C10($r);String:C10($i))
			End for 
		End for 
		
		If (cbFacturacion=1)
			$msg1:="Ingreso de contra cuentas para archivo de facturación"
			$msg2:="Generando archivo de facturación..."
			$msg3:="Facturación"
		Else 
			$msg1:="Ingreso de contra cuentas para archivo de recaudación"
			$msg2:="Generando archivo de recaudación..."
			$msg3:="Recaudación"
		End if 
		ACTwiz_GeneraArchContable ($msg1;$msg2;$fileName;$msg3)
		ACTtrf_Master (1)  //inicializa arreglos
	Else 
		CD_Dlog (0;__ ("No se encontró el modelo de archivo contable"))
	End if 
	CLEAR SET:C117("boletas")
Else 
	CD_Dlog (0;__ ("No hay documentos tributarios emitidos en el rango de fechas especificado."))
End if 
KRL_UnloadReadOnly (->[ACT_Transacciones:178])
KRL_UnloadReadOnly (->[ACT_Boletas:181])
KRL_UnloadReadOnly (->[ACT_Cargos:173])