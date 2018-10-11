//%attributes = {}
C_LONGINT:C283($ae;$uther)

ARRAY LONGINT:C221(rneliminadosxeliminar;0)
ARRAY LONGINT:C221($aeliminarxtipo;0)
ARRAY TEXT:C222($tipodato;0)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando integridad de registos de eliminación en SchoolNet…"))
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_EventosAgenda;->[Asignaturas_Eventos:170]ID_Event:11)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_EventosAgenda")

  // Modificado por: Saúl Ponce (09-03-2017) Cambié todas las divisiones por 100 para que la barra de progreso 'avance' correctamente

  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*1)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*1)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Calificaciones;->[Alumnos_Calificaciones:208]ID:506)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Calificaciones")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*2)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*2)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Anotaciones;->[Alumnos_Anotaciones:11]ID:12)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Anotaciones")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*3)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*3)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Atrasos;->[Alumnos_Atrasos:55]ID:7)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Atrasos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*4)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*4)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Castigos;->[Alumnos_Castigos:9]ID:10)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Castigos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*5)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*5)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Inasistencias;->[Alumnos_Inasistencias:10]ID:12)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Inasistencias")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*6)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*6)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_InasistenciaxHoraAcum;->[Alumnos_ComplementoEvaluacion:209]ID:90)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_InasistenciaxHoraAcum")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*7)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*7)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_InasistenciaxHoraDetalle;->[Asignaturas_Inasistencias:125]ID:10)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_InasistenciaxHoraDetalle")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*8)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*8)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Suspensiones;->[Alumnos_Suspensiones:12]ID:9)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Suspensiones")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*9)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*9)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Condicionalidad;->[Alumnos_SintesisAnual:210]ID_Alumno:4)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Condicionalidad")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*10)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*10)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Horarios;->[TMT_Horario:166]ID:15)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Horarios")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*11)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*11)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_ObsAsignatura;->[Alumnos_ComplementoEvaluacion:209]ID:90)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_ObsAsignatura")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*12)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*12)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_ObsJefatura;->[Alumnos_SintesisAnual:210]ID:267)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_ObsJefatura")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*13)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*13)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_PlanesDeClase;->[Asignaturas_PlanesDeClases:169]ID_Plan:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_PlanesDeClase")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*14)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*14)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Documentos;->[xShell_Documents:91]DocID:9)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Documentos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*15)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*15)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_EventosEnfermeria;->[Alumnos_EventosEnfermeria:14]ID:15)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_EventosEnfermeria")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*16)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*16)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_ControlesMedicos;->[Alumnos_ControlesMedicos:99]ID:9)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_ControlesMedicos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*17)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*17)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Actividades_Evaluaciones;->[Alumnos_Actividades:28]ID:63)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Actividades_Evaluaciones")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*18)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*18)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Aprendizajes_Evaluacion;->[Alumnos_EvaluacionAprendizajes:203]ID:90)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Aprendizajes_Evaluacion")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*19)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*19)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_ACT_Avisos;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_ACT_Avisos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*20)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*20)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_ACT_Pagos;->[ACT_Pagos:172]ID:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_ACT_Pagos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*21)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*21)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_MT_Prestamos;->[BBL_Prestamos:60]Número_de_Transacción:8)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_MT_Prestamos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*22)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*22)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Alumnos;->[Alumnos:2]numero:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Alumnos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*23)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*23)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Profesores;->[Profesores:4]Numero:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Profesores")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*24)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*24)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Cursos;->[Cursos:3]Numero_del_curso:6)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Cursos")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*25)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*25)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Asignaturas;->[Asignaturas:18]Numero:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Asignaturas")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*26)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*26)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Familias;->[Familia:78]Numero:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Familias")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*27)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*27)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_RelacionesFamiliares;->[Personas:7]No:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_RelacionesFamiliares")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*28)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*28)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Actividades;->[Actividades:29]ID:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Actividades")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*29)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*29)
$ae:=xxSN3_VerifObsoletosAEliminar (SN3_Subasignaturas;->[xxSTR_Subasignaturas:83]ID:19)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"SN3_Subasignaturas")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*30)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*30)
$ae:=xxSN3_VerifObsoletosAEliminar (10013;->[Asignaturas_Adjuntos:230]ID:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"10013")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*31)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*31)
$ae:=xxSN3_VerifObsoletosAEliminar (5006;->[ACT_Boletas:181]ID:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"5006")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*32)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*32)
$ae:=xxSN3_VerifObsoletosAEliminar (100022;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
APPEND TO ARRAY:C911($aeliminarxtipo;$ae)
APPEND TO ARRAY:C911($tipodato;"100022")
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(100/33)*33)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(1/33)*33)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$uther:=IT_UThermometer (1;0;__ ("Limpiando registros de eliminación en SchoolNet…"))
READ WRITE:C146([xxSN3_RegistrosXEnviar:143])
CREATE SELECTION FROM ARRAY:C640([xxSN3_RegistrosXEnviar:143];rneliminadosxeliminar)
APPLY TO SELECTION:C70([xxSN3_RegistrosXEnviar:143];[xxSN3_RegistrosXEnviar:143]accion:3:=SNT_Accion_Actualizar)
KRL_UnloadReadOnly (->[xxSN3_RegistrosXEnviar:143])
ARRAY LONGINT:C221(rneliminadosxeliminar;0)
IT_UThermometer (-2;$uther)