//%attributes = {}
  //ACTwiz_GenerarXAvisos

AT_Initialize (->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
AT_Initialize (->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
READ ONLY:C145([ACT_Cargos:173])
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
Case of 
	: (b1=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$day:=Day of:C23(Current date:C33(*))
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=Current date:C33(*))
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
	: (b3=1)
		$year:=viAño
		$dateIni:=DT_GetDateFromDayMonthYear (1;vi_SelectedMonth;$year)
		$lastDay:=DT_GetLastDay (vi_SelectedMonth;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;vi_SelectedMonth;$year)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$DateEnd)
		$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
	: (b5=1)
		$year:=viAño2
		$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
		$lastDay:=DT_GetLastDay (12;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;12;$year)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$DateEnd)
		$fileName:=String:C10($year)
	: (b6=1)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=vd_Fecha1;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=vd_Fecha2)
		$vt_Fecha1:=Replace string:C233(vt_Fecha1;<>tXS_RS_DateSeparator;"")
		$vt_Fecha2:=Replace string:C233(vt_Fecha2;<>tXS_RS_DateSeparator;"")
		$fileName:=$vt_Fecha1+"al"+$vt_Fecha2
End case 
$fileName:="Emision"+$fileName
If (SYS_IsWindows )
	$fileName:=$fileName+".txt"
End if 

If (cbNoEnDT=1)
	  //20140324 RCH quito descuentos por NC y devolucion NC
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]No_Incluir_en_DocTrib:50=True:C214;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-127;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-128;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129)
End if 

If (Records in selection:C76([ACT_Cargos:173])>0)
	CREATE SET:C116([ACT_Cargos:173];"todos")
	  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Monto_Neto<0)`MOD DSCTO POR CAJA 20070817
	  //CREATE SET([ACT_Cargos];"desctos") `MOD DSCTO POR CAJA 20070817
	  //DIFFERENCE("todos";"desctos";"positivos") `MOD DSCTO POR CAJA 20070817
	  //USE SET("positivos") `MOD DSCTO POR CAJA 20070817
	If (cbResumidoF=0)
		Case of 
			: (fo2=1)
				ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]No_de_Cuenta_contable:17;>)
			: (fo3=1)
				ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Centro_de_costos:15;>)
		End case 
		AT_RedimArrays (Records in selection:C76([ACT_Cargos:173]);->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de facturación..."))
		$j:=1
		
		ARRAY LONGINT:C221($al_recNum;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNum)
		For ($i;1;Size of array:C274($al_recNum))
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$i})
			$vr_montoNeto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			$vr_montoIVA:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_IVA:20;->[ACT_Cargos:173]Monto_IVA:20;Current date:C33(*))
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$i})
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
								If ($vr_montoNeto>=0)
									acampocc2{$DA_Return{$xx}}:=acampocc2{$DA_Return{$xx}}+$vr_montoNeto
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
						$ccta:=ACTwiz_InsertCCtaLine ("fact")
					End if 
				Else 
					$ccta:=ACTwiz_InsertCCtaLine ("fact")
				End if 
			End if 
			acampo1{$j}:=Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18)
			If (($vr_montoNeto-$vr_montoIVA)>=0)
				acampo3{$j}:=$vr_montoNeto-$vr_montoIVA
			Else 
				acampo2{$j}:=Abs:C99($vr_montoNeto)-$vr_montoIVA
			End if 
			acampo4{$j}:=Substring:C12([ACT_Cargos:173]Glosa:12;1;60)
			acampo16{$j}:=Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;8)
			acampo19{$j}:=Substring:C12([ACT_Cargos:173]CodAuxCta:43;1;12)
			aenccuenta{$j}:=$ccta
			aID{$j}:=[ACT_Cargos:173]ID:1
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNum);__ ("Recopilando información de facturación..."))
			$j:=$j+1
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de facturación..."))
		ARRAY LONGINT:C221($al_recNum;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNum)
		For ($i;1;Size of array:C274($al_recNum))
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$i})
			$vr_montoNeto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			$vr_montoIVA:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_IVA:20;->[ACT_Cargos:173]Monto_IVA:20;Current date:C33(*))
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$i})
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
								If ($vr_montoNeto>=0)
									acampocc2{$DA_Return{$xx}}:=acampocc2{$DA_Return{$xx}}+$vr_montoNeto
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
								If (($vr_montoNeto-$vr_montoIVA)>=0)
									acampo3{$DA_Return{$xx}}:=acampo3{$DA_Return{$xx}}+($vr_montoNeto-$vr_montoIVA)
								Else 
									acampo2{$DA_Return{$xx}}:=acampo2{$DA_Return{$xx}}+(Abs:C99(($vr_montoNeto)-$vr_montoIVA))
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
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNum);__ ("Recopilando información de facturación..."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		Case of 
			: (fo2=1)
				SORT ARRAY:C229(acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo16;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;>)
			: (fo3=1)
				SORT ARRAY:C229(acampo16;acampo1;acampo2;acampo3;acampo4;acampo5;acampo6;acampo7;acampo8;acampo9;acampo10;acampo11;acampo12;acampo13;acampo14;acampo15;acampo17;acampo18;acampo19;acampo20;acampo21;acampo22;acampo23;acampo24;acampo25;acampo26;acampo27;acampo28;acampo29;acampo30;acampo31;acampo32;acampo33;acampo34;acampo35;acampo36;acampo37;acampo38;acampo39;aenccuenta;aID;>)
		End case 
	End if 
	ACTwiz_GeneraArchContable ("Ingreso de contra cuentas para archivo de emisión";"Generando archivo de emisión...";$fileName;"Emisión")
	SET_ClearSets ("todos";"desctos";"positivos")
Else 
	CD_Dlog (0;__ ("No hay cargos emitidos en el rango de fechas especificado."))
End if 