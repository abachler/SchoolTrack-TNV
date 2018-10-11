//%attributes = {}
  //SRACT_CartolaApoderado
  //20121122 RCH Se cambia forma de buscar cargos pq si el alumno no tiene asignado el apdo de cta los cargos no salen en el informe. Tampoco salian si eran de ventas rapidas.
  //ACT_relacionaCtasyApdos (2)
  //READ ONLY([ACT_Cargos])
  //LOAD RECORD([Personas])
  //
  //ARRAY LONGINT(alACT_CargosRecNum;0)
  //ARRAY DATE(adACT_FechaEmision;0)
  //ARRAY TEXT(atACT_GlosaCartola;0)
  //ARRAY REAL(arACT_CargoMonto;0)
  //ARRAY TEXT(atACT_CargoPeriodo;0)
  //ARRAY TEXT(atACT_AlumnoCartola;0)
  //ARRAY LONGINT(alACT_NivelAlumno;0)
  //ARRAY TEXT(atACT_CursoCartola;0)
  //FIRST RECORD([ACT_CuentasCorrientes])
  //
  //For ($o;1;Records in selection([ACT_CuentasCorrientes]))
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente;=;[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]ID_Apoderado;=;[Personas]No)
  //Case of 
  //: (b1=1)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Fecha_de_generacion=Current date(*))
  //vDate1:=Current date(*)
  //vDate2:=vDate1
  //: (b3=1)
  //$iniDate:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;viAño)
  //$endDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vi_selectedMonth;viAño);vi_selectedMonth;viAño)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision>=$iniDate;*)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision<=$endDate;*)
  //vDate1:=$iniDate
  //vDate2:=$endDate
  //: (b5=1)
  //$iniDate:=DT_GetDateFromDayMonthYear (1;1;viAño2)
  //$endDate:=DT_GetDateFromDayMonthYear (31;12;viAño2)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision>=$iniDate;*)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision<=$endDate;*)
  //vDate1:=$iniDate
  //vDate2:=$endDate
  //: (b6=1)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision>=vd_Fecha1;*)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision<=vd_Fecha2;*)
  //vDate1:=vd_Fecha1
  //vDate2:=vd_Fecha2
  //End case 
  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]EsRelativo=False)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-129)
  //SELECTION TO ARRAY([ACT_Cargos];alACT_CargosRecNum)
  //For ($i;1;Size of array(alACT_CargosRecNum))
  //GOTO RECORD([ACT_Cargos];alACT_CargosRecNum{$i})
  //AT_Insert (0;1;->adACT_FechaEmision;->atACT_GlosaCartola;->arACT_CargoMonto;->atACT_CargoPeriodo;->atACT_AlumnoCartola;->atACT_CursoCartola;->alACT_NivelAlumno)
  //adACT_FechaEmision{Size of array(adACT_FechaEmision)}:=[ACT_Cargos]FechaEmision
  //atACT_GlosaCartola{Size of array(atACT_GlosaCartola)}:=[ACT_Cargos]Glosa
  //atACT_CargoPeriodo{Size of array(atACT_CargoPeriodo)}:=String([ACT_Cargos]Mes)+" - "+String([ACT_Cargos]Año)
  //QUERY([Alumnos];[Alumnos]Número;=;[ACT_CuentasCorrientes]ID_Alumno)
  //atACT_AlumnoCartola{Size of array(atACT_AlumnoCartola)}:=[Alumnos]Apellidos_y_Nombres
  //atACT_CursoCartola{Size of array(atACT_CursoCartola)}:=[Alumnos]Curso
  //alACT_NivelAlumno{Size of array(alACT_NivelAlumno)}:=[Alumnos]Nivel_Número
  //arACT_CargoMonto{Size of array(arACT_CargoMonto)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Monto_Neto;->[ACT_Cargos]Monto_Neto;Current date(*))
  //End for 
  //
  //NEXT RECORD([ACT_CuentasCorrientes])
  //End for 

READ ONLY:C145([ACT_Cargos:173])
LOAD RECORD:C52([Personas:7])

QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
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
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-129)

ARRAY LONGINT:C221(alACT_CargosRecNum;0)
ARRAY DATE:C224(adACT_FechaEmision;0)
ARRAY TEXT:C222(atACT_GlosaCartola;0)
ARRAY REAL:C219(arACT_CargoMonto;0)
ARRAY TEXT:C222(atACT_CargoPeriodo;0)
ARRAY TEXT:C222(atACT_AlumnoCartola;0)
ARRAY LONGINT:C221(alACT_NivelAlumno;0)
ARRAY TEXT:C222(atACT_CursoCartola;0)
FIRST RECORD:C50([ACT_CuentasCorrientes:175])

LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];alACT_CargosRecNum;"")

For ($o;1;Size of array:C274(alACT_CargosRecNum))
	GOTO RECORD:C242([ACT_Cargos:173];alACT_CargosRecNum{$o})
	KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
	KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
	
	AT_Insert (0;1;->adACT_FechaEmision;->atACT_GlosaCartola;->arACT_CargoMonto;->atACT_CargoPeriodo;->atACT_AlumnoCartola;->atACT_CursoCartola;->alACT_NivelAlumno)
	adACT_FechaEmision{Size of array:C274(adACT_FechaEmision)}:=[ACT_Cargos:173]FechaEmision:22
	atACT_GlosaCartola{Size of array:C274(atACT_GlosaCartola)}:=[ACT_Cargos:173]Glosa:12
	atACT_CargoPeriodo{Size of array:C274(atACT_CargoPeriodo)}:=String:C10([ACT_Cargos:173]Mes:13)+" - "+String:C10([ACT_Cargos:173]Año:14)
	  //QUERY([Alumnos];[Alumnos]Número;=;[ACT_CuentasCorrientes]ID_Alumno)
	atACT_AlumnoCartola{Size of array:C274(atACT_AlumnoCartola)}:=[Alumnos:2]apellidos_y_nombres:40
	atACT_CursoCartola{Size of array:C274(atACT_CursoCartola)}:=[Alumnos:2]curso:20
	alACT_NivelAlumno{Size of array:C274(alACT_NivelAlumno)}:=[Alumnos:2]nivel_numero:29
	arACT_CargoMonto{Size of array:C274(arACT_CargoMonto)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
End for 

vrACT_MontoTotal:=AT_GetSumArray (->arACT_CargoMonto)
ARRAY POINTER:C280(aPtrs;0)
ARRAY LONGINT:C221(aDir;0)
ARRAY POINTER:C280(aPtrs;7)
ARRAY LONGINT:C221(aDir;7)
aPtrs{1}:=->adACT_FechaEmision
aPtrs{2}:=->atACT_CargoPeriodo
aPtrs{3}:=->alACT_NivelAlumno
aPtrs{4}:=->atACT_CursoCartola
aPtrs{5}:=->atACT_AlumnoCartola
aPtrs{6}:=->atACT_GlosaCartola
aPtrs{7}:=->arACT_CargoMonto

aDir{1}:=1
aDir{2}:=1
aDir{3}:=1
aDir{4}:=1
aDir{5}:=1
aDir{6}:=0
aDir{7}:=0
MULTI SORT ARRAY:C718(aPtrs;aDir)




