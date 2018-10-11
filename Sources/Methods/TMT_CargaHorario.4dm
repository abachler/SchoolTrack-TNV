//%attributes = {}
  // TMT_CargaHorario()
  // Por: Alberto Bachler: 27/05/13, 08:44:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3;$b_soloBloquesVigentes)  //MONO TICKET 216065

C_BOOLEAN:C305($b_insertarFila)
_O_C_INTEGER:C282($i_celdas)
C_LONGINT:C283($i;$k;$l_celdaSeleccionada;$l_elemento;$l_horaSiguiente;$l_numeroAsignacionesHorario;$l_numeroCiclo;$l_numeroDia;$l_numeroHora;$l_recNumAsignacion)
C_POINTER:C301($y_celdaHoraria_Activa;$y_celdaHoraria_RecNum;$y_celdaHoraria_texto)
C_TEXT:C284($t_asignatura;$t_Curso;$t_nombreSala;$t_referenciaActual;$t_ultimaReferencia)

ARRAY DATE:C224($ad_FechaInicio;0)
ARRAY DATE:C224($ad_fechaTermino;0)
ARRAY INTEGER:C220($ai_numeroDia;0)
ARRAY INTEGER:C220($ai_numeroHora;0)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_recNumAsignacion;0)
ARRAY TEXT:C222($at_Sala;0)

$l_numeroCiclo:=0
$t_Curso:=$1

Case of 
	: (Count parameters:C259=2)
		$l_numeroCiclo:=$2
	: (Count parameters:C259=3)  //MONO TICKET 216065
		$l_numeroCiclo:=$2
		$b_soloBloquesVigentes:=$3
End case 

TMT_InicializaVariables 
READ ONLY:C145([Alumnos:2])
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_Curso;*)
QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"Ret@")
QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_Curso)
PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)

If ($l_numeroCiclo=0)
	Case of 
		: (vlSTR_Horario_NoCiclos=1)
			OBJECT SET VISIBLE:C603(*;"ciclo@";False:C215)
			$l_numeroCiclo:=1
		: (vlSTR_Horario_NoCiclos=2)
			ARRAY TEXT:C222(atSTR_NombresCiclos;vlSTR_Horario_NoCiclos)
			For ($i;1;vlSTR_Horario_NoCiclos)
				atSTR_NombresCiclos{$i}:=Char:C90($i+64)
			End for 
			atSTR_NombresCiclos:=1
			$l_numeroCiclo:=1
			OBJECT SET VISIBLE:C603(*;"ciclo@";True:C214)
		Else 
			CD_Dlog (0;__ ("No se ha definido el tipo de horario a utilizar\rEl horario no puede ser configurado ahora."))
			CANCEL:C270
	End case 
End if 
vlSTR_Horario_CicloNumero:=$l_numeroCiclo

COPY ARRAY:C226(aiSTR_Horario_HoraNo;aiSTK_Hora)
COPY ARRAY:C226(atSTR_Horario_HoraAlias;atSTK_HoraAlias)  //MONO Ticket 144924
COPY ARRAY:C226(alSTR_Horario_Desde;alSTK_Desde)
COPY ARRAY:C226(alSTR_Horario_hasta;alSTK_Hasta)
COPY ARRAY:C226(alSTR_Horario_RefTipoHora;alSTK_RefTipoHora)
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Abreviación:26;>;[Asignaturas:18]denominacion_interna:16;>;[Asignaturas:18]Numero:1;>)
SELECTION TO ARRAY:C260([Asignaturas:18]Abreviación:26;atSTK_Subsectores_shortName;[Asignaturas:18]denominacion_interna:16;atSTK_Subsectores_longName;[Asignaturas:18]Numero:1;alSTK_IDSubsectores;[Profesores:4]Nombre_comun:21;atSTK_Subsectores_TeacherName;[Asignaturas:18]Curso:5;atTMT_Subsectores_Curso)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
For ($i;1;Size of array:C274(atTMT_Subsectores_Curso))
	If (atTMT_Subsectores_Curso{$i}=vs_SelectedClass)
		atTMT_Subsectores_Curso{$i}:=""
	End if 
End for 

KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]No_Ciclo:14=vlSTR_Horario_CicloNumero)
If ($b_soloBloquesVigentes)  //MONO TICKET 216065
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*))
End if 
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([TMT_Horario:166];[Asignaturas:18]Abreviación:26;>;[Asignaturas:18]denominacion_interna:16;>;[Asignaturas:18]Numero:1;>)
SELECTION TO ARRAY:C260([TMT_Horario:166];$al_recNumAsignacion;[TMT_Horario:166]ID_Asignatura:5;$al_IdAsignaturas;[TMT_Horario:166]ID_Teacher:9;$al_IdProfesor;[Asignaturas:18]Abreviación:26;$at_Abreviacion;[TMT_Horario:166]NumeroDia:1;$ai_numeroDia;[TMT_Horario:166]NumeroHora:2;$ai_numeroHora;[TMT_Horario:166]Sala:8;$at_Sala;[TMT_Horario:166]SesionesDesde:12;$ad_FechaInicio;[TMT_Horario:166]SesionesHasta:13;$ad_fechaTermino)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
$l_numeroAsignacionesHorario:=Size of array:C274($al_IdAsignaturas)

$t_ultimaReferencia:=""
For ($i;$l_numeroAsignacionesHorario;1;-1)
	$t_referenciaActual:=String:C10($al_IdAsignaturas{$i})+","+String:C10($ai_numeroDia{$i})+","+String:C10($ai_numeroHora{$i})+","+String:C10($ad_fechaTermino{$i})  //MONO TICKET 216065
	If ($t_referenciaActual=$t_ultimaReferencia)
		DELETE FROM ARRAY:C228($al_IdAsignaturas;$i)
		DELETE FROM ARRAY:C228($ai_numeroDia;$i)
		DELETE FROM ARRAY:C228($ai_numeroHora;$i)
		DELETE FROM ARRAY:C228($al_recNumAsignacion;$i)
		DELETE FROM ARRAY:C228($at_Sala;$i)
	End if 
	$t_ultimaReferencia:=$t_referenciaActual
End for 

AT_MultiLevelSort (">>>";->$ai_numeroDia;->$ai_numeroHora;->$at_Abreviacion;->$al_IdAsignaturas;->$al_IdProfesor;->$at_Sala;->$al_recNumAsignacion;->$ad_FechaInicio;->$ad_fechaTermino)
$l_numeroAsignacionesHorario:=Size of array:C274($al_IdAsignaturas)
For ($i;1;$l_numeroAsignacionesHorario)
	$t_nombreSala:=$at_Sala{$i}
	$l_numeroDia:=$ai_numeroDia{$i}
	$l_numeroHora:=$ai_numeroHora{$i}
	If ($at_Sala{$i}#"")
		$t_nombreSala:=$at_Sala{$i}
	Else 
		$t_nombreSala:=""
	End if 
	$l_recNumAsignacion:=$al_recNumAsignacion{$i}
	$l_horaSiguiente:=$l_numeroHora+1
	$y_celdaHoraria_texto:=Get pointer:C304("atSTK_Day"+String:C10($l_numeroDia))
	$y_celdaHoraria_RecNum:=Get pointer:C304("alSTK_Day"+String:C10($l_numeroDia))
	$y_celdaHoraria_Activa:=Get pointer:C304("abSTK_ActivoDay"+String:C10($l_numeroDia))
	$l_elemento:=Find in array:C230(aiSTK_Hora;$l_numeroHora)
	If ($l_elemento>0)
		$b_insertarFila:=True:C214
		For ($i_celdas;$l_elemento;Size of array:C274(aiSTK_Hora))
			If (aiSTK_Hora{$i_celdas}=$l_numeroHora)
				If ($y_celdaHoraria_texto->{$i_celdas}="")
					$b_insertarFila:=False:C215
					$l_celdaSeleccionada:=$i_celdas
				End if 
			End if 
		End for 
		If ($b_insertarFila)
			$l_horaSiguiente:=$l_elemento+1
			  //MONO Ticket 144924
			AT_Insert ($l_horaSiguiente;1;->aiSTK_Hora;->atSTK_HoraAlias;->alSTK_Desde;->alSTK_Hasta;->atSTK_Day1;->atSTK_Day2;->atSTK_Day3;->atSTK_Day4;->atSTK_Day5;->atSTK_Day6;->alSTK_Day1;->alSTK_Day2;->alSTK_Day3;->alSTK_Day4;->alSTK_Day5;->alSTK_Day6;->abSTK_ActivoDay1;->abSTK_ActivoDay2;->abSTK_ActivoDay3;->abSTK_ActivoDay4;->abSTK_ActivoDay5;->abSTK_ActivoDay6;->alSTK_RefTipoHora)
			$l_elemento:=Find in array:C230(alSTK_IDSubsectores;$al_IdAsignaturas{$i})
			If ($l_elemento>0)
				$t_asignatura:=TMT_textoBloqueHorario (atSTK_Subsectores_ShortName{$l_elemento};atTMT_Subsectores_Curso{$l_elemento};$t_nombreSala;atSTK_Subsectores_TeacherName{$l_elemento};$ad_FechaInicio{$i};$ad_fechaTermino{$i};$l_numeroDia)
				$y_celdaHoraria_texto->{$l_horaSiguiente}:=$t_asignatura
				$y_celdaHoraria_RecNum->{$l_horaSiguiente}:=$l_recNumAsignacion
				
				KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacion;False:C215)
				If ([TMT_Horario:166]SesionesHasta:13<Current date:C33(*))
					$y_celdaHoraria_Activa->{$l_horaSiguiente}:=True:C214
				Else 
					$y_celdaHoraria_Activa->{$l_horaSiguiente}:=False:C215
				End if 
				aiSTK_Hora{$l_horaSiguiente}:=$l_numeroHora
				atSTK_HoraAlias{$l_horaSiguiente}:=atSTK_HoraAlias{$l_horaSiguiente-1}  //MONO Ticket 144924
				alSTK_Desde{$l_horaSiguiente}:=alSTK_Desde{$l_horaSiguiente-1}
				alSTK_Hasta{$l_horaSiguiente}:=alSTK_Hasta{$l_horaSiguiente-1}
				alSTK_RefTipoHora{$l_horaSiguiente}:=alSTK_RefTipoHora{$l_horaSiguiente-1}
			End if 
		Else 
			$l_elemento:=Find in array:C230(alSTK_IDSubsectores;$al_IdAsignaturas{$i})
			If ($l_elemento>0)
				$t_asignatura:=TMT_textoBloqueHorario (atSTK_Subsectores_ShortName{$l_elemento};atTMT_Subsectores_Curso{$l_elemento};$t_nombreSala;atSTK_Subsectores_TeacherName{$l_elemento};$ad_FechaInicio{$i};$ad_fechaTermino{$i};$l_numeroDia)
				$y_celdaHoraria_texto->{$l_celdaSeleccionada}:=$t_asignatura
				$y_celdaHoraria_RecNum->{$l_celdaSeleccionada}:=$l_recNumAsignacion
				aiSTK_Hora{$l_celdaSeleccionada}:=$l_numeroHora
				
				KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacion;False:C215)
				If ([TMT_Horario:166]SesionesHasta:13<Current date:C33(*))
					$y_celdaHoraria_Activa->{$l_celdaSeleccionada}:=True:C214
				Else 
					$y_celdaHoraria_Activa->{$l_celdaSeleccionada}:=False:C215
				End if 
			End if 
		End if 
	End if 
End for 

For ($i;1;5)
	$y_celdaHoraria_texto:=Get pointer:C304("atSTK_Day"+String:C10($i))
	$y_celdaHoraria_RecNum:=Get pointer:C304("alSTK_Day"+String:C10($i))
	For ($k;1;Size of array:C274(aiSTK_Hora))
		If ($y_celdaHoraria_texto->{$k}="")
			$y_celdaHoraria_RecNum->{$k}:=-1
		End if 
	End for 
End for 

KRL_UnloadReadOnly (->[TMT_Horario:166];->[TMT_Salas:167];->[Asignaturas:18];->[Asignaturas_RegistroSesiones:168];->[Asignaturas_Inasistencias:125])
OBJECT SET VISIBLE:C603(bTaskWheelHorario;Size of array:C274(aiSTK_Hora)>0)

  // posteo un click sobre el botón que llama a TMT_FijaAparienciaCeldas ya queen algunos casos el redibujo no se hace correctamente con un llamado directo
POST KEY:C465(Character code:C91("*");Command key mask:K16:1)

