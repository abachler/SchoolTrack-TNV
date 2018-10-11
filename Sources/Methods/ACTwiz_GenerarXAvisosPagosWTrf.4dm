//%attributes = {}
  //ACTwiz_GenerarXAvisosPagosWTrf

C_LONGINT:C283(cb_exportacionNormal)
ARRAY POINTER:C280(ap_PointersToFieldsWTrf;0)
C_POINTER:C301(vp_tabla)
C_POINTER:C301($vp_campoBusqueda;ptr_Id)
C_TEXT:C284($msgNoCargosPagos)
C_LONGINT:C283(vl_correlativo)
vl_correlativo:=0
ACTinit_LoadFdPago   //para capturar forma de pago 
ACTcfg_LoadConfigData (10)  //para leer las cuentas contables

If (cbFacturacion=1)
	APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Cargos:173]No_CCta_contable:39)
	APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Cargos:173]CodAuxCCta:44)
	APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Cargos:173]CCentro_de_costos:40)
	APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Cargos:173]Monto_Neto:5)
	APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Cargos:173]No_de_Cuenta_contable:17)
	APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Cargos:173]Glosa:12)
	APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Cargos:173]Centro_de_costos:15)
	APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Cargos:173]CodAuxCta:43)
	vp_tabla:=->[ACT_Cargos:173]
	ptr_Id:=->[ACT_Cargos:173]ID:1
	READ ONLY:C145([ACT_Cargos:173])
	If (td1=1)
		$vp_campoBusqueda:=->[ACT_Cargos:173]FechaEmision:22
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	Else 
		$vp_campoBusqueda:=->[ACT_Cargos:173]Fecha_de_generacion:4
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	End if 
Else 
	If (cbRecaudacion=1)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]No_CCta_Contable:19)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]CodAuxCCta:23)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]CCentro_de_costos:20)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]Monto_Pagado:5)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]No_Cuenta_Contable:16)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]forma_de_pago_new:31)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]Centro_de_costos:17)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]CodAuxCta:22)
		APPEND TO ARRAY:C911(ap_PointersToFieldsWTrf;->[ACT_Pagos:172]Saldo:15)
		vp_tabla:=->[ACT_Pagos:172]
		$vp_campoBusqueda:=->[ACT_Pagos:172]Fecha:2
		ptr_Id:=->[ACT_Pagos:172]ID:1
		READ ONLY:C145([ACT_Pagos:172])
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Venta_Rapida:10=False:C215;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
	End if 
End if 

AT_Initialize (->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
AT_Initialize (->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)


Case of 
	: (b1=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$day:=Day of:C23(Current date:C33(*))
		QUERY SELECTION:C341(vp_tabla->;$vp_campoBusqueda->;>=;Current date:C33(*))
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
		vd_Fecha1:=Current date:C33(*)
		vd_Fecha2:=Current date:C33(*)
	: (b3=1)
		$year:=viAño
		$dateIni:=DT_GetDateFromDayMonthYear (1;vi_SelectedMonth;$year)
		$lastDay:=DT_GetLastDay (vi_SelectedMonth;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;vi_SelectedMonth;$year)
		QUERY SELECTION:C341(vp_tabla->;$vp_campoBusqueda->;>=;$DateIni;*)
		QUERY SELECTION:C341(vp_tabla->; & ;$vp_campoBusqueda->;<=;$DateEnd)
		$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
		vd_Fecha1:=$dateIni
		vd_Fecha2:=$dateEnd
	: (b5=1)
		$year:=viAño2
		$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
		$lastDay:=DT_GetLastDay (12;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;12;$year)
		QUERY SELECTION:C341(vp_tabla->;$vp_campoBusqueda->;>=;$DateIni;*)
		QUERY SELECTION:C341(vp_tabla->; & ;$vp_campoBusqueda->;<=;$DateEnd)
		$fileName:=String:C10($year)
		vd_Fecha1:=$dateIni
		vd_Fecha2:=$dateEnd
	: (b6=1)
		QUERY SELECTION:C341(vp_tabla->;$vp_campoBusqueda->;>=;vd_Fecha1;*)
		QUERY SELECTION:C341(vp_tabla->; & ;$vp_campoBusqueda->;<=;vd_Fecha2)
		$vt_Fecha1:=Replace string:C233(vt_Fecha1;<>tXS_RS_DateSeparator;"")
		$vt_Fecha2:=Replace string:C233(vt_Fecha2;<>tXS_RS_DateSeparator;"")
		$fileName:=$vt_Fecha1+"al"+$vt_Fecha2
End case 
If (cbFacturacion=1)
	$fileName:="Emision"+$fileName
Else 
	$fileName:="Recaudacion"+$fileName
End if 
If (SYS_IsWindows )
	$fileName:=$fileName+".txt"
End if 
If (Records in selection:C76(vp_tabla->)>0)
	If (cbFacturacion=1)
		CREATE SET:C116([ACT_Cargos:173];"todos")
	End if 
	If (((cbRecaudacion=1) & (cbResumidoR=0)) | ((cbFacturacion=1) & (cbResumidoF=0)))
		If (cbFacturacion=1)
			If (cbResumidoF=0)
				Case of 
					: (fo2=1)
						ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]No_de_Cuenta_contable:17;>)
					: (fo3=1)
						ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Centro_de_costos:15;>)
				End case 
			End if 
		Else 
			If (cbRecaudacion=1)
				If (cbResumidoR=0)
					Case of 
						: (ro2=1)
							ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]No_Cuenta_Contable:16;>)
						: (ro3=1)
							ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]Centro_de_costos:17;>)
					End case 
				End if 
			End if 
		End if 
		AT_RedimArrays (Records in selection:C76(vp_tabla->);->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de facturación..."))
		$j:=1
		
		If (cb_exportacionNormal=0)
			
			ARRAY LONGINT:C221($al_recNum;0)
			SELECTION TO ARRAY:C260(vp_tabla->;$al_recNum)
			For ($i;1;Size of array:C274($al_recNum))
				KRL_GotoRecord (vp_tabla;$al_recNum{$i})
				If (cbFacturacion=1)
					$vr_montoNeto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
					$vr_montoIVA:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_IVA:20;->[ACT_Cargos:173]Monto_IVA:20;Current date:C33(*))
					KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$i})
				Else 
					$vr_montoNeto:=ap_PointersToFieldsWTrf{4}->
				End if 
				$existeccta:=Find in array:C230(acampocc1;Substring:C12(ap_PointersToFieldsWTrf{1}->;1;18))  //no ccta contable
				If ($existeccta=-1)
					If (cbFacturacion=1)
						$ccta:=ACTwiz_InsertCCtaLine ("fact")
					Else   //pagos
						$ccta:=ACTwiz_InsertCCtaLine ("rec")
					End if 
				Else 
					acampocc1{0}:=Substring:C12(ap_PointersToFieldsWTrf{1}->;1;18)  //no ccta contable
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->acampocc1;"=";->$DA_Return)
					If (Size of array:C274($DA_Return)#0)
						$createNew:=True:C214
						For ($xx;1;Size of array:C274($DA_Return))
							If (acampocc19{$DA_Return{$xx}}=ap_PointersToFieldsWTrf{2}->)  //CodAuxCCta
								If (acampocc16{$DA_Return{$xx}}=Substring:C12(ap_PointersToFieldsWTrf{3}->;1;8))  //CCentro_de_costos
									If (cbFacturacion=1)
										If ($vr_montoNeto>=0)
											acampocc2{$DA_Return{$xx}}:=acampocc2{$DA_Return{$xx}}+$vr_montoNeto
										Else 
											acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+Abs:C99($vr_montoNeto)
										End if 
									Else 
										acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+Abs:C99($vr_montoNeto)
									End if 
									$ccta:=aCCID{$DA_Return{$xx}}
									$xx:=Size of array:C274($DA_Return)
									$createNew:=False:C215
								End if 
							End if 
						End for 
						If ($createNew)
							If (cbFacturacion=1)
								$ccta:=ACTwiz_InsertCCtaLine ("fact")
							Else   //pagos
								$ccta:=ACTwiz_InsertCCtaLine ("rec")
							End if 
						End if 
					Else 
						If (cbFacturacion=1)
							$ccta:=ACTwiz_InsertCCtaLine ("fact")
						Else   //pagos
							$ccta:=ACTwiz_InsertCCtaLine ("rec")
						End if 
					End if 
				End if 
				acampo1{$j}:=Substring:C12(ap_PointersToFieldsWTrf{5}->;1;18)  //No_de_Cuenta_contable
				If (cbFacturacion=1)
					$monto:=$vr_montoNeto-$vr_montoIVA
					If ($monto>0)
						acampo3{$j}:=$monto
					Else 
						acampo2{$j}:=Abs:C99($monto)
					End if 
				Else   //pagos
					acampo2{$j}:=[ACT_Pagos:172]Monto_Pagado:5-[ACT_Pagos:172]Saldo:15
				End if 
				acampo4{$j}:=Substring:C12(ap_PointersToFieldsWTrf{6}->;1;60)  //glosa, forma de pago
				acampo16{$j}:=Substring:C12(ap_PointersToFieldsWTrf{7}->;1;8)  //Centro_de_costos
				acampo19{$j}:=Substring:C12(ap_PointersToFieldsWTrf{8}->;1;12)  //CodAuxCta
				aenccuenta{$j}:=$ccta
				aID{$j}:=ptr_Id->
				  //NEXT RECORD(vp_tabla->)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNum);__ ("Recopilando información de facturación..."))
				$j:=$j+1
				  //End while 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			
		Else 
			If (cbRecaudacion=1)
				  //nueva opción Villa Maria
				ARRAY LONGINT:C221($al_recNum;0)
				SELECTION TO ARRAY:C260(vp_tabla->;$al_recNum)
				For ($i;1;Size of array:C274($al_recNum))
					KRL_GotoRecord (vp_tabla;$al_recNum{$i})
					
					ARRAY LONGINT:C221($al_recNumCargos;0)
					READ ONLY:C145([ACT_Transacciones:178])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNumCargos)
					
					$vr_valida:=0
					
					For ($y;1;Size of array:C274($al_recNumCargos))
						GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCargos{$y})
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
						ARRAY LONGINT:C221($al_recNumTransacciones;0)
						SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNumTransacciones)
						$vr_montoNeto:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
						$vr_valida:=$vr_valida+$vr_montoNeto
						$existeccta:=Find in array:C230(acampocc1;Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18))  //no ccta contable
						If ($existeccta=-1)
							$ccta:=ACTwiz_InsertCCtaLine ("recCargos";->$vr_montoNeto)
						Else 
							acampocc1{0}:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)  //no ccta contable
							ARRAY LONGINT:C221($DA_Return;0)
							AT_SearchArray (->acampocc1;"=";->$DA_Return)
							If (Size of array:C274($DA_Return)#0)
								$createNew:=True:C214
								For ($xx;1;Size of array:C274($DA_Return))
									If (acampocc19{$DA_Return{$xx}}=[ACT_Cargos:173]CodAuxCCta:44)  //CodAuxCCta
										If (acampocc16{$DA_Return{$xx}}=Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;8))  //CCentro_de_costos
											If ($vr_montoNeto>0)
												acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+Abs:C99($vr_montoNeto)
											Else 
												acampocc2{$DA_Return{$xx}}:=acampocc2{$DA_Return{$xx}}+Abs:C99($vr_montoNeto)
											End if 
											
											
											$ccta:=aCCID{$DA_Return{$xx}}
											$xx:=Size of array:C274($DA_Return)
											$createNew:=False:C215
										End if 
									End if 
								End for 
								If ($createNew)
									$ccta:=ACTwiz_InsertCCtaLine ("recCargos";->$vr_montoNeto)
								End if 
							Else 
								$ccta:=ACTwiz_InsertCCtaLine ("recCargos";->$vr_montoNeto)
							End if 
						End if 
					End for 
					
					If ($vr_valida#([ACT_Pagos:172]Monto_Pagado:5-[ACT_Pagos:172]Saldo:15))
						$vb_problemas:=True:C214
					End if 
					acampo1{$j}:=Substring:C12(ap_PointersToFieldsWTrf{5}->;1;18)  //No_de_Cuenta_contable
					acampo2{$j}:=[ACT_Pagos:172]Monto_Pagado:5-[ACT_Pagos:172]Saldo:15
					acampo4{$j}:=Substring:C12(ap_PointersToFieldsWTrf{6}->;1;60)  //glosa, forma de pago
					acampo16{$j}:=Substring:C12(ap_PointersToFieldsWTrf{7}->;1;8)  //Centro_de_costos
					acampo19{$j}:=Substring:C12(ap_PointersToFieldsWTrf{8}->;1;12)  //CodAuxCta
					aenccuenta{$j}:=$ccta
					aID{$j}:=ptr_Id->
					  //NEXT RECORD(vp_tabla->)
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNum);__ ("Recopilando información de facturación..."))
					$j:=$j+1
					  //End while 
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
		End if 
	Else 
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de facturación..."))
		ARRAY LONGINT:C221($al_recNum;0)
		SELECTION TO ARRAY:C260(vp_tabla->;$al_recNum)
		For ($i;1;Size of array:C274($al_recNum))
			KRL_GotoRecord (vp_tabla;$al_recNum{$i})
			If (cbFacturacion=1)
				$vr_montoNeto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
				$vr_montoIVA:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_IVA:20;->[ACT_Cargos:173]Monto_IVA:20;Current date:C33(*))
				KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$i})
			Else 
				$vr_montoNeto:=ap_PointersToFieldsWTrf{4}->
			End if 
			$existeccta:=Find in array:C230(acampocc1;Substring:C12(ap_PointersToFieldsWTrf{1}->;1;18))  //no ccta contable
			If ($existeccta=-1)
				If (cbFacturacion=1)
					$ccta:=ACTwiz_InsertCCtaLine ("fact")
				Else   //pagos
					$ccta:=ACTwiz_InsertCCtaLine ("rec")
				End if 
			Else 
				acampocc1{0}:=Substring:C12(ap_PointersToFieldsWTrf{1}->;1;18)  //no ccta contable
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->acampocc1;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)#0)
					$createNew:=True:C214
					For ($xx;1;Size of array:C274($DA_Return))
						If (acampocc19{$DA_Return{$xx}}=ap_PointersToFieldsWTrf{2}->)  //CodAuxCCta
							If (acampocc16{$DA_Return{$xx}}=Substring:C12(ap_PointersToFieldsWTrf{3}->;1;8))  //CCentro_de_costos
								  //acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+[ACT_Cargos]Monto_Neto+[ACT_Cargos]Intereses
								If (cbFacturacion=1)
									  //acampocc2{DA_Return{$xx}}:=acampocc2{DA_Return{$xx}}+[ACT_Cargos]Monto_Neto
									If ($vr_montoNeto>=0)
										acampocc2{$DA_Return{$xx}}:=acampocc2{$DA_Return{$xx}}+$vr_montoNeto
									Else 
										acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+Abs:C99($vr_montoNeto)
									End if 
								Else 
									acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+[ACT_Pagos:172]Monto_Pagado:5
								End if 
								$ccta:=aCCID{$DA_Return{$xx}}
								$xx:=Size of array:C274($DA_Return)
								$createNew:=False:C215
							End if 
						End if 
					End for 
					If ($createNew)
						If (cbFacturacion=1)
							$ccta:=ACTwiz_InsertCCtaLine ("fact")
						Else   //pagos
							$ccta:=ACTwiz_InsertCCtaLine ("rec")
						End if 
					End if 
				Else 
					If (cbFacturacion=1)
						$ccta:=ACTwiz_InsertCCtaLine ("fact")
					Else   //pagos
						$ccta:=ACTwiz_InsertCCtaLine ("rec")
					End if 
				End if 
			End if 
			
			$estacta:=Find in array:C230(acampo1;Substring:C12(ap_PointersToFieldsWTrf{5}->;1;18))  //No_de_Cuenta_contable
			If ($estacta=-1)
				If (cbFacturacion=1)
					ACTwiz_InsertCtaLine ("fact";$ccta)
				Else 
					ACTwiz_InsertCtaLine ("rec";$ccta)
				End if 
			Else 
				acampo1{0}:=Substring:C12(ap_PointersToFieldsWTrf{5}->;1;18)  //No_de_Cuenta_contable
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->acampo1;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)#0)
					$createNew:=True:C214
					For ($xx;1;Size of array:C274($DA_Return))
						If (acampo19{$DA_Return{$xx}}=ap_PointersToFieldsWTrf{8}->)  //CodAuxCta
							If (acampo16{$DA_Return{$xx}}=Substring:C12(ap_PointersToFieldsWTrf{7}->;1;8))  //Centro_de_costos
								If (cbFacturacion=1)
									  //acampo3{DA_Return{$xx}}:=acampo3{DA_Return{$xx}}+([ACT_Cargos]Monto_Neto-[ACT_Cargos]Monto_IVA)
									If (($vr_montoNeto-$vr_montoIVA)>=0)
										acampo3{$DA_Return{$xx}}:=acampo3{$DA_Return{$xx}}+($vr_montoNeto-$vr_montoIVA)
									Else 
										acampo2{$DA_Return{$xx}}:=acampo2{$DA_Return{$xx}}+(Abs:C99(($vr_montoNeto)-$vr_montoIVA))
									End if 
								Else 
									acampo2{$DA_Return{$xx}}:=acampo2{$DA_Return{$xx}}+[ACT_Pagos:172]Monto_Pagado:5-[ACT_Pagos:172]Saldo:15
								End if 
								$xx:=Size of array:C274($DA_Return)+1
								$createNew:=False:C215
							End if 
						End if 
					End for 
					If ($createNew)
						If (cbFacturacion=1)
							ACTwiz_InsertCtaLine ("fact";$ccta)
						Else 
							ACTwiz_InsertCtaLine ("rec";$ccta)
						End if 
					End if 
				Else 
					If (cbFacturacion=1)
						ACTwiz_InsertCtaLine ("fact";$ccta)
					Else 
						ACTwiz_InsertCtaLine ("rec";$ccta)
					End if 
				End if 
			End if 
			NEXT RECORD:C51(vp_tabla->)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNum);__ ("Recopilando información de facturación..."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		Case of 
			: ((fo2=1) | (ro2=1))
				SORT ARRAY:C229(acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo16;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;>)
			: ((fo3=1) | (ro3=1))
				SORT ARRAY:C229(acampo16;acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;>)
		End case 
	End if 
	
	C_LONGINT:C283($indice)
	$indice:=Find in array:C230(aSoftwares;vSoftware)
	If ($indice#-1)
		$id:=al_idsArchivosContables{$indice}
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
			$msg1:="Ingreso de contra cuentas para archivo de emisión"
			$msg2:="Generando archivo de emisión..."
			If (td1=1)
				$msg3:="Emisión"
			Else 
				$msg3:="Proyectado"
			End if 
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
	If (cbFacturacion=1)
		SET_ClearSets ("todos";"desctos";"positivos")
	End if 
Else 
	If (cbFacturacion=1)
		  //$msgNoCargosPagos:="No hay cargos emitidos en el rango de fechas especificado."
		CD_Dlog (0;__ ("No hay cargos emitidos en el rango de fechas especificado."))
	Else 
		  //$msgNoCargosPagos:="No hay pagos en el rango de fechas especificado."
		CD_Dlog (0;__ ("No hay pagos en el rango de fechas especificado."))
	End if 
End if 