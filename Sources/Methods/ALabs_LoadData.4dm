//%attributes = {}
  // ALabs_LoadData()
  // Por: Alberto Bachler K.: 19-03-14, 15:22:43
  //  ---------------------------------------------
  // 
  //


C_TEXT:C284($1)

C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_mostrarProgreso)
C_DATE:C307($d_fecha)
_O_C_INTEGER:C282($i_alumnos)
C_LONGINT:C283($i;$l_columnaHora;$l_idProceso;$l_IdSesion;$l_numeroCiclo;$l_numeroDia;$l_posicionAlumno;$l_posicionAsignatura)
C_POINTER:C301($y_arregloHora)
C_TEXT:C284($t_curso)

ARRAY INTEGER:C220($al_numeroCiclo;0)
ARRAY LONGINT:C221($al_horasEnHorario;0)
ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY TEXT:C222($at_nombreCurso;0)
ARRAY TEXT:C222($at_profesores;0)

If (False:C215)
	C_TEXT:C284(ALabs_LoadData ;$1)
	C_BOOLEAN:C305(ALabs_LoadData ;$2)
End if 
$t_curso:=$1

$b_mostrarProgreso:=True:C214
If (Count parameters:C259=2)
	$b_mostrarProgreso:=$2
End if 
ALabs_Initialize   //MONO TICKET 214017

If (DateIsValid (dFrom;1))  //MONO TICKET 214017
	
	If ($b_mostrarProgreso)
		$l_idProceso:=IT_UThermometer (1;0;"Leyendo planilla de asistencia...";-5)
	End if 
	$t_curso:=$1
	$d_fecha:=dFrom
	$l_numeroDia:=Day number:C114(dFrom)-1
	
	
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_curso)
	PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	$l_numeroCiclo:=TMT_retornaCiclo ($d_fecha;PERIODOS_refConfiguracion ([Alumnos:2]nivel_numero:29))
	
	For ($i;1;Size of array:C274(aiSTR_Horario_HoraNo))
		If (alSTR_Horario_RefTipoHora{$i}=1)
			APPEND TO ARRAY:C911($al_horasEnHorario;aiSTR_Horario_HoraNo{$i})
		End if 
	End for 
	
	
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
	  //ORDER BY([Alumnos_Calificaciones];[Alumnos_Calificaciones]ID_Alumno;>;[Alumnos_Calificaciones]ID_Asignatura;>)
	  // ASM 20151001  Ticket 150435 
	SET AUTOMATIC RELATIONS:C310(True:C214;True:C214)
	Case of 
		: (<>gOrdenNta=0)
			ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		: (<>gOrdenNta=1)
			ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]no_de_lista:53;>)
		: (<>gOrdenNta=2)
			ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
	End case 
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_curso)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos;[Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IdAsignaturas)
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
	KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
	If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
	End if 
	  // ASM 20151001  Ticket 150435 
	Case of 
		: (<>gOrdenNta=0)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		: (<>gOrdenNta=1)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
		: (<>gOrdenNta=2)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
	End case 
	  //ORDER BY([Alumnos];[Alumnos]Apellidos_y_Nombres;>)
	SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;atSTK_StudentNames;[Alumnos:2]curso:20;atSTK_StudentClass;[Alumnos:2]numero:1;alSTK_StudentIDs;[Alumnos:2]Fecha_de_Ingreso:41;adSTK_FechaIngreso;[Alumnos:2]Fecha_de_retiro:42;adSTK_FechaRetiro)
	
	
	  //Leo las horas asignadas en el horario correspondiente al curso
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$l_numeroDia;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]SesionesDesde:12<=$d_fecha;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]SesionesHasta:13>=$d_fecha;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]No_Ciclo:14=$l_numeroCiclo)  //ASM 20150312 Para horarios configurados semana intercalada ticket 142509 
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroHora:2;aiSTK_Hora;[TMT_Horario:166]ID_Asignatura:5;alSTK_IDsubsector;[TMT_Horario:166]No_Ciclo:14;$al_numeroCiclo;[Asignaturas:18]denominacion_interna:16;atSTK_Subsectores;[Asignaturas:18]Curso:5;$at_nombreCurso;[Asignaturas:18]Curso:5;$at_profesores)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	AT_RedimArrays (Size of array:C274(atSTK_StudentNames);->alSTK_Hora1;->alSTK_Hora2;->alSTK_Hora3;->alSTK_Hora4;->alSTK_Hora5;->alSTK_Hora6;->alSTK_Hora7;->alSTK_Hora8;->alSTK_Hora9;->alSTK_Hora10;->alSTK_Hora11;->alSTK_Hora12;->alSTK_Hora13;->alSTK_Hora14;->alSTK_Hora15;->alSTK_Hora16)
	AT_RedimArrays (Size of array:C274(atSTK_StudentNames);->alSTK_Hora17;->alSTK_Hora18;->alSTK_Hora19;->alSTK_Hora20;->alSTK_Hora21;->alSTK_Hora22;->alSTK_Hora23;->alSTK_Hora24)
	SORT ARRAY:C229(aiSTK_Hora;alSTK_IDsubsector;$at_nombreCurso;>)
	
	
	For ($i;1;Size of array:C274(aiSTK_Hora))
		ASrs_CreaRegistro (alSTK_IDsubsector{$i};aiSTK_Hora{$i};$l_numeroCiclo;dFrom)
	End for 
	
	
	READ ONLY:C145([Asignaturas_RegistroSesiones:168])
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=dFrom;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=$l_numeroCiclo)  //MONO Ticket 201788
	QRY_QueryWithArray (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->alSTK_IDsubsector;True:C214)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]ID_Sesion:1;alSTK_SesionID;[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;alSTK_IDsubsector;[Asignaturas_RegistroSesiones:168]Hora:4;aiSTK_Hora;[Asignaturas:18]denominacion_interna:16;atSTK_Subsectores;[Asignaturas_RegistroSesiones:168]Impartida:5;aImpartida;[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18;ab_InasistenciaTomada;[Asignaturas:18]Curso:5;$at_nombreCurso;[Profesores:4]Nombre_comun:21;$at_profesores)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	  //MONO Ticket 144924
	For ($i;1;Size of array:C274(aiSTK_Hora))
		$fia:=Find in array:C230(aiSTR_Horario_HoraNo;aiSTK_Hora{$i})
		APPEND TO ARRAY:C911(atSTK_HoraAlias;atSTR_Horario_HoraAlias{$fia})
	End for 
	
	For ($i;1;Size of array:C274(atSTK_Subsectores))
		If ($at_nombreCurso{$i}#$t_curso)
			atSTK_Subsectores{$i}:=atSTK_Subsectores{$i}+" ("+$at_nombreCurso{$i}+")\r"+$at_profesores{$i}
		Else 
			atSTK_Subsectores{$i}:=atSTK_Subsectores{$i}+"\r"+$at_profesores{$i}
		End if 
	End for 
	
	
	For ($i_alumnos;1;Size of array:C274($al_IdAlumnos))
		$l_posicionAlumno:=Find in array:C230(alSTK_StudentIDs;$al_IdAlumnos{$i_alumnos})
		$l_posicionAsignatura:=Find in array:C230(alSTK_IDsubsector;$al_IdAsignaturas{$i_alumnos})
		If ($l_posicionAsignatura>0)
			$l_columnaHora:=Find in array:C230($al_horasEnHorario;aiSTK_Hora{$l_posicionAsignatura})
			If (($l_columnaHora>0) & ($l_posicionAlumno>0))
				While (($l_columnaHora>0) & ($l_posicionAlumno>0))
					$l_IdSesion:=alSTK_SesionID{$l_posicionAsignatura}
					$y_arregloHora:=Get pointer:C304("alSTK_Hora"+String:C10($l_columnaHora))
					$y_arregloHora->{$l_posicionAlumno}:=$l_IdSesion
					$l_posicionAsignatura:=Find in array:C230(alSTK_IDsubsector;$al_IdAsignaturas{$i_alumnos};$l_posicionAsignatura+1)
					If ($l_posicionAsignatura>0)
						$l_columnaHora:=Find in array:C230($al_horasEnHorario;aiSTK_Hora{$l_posicionAsignatura})
					Else 
						$l_columnaHora:=0
					End if 
				End while 
			End if 
		End if 
	End for 
	
	If ($b_mostrarProgreso)
		$l_idProceso:=IT_UThermometer (-2;$l_idProceso)
	End if 
End if 
