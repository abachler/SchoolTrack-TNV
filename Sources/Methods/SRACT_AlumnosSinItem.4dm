//%attributes = {}
  //SRACT_AlumnosSinItem

C_DATE:C307(vDate1;vDate2)
C_LONGINT:C283($1)

ok:=1

WDW_OpenFormWindow (->[xxSTR_Constants:1];"SRACT_SeleccionaItem";0;Palette form window:K39:9;__ ("Selección del item"))
DIALOG:C40([xxSTR_Constants:1];"SRACT_SeleccionaItem")
CLOSE WINDOW:C154

If (ok=1)
	vi_TipoInforme:=3
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;__ ("Selección del período de generación"))
	DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")
	CLOSE WINDOW:C154
	KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
	If (ok=1)
		$0:=True:C214
		Case of 
			: (b1=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=Current date:C33(*))
				vDate1:=Current date:C33(*)
				vDate2:=vDate1
			: (b3=1)
				$iniDate:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;viAño)
				$endDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vi_selectedMonth;viAño);vi_selectedMonth;viAño)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$iniDate)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=$endDate)
				vDate1:=$iniDate
				vDate2:=$endDate
			: (b5=1)
				$iniDate:=DT_GetDateFromDayMonthYear (1;1;viAño2)
				$endDate:=DT_GetDateFromDayMonthYear (31;12;viAño2)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$iniDate)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=$endDate)
				vDate1:=$iniDate
				vDate2:=$endDate
			: (b6=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=vd_Fecha1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<=vd_Fecha2)
				vDate1:=vd_Fecha1
				vDate2:=vd_Fecha2
		End case 
		
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215)
		CREATE SET:C116([ACT_CuentasCorrientes:175];"todasCtas")
		CREATE SET:C116([ACT_Cargos:173];"todos")
		SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$aIDsCtas)
		For ($i;1;Size of array:C274($aIDsCtas))
			USE SET:C118("todos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$aIDsCtas{$i})
			SET QUERY LIMIT:C395(1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vlACT_RefItem)
			SET QUERY LIMIT:C395(0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($recs=1)
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$aIDsCtas{$i})
				REMOVE FROM SET:C561([ACT_CuentasCorrientes:175];"todasCtas")
			End if 
		End for 
		USE SET:C118("todasCtas")
		
		SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;aIdsCtas)
		ARRAY TEXT:C222(aApellidos;0)
		ARRAY TEXT:C222(aApellidos;Size of array:C274(aIdsCtas))
		ARRAY TEXT:C222(aCursos;0)
		ARRAY TEXT:C222(aCursos;Size of array:C274(aIdsCtas))
		ARRAY LONGINT:C221(aNivelNum;0)
		ARRAY LONGINT:C221(aNivelNum;Size of array:C274(aIdsCtas))
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		For ($i;1;Size of array:C274(aIdsCtas))
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIdsCtas{$i})
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			aApellidos{$i}:=[Alumnos:2]apellidos_y_nombres:40
			aCursos{$i}:=[Alumnos:2]curso:20
			aNivelNum{$i}:=[Alumnos:2]nivel_numero:29
		End for 
		ARRAY POINTER:C280(aPtrs;0)
		ARRAY LONGINT:C221(aDir;0)
		ARRAY POINTER:C280(aPtrs;3)
		ARRAY LONGINT:C221(aDir;3)
		aPtrs{1}:=->aNivelNum
		aPtrs{2}:=->aCursos
		aPtrs{3}:=->aApellidos
		aDir{1}:=1
		aDir{2}:=1
		aDir{3}:=1
		MULTI SORT ARRAY:C718(aPtrs;aDir)
		USE SET:C118("todasCtas")
		AT_Initialize (->aApellidos;->aCursos;->aNivelNum)
		If (Records in selection:C76([ACT_CuentasCorrientes:175])=0)
			CD_Dlog (0;__ ("No hay cargos generados en el rango de fechas especificado."))
			$0:=False:C215
		End if 
		SET_ClearSets ("todos";"todasCtas")
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=False:C215
End if 
