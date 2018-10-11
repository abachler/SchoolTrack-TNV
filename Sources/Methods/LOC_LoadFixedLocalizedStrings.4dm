//%attributes = {}
  // LOC_LoadFixedLocalizedStrings()
  // Por: Alberto Bachler: 17/09/13, 13:43:54
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



ARRAY TEXT:C222(<>atXS_MonthNames;12)
<>atXS_MonthNames{1}:=__ ("Enero")
<>atXS_MonthNames{2}:=__ ("Febrero")
<>atXS_MonthNames{3}:=__ ("Marzo")
<>atXS_MonthNames{4}:=__ ("Abril")
<>atXS_MonthNames{5}:=__ ("Mayo")
<>atXS_MonthNames{6}:=__ ("Junio")
<>atXS_MonthNames{7}:=__ ("Julio")
<>atXS_MonthNames{8}:=__ ("Agosto")
<>atXS_MonthNames{9}:=__ ("Septiembre")
<>atXS_MonthNames{10}:=__ ("Octubre")
<>atXS_MonthNames{11}:=__ ("Noviembre")
<>atXS_MonthNames{12}:=__ ("Diciembre")

ARRAY TEXT:C222(<>atXS_DayNames;7)
<>atXS_DayNames{1}:=__ ("Domingo")
<>atXS_DayNames{2}:=__ ("Lunes")
<>atXS_DayNames{3}:=__ ("Martes")
<>atXS_DayNames{4}:=__ ("Miércoles")
<>atXS_DayNames{5}:=__ ("Jueves")
<>atXS_DayNames{6}:=__ ("Viernes")
<>atXS_DayNames{7}:=__ ("Sábado")


  //operadores Queries
ARRAY TEXT:C222(<>atXS_QueryOperators_Text;0)
ARRAY TEXT:C222(<>atXS_QueryOperators_Symbol;0)
ARRAY LONGINT:C221(<>alXS_QueryOperators_NumRef;0)
  //=...@"
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("comienza con"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;"=")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;1)
  //=
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("es igual a"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;"=")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;2)
  //#
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("es distinto de"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;"#")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;3)
  //>
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("es superior a"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;">")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;4)
  //>=
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("es superior o igual a"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;">=")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;5)
  //<
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("es inferior a"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;"<")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;6)
  //<=
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("es inferior o igual a"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;"")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;7)
  //= @...@
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("contiene"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;"")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;8)
  //# @...@
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Text;__ ("no contiene"))
APPEND TO ARRAY:C911(<>atXS_QueryOperators_Symbol;"")
APPEND TO ARRAY:C911(<>alXS_QueryOperators_NumRef;9)


  //conectores Queries
ARRAY TEXT:C222(<>atXS_QueryConnectors_Text;0)
ARRAY TEXT:C222(<>atXS_QueryConnectors_Symbol;0)
  //&
APPEND TO ARRAY:C911(<>atXS_QueryConnectors_Text;__ ("Y"))
APPEND TO ARRAY:C911(<>atXS_QueryConnectors_Symbol;"&")
  //|
APPEND TO ARRAY:C911(<>atXS_QueryConnectors_Text;__ ("O"))
APPEND TO ARRAY:C911(<>atXS_QueryConnectors_Symbol;"|")
  //#
APPEND TO ARRAY:C911(<>atXS_QueryConnectors_Text;__ ("excepto"))
APPEND TO ARRAY:C911(<>atXS_QueryConnectors_Symbol;"#")


  //POR MODULOS
  //SchoolTrack

  //tabs alumnos input
ARRAY TEXT:C222(<>atSTR_PaginaAlumnos;11)
ARRAY LONGINT:C221(<>alSTR_PaginaAlumnosRefs;11)
<>atSTR_PaginaAlumnos{1}:=__ ("Datos personales")
<>atSTR_PaginaAlumnos{2}:=__ ("Conducta")
<>atSTR_PaginaAlumnos{3}:=__ ("Evaluación")
<>atSTR_PaginaAlumnos{4}:=__ ("Aprendizajes")
<>atSTR_PaginaAlumnos{5}:=__ ("Salud")
<>atSTR_PaginaAlumnos{6}:=__ ("Orientación")
<>atSTR_PaginaAlumnos{7}:=__ ("Comentarios")
<>atSTR_PaginaAlumnos{8}:=__ ("Actividades")
<>atSTR_PaginaAlumnos{9}:=__ ("Familia")
<>atSTR_PaginaAlumnos{10}:=__ ("Histórico")
<>atSTR_PaginaAlumnos{11}:=__ ("Post-Egreso")
<>alSTR_PaginaAlumnosRefs{1}:=1
<>alSTR_PaginaAlumnosRefs{2}:=2
<>alSTR_PaginaAlumnosRefs{3}:=3
<>alSTR_PaginaAlumnosRefs{4}:=4
<>alSTR_PaginaAlumnosRefs{5}:=5
<>alSTR_PaginaAlumnosRefs{6}:=6
<>alSTR_PaginaAlumnosRefs{7}:=7
<>alSTR_PaginaAlumnosRefs{8}:=8
<>alSTR_PaginaAlumnosRefs{9}:=9
<>alSTR_PaginaAlumnosRefs{10}:=10
<>alSTR_PaginaAlumnosRefs{11}:=11

ARRAY TEXT:C222(<>atSTR_PaginaAlHistorico;4)
ARRAY LONGINT:C221(<>alSTR_PaginaAlHistorico;4)
<>atSTR_PaginaAlHistorico{1}:=__ ("Notas")
<>atSTR_PaginaAlHistorico{2}:=__ ("Comentario profesor jefe")
<>atSTR_PaginaAlHistorico{3}:=__ ("Comentarios asignaturas")
<>atSTR_PaginaAlHistorico{4}:=__ ("Eventos curso")
<>alSTR_PaginaAlHistorico{1}:=1
<>alSTR_PaginaAlHistorico{2}:=2
<>alSTR_PaginaAlHistorico{3}:=3
<>alSTR_PaginaAlHistorico{4}:=4

ARRAY TEXT:C222(<>atSTR_PaginaAlComentarios;3)
ARRAY LONGINT:C221(<>alSTR_PaginaAlComentarios;3)
<>atSTR_PaginaAlComentarios{1}:=__ ("Comentarios de profesor jefe o tutor")
<>atSTR_PaginaAlComentarios{2}:=__ ("Comentarios de profesores de asignaturas")
<>atSTR_PaginaAlComentarios{3}:=__ ("Eventos curso")
<>alSTR_PaginaAlComentarios{1}:=1
<>alSTR_PaginaAlComentarios{2}:=2
<>alSTR_PaginaAlComentarios{3}:=3

ARRAY TEXT:C222(<>atSTR_PaginaAlConducta;7)
ARRAY LONGINT:C221(<>alSTR_PaginaAlConducta;7)
<>atSTR_PaginaAlConducta{1}:=__ ("Inasistencias")
<>atSTR_PaginaAlConducta{2}:=__ ("Asistencia a clases")
<>atSTR_PaginaAlConducta{3}:=__ ("Licencias")
<>atSTR_PaginaAlConducta{4}:=__ ("Atrasos")
<>atSTR_PaginaAlConducta{5}:=__ ("Anotaciones")
<>atSTR_PaginaAlConducta{6}:=__ ("Medidas Disciplinarias")
<>atSTR_PaginaAlConducta{7}:=__ ("Suspensiones")
<>alSTR_PaginaAlConducta{1}:=1
<>alSTR_PaginaAlConducta{2}:=2
<>alSTR_PaginaAlConducta{3}:=3
<>alSTR_PaginaAlConducta{4}:=4
<>alSTR_PaginaAlConducta{5}:=5
<>alSTR_PaginaAlConducta{6}:=6
<>alSTR_PaginaAlConducta{7}:=7

ARRAY TEXT:C222(<>atSTR_PaginaSalud;7)
ARRAY LONGINT:C221(<>alSTR_PaginaSalud;7)
<>atSTR_PaginaSalud{1}:=__ ("Observaciones")
<>atSTR_PaginaSalud{2}:=__ ("Med. autorizados")
<>atSTR_PaginaSalud{3}:=__ ("Med. prohibidos")
<>atSTR_PaginaSalud{4}:=__ ("Tratamientos")
<>atSTR_PaginaSalud{5}:=__ ("Dieta")
<>atSTR_PaginaSalud{6}:=__ ("Prótesis")
<>atSTR_PaginaSalud{7}:=__ ("Médicos")
<>alSTR_PaginaSalud{1}:=3
<>alSTR_PaginaSalud{2}:=11
<>alSTR_PaginaSalud{3}:=17
<>alSTR_PaginaSalud{4}:=18
<>alSTR_PaginaSalud{5}:=19
<>alSTR_PaginaSalud{6}:=-1
<>alSTR_PaginaSalud{7}:=-2

ARRAY TEXT:C222(<>atSTR_PaginaSalud2;5)
ARRAY LONGINT:C221(<>alSTR_PaginaSalud2;5)
<>atSTR_PaginaSalud2{1}:=__ ("Enfermedades")
<>atSTR_PaginaSalud2{2}:=__ ("Hospitalizaciones")
<>atSTR_PaginaSalud2{3}:=__ ("Vacunas")
<>atSTR_PaginaSalud2{4}:=__ ("Alergias")
<>atSTR_PaginaSalud2{5}:=__ ("Controles médicos")
<>alSTR_PaginaSalud2{1}:=1
<>alSTR_PaginaSalud2{2}:=2
<>alSTR_PaginaSalud2{3}:=3
<>alSTR_PaginaSalud2{4}:=4
<>alSTR_PaginaSalud2{5}:=5

  //tab familias input
ARRAY TEXT:C222(<>atSTR_PaginaFamilias;3)
ARRAY LONGINT:C221(<>alSTR_PaginaFamilias;3)
<>atSTR_PaginaFamilias{1}:=__ ("General")
<>atSTR_PaginaFamilias{2}:=__ ("Registro de eventos")
<>atSTR_PaginaFamilias{3}:=__ ("Fotografía")
<>alSTR_PaginaFamilias{1}:=1
<>alSTR_PaginaFamilias{2}:=2
<>alSTR_PaginaFamilias{3}:=3

  //tab cursos input
ARRAY TEXT:C222(<>atSTR_PaginaCursos;8)
ARRAY LONGINT:C221(<>alSTR_PaginaCursos;8)
<>atSTR_PaginaCursos{1}:=__ ("General")
<>atSTR_PaginaCursos{2}:=__ ("Conducta y asistencia")
<>atSTR_PaginaCursos{3}:=__ ("Evaluación personal")
<>atSTR_PaginaCursos{4}:=__ ("Eventos")
<>atSTR_PaginaCursos{5}:=__ ("Calendario")
<>atSTR_PaginaCursos{6}:=__ ("Situación final")
<>atSTR_PaginaCursos{7}:=__ ("Actas")
<>atSTR_PaginaCursos{8}:=__ ("Firmas en actas")
<>alSTR_PaginaCursos{1}:=1
<>alSTR_PaginaCursos{2}:=2
<>alSTR_PaginaCursos{3}:=3
<>alSTR_PaginaCursos{4}:=4
<>alSTR_PaginaCursos{5}:=5
<>alSTR_PaginaCursos{6}:=6
<>alSTR_PaginaCursos{7}:=7
<>alSTR_PaginaCursos{8}:=8

  //tab profesores input
ARRAY TEXT:C222(<>atSTR_PaginaProfesores;3)
ARRAY LONGINT:C221(<>alSTR_PaginaProfesores;3)
<>atSTR_PaginaProfesores{1}:=__ ("Personal")
<>atSTR_PaginaProfesores{2}:=__ ("Docencia")
<>atSTR_PaginaProfesores{3}:=__ ("Tutoría")
<>alSTR_PaginaProfesores{1}:=1
<>alSTR_PaginaProfesores{2}:=2
<>alSTR_PaginaProfesores{3}:=3

  //tab asignaturas input
ARRAY TEXT:C222(<>atSTR_PaginaAsignaturas;9)
ARRAY LONGINT:C221(<>alSTR_PaginaAsignaturas;9)
<>atSTR_PaginaAsignaturas{1}:=__ ("Propiedades")
<>atSTR_PaginaAsignaturas{2}:=__ ("Objetivos")
<>atSTR_PaginaAsignaturas{3}:=__ ("Evaluación")
<>atSTR_PaginaAsignaturas{4}:=__ ("Aprendizajes")
<>atSTR_PaginaAsignaturas{5}:=__ ("Observaciones")
<>atSTR_PaginaAsignaturas{6}:=__ ("Planes de clase")
<>atSTR_PaginaAsignaturas{7}:=__ ("Sesiones")
<>atSTR_PaginaAsignaturas{8}:=__ ("Calendario")
<>atSTR_PaginaAsignaturas{9}:=__ ("Asistencia")
<>alSTR_PaginaAsignaturas{1}:=1
<>alSTR_PaginaAsignaturas{2}:=2
<>alSTR_PaginaAsignaturas{3}:=3
<>alSTR_PaginaAsignaturas{4}:=10
<>alSTR_PaginaAsignaturas{5}:=4
<>alSTR_PaginaAsignaturas{6}:=6
<>alSTR_PaginaAsignaturas{7}:=7
<>alSTR_PaginaAsignaturas{8}:=8
<>alSTR_PaginaAsignaturas{9}:=9

  //tab asignaturas input2
ARRAY TEXT:C222(<>atSTR_PaginaAsignaturas2;9)
ARRAY LONGINT:C221(<>alSTR_PaginaAsignaturas2;9)
<>atSTR_PaginaAsignaturas2{1}:=__ ("Propiedades")
<>atSTR_PaginaAsignaturas2{2}:=__ ("Objetivos")
<>atSTR_PaginaAsignaturas2{3}:=__ ("Evaluación")
<>atSTR_PaginaAsignaturas2{4}:=__ ("Aprendizajes")
<>atSTR_PaginaAsignaturas2{5}:=__ ("Observaciones")
<>atSTR_PaginaAsignaturas2{6}:=__ ("Planes de clase")
<>atSTR_PaginaAsignaturas2{7}:=__ ("Sesiones")
<>atSTR_PaginaAsignaturas2{8}:=__ ("Calendario")
<>atSTR_PaginaAsignaturas2{9}:=__ ("Asistencia")
<>alSTR_PaginaAsignaturas2{1}:=1
<>alSTR_PaginaAsignaturas2{2}:=2
<>alSTR_PaginaAsignaturas2{3}:=3
<>alSTR_PaginaAsignaturas2{4}:=9
<>alSTR_PaginaAsignaturas2{5}:=4
<>alSTR_PaginaAsignaturas2{6}:=5
<>alSTR_PaginaAsignaturas2{7}:=6
<>alSTR_PaginaAsignaturas2{8}:=7
<>alSTR_PaginaAsignaturas2{9}:=8

  //tab actividades input
ARRAY TEXT:C222(<>atSTR_PaginaActividades;2)
ARRAY LONGINT:C221(<>alSTR_PaginaActividades;2)
<>atSTR_PaginaActividades{1}:=__ ("Propiedades")
<>atSTR_PaginaActividades{2}:=__ ("Evaluación")
<>alSTR_PaginaActividades{1}:=1
<>alSTR_PaginaActividades{2}:=2

  //tab personas input
ARRAY TEXT:C222(<>atSTR_PaginaPersonas;2)
ARRAY LONGINT:C221(<>alSTR_PaginaPersonas;2)
<>atSTR_PaginaPersonas{1}:=__ ("Datos personales")
<>atSTR_PaginaPersonas{2}:=__ ("Formación académica")
<>alSTR_PaginaPersonas{1}:=1
<>alSTR_PaginaPersonas{2}:=2

  //configuracion conducta y asistencia
ARRAY TEXT:C222(<>atSTR_CFGConducta;4)
ARRAY LONGINT:C221(<>alSTR_CFGConducta;4)
<>atSTR_CFGConducta{1}:=__ ("Anotaciones")
<>atSTR_CFGConducta{2}:=__ ("Medidas Disciplinarias")
<>atSTR_CFGConducta{3}:=__ ("Atrasos")
<>atSTR_CFGConducta{4}:=__ ("Justificación Atrasos")
<>alSTR_CFGConducta{1}:=1
<>alSTR_CFGConducta{2}:=2
<>alSTR_CFGConducta{3}:=3
<>alSTR_CFGConducta{4}:=4


  //configuracion niveles
ARRAY TEXT:C222(<>atSTR_CFGNiveles;5)
ARRAY LONGINT:C221(<>alSTR_CFGNiveles;5)
<>atSTR_CFGNiveles{1}:=__ ("Información")
<>atSTR_CFGNiveles{2}:=__ ("Evaluación y promoción")
<>atSTR_CFGNiveles{3}:=__ ("Preferencias")
<>atSTR_CFGNiveles{4}:=__ ("Atributos")
<>atSTR_CFGNiveles{5}:=__ ("Legal")
<>alSTR_CFGNiveles{1}:=1
<>alSTR_CFGNiveles{2}:=2
<>alSTR_CFGNiveles{3}:=3
<>alSTR_CFGNiveles{4}:=4
<>alSTR_CFGNiveles{5}:=5

ARRAY TEXT:C222(<>atSTR_ModoCalcPromGrales;3)
ARRAY LONGINT:C221(<>alSTR_ModoCalcPromGrales;3)
<>atSTR_ModoCalcPromGrales{1}:=__ ("Igual valor para las notas de todas las asignaturas")
<>atSTR_ModoCalcPromGrales{2}:=__ ("Notas ponderadas por intensidad horaria de las asignaturas")
<>atSTR_ModoCalcPromGrales{3}:=__ ("Notas ponderadas por factor establecido en las asignaturas")
<>alSTR_ModoCalcPromGrales{1}:=1
<>alSTR_ModoCalcPromGrales{2}:=2
<>alSTR_ModoCalcPromGrales{3}:=3

  //cònfig calculo aprendizajes
ARRAY TEXT:C222(<>atSTR_OpcionesCalcAprendizajes;3)
ARRAY LONGINT:C221(<>alSTR_OpcionesCalcAprendizajes;3)
<>atSTR_OpcionesCalcAprendizajes{1}:=__ ("Resultados finales")
<>atSTR_OpcionesCalcAprendizajes{2}:=__ ("Ejes de aprendizajes")
<>atSTR_OpcionesCalcAprendizajes{3}:=__ ("Dimensiones de aprendizajes")
<>alSTR_OpcionesCalcAprendizajes{1}:=-1
<>alSTR_OpcionesCalcAprendizajes{2}:=1
<>alSTR_OpcionesCalcAprendizajes{3}:=2

  //config colegio
ARRAY TEXT:C222(<>atSTR_PaginasColegio;4)
ARRAY LONGINT:C221(<>alSTR_PaginasColegio;4)
<>atSTR_PaginasColegio{1}:=__ ("Académica")
<>atSTR_PaginasColegio{2}:=__ ("Administrativa")
<>atSTR_PaginasColegio{3}:=__ ("Reglamentaria")
<>atSTR_PaginasColegio{4}:=__ ("Logo")
<>alSTR_PaginasColegio{1}:=1
<>alSTR_PaginasColegio{2}:=2
<>alSTR_PaginasColegio{3}:=3
<>alSTR_PaginasColegio{4}:=5

  //config periodos
ARRAY TEXT:C222(<>atSTR_PaginasConfPeriodos;3)
ARRAY LONGINT:C221(<>alSTR_PaginasConfPeriodos;3)
<>atSTR_PaginasConfPeriodos{1}:=__ ("Períodos escolares")
<>atSTR_PaginasConfPeriodos{2}:=__ ("Calendario")
<>atSTR_PaginasConfPeriodos{3}:=__ ("Horario")
<>alSTR_PaginasConfPeriodos{1}:=1
<>alSTR_PaginasConfPeriodos{2}:=2
<>alSTR_PaginasConfPeriodos{3}:=3

ARRAY TEXT:C222(<>atSTR_PeriodosExtendidos;5)
ARRAY LONGINT:C221(<>alSTR_PeriodosExtendidos;5)
<>atSTR_PeriodosExtendidos{1}:=__ ("Período único")
<>atSTR_PeriodosExtendidos{2}:=__ ("2 períodos")
<>atSTR_PeriodosExtendidos{3}:=__ ("3 períodos")
<>atSTR_PeriodosExtendidos{4}:=__ ("4 períodos")
<>atSTR_PeriodosExtendidos{5}:=__ ("5 períodos")
<>alSTR_PeriodosExtendidos{1}:=6
<>alSTR_PeriodosExtendidos{2}:=1
<>alSTR_PeriodosExtendidos{3}:=2
<>alSTR_PeriodosExtendidos{4}:=3
<>alSTR_PeriodosExtendidos{5}:=5

ARRAY TEXT:C222(<>atSTR_Tutorias;3)
ARRAY LONGINT:C221(<>alSTR_Tutorias;3)
<>atSTR_Tutorias{1}:=__ ("Notas")
<>atSTR_Tutorias{2}:=__ ("Entrevistas")
<>atSTR_Tutorias{3}:=__ ("Observaciones")
<>alSTR_Tutorias{1}:=1
<>alSTR_Tutorias{2}:=2
<>alSTR_Tutorias{3}:=3

ARRAY TEXT:C222(<>atSTR_TabPlanes;7)
ARRAY LONGINT:C221(<>alSTR_TabPlanes;7)
<>atSTR_TabPlanes{1}:="Nota al alumno"
<>atSTR_TabPlanes{2}:="Objetivos"
<>atSTR_TabPlanes{3}:="Contenidos"
<>atSTR_TabPlanes{4}:="Actividades"
<>atSTR_TabPlanes{5}:="Referencias y guías"
<>atSTR_TabPlanes{6}:="Tareas"
<>atSTR_TabPlanes{7}:="Evaluación"
<>alSTR_TabPlanes{1}:=1
<>alSTR_TabPlanes{2}:=2
<>alSTR_TabPlanes{3}:=3
<>alSTR_TabPlanes{4}:=4
<>alSTR_TabPlanes{5}:=5
<>alSTR_TabPlanes{6}:=6
<>alSTR_TabPlanes{7}:=7

ARRAY TEXT:C222(<>atSTR_TabsEstilos;6)
ARRAY LONGINT:C221(<>alSTR_TabsEstilos;6)
<>atSTR_TabsEstilos{1}:=__ ("Modo")
<>atSTR_TabsEstilos{2}:=__ ("Escalas")
<>atSTR_TabsEstilos{3}:=__ ("Cálculos")
<>atSTR_TabsEstilos{4}:=__ ("Símbolos")
<>atSTR_TabsEstilos{5}:=__ ("Conversión")
<>atSTR_TabsEstilos{6}:=__ ("Esfuerzo")
<>alSTR_TabsEstilos{1}:=1
<>alSTR_TabsEstilos{2}:=2
<>alSTR_TabsEstilos{3}:=4
<>alSTR_TabsEstilos{4}:=3
<>alSTR_TabsEstilos{5}:=5
<>alSTR_TabsEstilos{6}:=6

ARRAY TEXT:C222(<>atSTR_ModosEvaluacion;4)
ARRAY LONGINT:C221(<>alSTR_ModosEvaluacion;4)
<>atSTR_ModosEvaluacion{1}:=__ ("Notas")
<>atSTR_ModosEvaluacion{2}:=__ ("Puntaje")
<>atSTR_ModosEvaluacion{3}:=__ ("Porcentaje")
<>atSTR_ModosEvaluacion{4}:=__ ("Símbolos")
<>alSTR_ModosEvaluacion{1}:=1
<>alSTR_ModosEvaluacion{2}:=2
<>alSTR_ModosEvaluacion{3}:=3
<>alSTR_ModosEvaluacion{4}:=4

ARRAY TEXT:C222(<>atSTR_ModoConversionSimbolos;4)
ARRAY LONGINT:C221(<>alSTR_ModoConversionSimbolos;4)
<>atSTR_ModoConversionSimbolos{1}:=__ ("Valor inferior del rango")
<>atSTR_ModoConversionSimbolos{2}:=__ ("Valor mediano del rango")
<>atSTR_ModoConversionSimbolos{3}:=__ ("Valor superior del rango")
<>atSTR_ModoConversionSimbolos{4}:=__ ("Manual")
<>alSTR_ModoConversionSimbolos{1}:=1
<>alSTR_ModoConversionSimbolos{2}:=2
<>alSTR_ModoConversionSimbolos{3}:=3
<>alSTR_ModoConversionSimbolos{4}:=4


ARRAY TEXT:C222(<>atSTR_Horario_TipoHora;5)
ARRAY LONGINT:C221(<>alSTR_Horario_RefTipoHora;5)
<>atSTR_Horario_TipoHora{1}:=__ ("Hora de clases")
<>atSTR_Horario_TipoHora{2}:=__ ("Recreo o pausa")
<>atSTR_Horario_TipoHora{3}:=__ ("Hora estudio")
<>atSTR_Horario_TipoHora{4}:=__ ("Hora libre")
<>atSTR_Horario_TipoHora{5}:=__ ("Otro tipo no asignable")
<>alSTR_Horario_RefTipoHora{1}:=1
<>alSTR_Horario_RefTipoHora{2}:=0
<>alSTR_Horario_RefTipoHora{3}:=-1
<>alSTR_Horario_RefTipoHora{4}:=-2
<>alSTR_Horario_RefTipoHora{5}:=-3


ARRAY TEXT:C222(<>atSTR_Horario_TipoCiclos;2)
ARRAY LONGINT:C221(<>alSTR_Horario_TipoCiclos;2)
<>atSTR_Horario_TipoCiclos{1}:=__ ("Una semana")
<>atSTR_Horario_TipoCiclos{2}:=__ ("Dos semanas alternadas")
<>alSTR_Horario_TipoCiclos{1}:=1
<>alSTR_Horario_TipoCiclos{2}:=2

ARRAY TEXT:C222(<>atEVLG_TiposEvaluacion;3)
ARRAY LONGINT:C221(<>alEVLG_TiposEvaluacion;3)
<>atEVLG_TiposEvaluacion{1}:=__ ("Según Estilo de Evaluación")
<>atEVLG_TiposEvaluacion{2}:=__ ("Binario")
<>atEVLG_TiposEvaluacion{3}:=__ ("Escala Independiente (enteros)")
<>alEVLG_TiposEvaluacion{1}:=1
<>alEVLG_TiposEvaluacion{2}:=2
<>alEVLG_TiposEvaluacion{3}:=3

ARRAY TEXT:C222(<>atEVLG_TiposEvaluacionComp;3)
ARRAY LONGINT:C221(<>alEVLG_TiposEvaluacionComp;3)
<>atEVLG_TiposEvaluacionComp{1}:=__ ("Indicadores de Logros")
<>atEVLG_TiposEvaluacionComp{2}:=__ ("Binario")
<>atEVLG_TiposEvaluacionComp{3}:=__ ("Según Estilo de Evaluación")
<>alEVLG_TiposEvaluacionComp{1}:=1
<>alEVLG_TiposEvaluacionComp{2}:=2
<>alEVLG_TiposEvaluacionComp{3}:=3

ARRAY TEXT:C222(<>atCMT_PaginasConfig;5)
ARRAY LONGINT:C221(<>alCMT_PaginasConfig;5)
<>atCMT_PaginasConfig{1}:=__ ("Configuraciones Generales")
<>atCMT_PaginasConfig{2}:=__ ("Envío de Datos")
<>atCMT_PaginasConfig{3}:=__ ("Registro de Actividades")
<>atCMT_PaginasConfig{4}:=__ ("Nombres y Contraseñas")
<>atCMT_PaginasConfig{5}:=__ ("Envío Automático de Datos")
<>alCMT_PaginasConfig{1}:=1
<>alCMT_PaginasConfig{2}:=2
<>alCMT_PaginasConfig{3}:=3
<>alCMT_PaginasConfig{4}:=4
<>alCMT_PaginasConfig{5}:=5

ARRAY TEXT:C222(<>atCMT_Config;1)
ARRAY LONGINT:C221(<>alCMT_Config;1)
<>atCMT_Config{1}:=__ ("Opciones Generales")
<>alCMT_Config{1}:=1

ARRAY TEXT:C222(<>atSTR_SubSectoresInput;3)
ARRAY LONGINT:C221(<>alSTR_SubSectoresInput;3)
<>atSTR_SubSectoresInput{1}:=__ ("Propiedades")
<>atSTR_SubSectoresInput{2}:=__ ("Observaciones")
<>atSTR_SubSectoresInput{3}:=__ ("Competencias")
<>alSTR_SubSectoresInput{1}:=1
<>alSTR_SubSectoresInput{2}:=2
<>alSTR_SubSectoresInput{3}:=3



  //ACCOUNTTRACK
If (<>gCountryCode="")  //20161011 RCH
	STR_ReadGlobals 
End if 

  //tab personas input
ARRAY TEXT:C222(<>atACT_PaginaPersonas;10)
ARRAY LONGINT:C221(<>alACT_PaginaPersonas;10)
<>atACT_PaginaPersonas{1}:=__ ("Datos personales")
<>atACT_PaginaPersonas{2}:=__ ("Infos. para pagos")
<>atACT_PaginaPersonas{3}:=__ ("Transacciones")
<>atACT_PaginaPersonas{4}:=__ ("Avisos de cobranza")
<>atACT_PaginaPersonas{5}:=__ ("Pagos")
<>atACT_PaginaPersonas{6}:=__ ("Docs tributarios")
<>atACT_PaginaPersonas{7}:=__ ("Docs en cartera")
<>atACT_PaginaPersonas{8}:=__ ("Docs depositados")
<>atACT_PaginaPersonas{9}:=__ ("Obs.")
<>atACT_PaginaPersonas{10}:=__ ("Pagarés")
If (<>gCountryCode="uy")
	APPEND TO ARRAY:C911(<>atACT_PaginaPersonas;__ ("DGI"))
End if 
APPEND TO ARRAY:C911(<>atACT_PaginaPersonas;__ ("Estado de Cuenta"))  // Saúl Ponce Ticket Nº 174553
<>alACT_PaginaPersonas{1}:=1
<>alACT_PaginaPersonas{2}:=2
<>alACT_PaginaPersonas{3}:=3
<>alACT_PaginaPersonas{4}:=4
<>alACT_PaginaPersonas{5}:=5
<>alACT_PaginaPersonas{6}:=6
<>alACT_PaginaPersonas{7}:=7
<>alACT_PaginaPersonas{8}:=8
<>alACT_PaginaPersonas{9}:=9
<>alACT_PaginaPersonas{10}:=10
If (<>gCountryCode="uy")
	APPEND TO ARRAY:C911(<>alACT_PaginaPersonas;11)
End if 
APPEND TO ARRAY:C911(<>alACT_PaginaPersonas;12)  // Saúl Ponce Ticket Nº 174553

  //tabs cuentas input
ARRAY TEXT:C222(<>atACT_PaginaCuentas;6)
ARRAY LONGINT:C221(<>alACT_PaginaCuentas;6)
<>atACT_PaginaCuentas{1}:=__ ("Datos generales")
<>atACT_PaginaCuentas{2}:=__ ("Info. para pagos")
<>atACT_PaginaCuentas{3}:=__ ("Transacciones")
<>atACT_PaginaCuentas{4}:=__ ("Avisos de cobranza")
<>atACT_PaginaCuentas{5}:=__ ("Pagos")
<>atACT_PaginaCuentas{6}:=__ ("Observaciones")
APPEND TO ARRAY:C911(<>atACT_PaginaCuentas;__ ("Estado de Cuentas"))  // Saúl Ponce Ticket Nº 174553
<>alACT_PaginaCuentas{1}:=1
<>alACT_PaginaCuentas{2}:=2
<>alACT_PaginaCuentas{3}:=3
<>alACT_PaginaCuentas{4}:=4
<>alACT_PaginaCuentas{5}:=5
<>alACT_PaginaCuentas{6}:=6
APPEND TO ARRAY:C911(<>alACT_PaginaCuentas;7)  // Saúl Ponce Ticket Nº 174553

  //tab terceros input
ARRAY TEXT:C222(<>atACT_PaginaTerceros;9)
ARRAY LONGINT:C221(<>alACT_PaginaTerceros;9)
<>atACT_PaginaTerceros{1}:=__ ("Datos generales")
<>atACT_PaginaTerceros{2}:=__ ("Info. para pagos")
<>atACT_PaginaTerceros{3}:=__ ("Pactado")
<>atACT_PaginaTerceros{4}:=__ ("Transacciones")
<>atACT_PaginaTerceros{5}:=__ ("Avisos de cobranza")
<>atACT_PaginaTerceros{6}:=__ ("Pagos")
<>atACT_PaginaTerceros{7}:=__ ("Documentos tributarios")
<>atACT_PaginaTerceros{8}:=__ ("Documentos en cartera")
<>atACT_PaginaTerceros{9}:=__ ("Documentos depositados")
<>alACT_PaginaTerceros{1}:=1
<>alACT_PaginaTerceros{2}:=2
<>alACT_PaginaTerceros{3}:=3
<>alACT_PaginaTerceros{4}:=4
<>alACT_PaginaTerceros{5}:=5
<>alACT_PaginaTerceros{6}:=6
<>alACT_PaginaTerceros{7}:=7
<>alACT_PaginaTerceros{8}:=8
<>alACT_PaginaTerceros{9}:=9

  //tab terceros Gen Input
ARRAY TEXT:C222(<>atACT_PaginaTercerosGen;3)
ARRAY LONGINT:C221(<>alACT_PaginaTercerosGen;3)
<>atACT_PaginaTercerosGen{1}:=__ ("Cuentas asociadas")
<>atACT_PaginaTercerosGen{2}:=__ ("Ítems asociados")
<>atACT_PaginaTercerosGen{3}:=__ ("Montos pactados")
<>alACT_PaginaTercerosGen{1}:=1
<>alACT_PaginaTercerosGen{2}:=2
<>alACT_PaginaTercerosGen{3}:=3

  //tab boletas input
ARRAY TEXT:C222(<>atACT_PaginaBoletas;2)
ARRAY LONGINT:C221(<>alACT_PaginaBoletas;2)
<>atACT_PaginaBoletas{1}:=__ ("Pagos involucrados")
<>atACT_PaginaBoletas{2}:=__ ("Documentos asociados")
<>alACT_PaginaBoletas{1}:=1
<>alACT_PaginaBoletas{2}:=2

  //tipos de transaccion
ARRAY TEXT:C222(<>atACT_TipoTransacciones;5)
ARRAY LONGINT:C221(<>alACT_TipoTransacciones;5)
<>atACT_TipoTransacciones{1}:=__ ("Cargos emitidos y pagos")
<>atACT_TipoTransacciones{2}:=__ ("Sólo cargos emitidos")
<>atACT_TipoTransacciones{3}:=__ ("Sólo cargos proyectados")
<>atACT_TipoTransacciones{4}:=__ ("Sólo pagos")
<>atACT_TipoTransacciones{5}:=__ ("Todas las transacciones")
<>alACT_TipoTransacciones{1}:=1
<>alACT_TipoTransacciones{2}:=2
<>alACT_TipoTransacciones{3}:=3
<>alACT_TipoTransacciones{4}:=4
<>alACT_TipoTransacciones{5}:=5

  //asociados apdos
ARRAY TEXT:C222(<>atACT_AsociadosApdos;2)
ARRAY LONGINT:C221(<>alACT_AsociadosApdos;2)
<>atACT_AsociadosApdos{1}:=__ ("Familias")
<>atACT_AsociadosApdos{2}:=__ ("Terceros")
<>alACT_AsociadosApdos{1}:=1
<>alACT_AsociadosApdos{2}:=2

  //asociados ctas
ARRAY TEXT:C222(<>atACT_AsociadosCtas;2)
ARRAY LONGINT:C221(<>alACT_AsociadosCtas;2)
<>atACT_AsociadosCtas{1}:=__ ("Alumnos asociados al mismo apoderado de cuentas")
<>atACT_AsociadosCtas{2}:=__ ("Terceros")
<>alACT_AsociadosCtas{1}:=1
<>alACT_AsociadosCtas{2}:=2

  //20160720 RCH
  //Descuentos Individuales
ARRAY TEXT:C222(<>atACT_DctosCtas;2)
ARRAY LONGINT:C221(<>alACT_DctosCtas;2)
<>atACT_DctosCtas{1}:=__ ("Parámetros de la cuenta")
<>atACT_DctosCtas{2}:=__ ("Descuentos Individuales")
<>alACT_DctosCtas{1}:=1
<>alACT_DctosCtas{2}:=2

  //config boletas
ARRAY TEXT:C222(<>atACT_ConfigBoletas;3)
ARRAY LONGINT:C221(<>alACT_ConfigBoletas;3)
<>atACT_ConfigBoletas{1}:=__ ("Generales")
<>atACT_ConfigBoletas{2}:=__ ("Definiciones")
<>atACT_ConfigBoletas{3}:=__ ("Modelos")
<>alACT_ConfigBoletas{1}:=1
<>alACT_ConfigBoletas{2}:=2
<>alACT_ConfigBoletas{3}:=3
  // CFDI para mx; DTE para cl
APPEND TO ARRAY:C911(<>atACT_ConfigBoletas;__ ("DTE"))
APPEND TO ARRAY:C911(<>alACT_ConfigBoletas;4)

  //config Generales
ARRAY TEXT:C222(<>atACT_PaginaConfigGrales;6)
ARRAY LONGINT:C221(<>alACT_PaginaConfigGrales;6)
<>atACT_PaginaConfigGrales{1}:=__ ("Generales")
<>atACT_PaginaConfigGrales{2}:=__ ("Datos institución")
<>atACT_PaginaConfigGrales{3}:=__ ("Descuentos")
<>atACT_PaginaConfigGrales{4}:=__ ("Emisión e impresión de avisos de cobranza")
<>atACT_PaginaConfigGrales{5}:=__ ("Alertas, multas y otros")
<>atACT_PaginaConfigGrales{6}:=__ ("Pagarés")
<>alACT_PaginaConfigGrales{1}:=1
<>alACT_PaginaConfigGrales{2}:=2
<>alACT_PaginaConfigGrales{3}:=3
<>alACT_PaginaConfigGrales{4}:=4
<>alACT_PaginaConfigGrales{5}:=5
<>alACT_PaginaConfigGrales{6}:=6

  //config recargos
ARRAY TEXT:C222(<>atACT_ConfigRecargos;3)
ARRAY LONGINT:C221(<>alACT_ConfigRecargos;3)
<>atACT_ConfigRecargos{1}:=__ ("Pagos manuales")
<>atACT_ConfigRecargos{2}:=__ ("Protestos")
<>atACT_ConfigRecargos{3}:=__ ("Recargos automáticos")
APPEND TO ARRAY:C911(<>atACT_ConfigRecargos;__ ("Recargos según tabla"))
<>alACT_ConfigRecargos{1}:=1
<>alACT_ConfigRecargos{2}:=2
<>alACT_ConfigRecargos{3}:=3
APPEND TO ARRAY:C911(<>alACT_ConfigRecargos;4)

  //config boletas subvencionados
ARRAY TEXT:C222(<>atACT_ConfigSubvencionados;3)
ARRAY LONGINT:C221(<>alACT_ConfigSubvencionados;3)
<>atACT_ConfigSubvencionados{1}:=__ ("Completo")
<>atACT_ConfigSubvencionados{2}:=__ ("Abono")
<>atACT_ConfigSubvencionados{3}:=__ ("Saldo")
<>alACT_ConfigSubvencionados{1}:=1
<>alACT_ConfigSubvencionados{2}:=2
<>alACT_ConfigSubvencionados{3}:=3

  //modos de pago
  //20120720 ASM. Por el momento las formas de pagos no se localizarán.
  //ARRAY TEXT(<>atACT_ModosdePago;4)
  //ARRAY LONGINT(<>alACT_ModosdePago;4)
  //<>atACT_ModosdePago{1}:=__ ("En el colegio")
  //<>atACT_ModosdePago{2}:=__ ("Pago automatico de cuenta")
  //<>atACT_ModosdePago{3}:=__ ("Cargo a tarjeta de crédito")
  //<>atACT_ModosdePago{4}:=__ ("Cuponera")
  //<>alACT_ModosdePago{1}:=1
  //<>alACT_ModosdePago{2}:=2
  //<>alACT_ModosdePago{3}:=3
  //<>alACT_ModosdePago{4}:=4

  //categorias docs tributarios
ARRAY TEXT:C222(<>atACT_CategoriasDocsTrib;5)
ARRAY LONGINT:C221(<>alACT_CategoriasDocsTrib;5)
<>atACT_CategoriasDocsTrib{1}:=__ ("Boleta")
<>atACT_CategoriasDocsTrib{2}:=__ ("Letra de cambio")
<>atACT_CategoriasDocsTrib{3}:=__ ("Factura")
<>atACT_CategoriasDocsTrib{4}:=__ ("Nota de crédito")
<>atACT_CategoriasDocsTrib{5}:=__ ("Nota de débito")
<>alACT_CategoriasDocsTrib{1}:=-1
<>alACT_CategoriasDocsTrib{2}:=-2
<>alACT_CategoriasDocsTrib{3}:=-3
<>alACT_CategoriasDocsTrib{4}:=-4
<>alACT_CategoriasDocsTrib{5}:=-5

  //estados boletas
ARRAY TEXT:C222(<>atACT_EstadosBoletas;6)
ARRAY LONGINT:C221(<>alACT_EstadosBoletas;6)
<>atACT_EstadosBoletas{1}:=__ ("Por pagar")
<>atACT_EstadosBoletas{2}:=__ ("Parcialmente pagada")
  //20131104 ASM Ticket 126600
If (<>vtXS_CountryCode="mx")
	<>atACT_EstadosBoletas{3}:=__ ("Pagada")
Else 
	<>atACT_EstadosBoletas{3}:=__ ("Cancelada")
End if 
<>atACT_EstadosBoletas{4}:=__ ("Nula")
<>atACT_EstadosBoletas{5}:=__ ("Emitida")
<>atACT_EstadosBoletas{6}:=__ ("Cancelado")
APPEND TO ARRAY:C911(<>atACT_EstadosBoletas;__ ("Boleta de pruebas"))
<>alACT_EstadosBoletas{1}:=1
<>alACT_EstadosBoletas{2}:=2
<>alACT_EstadosBoletas{3}:=3
<>alACT_EstadosBoletas{4}:=4
<>alACT_EstadosBoletas{5}:=5
<>alACT_EstadosBoletas{6}:=6
APPEND TO ARRAY:C911(<>alACT_EstadosBoletas;7)

  //ficha pagares
ARRAY TEXT:C222(<>atACT_PaginaPagares;0)
ARRAY LONGINT:C221(<>alACT_PaginaPagares;0)
APPEND TO ARRAY:C911(<>atACT_PaginaPagares;__ ("Datos generales"))
APPEND TO ARRAY:C911(<>atACT_PaginaPagares;__ ("Avisos de Cobranza asociados"))
APPEND TO ARRAY:C911(<>alACT_PaginaPagares;1)
APPEND TO ARRAY:C911(<>alACT_PaginaPagares;2)

  //==================
  //MEDIATRACK
  //==================

  //Items
ARRAY TEXT:C222(<>atBBL_PaginaItems;0)
ARRAY LONGINT:C221(<>alBBL_PaginaItems;0)
APPEND TO ARRAY:C911(<>atBBL_PaginaItems;__ ("Catalogación"))
APPEND TO ARRAY:C911(<>atBBL_PaginaItems;__ ("Resumen, Interés"))
APPEND TO ARRAY:C911(<>atBBL_PaginaItems;__ ("Indexación"))
APPEND TO ARRAY:C911(<>atBBL_PaginaItems;__ ("Copias"))
APPEND TO ARRAY:C911(<>atBBL_PaginaItems;__ ("Registros analíticos"))
APPEND TO ARRAY:C911(<>atBBL_PaginaItems;__ ("Campos MARC"))
APPEND TO ARRAY:C911(<>atBBL_PaginaItems;__ ("Imágenes"))
APPEND TO ARRAY:C911(<>atBBL_PaginaItems;__ ("Fichas"))
APPEND TO ARRAY:C911(<>alBBL_PaginaItems;1)
APPEND TO ARRAY:C911(<>alBBL_PaginaItems;5)
APPEND TO ARRAY:C911(<>alBBL_PaginaItems;2)
APPEND TO ARRAY:C911(<>alBBL_PaginaItems;3)
APPEND TO ARRAY:C911(<>alBBL_PaginaItems;4)
APPEND TO ARRAY:C911(<>alBBL_PaginaItems;6)
APPEND TO ARRAY:C911(<>alBBL_PaginaItems;7)
APPEND TO ARRAY:C911(<>alBBL_PaginaItems;8)


  //Lectores
ARRAY TEXT:C222(<>atBBL_PaginaLectores;0)
ARRAY LONGINT:C221(<>alBBL_PaginaLectores;0)
APPEND TO ARRAY:C911(<>atBBL_PaginaLectores;__ ("Datos personales"))
APPEND TO ARRAY:C911(<>alBBL_PaginaLectores;1)
APPEND TO ARRAY:C911(<>atBBL_PaginaLectores;__ ("Historial"))
APPEND TO ARRAY:C911(<>alBBL_PaginaLectores;2)

  //PáginasBusqueda
ARRAY TEXT:C222(<>atBBL_PaginaQF;0)
ARRAY LONGINT:C221(<>alBBL_PaginaQF;0)
APPEND TO ARRAY:C911(<>atBBL_PaginaQF;__ ("General"))
APPEND TO ARRAY:C911(<>alBBL_PaginaQF;1)
APPEND TO ARRAY:C911(<>atBBL_PaginaQF;__ ("Materias"))
APPEND TO ARRAY:C911(<>alBBL_PaginaQF;2)
APPEND TO ARRAY:C911(<>atBBL_PaginaQF;__ ("Busqueda Asistida"))
APPEND TO ARRAY:C911(<>alBBL_PaginaQF;3)

  // estados Registro
ARRAY TEXT:C222(<>aCpyStatus;0)
ARRAY LONGINT:C221(<>aCpyStatusId;0)
APPEND TO ARRAY:C911(<>aCpyStatusId;Disponible)
APPEND TO ARRAY:C911(<>aCpyStatusId;Prestado)
APPEND TO ARRAY:C911(<>aCpyStatusId;Reservado)
APPEND TO ARRAY:C911(<>aCpyStatusId;En sala)
APPEND TO ARRAY:C911(<>aCpyStatusId;Perdido)
APPEND TO ARRAY:C911(<>aCpyStatusId;Archivado)
APPEND TO ARRAY:C911(<>aCpyStatusId;En Reparacion)
APPEND TO ARRAY:C911(<>aCpyStatusId;Uso Interno)
APPEND TO ARRAY:C911(<>aCpyStatusId;Dado de baja)
APPEND TO ARRAY:C911(<>aCpyStatusId;Pedido)
APPEND TO ARRAY:C911(<>aCpyStatus;"Disponible")
APPEND TO ARRAY:C911(<>aCpyStatus;"Prestado")
APPEND TO ARRAY:C911(<>aCpyStatus;"Reservado")
APPEND TO ARRAY:C911(<>aCpyStatus;"En Sala")
APPEND TO ARRAY:C911(<>aCpyStatus;"Perdido")
APPEND TO ARRAY:C911(<>aCpyStatus;"Archivado")
APPEND TO ARRAY:C911(<>aCpyStatus;"En Reparación")
APPEND TO ARRAY:C911(<>aCpyStatus;"Uso Interno")
APPEND TO ARRAY:C911(<>aCpyStatus;"Dado de baja")
APPEND TO ARRAY:C911(<>aCpyStatus;"Pedido")


  //Alfabeto Busqueda
ARRAY TEXT:C222(<>atBBL_Alfabeto;0)
ARRAY LONGINT:C221(<>alBBL_Alfabeto;0)
If (SYS_IsMacintosh )
	APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("Seleccione..."))
End if 
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("A"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("B"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("C"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("D"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("E"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("F"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("G"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("H"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("I"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("J"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("K"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("L"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("M"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("N"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("Ñ"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("O"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("P"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("Q"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("R"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("S"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("T"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("U"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("V"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("W"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("X"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("Y"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("Z"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("0-9"))
APPEND TO ARRAY:C911(<>atBBL_Alfabeto;__ ("Otros"))
For ($i;1;Size of array:C274(<>atBBL_Alfabeto))
	APPEND TO ARRAY:C911(<>alBBL_Alfabeto;$i)
End for 



  //ADMISSIONTRACK
ARRAY TEXT:C222(<>atADT_PaginaPostulantes;3)
ARRAY LONGINT:C221(<>alADT_PaginaPostulantes;3)
<>atADT_PaginaPostulantes{1}:=__ ("Datos personales")
<>atADT_PaginaPostulantes{2}:=__ ("Datos adicionales")
<>atADT_PaginaPostulantes{3}:=__ ("Fechas y evaluaciones")
<>alADT_PaginaPostulantes{1}:=1
<>alADT_PaginaPostulantes{2}:=2
<>alADT_PaginaPostulantes{3}:=3

ARRAY TEXT:C222(<>atADT_Entrevistadores;2)
ARRAY LONGINT:C221(<>alADT_Entrevistadores;2)
<>atADT_Entrevistadores{1}:=__ ("Disponibilidad")
<>atADT_Entrevistadores{2}:=__ ("Otros datos")
<>alADT_Entrevistadores{1}:=1
<>alADT_Entrevistadores{2}:=2

ARRAY TEXT:C222(<>atADT_MetaDatos;5)
ARRAY LONGINT:C221(<>alADT_MetaDatos;5)
<>atADT_MetaDatos{1}:=__ ("Del sistema")
<>atADT_MetaDatos{2}:=__ ("Candidatos")
<>atADT_MetaDatos{3}:=__ ("Padres")
<>atADT_MetaDatos{4}:=__ ("Madres")
<>atADT_MetaDatos{5}:=__ ("Apoderados")
<>alADT_MetaDatos{1}:=1
<>alADT_MetaDatos{2}:=2
<>alADT_MetaDatos{3}:=3
<>alADT_MetaDatos{4}:=4
<>alADT_MetaDatos{5}:=5

  //Commtrack
  //intervalos de actualización
ARRAY TEXT:C222(<>atCT_UPD_Intervalos;6)
ARRAY LONGINT:C221(<>alCT_UPD_Intervalos;6)

<>atCT_UPD_Intervalos{1}:=__ ("15 Minutos")
<>atCT_UPD_Intervalos{2}:=__ ("30 Minutos")
<>atCT_UPD_Intervalos{3}:=__ ("1 Hora")
<>atCT_UPD_Intervalos{4}:=__ ("2 Horas")
<>atCT_UPD_Intervalos{5}:=__ ("4 Horas")
<>atCT_UPD_Intervalos{6}:=__ ("Entre 20:00 y 08:00")
<>alCT_UPD_Intervalos{1}:=1
<>alCT_UPD_Intervalos{2}:=2
<>alCT_UPD_Intervalos{3}:=3
<>alCT_UPD_Intervalos{4}:=4
<>alCT_UPD_Intervalos{5}:=5
<>alCT_UPD_Intervalos{6}:=6

  //STWA2 Pestaña panel de configuración

ARRAY TEXT:C222(<>atSTWA2_Configuracion;4)
ARRAY LONGINT:C221(<>alSTWA2_Configuracion;4)
<>atSTWA2_Configuracion{1}:=__ ("Configuración general")
<>atSTWA2_Configuracion{2}:="Single Sign On (SSO)"
<>atSTWA2_Configuracion{3}:=__ ("Reemplazo de Profesores")
<>atSTWA2_Configuracion{4}:=__ ("Fondo Responsive")
<>alSTWA2_Configuracion{1}:=1
<>alSTWA2_Configuracion{2}:=2
<>alSTWA2_Configuracion{3}:=3
<>alSTWA2_Configuracion{4}:=4

ARRAY TEXT:C222(<>atACT_CentroDeCosto;2)
ARRAY LONGINT:C221(<>alACT_CentroDeCosto;2)
<>atACT_CentroDeCosto{1}:=__ ("Moneda Item")
<>atACT_CentroDeCosto{2}:=__ ("Moneda País")
<>alACT_CentroDeCosto{1}:=1
<>alACT_CentroDeCosto{2}:=2

  // Modificado por: Saúl Ponce (22/09/2017) Ticket 187868
ARRAY TEXT:C222(<>atCIM_InfoRespaldos;2)
ARRAY LONGINT:C221(<>alCIM_InfoRespaldos;2)
<>atCIM_InfoRespaldos{1}:=__ ("Respaldos en la Nube")
<>atCIM_InfoRespaldos{2}:=__ ("Registro de Eventos")
<>alCIM_InfoRespaldos{1}:=1
<>alCIM_InfoRespaldos{2}:=2