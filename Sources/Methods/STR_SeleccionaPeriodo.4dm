//%attributes = {}
  //STR_SeleccionaPeriodo

PERIODOS_Init 
Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
		LOAD RECORD:C52([Alumnos:2])
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
		LOAD RECORD:C52([Cursos:3])
		PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
		LOAD RECORD:C52([Asignaturas:18])
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Actividades:29]))
		LOAD RECORD:C52([Actividades:29])
		PERIODOS_LoadData (-999;[Actividades:29]ID_ConfiguracionPeriodos:13)
End case 

$devolverPeriodoMasCercano:=True:C214
$periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);$devolverPeriodoMasCercano)
If ((atSTR_Periodos_Nombre=0) & (Size of array:C274(atSTR_Periodos_Nombre)>0))
	atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;$periodo)
End if 

vPeriodo:=0
WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_SeleccionPeriodo";0;Palette form window:K39:9;__ ("Período"))
DIALOG:C40([xxSTR_Constants:1];"STR_SeleccionPeriodo")
CLOSE WINDOW:C154
vPeriodo:=aiSTR_Periodos_Numero{atSTR_Periodos_Nombre}
vsNombrePeriodo:=atSTR_Periodos_Nombre{Find in array:C230(aiSTR_Periodos_Numero;vPeriodo)}