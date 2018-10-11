//%attributes = {}
  //SRACT_ExtractoCuentaApod

vi_TipoInforme:=3

  //LOAD RECORD([Personas])

WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;"Selección del período de generación")
DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")
CLOSE WINDOW:C154


If (ok=1)
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9;=;[Personas:7]No:1;*)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4;=;True:C214)
	ARRAY TEXT:C222(at_CodCtasCtes;0)
	ARRAY DATE:C224(ad_GenDate;0)
	ARRAY REAL:C219(ar_MontoCargo;0)
	ARRAY TEXT:C222(at_AlName;0)
	ARRAY LONGINT:C221(al_Comprobante;0)
	ARRAY DATE:C224(ad_FechaPago;0)
	ARRAY TEXT:C222(at_GlosaPagado;0)
	ARRAY TEXT:C222(at_PeriodoCargo;0)
	ARRAY TEXT:C222(at_CargoGlosa;0)
	ARRAY REAL:C219(ar_MontosPagados;0)
	ARRAY TEXT:C222(at_CursoCta;0)
	C_LONGINT:C283(vl_MontosPagados)
	ARRAY LONGINT:C221(alACT_NumBoleta;0)
	FIRST RECORD:C50([ACT_CuentasCorrientes:175])
	$0:=True:C214
	For ($i;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
		  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]ID_Apoderado=[Personas]No;*)
		Case of 
			: (b1=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4=Current date:C33(*))
				vDate1:=Current date:C33(*)
				vDate2:=vDate1
			: (b3=1)
				$iniDate:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;viAño)
				$endDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vi_selectedMonth;viAño);vi_selectedMonth;viAño)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$iniDate;*)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=$endDate;*)
				vDate1:=$iniDate
				vDate2:=$endDate
			: (b5=1)
				$iniDate:=DT_GetDateFromDayMonthYear (1;1;viAño2)
				$endDate:=DT_GetDateFromDayMonthYear (31;12;viAño2)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$iniDate;*)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=$endDate;*)
				vDate1:=$iniDate
				vDate2:=$endDate
			: (b6=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=vd_Fecha1;*)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=vd_Fecha2;*)
				vDate1:=vd_Fecha1
				vDate2:=vd_Fecha2
		End case 
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
		
		ARRAY LONGINT:C221($al_recNum;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNum)
		For ($j;1;Size of array:C274($al_recNum))
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$j})
			AT_Insert (0;1;->at_CodCtasCtes;->ad_GenDate;->ar_MontoCargo;->at_AlName;->al_Comprobante;->ad_FechaPago;->at_GlosaPagado;->at_PeriodoCargo;->at_CargoGlosa;->ar_MontosPagados;->at_CursoCta)
			at_CodCtasCtes{Size of array:C274(at_CodCtasCtes)}:=[ACT_CuentasCorrientes:175]Codigo:19
			ad_GenDate{Size of array:C274(ad_GenDate)}:=[ACT_Cargos:173]Fecha_de_generacion:4
			at_CargoGlosa{Size of array:C274(at_CargoGlosa)}:=[ACT_Cargos:173]Glosa:12
			ar_MontosPagados{Size of array:C274(ar_MontosPagados)}:=[ACT_Cargos:173]MontosPagados:8
			at_GlosaPagado{Size of array:C274(at_GlosaPagado)}:=ST_Boolean2Str ([ACT_Cargos:173]Saldo:23=0;"SI";ST_Boolean2Str (((-1*[ACT_Cargos:173]Saldo:23)=[ACT_Cargos:173]Monto_Neto:5);"NO";"Parcial"))
			at_PeriodoCargo{Size of array:C274(at_PeriodoCargo)}:=String:C10([ACT_Cargos:173]Mes:13)+" - "+String:C10([ACT_Cargos:173]Año:14)
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1;=;[ACT_CuentasCorrientes:175]ID_Alumno:3)
			at_AlName{Size of array:C274(at_AlName)}:=[Alumnos:2]apellidos_y_nombres:40
			at_CursoCta{Size of array:C274(at_CursoCta)}:=[Alumnos:2]curso:20
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3;=;[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
			al_Comprobante{Size of array:C274(al_Comprobante)}:=[ACT_Transacciones:178]No_Comprobante:10
			ad_FechaPago{Size of array:C274(ad_FechaPago)}:=[ACT_Transacciones:178]Fecha:5
			ar_MontoCargo{Size of array:C274(ar_MontoCargo)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			APPEND TO ARRAY:C911(alACT_NumBoleta;KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]Numero:11))
		End for 
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
	End for 
	ARRAY POINTER:C280(aPtrs;0)
	ARRAY LONGINT:C221(aDir;0)
	ARRAY POINTER:C280(aPtrs;12)
	ARRAY LONGINT:C221(aDir;12)
	aPtrs{1}:=->at_AlName
	aPtrs{2}:=->ad_GenDate
	aPtrs{3}:=->at_CargoGlosa
	aPtrs{4}:=->at_CodCtasCtes
	aPtrs{5}:=->at_CursoCta
	aPtrs{6}:=->at_PeriodoCargo
	aPtrs{7}:=->ar_MontoCargo
	aPtrs{8}:=->at_GlosaPagado
	aPtrs{9}:=->al_Comprobante
	aPtrs{10}:=->ad_FechaPago
	aPtrs{11}:=->ar_MontosPagados
	aPtrs{12}:=->alACT_NumBoleta
	aDir{1}:=1
	aDir{2}:=1
	aDir{3}:=1
	aDir{4}:=0
	aDir{5}:=0
	aDir{6}:=0
	aDir{7}:=0
	aDir{8}:=0
	aDir{9}:=0
	aDir{10}:=0
	aDir{11}:=0
	aDir{12}:=0
	
	MULTI SORT ARRAY:C718(aPtrs;aDir)
	vl_MontosPagados:=AT_GetSumArray (->ar_MontosPagados)
	
	  //If (Records in selection([ACT_Cargos])=0)
	  //CD_Dlog (0;"No hay cargos generados en el rango de fechas especificado.")
	  //$0:=False
	  //End if 
Else 
	$0:=False:C215
End if 