  // [Cursos].Eventos_Agenda()
  //
  //
  // creado por: Alberto Bachler Klein: 05-08-16, 10:35:48
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_bloqueoAutorizado)
C_LONGINT:C283($i;$l_alumnos;$l_posicion)
C_POINTER:C301($y_bloqueosDesde;$y_bloqueosHasta;$y_bloqueosMotivo;$y_EventosAlumnos;$y_eventosAsignatura;$y_EventosEvento;$y_EventosRecNum)

ARRAY DATE:C224($ad_fechasBloqueadas;0)
ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
ARRAY LONGINT:C221($al_HoraDesde;0)
ARRAY LONGINT:C221($al_HoraHasta;0)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($DA_Return;0)
ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)

$y_bloqueosMotivo:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Motivo")
$y_bloqueosDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Desde")
$y_bloqueosHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_Hasta")

$y_EventosAlumnos:=OBJECT Get pointer:C1124(Object named:K67:5;"eventos_Alumnos")
$y_eventosAsignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"eventos_Asignatura")
$y_EventosEvento:=OBJECT Get pointer:C1124(Object named:K67:5;"eventos_Evento")
$y_EventosRecNum:=OBJECT Get pointer:C1124(Object named:K67:5;"eventos_RecNum")

Case of 
	: (Form event:C388=On Load:K2:1)
		KRL_ReloadInReadWriteMode (->[Cursos:3])
		C_TEXT:C284(vt_motivoDia)
		
		OBJECT SET TITLE:C194(*;"Eventos_H1";__ ("Alumnos"))
		OBJECT SET TITLE:C194(*;"Eventos_H2";__ ("Asignatura"))
		OBJECT SET TITLE:C194(*;"Eventos_H3";__ ("Detalle"))
		
		OBJECT SET TITLE:C194(*;"Bloqueos_H1";__ ("Motivo"))
		OBJECT SET TITLE:C194(*;"Bloqueos_H2";__ ("Desde"))
		OBJECT SET TITLE:C194(*;"Bloqueos_H3";__ ("Hasta"))
		
		  // obtenfo los eventos del dia seleccionado
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Año:3=<>gYear)
		DISTINCT VALUES:C339([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IdAsignaturas)
		QUERY WITH ARRAY:C644([Asignaturas_Eventos:170]ID_asignatura:1;$al_IdAsignaturas)
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2=vd_fechaBloqueoDia)
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]UserID:10=<>lUSR_CurrentUserID;*)
		QUERY SELECTION:C341([Asignaturas_Eventos:170]; | [Asignaturas_Eventos:170]Privado:9=False:C215)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([Asignaturas_Eventos:170];$y_EventosRecNum->;[Asignaturas_Eventos:170]Evento:3;$y_EventosEvento->;[Asignaturas:18]denominacion_interna:16;$y_EventosAsignatura->;[Asignaturas:18]Numero:1;$al_IdAsignaturas)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		  //REDUCE SELECTION([Asignaturas];0)
		
		
		ARRAY TEXT:C222($y_EventosAlumnos->;Size of array:C274($y_EventosRecNum->))
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_alumnos)
		For ($i;1;Size of array:C274($y_EventosRecNum->))
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$al_IdAsignaturas{$i};*)
			QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Año:3=<>gYear)
			$y_EventosAlumnos->{$i}:=String:C10($l_alumnos)+"/"+String:C10([Cursos:3]Numero_de_Alumnos:11)
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
		
		$ad_HorasBloqueadasFechas{0}:=vd_fechaBloqueoDia
		AT_SearchArray (->$ad_HorasBloqueadasFechas;"=";->$DA_Return)
		
		For ($i;1;Size of array:C274($DA_Return))
			APPEND TO ARRAY:C911($y_bloqueosMotivo->;$at_HorasBloqueadasMotivo{$DA_Return{$i}})
			APPEND TO ARRAY:C911($y_bloqueosDesde->;$al_HoraDesde{$DA_Return{$i}})
			APPEND TO ARRAY:C911($y_bloqueosHasta->;$al_HoraHasta{$DA_Return{$i}})
		End for 
		
		$l_posicion:=Find in array:C230($ad_fechasBloqueadas;vd_fechaBloqueoDia)
		(OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_DiaBloqueado"))->:=Num:C11($l_posicion>0)
		
		If ($l_posicion>0)
			(OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_MotivoDia"))->:=Choose:C955($l_posicion>0;$at_fechasBloqueadasMotivo{$l_posicion};"")
		End if 
		OBJECT SET ENTERABLE:C238(*;"bloqueos_MotivoDia";(OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_DiaBloqueado"))->=1)
		
		$b_bloqueoAutorizado:=((USR_IsGroupMember_by_GrpID (-15001)) | ((<>viSTR_puedeBloquearDiasCalendar=1) & (USR_checkRights ("M";->[Alumnos_Calificaciones:208])) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4)))
		OBJECT SET ENABLED:C1123(*;"bloqueos_DiaBloqueado";$b_bloqueoAutorizado)
		
End case 


