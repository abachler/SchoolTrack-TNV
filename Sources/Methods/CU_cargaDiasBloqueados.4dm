//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 25-08-16, 11:30:53
  // ----------------------------------------------------
  // Método: CU_cargaDiasBloqueados
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_LONGINT:C283($1)

C_BOOLEAN:C305($b_esGrupal;$b_esGrupal_)
C_LONGINT:C283($l_idAsignatura)

ARRAY DATE:C224($ad_fechasBloqueadas;0)
ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
ARRAY LONGINT:C221($al_HoraDesde;0)
ARRAY LONGINT:C221($al_HoraHasta;0)
ARRAY TEXT:C222($at_Cursos;0)
ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)

ARRAY DATE:C224(ad_fechasBloqueadas;0)
ARRAY DATE:C224(ad_HorasBloqueadasFechas;0)
ARRAY LONGINT:C221(al_HoraDesde;0)
ARRAY LONGINT:C221(al_HoraHasta;0)
ARRAY TEXT:C222(at_Cursos;0)
ARRAY TEXT:C222(at_fechasBloqueadasMotivo;0)
ARRAY TEXT:C222(at_HorasBloqueadasMotivo;0)
  //para stwa2
ARRAY TEXT:C222(at_curso;0)

$l_idAsignatura:=$1
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idAsignatura)

  //verifico si es grupal
$b_esGrupal:=[Asignaturas:18]Seleccion:17

If ($b_esGrupal)
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
	AT_DistinctsFieldValues (->[Alumnos:2]curso:20;->$at_Cursos)
	
	For ($i;1;Size of array:C274($at_Cursos))
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$at_Cursos{$i})
		BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
		
		For ($x;1;Size of array:C274($ad_fechasBloqueadas))
			APPEND TO ARRAY:C911(ad_fechasBloqueadas;$ad_fechasBloqueadas{$x})
			APPEND TO ARRAY:C911(at_fechasBloqueadasMotivo;$at_fechasBloqueadasMotivo{$x})  //ASM 20170407
		End for 
		
		  // código para STWA2 para el bloqueo de horas
		For ($x;1;Size of array:C274($ad_HorasBloqueadasFechas))
			APPEND TO ARRAY:C911(ad_HorasBloqueadasFechas;$ad_HorasBloqueadasFechas{$x})
			APPEND TO ARRAY:C911(at_HorasBloqueadasMotivo;$at_HorasBloqueadasMotivo{$x})
			APPEND TO ARRAY:C911(al_HoraDesde;$al_HoraDesde{$x})
			APPEND TO ARRAY:C911(al_HoraHasta;$al_HoraHasta{$x})
			APPEND TO ARRAY:C911(at_curso;[Cursos:3]Curso:1)
		End for 
	End for 
	
Else 
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Asignaturas:18]Curso:5)
	BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->ad_fechasBloqueadas;->at_fechasBloqueadasMotivo;->ad_HorasBloqueadasFechas;->at_HorasBloqueadasMotivo;->al_HoraDesde;->al_HoraHasta)
End if 

