//%attributes = {}
  // MÉTODO: AS_GuardaObjetivos_Alumnos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 27/12/11, 12:36:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AS_GuardaObjetivos_Alumnos()
  // ----------------------------------------------------
C_LONGINT:C283($l_recNumComplementoEvaluacion)
C_TEXT:C284($t_llaveComplementoEvaluacion;$t_Objetivo)


  // CODIGO PRINCIPAL
If (ST_ExactlyEqual (aNtaObj{vl_rowseleccionAL};vt_CuadroTextoObj)=0)
	$t_llaveComplementoEvaluacion:=KRL_MakeStringAccesKey (-><>ginstitucion;-><>gYear;->[Asignaturas:18]Numero_del_Nivel:6;->[Asignaturas:18]Numero:1;->vl_IDAlumnoseleccionadoAL)
	$l_recNumComplementoEvaluacion:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->$t_llaveComplementoEvaluacion;True:C214)
	Case of 
		: (vlSTR_PeriodoSeleccionado=1)
			[Alumnos_ComplementoEvaluacion:209]P01_Objetivos:100:=vt_CuadroTextoObj
		: (vlSTR_PeriodoSeleccionado=2)
			[Alumnos_ComplementoEvaluacion:209]P02_Objetivos:101:=vt_CuadroTextoObj
		: (vlSTR_PeriodoSeleccionado=3)
			[Alumnos_ComplementoEvaluacion:209]P03_Objetivos:102:=vt_CuadroTextoObj
		: (vlSTR_PeriodoSeleccionado=4)
			[Alumnos_ComplementoEvaluacion:209]P04_Objetivos:103:=vt_CuadroTextoObj
		: (vlSTR_PeriodoSeleccionado=5)
			[Alumnos_ComplementoEvaluacion:209]P05_Objetivos:104:=vt_CuadroTextoObj
		: (vlSTR_PeriodoSeleccionado=0)
			[Alumnos_ComplementoEvaluacion:209]Final_objetivos:105:=vt_CuadroTextoObj
	End case 
	$t_Objetivo:=aNtaObj{vl_rowseleccionAL}
	AS_RegistroActividades ("Objetivo por Alumno";->$t_Objetivo;->vt_CuadroTextoObj;->sPeriodo)
	
	SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
End if 
aNtaObj{vl_rowseleccionAL}:=vt_CuadroTextoObj
GOTO OBJECT:C206(vt_CuadroTextoObj)
HIGHLIGHT TEXT:C210(vt_CuadroTextoObj;Length:C16(vt_CuadroTextoObj)+1;Length:C16(vt_CuadroTextoObj))
