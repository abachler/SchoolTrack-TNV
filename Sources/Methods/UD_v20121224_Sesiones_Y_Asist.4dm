//%attributes = {}
  // UD_v20121224_Sesiones_Y_Asist()
  //
  // Descripción
  // Asigna -1 al campo Año en las tablas [Asignaturas_RegistroSesiones] y [Asignaturas_Inasistencias] para todos los registros anteriores al año actual
  // En el trigger de ambas tablas el ID de Asignaturas (y Alumnos en el caso de [Asignaturas_Inasistencias]) es pasado a negativo
  // Elimina los registro de inasistencias a clases de años anteriores al ciclo escolar del año 2012 (que de todas manera no podían ser utilizados)
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 24/12/12, 12:48:26
  // ---------------------------------------------


  // CODIGO


$p:=IT_UThermometer (1;0;__ ("Normalizando registros de sesiones de clases e inasistencias..."))
READ WRITE:C146([Asignaturas_Inasistencias:125])
READ WRITE:C146([Asignaturas_RegistroSesiones:168])


  // obtengo las fechas de inicio y termino del año escolar actual 
  // (buscando en las configuraciones de período la fecha de inicio mas temprana y la fecha de término más tardía)
PERIODOS_Init 
$d_fechaInicioAño:=PERIODOS_InicioAñoSTrack 
$d_fechaTerminoAño:=PERIODOS_FinAñoPeriodosSTrack 



MESSAGES ON:C181
  //QUERY([Asignaturas_Inasistencias];[Asignaturas_Inasistencias]dateSesion<$d_fechaInicioAño)
  //KRL_DeleteSelection (->[Asignaturas_Inasistencias])

  // El campo [Asignaturas_RegistroSesiones]Año en los registros con fecha sesión anteriores a la fecha de inicio del año actual toman el valor -1
  // En principio no debieramos encontrar registros de sesiones anteriores al año 2012. 
  // (Si existieran podríamos intentar asignar el año correcto)
  // En el trigger los IDs de asignaturas serán pasados a negativo, evitando así relacionarse con registros del asignaturas actuales
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<$d_fechaInicioAño)
APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Año:13:=-1)

  // Asignamos el año actual a los registros que corresponden a fechas del año actual
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_fechaTerminoAño)
APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Año:13:=<>gYear)


  // El campo [Asignaturas_Inasistencias]Año en los registros con fecha sesión anteriores a la fecha de inicio del año actual toman el valor -1
  // En principio no debieramos encontrar registros de sesiones anteriores al año 2012. 
  // (Si existieran podríamos intentar asignar el año correcto)
  // En el trigger los IDs de asignaturas y alumnos serán pasados a negativo, evitando así relacionarse con registros de alumnos o asignaturas actuales
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4<$d_fechaInicioAño)
APPLY TO SELECTION:C70([Asignaturas_Inasistencias:125];[Asignaturas_RegistroSesiones:168]Año:13:=-1)

  // Asignamos el año actual a los registros que corresponden a fechas del año actual
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
APPLY TO SELECTION:C70([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Año:11:=<>gYear)

MESSAGES OFF:C175

UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
UNLOAD RECORD:C212([Asignaturas_RegistroSesiones:168])
READ ONLY:C145([Asignaturas_Inasistencias:125])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])


$p:=IT_UThermometer (-2;$p)
