//%attributes = {}
  //SRACT_CargosconDctoxItem

C_DATE:C307(vDate1;vDate2)
C_LONGINT:C283($1)
If (ok=1)
	vi_TipoInforme:=3
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;__ ("Selección del período de generación"))
	DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")
	CLOSE WINDOW:C154
	If (ok=1)
		$0:=True:C214
		Case of 
			: (b1=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=Current date:C33(*))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]PctDescto_XItem:34#0)
				vDate1:=Current date:C33(*)
				vDate2:=vDate1
			: (b3=1)
				$iniDate:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;viAño)
				$endDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vi_selectedMonth;viAño);vi_selectedMonth;viAño)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$iniDate)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=$endDate)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
				vDate1:=$iniDate
				vDate2:=$endDate
			: (b5=1)
				$iniDate:=DT_GetDateFromDayMonthYear (1;1;viAño2)
				$endDate:=DT_GetDateFromDayMonthYear (31;12;viAño2)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$iniDate)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=$endDate)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
				vDate1:=$iniDate
				vDate2:=$endDate
			: (b6=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=vd_Fecha1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=vd_Fecha2)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
				vDate1:=vd_Fecha1
				vDate2:=vd_Fecha2
		End case 
		
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215)
		
		SELECTION TO ARRAY:C260([ACT_Cargos:173];aRecNums;[ACT_Cargos:173]ID_CuentaCorriente:2;aIdsCtas;[ACT_Cargos:173]Fecha_de_generacion:4;aFecha;[ACT_Cargos:173]Monto_Neto:5;aMonto)
		ARRAY TEXT:C222(aApellidos;0)
		ARRAY TEXT:C222(aApellidos;Size of array:C274(aIdsCtas))
		ARRAY TEXT:C222(aCursos;0)
		ARRAY TEXT:C222(aCursos;Size of array:C274(aIdsCtas))
		ARRAY LONGINT:C221(alNivel;0)
		ARRAY LONGINT:C221(alNivel;Size of array:C274(aIdsCtas))
		ARRAY LONGINT:C221(alFamilia;0)
		ARRAY LONGINT:C221(alFamilia;Size of array:C274(aIdsCtas))
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		For ($i;1;Size of array:C274(aIdsCtas))
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIdsCtas{$i})
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			aApellidos{$i}:=[Alumnos:2]apellidos_y_nombres:40
			aCursos{$i}:=[Alumnos:2]curso:20
			alNivel{$i}:=[Alumnos:2]nivel_numero:29
			alFamilia{$i}:=[Alumnos:2]Familia_Número:24
		End for 
		ARRAY POINTER:C280(aPtrs;0)
		ARRAY LONGINT:C221(aDir;0)
		ARRAY POINTER:C280(aPtrs;7)
		ARRAY LONGINT:C221(aDir;7)
		aPtrs{1}:=->alFamilia
		aPtrs{2}:=->alNivel
		aPtrs{3}:=->aCursos
		aPtrs{4}:=->aApellidos
		aPtrs{5}:=->aMonto
		aPtrs{6}:=->aFecha
		aPtrs{7}:=->aRecNums
		aDir{1}:=1
		aDir{2}:=1
		aDir{3}:=1
		aDir{4}:=0
		aDir{5}:=0
		aDir{6}:=0
		aDir{7}:=0
		MULTI SORT ARRAY:C718(aPtrs;aDir)
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];aRecNums)
		AT_Initialize (->aRecNums;->aIdsCtas;->aMonto;->aApellidos;->aCursos;->alNivel;->alFamilia;->aFecha)
		If (Records in selection:C76([ACT_Cargos:173])=0)
			CD_Dlog (0;__ ("No hay cargos generados en el rango de fechas especificado."))
			$0:=False:C215
		End if 
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=False:C215
End if 
