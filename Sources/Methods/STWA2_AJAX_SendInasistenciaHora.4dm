//%attributes = {}
C_BOOLEAN:C305($b_expandir)
$b_expandir:=False:C215
$profID:=$1
$userID:=$2
$dFrom:=Current date:C33(*)
Case of 
	: (Count parameters:C259=3)
		$dFrom:=$3
	: (Count parameters:C259=4)
		$dFrom:=$3
		$b_expandir:=$4
End case 

STR_ReadGlobals 
If (USR_checkRights ("L";->[Asignaturas_Inasistencias:125];$userID))
	If (KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)=2)
		PERIODOS_Init 
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		$l_numeroCiclo:=TMT_retornaCiclo ($dFrom)
		While ((Not:C34(DateIsValid ($dFrom;0))) & ($dFrom>=adSTR_Periodos_Desde{1}))
			$dFrom:=$dFrom-1
		End while 
		If (($dFrom>=adSTR_Periodos_Desde{1}) & ($dFrom<=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}))
			ALabs_Initialize 
			READ ONLY:C145([Alumnos_Calificaciones:208])
			$periodo:=PERIODOS_PeriodosActuales ($dFrom;True:C214)
			$idProfAsig:=[Asignaturas:18]profesor_numero:4
			$l_numeroDia:=Day number:C114($dFrom)-1
			EVS_initialize 
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			AS_PropEval_Lectura ("";$periodo)
			EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$periodo)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
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
			SELECTION TO ARRAY:C260([Alumnos:2]no_de_lista:53;$numeroLista;[Alumnos:2]apellidos_y_nombres:40;atSTK_StudentNames;[Alumnos:2]curso:20;atSTK_StudentClass;[Alumnos:2]numero:1;alSTK_StudentIDs;[Alumnos:2]Fecha_de_Ingreso:41;adSTK_FechaIngreso;[Alumnos:2]Fecha_de_retiro:42;adSTK_FechaRetiro)
			If ($b_expandir)
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
				KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
			Else 
				QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
			End if 
			QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$l_numeroDia;*)
			QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]SesionesDesde:12<=$dFrom;*)
			QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]SesionesHasta:13>=$dFrom;*)
			QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]No_Ciclo:14=$l_numeroCiclo)  //mono ticket 143138
			SELECTION TO ARRAY:C260([TMT_Horario:166]ID_Asignatura:5;$al_idAsignaturas)
			
			
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroHora:2;aiSTK_Hora;[TMT_Horario:166]ID_Asignatura:5;alSTK_IDsubsector;[TMT_Horario:166]No_Ciclo:14;$al_numeroCiclo;[Asignaturas:18]denominacion_interna:16;atSTK_Subsectores)
			AT_RedimArrays (Size of array:C274(atSTK_StudentNames);->alSTK_Hora1;->alSTK_Hora2;->alSTK_Hora3;->alSTK_Hora4;->alSTK_Hora5;->alSTK_Hora6;->alSTK_Hora7;->alSTK_Hora8;->alSTK_Hora9;->alSTK_Hora10;->alSTK_Hora11;->alSTK_Hora12;->alSTK_Hora13;->alSTK_Hora14;->alSTK_Hora15;->alSTK_Hora16)
			
			SORT ARRAY:C229(aiSTK_Hora;alSTK_IDsubsector;>)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			ARRAY LONGINT:C221(alSTK_SesionID;Size of array:C274(aiSTK_Hora))
			$idAsignatura:=[Asignaturas:18]Numero:1
			For ($i;1;Size of array:C274(aiSTK_Hora))
				ASrs_CreaRegistro (alSTK_IDsubsector{$i};aiSTK_Hora{$i};$l_numeroCiclo;$dFrom)
			End for 
			READ ONLY:C145([Asignaturas_RegistroSesiones:168])
			  //QUERY([Asignaturas_RegistroSesiones];[Asignaturas_RegistroSesiones]ID_Asignatura=$idAsignatura;*)
			  //QUERY([Asignaturas_RegistroSesiones]; & ;[Asignaturas_RegistroSesiones]Fecha_Sesion=$dFrom)
			QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Asignatura:2;$al_idAsignaturas)
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$dFrom)
			
			
			
			ARRAY TEXT:C222($observacionesSesion;0)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Observacion:12;$observacionesSesion;[Asignaturas_RegistroSesiones:168]ID_Sesion:1;alSTK_SesionID;[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;alSTK_IDsubsector;[Asignaturas_RegistroSesiones:168]Hora:4;aiSTK_Hora;[Asignaturas:18]denominacion_interna:16;atSTK_Subsectores;[Asignaturas_RegistroSesiones:168]Impartida:5;aImpartida;[Asignaturas:18]Curso:5;aClass;[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18;abAsistenciaRegistrada)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			SORT ARRAY:C229(aiSTK_Hora;alSTK_SesionID;alSTK_IDsubsector;atSTK_Subsectores;aImpartida;aClass;$observacionesSesion;abAsistenciaRegistrada;>)
			
			  //quito las comillas
			
			For ($x;1;Size of array:C274($observacionesSesion))
				If ($observacionesSesion{$x}#"")
					$observacionesSesion{$x}:=Replace string:C233($observacionesSesion{$x};Char:C90(34);"'")
				End if 
			End for 
			
			
			  //para marcar las celdas
			ARRAY BOOLEAN:C223($ab_habilitar;0)
			For ($indice;1;Size of array:C274(alSTK_IDsubsector))
				APPEND TO ARRAY:C911($ab_habilitar;(alSTK_IDsubsector{$indice}=$idAsignatura))
			End for 
			
			
			
			
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$idAsignatura;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=vdSTR_Periodos_InicioEjercicio;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=vdSTR_Periodos_FinEjercicio)
			ARRAY DATE:C224($fechasDondeHaySesion;0)
			DISTINCT VALUES:C339([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$fechasDondeHaySesion)
			ARRAY TEXT:C222($fechasDondeHaySesionTXT;Size of array:C274($fechasDondeHaySesion))
			For ($i;1;Size of array:C274($fechasDondeHaySesion))
				$fechasDondeHaySesionTXT{$i}:=STWA2_MakeDate4JS ($fechasDondeHaySesion{$i})
			End for 
			
			
			ARRAY LONGINT:C221($aLong1;0)
			COPY ARRAY:C226(alSTK_SesionID;$aLong1)
			QRY_QueryWithArray (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->$aLong1)
			SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Sesión:1;$al_IdSesiones;[Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnos;[Asignaturas_Inasistencias:125]Justificacion:3;$aJustificacion;[Asignaturas_Inasistencias:125]ID_Asignatura:6;$al_idAsignaturaInasi)
			SORT ARRAY:C229($al_IdAlumnos;$al_IdSesiones;$aJustificacion;$al_idAsignaturaInasi;>)
			
			
			  //habilitar hora en la inasistencia
			ARRAY BOOLEAN:C223($ab_horaHabilitada;0)
			For ($indice;1;Size of array:C274($al_idAsignaturaInasi))
				APPEND TO ARRAY:C911($ab_horaHabilitada;($al_idAsignaturaInasi{$indice}=$idAsignatura))
			End for 
			
			
			
			ARRAY TEXT:C222($aFechasIngreso;Size of array:C274(adSTK_FechaIngreso))
			ARRAY TEXT:C222($aFechasRetiro;Size of array:C274(adSTK_FechaRetiro))
			For ($i;1;Size of array:C274(adSTK_FechaIngreso))
				$aFechasIngreso{$i}:=STWA2_MakeDate4JS (adSTK_FechaIngreso{$i})
				$aFechasRetiro{$i}:=STWA2_MakeDate4JS (adSTK_FechaRetiro{$i})
			End for 
			ARRAY LONGINT:C221($ahoraslong;Size of array:C274(aiSTK_Hora))
			AT_CopyArrayElements (->aiSTK_Hora;->$ahoraslong)
			ARRAY LONGINT:C221($numeroListaLONG;Size of array:C274($numeroLista))
			AT_CopyArrayElements (->$numeroLista;->$numeroListaLONG)
			
			
			$ob_raiz:=OB_Create 
			OB_SET ($ob_raiz;->$numeroListaLONG;"nolista")
			OB_SET ($ob_raiz;->alSTK_StudentIDs;"idsalumnos")
			OB_SET ($ob_raiz;->atSTK_StudentNames;"nombresalumnos")
			OB_SET ($ob_raiz;->$aFechasIngreso;"fechasingreso")
			OB_SET ($ob_raiz;->$aFechasRetiro;"fechasretiro")
			
			OB_SET ($ob_raiz;->$ahoraslong;"horas")
			OB_SET ($ob_raiz;->alSTK_SesionID;"sesiones")
			OB_SET ($ob_raiz;->aImpartida;"impartidas")
			OB_SET ($ob_raiz;->$ab_habilitar;"habilitar")
			OB_SET ($ob_raiz;->$observacionesSesion;"observacionessesion")
			
			
			$t_fecha:=STWA2_MakeDate4JS ($dFrom)
			OB_SET ($ob_raiz;->$t_fecha;"fecha")
			OB_SET ($ob_raiz;->$fechasDondeHaySesionTXT;"fechasdondehaysesion")
			$t_fecha:=STWA2_MakeDate4JS (vdSTR_Periodos_InicioEjercicio)
			OB_SET ($ob_raiz;->$t_fecha;"inicioejercicio")
			$t_fecha:=STWA2_MakeDate4JS (vdSTR_Periodos_FinEjercicio)
			OB_SET ($ob_raiz;->$t_fecha;"finejercicio")
			OB_SET ($ob_raiz;->abAsistenciaRegistrada;"asistregistrada")
			
			$ob_inasistencias:=OB_Create 
			OB_SET ($ob_raiz;->$ob_inasistencias;"inasistencias")
			OB_SET ($ob_raiz;->$al_IdAlumnos;"inasistencias.idalumnos")
			OB_SET ($ob_raiz;->$al_IdSesiones;"inasistencias.sesiones")
			OB_SET ($ob_raiz;->$aJustificacion;"inasistencias.justificaciones")
			OB_SET ($ob_raiz;->$ab_horaHabilitada;"inasistencias.horahabilitada")
			
			$permisocrear:=(USR_checkRights ("M";->[Asignaturas_Inasistencias:125];$userID)) | ($idProfAsig=$profID)
			$permisoeliminar:=(USR_checkRights ("D";->[Asignaturas_Inasistencias:125];$userID)) | (($idProfAsig=$profID) & (<>viSTR_NoModificarNotas=0))
			$permisoimpartir:=(STWA2_Priv_GetMethodAccess ("ASrs_EstadoSesion";$userID) | (USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168];$userID)) | ($idProfAsig=$profID))
			
			OB_SET ($ob_raiz;->$permisocrear;"permisocrear")
			OB_SET ($ob_raiz;->$permisoeliminar;"permisoeliminar")
			OB_SET ($ob_raiz;->$permisoimpartir;"permisoimpartida")
			
			OB_SET ($ob_raiz;-><>aJustAbs;"justificaciones")
			
			$0:=OB_Object2Json ($ob_Raiz)
		Else 
			$0:=STWA2_JSON_SendError (-100002)  //No hay fechas que calcen dentro del año escolar 
		End if 
	Else 
		$0:=STWA2_JSON_SendError (-100001)  //El nivel no esta configurado para asistencia por hora detalle
	End if 
Else 
	$0:=STWA2_JSON_SendError (-100000)  //El usuario no tiene privilegios para ver
End if 