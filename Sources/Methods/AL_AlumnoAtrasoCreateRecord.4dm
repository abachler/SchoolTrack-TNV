//%attributes = {}
  //AL_AlumnoAtrasoCreateRecord//MONO 180505
  //Resivimos un objeto con los sigiente atributos:
  //fecha
  //idAlumno
  //observacion
  //esIntersesion
  //minutosAtraso
  //numeroHora
  //horaAtraso
  //idAsignatura
  //justificar
  //idJustificacion
  //Para crear un registro de alumnos atraso
C_OBJECT:C1216($1;$ob_atraso)
C_TEXT:C284($t_nombreAlu;$t_cursoAlu;$t_log)
C_BOOLEAN:C305($b_esIntersesion)
$ob_atraso:=$1

READ WRITE:C146([Alumnos_Atrasos:55])
CREATE RECORD:C68([Alumnos_Atrasos:55])
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]Fecha:2;"fecha")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]Alumno_numero:1;"idAlumno")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]Observaciones:3;"observacion")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4;"esIntersesion")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]MinutosAtraso:5;"minutosAtraso")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]NumeroHora:11;"numeroHora")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]HoradeAtraso:12;"horaAtraso")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]ID_Asignatura:15;"idAsignatura")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]justificado:14;"justificar")
OB_GET ($ob_atraso;->[Alumnos_Atrasos:55]id_justificacion:13;"idJustificacion")
[Alumnos_Atrasos:55]Nivel_Numero:8:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]nivel_numero:29)
SAVE RECORD:C53([Alumnos_Atrasos:55])

$t_nombreAlu:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]apellidos_y_nombres:40)
$t_cursoAlu:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]curso:20)
$t_log:=__ ("Conducta - Registro de atraso: ")+$t_nombreAlu+", "+$t_cursoAlu+__ (" para el ")+String:C10([Alumnos_Atrasos:55]Fecha:2)
If ([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4)
	$t_log:=$t_log+__ (", intersesión.")
End if 
LOG_RegisterEvt ($t_log;Table:C252(->[Alumnos:2]);[Alumnos_Atrasos:55]Alumno_numero:1)

  // ASM Ticket 208501 Registro de atraso de inicio de jornada cuando se crear atraso en la primera hora.
$l_noHora:=OB Get:C1224($ob_atraso;"numeroHora";Is longint:K8:6)
$b_esIntersesion:=OB Get:C1224($ob_atraso;"esIntersesion";Is boolean:K8:9)
If (($l_noHora=1) & ($b_esIntersesion) & (Num:C11(PREF_fGet (0;"CrearAtrasoInicioJornada";"0"))=1))
	DUPLICATE RECORD:C225([Alumnos_Atrasos:55])
	[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4:=False:C215
	[Alumnos_Atrasos:55]CreadoPorConfiguracion:16:=True:C214
	SAVE RECORD:C53([Alumnos_Atrasos:55])
	LOG_RegisterEvt ("Asistencia y Atrasos: Atraso de inicio de jornada creado automáticamente por configuración.. \rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10([Alumnos_Atrasos:55]Fecha:2))
End if 

KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])