//%attributes = {}
  // MÉTODO: AS_InitVariables
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de modificación: 20/12/11, 18:07:23
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Inicializa variables procesos utilizadas en diferentes instancias en la ficha de la asignatura
  //
  // PARÁMETROS
  // AS_InitVariables()
  // ----------------------------------------------------

  //20120705 RCH
C_TEXT:C284($vt_tipoArreglos)
If (Count parameters:C259>=1)
	$vt_tipoArreglos:=$1
End if 

Case of 
	: ($vt_tipoArreglos="")
		  //alumnos
		ARRAY TEXT:C222(aNtaStdNme;0)
		ARRAY TEXT:C222(aNtaCurso;0)
		ARRAY LONGINT:C221(aNtaIdAlumno;0)
		ARRAY INTEGER:C220(aNtaOrden;0)
		
		  //destrezas
		ARRAY LONGINT:C221(atAS_evObjStudentRecNum;0)
		ARRAY TEXT:C222(atAS_evObjStudentNames;0)
		COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvMode)
		
		  //Configuration
		ARRAY TEXT:C222(<>aSAsgName;0)  //source name
		ARRAY TEXT:C222(<>aSAsgClass;0)  //source class
		ARRAY TEXT:C222(aCsdPop;0)  //area list entry popup
		
		
		  //planes de clases
		ARRAY LONGINT:C221(alSTK_ClassPlanID;0)
		ARRAY DATE:C224(adSTK_ClassPlanFrom;0)
		ARRAY DATE:C224(adSTK_ClassPlanTo;0)
		
		  //Sesiones
		AS_InitVariables ("Sesiones")
		
		  //notas
		vb_NotaOficialVisible:=False:C215
		EV2_InitArrays 
		
		  //Objetivos
		vObj_P1:=""
		vObj_P2:=""
		vObj_P3:=""
		vObj_P4:=""
		vObj_P5:=""
		
		tempObj_P1:=""
		tempObj_P2:=""
		tempObj_P3:=""
		tempObj_P4:=""
		tempObj_P5:=""
		
		vbEVLG_EvaluacionesModificadas:=False:C215
		VlEVLG_currentID:=0
		vlSTR_PeriodoObservaciones:=0
		ARRAY TEXT:C222(atSTR_PeriodosObservaciones;0)
		COPY ARRAY:C226(atSTR_Periodos_Nombre;atSTR_PeriodosObservaciones)
		AT_AppendItems2TextArray (->atSTR_PeriodosObservaciones;__ ("-;Finales"))
		
End case 
