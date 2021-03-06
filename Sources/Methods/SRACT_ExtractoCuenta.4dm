//%attributes = {}
  //SRACT_ExtractoCuenta

vi_TipoInforme:=3
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;__ ("Selección del período de generación"))
DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")

CLOSE WINDOW:C154
If (ok=1)
	$0:=True:C214
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
	ARRAY REAL:C219(aMonto;0)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	SELECTION TO ARRAY:C260([ACT_Cargos:173];aRecNums;[ACT_Cargos:173]ID_CuentaCorriente:2;aIdsCtas;[ACT_Cargos:173]Fecha_de_generacion:4;aFecha)
	For ($i;1;Size of array:C274(aRecNums))
		KRL_GotoRecord (->[ACT_Cargos:173];aRecNums{$i})
		APPEND TO ARRAY:C911(aMonto;ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*)))
	End for 
	ARRAY TEXT:C222(aApellidos;0)
	ARRAY TEXT:C222(aApellidos;Size of array:C274(aIdsCtas))
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	For ($i;1;Size of array:C274(aIdsCtas))
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIdsCtas{$i})
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		aApellidos{$i}:=[Alumnos:2]apellidos_y_nombres:40
	End for 
	ARRAY POINTER:C280(aPtrs;0)
	ARRAY LONGINT:C221(aDir;0)
	ARRAY POINTER:C280(aPtrs;4)
	ARRAY LONGINT:C221(aDir;4)
	aPtrs{1}:=->aIdsCtas
	aPtrs{2}:=->aFecha
	aPtrs{3}:=->aMonto
	aPtrs{4}:=->aRecNums
	aDir{1}:=1
	aDir{2}:=1
	aDir{3}:=1
	aDir{4}:=0
	MULTI SORT ARRAY:C718(aPtrs;aDir)
	CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];aRecNums)
	AT_Initialize (->aRecNums;->aIdsCtas;->aFecha;->aMonto;->aApellidos)
	If (Records in selection:C76([ACT_Cargos:173])=0)
		CD_Dlog (0;__ ("No hay cargos generados en el rango de fechas especificado."))
		$0:=False:C215
	End if 
Else 
	$0:=False:C215
End if 