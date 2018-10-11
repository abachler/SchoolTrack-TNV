//%attributes = {}
  // AS_PaginaAsistencia()
  //
  //
  // creado por: Alberto Bachler Klein: 09-04-16, 14:55:29
  // -----------------------------------------------------------
C_LONGINT:C283($i_alumnos;$i_periodos;$i_Sesiones;$l_año;$l_modoRegistroAsistencia;$l_records)
C_POINTER:C301($y_alumnos;$y_arreglo;$y_curso;$y_inasistenciasAnual;$y_inasistenciasP1;$y_inasistenciasP2;$y_inasistenciasP3;$y_inasistenciasP4;$y_inasistenciasP5;$y_inasistenciasPorcentaje;$y_margen)

ARRAY LONGINT:C221($al_recNums;0)

$l_año:=<>gYear
$y_margen:=OBJECT Get pointer:C1124(Object named:K67:5;"vacio")
$y_alumnos:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_alumno")
$y_curso:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_curso")
$y_inasistenciasP1:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_P1")
$y_inasistenciasP2:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_P2")
$y_inasistenciasP3:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_P3")
$y_inasistenciasP4:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_P4")
$y_inasistenciasP5:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_P5")
$y_inasistenciasAnual:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_anual")
$y_inasistenciasPorcentaje:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_porcentaje")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1;$l_año)

  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;<;[Alumnos:2]no_de_lista:53;>)
				Else 
					ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;>;[Alumnos:2]no_de_lista:53;>)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;<;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					Else 
						ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;<;[Alumnos:2]apellidos_y_nombres:40;>)
					End if 
				Else 
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					Else 
						ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;>;[Alumnos:2]apellidos_y_nombres:40;>)
					End if 
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;<;[Alumnos:2]apellidos_y_nombres:40;>)
				Else 
					ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;>;[Alumnos:2]apellidos_y_nombres:40;>)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]no_de_lista:53;>)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		Else 
			ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]apellidos_y_nombres:40;>)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]apellidos_y_nombres:40;>)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //Else 
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]apellidos_y_nombres;>)
  //End if 
  //: (<>gOrdenNta=1)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]no_de_lista;>)
  //: (<>gOrdenNta=2)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]apellidos_y_nombres;>)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Sexo;<;[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //Else 
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Sexo;<;[Alumnos]apellidos_y_nombres;>)
  //End if 
  //: (<>gOrdenNta=1)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Sexo;<;[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //: (<>gOrdenNta=2)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Sexo;<;[Alumnos]apellidos_y_nombres;>)
  //End case 
  //End if 



SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209];$al_recNums;[Alumnos:2]apellidos_y_nombres:40;$y_alumnos->;[Alumnos:2]curso:20;$y_curso->;[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;$y_inasistenciasP1->;[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;$y_inasistenciasP2->;[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;$y_inasistenciasP3->;[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;$y_inasistenciasP4->;[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;$y_inasistenciasP5->)
ARRAY LONGINT:C221($y_inasistenciasAnual->;Size of array:C274($al_recNums))
ARRAY REAL:C219($y_inasistenciasPorcentaje->;Size of array:C274($al_recNums))
ARRAY TEXT:C222($y_margen->;Size of array:C274($al_recNums))
$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)

Case of 
	: ($l_modoRegistroAsistencia=4)
		ARRAY INTEGER:C220($y_inasistenciasAnual->;Size of array:C274($al_recNums))
		ARRAY REAL:C219($y_inasistenciasPorcentaje->;Size of array:C274($al_recNums))
		For ($i_Sesiones;1;Size of array:C274($al_recNums))
			$y_inasistenciasAnual->{$i_Sesiones}:=$y_inasistenciasP1->{$i_Sesiones}+$y_inasistenciasP2->{$i_Sesiones}+$y_inasistenciasP3->{$i_Sesiones}+$y_inasistenciasP4->{$i_Sesiones}+$y_inasistenciasP5->{$i_Sesiones}
			$y_inasistenciasPorcentaje->{$i_Sesiones}:=100-Round:C94($y_inasistenciasAnual->{$i_Sesiones}/[Asignaturas:18]Horas_de_clases_efectivas:52*100;1)
		End for 
		FORM GOTO PAGE:C247(9)
		
	: ($l_modoRegistroAsistencia=2)
		READ ONLY:C145([Asignaturas_Inasistencias:125])
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
		  //
		For ($i_alumnos;1;Size of array:C274($al_recNums))
			$l_records:=0
			$y_inasistenciasAnual->{$i_alumnos}:=0  //20170808 ASM Ticket 186884
			For ($i_periodos;1;Size of array:C274(adSTR_Periodos_Desde))
				KRL_GotoRecord (->[Alumnos_ComplementoEvaluacion:209];$al_recNums{$i_alumnos};False:C215)
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6;=;[Asignaturas:18]Numero:1;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Alumno:2;=;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4;>=;adSTR_Periodos_Desde{$i_periodos};*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4;<=;adSTR_Periodos_Hasta{$i_periodos})
				$y_arreglo:=OBJECT Get pointer:C1124(Object named:K67:5;"inasistencias_P"+String:C10($i_periodos))
				$y_arreglo->{$i_alumnos}:=$l_records
				$y_inasistenciasAnual->{$i_alumnos}:=$y_inasistenciasAnual->{$i_alumnos}+$l_records
			End for 
			  //20170808 ASM Ticket 186884
			If ([Asignaturas:18]Horas_de_clases_efectivas:52>0)
				$y_inasistenciasPorcentaje->{$i_alumnos}:=100-Round:C94($y_inasistenciasAnual->{$i_alumnos}/[Asignaturas:18]Horas_de_clases_efectivas:52*100;1)
			Else 
				$y_inasistenciasPorcentaje->{$i_alumnos}:=0
			End if 
		End for 
		  //
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		
		$l_anchoColumnasPeriodos:=60
		For ($i_periodos;1;Size of array:C274(atSTR_Periodos_Nombre))
			OBJECT SET VISIBLE:C603(*;"inasistencias_P"+String:C10($i_periodos);True:C214)
			OBJECT SET TITLE:C194(*;"hdr_periodo"+String:C10($i_periodos);atSTR_Periodos_Nombre{$i_periodos})
		End for 
		
		LISTBOX SET COLUMN WIDTH:C833(*;"inasistenciasP_@";70)
		LISTBOX SET COLUMN WIDTH:C833(*;"inasistencias_alumno";120)  // Modificado por: Alexis Bustamante (02-08-2017) Ticket 186521
		$l_anchoListbox:=IT_Objeto_Ancho ("lb_inasistenciaSesiones")
		$l_anchoDisponible:=70*(5-Size of array:C274(atSTR_Periodos_Nombre))
		
		If ($l_anchoDisponible>0)
			$l_anchoAlumno:=LISTBOX Get column width:C834(*;"inasistencias_alumno")
			LISTBOX SET COLUMN WIDTH:C833(*;"inasistencias_alumno";$l_anchoAlumno+$l_anchoDisponible)
		End if 
		
		OBJECT SET RGB COLORS:C628(*;"lb_inasistenciaSesiones";0;0x00FFFFFF;color RGB whitesmoke)
		
		FORM GOTO PAGE:C247(9)
		
	Else 
		AS_OnRecordLoad (1)
End case 




