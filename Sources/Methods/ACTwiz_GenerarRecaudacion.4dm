//%attributes = {}
  //ACTwiz_GenerarRecaudacion

AT_Initialize (->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
AT_Initialize (->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
READ ONLY:C145([ACT_Pagos:172])
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Venta_Rapida:10=False:C215;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
  // se quitan notas de credito
QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30#-12)
Case of 
	: (b1=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$day:=Day of:C23(Current date:C33(*))
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=Current date:C33(*))
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
		vd_Fecha1:=Current date:C33(*)
		vd_Fecha2:=Current date:C33(*)
	: (b3=1)
		$year:=viAño
		$dateIni:=DT_GetDateFromDayMonthYear (1;vi_SelectedMonth;$year)
		$lastDay:=DT_GetLastDay (vi_SelectedMonth;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;vi_SelectedMonth;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
		vd_Fecha1:=$dateIni
		vd_Fecha2:=$dateEnd
	: (b5=1)
		$year:=viAño2
		$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
		$lastDay:=DT_GetLastDay (12;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;12;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:=String:C10($year)
		vd_Fecha1:=$dateIni
		vd_Fecha2:=$dateEnd
	: (b6=1)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_Fecha1;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=vd_Fecha2)
		$vt_Fecha1:=Replace string:C233(vt_Fecha1;<>tXS_RS_DateSeparator;"")
		$vt_Fecha2:=Replace string:C233(vt_Fecha2;<>tXS_RS_DateSeparator;"")
		$fileName:=$vt_Fecha1+"al"+$vt_Fecha2
End case 
$fileName:="Recaudacion"+$fileName
If (SYS_IsWindows )
	$fileName:=$fileName+".txt"
End if 
If (Records in selection:C76([ACT_Pagos:172])>0)
	If (cbResumidoR=0)
		Case of 
			: (ro2=1)
				ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]No_Cuenta_Contable:16;>)
			: (ro3=1)
				ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]Centro_de_costos:17;>)
		End case 
		AT_RedimArrays (Records in selection:C76([ACT_Pagos:172]);->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de recaudación..."))
		$j:=1
		FIRST RECORD:C50([ACT_Pagos:172])
		While (Not:C34(End selection:C36([ACT_Pagos:172])))
			$existeccta:=Find in array:C230(acampocc1;Substring:C12([ACT_Pagos:172]No_CCta_Contable:19;1;18))
			If ($existeccta=-1)
				$ccta:=ACTwiz_InsertCCtaLine ("rec")
			Else 
				acampocc1{0}:=Substring:C12([ACT_Pagos:172]No_CCta_Contable:19;1;18)
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->acampocc1;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)#0)
					$createNew:=True:C214
					For ($xx;1;Size of array:C274($DA_Return))
						If (acampocc19{$DA_Return{$xx}}=[ACT_Pagos:172]CodAuxCCta:23)
							If (acampocc16{$DA_Return{$xx}}=Substring:C12([ACT_Pagos:172]CCentro_de_costos:20;1;8))
								acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+[ACT_Pagos:172]Monto_Pagado:5
								$ccta:=aCCID{$DA_Return{$xx}}
								$xx:=Size of array:C274($DA_Return)
								$createNew:=False:C215
							End if 
						End if 
					End for 
					If ($createNew)
						$ccta:=ACTwiz_InsertCCtaLine ("rec")
					End if 
				Else 
					$ccta:=ACTwiz_InsertCCtaLine ("rec")
				End if 
			End if 
			acampo1{$j}:=Substring:C12([ACT_Pagos:172]No_Cuenta_Contable:16;1;18)
			acampo2{$j}:=[ACT_Pagos:172]Monto_Pagado:5-[ACT_Pagos:172]Saldo:15
			acampo4{$j}:=Substring:C12([ACT_Pagos:172]forma_de_pago_new:31;1;60)
			acampo16{$j}:=Substring:C12([ACT_Pagos:172]Centro_de_costos:17;1;8)
			acampo19{$j}:=Substring:C12([ACT_Pagos:172]CodAuxCta:22;1;12)
			aenccuenta{$j}:=$ccta
			aID{$j}:=[ACT_Pagos:172]ID:1
			NEXT RECORD:C51([ACT_Pagos:172])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ACT_Pagos:172])/Records in selection:C76([ACT_Pagos:172]);__ ("Recopilando información de recaudación..."))
			$j:=$j+1
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de recaudación..."))
		$j:=1
		FIRST RECORD:C50([ACT_Pagos:172])
		While (Not:C34(End selection:C36([ACT_Pagos:172])))
			$existeccta:=Find in array:C230(acampocc1;Substring:C12([ACT_Pagos:172]No_CCta_Contable:19;1;18))
			If ($existeccta=-1)
				$ccta:=ACTwiz_InsertCCtaLine ("rec")
			Else 
				acampocc1{0}:=Substring:C12([ACT_Pagos:172]No_CCta_Contable:19;1;18)
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->acampocc1;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)#0)
					$createNew:=True:C214
					For ($xx;1;Size of array:C274($DA_Return))
						If (acampocc19{$DA_Return{$xx}}=[ACT_Pagos:172]CodAuxCCta:23)
							If (acampocc16{$DA_Return{$xx}}=Substring:C12([ACT_Pagos:172]CCentro_de_costos:20;1;8))
								acampocc3{$DA_Return{$xx}}:=acampocc3{$DA_Return{$xx}}+[ACT_Pagos:172]Monto_Pagado:5
								$ccta:=aCCID{$DA_Return{$xx}}
								$xx:=Size of array:C274($DA_Return)
								$createNew:=False:C215
							End if 
						End if 
					End for 
					If ($createNew)
						$ccta:=ACTwiz_InsertCCtaLine ("rec")
					End if 
				Else 
					$ccta:=ACTwiz_InsertCCtaLine ("rec")
				End if 
			End if 
			$estacta:=Find in array:C230(acampo1;Substring:C12([ACT_Pagos:172]No_Cuenta_Contable:16;1;18))
			If ($estacta=-1)
				ACTwiz_InsertCtaLine ("rec";$ccta)
			Else 
				acampo1{0}:=Substring:C12([ACT_Pagos:172]No_Cuenta_Contable:16;1;18)
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->acampo1;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)#0)
					$createNew:=True:C214
					For ($xx;1;Size of array:C274($DA_Return))
						If (acampo19{$DA_Return{$xx}}=[ACT_Pagos:172]CodAuxCta:22)
							If (acampo16{$DA_Return{$xx}}=Substring:C12([ACT_Pagos:172]Centro_de_costos:17;1;8))
								acampo2{$DA_Return{$xx}}:=acampo2{$DA_Return{$xx}}+[ACT_Pagos:172]Monto_Pagado:5-[ACT_Pagos:172]Saldo:15
								$xx:=Size of array:C274($DA_Return)+1
								$createNew:=False:C215
							End if 
						End if 
					End for 
					If ($createNew)
						ACTwiz_InsertCtaLine ("rec";$ccta)
					End if 
				Else 
					ACTwiz_InsertCtaLine ("rec";$ccta)
				End if 
			End if 
			NEXT RECORD:C51([ACT_Pagos:172])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ACT_Pagos:172])/Records in selection:C76([ACT_Pagos:172]);__ ("Recopilando información de recaudación..."))
			$j:=$j+1
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		Case of 
			: (ro2=1)
				SORT ARRAY:C229(acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo16;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;>)
			: (ro3=1)
				SORT ARRAY:C229(acampo16;acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;>)
		End case 
	End if 
	ACTwiz_GeneraArchContable ("Ingreso de contra cuentas para archivo de recaudación";"Generando archivo de recaudación...";$fileName;"Recaudación")
Else 
	CD_Dlog (0;__ ("No hay pagos en el rango de fechas especificado."))
End if 