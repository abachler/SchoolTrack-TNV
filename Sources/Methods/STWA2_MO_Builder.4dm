//%attributes = {}
C_TEXT:C284($1;$0;$uuid;$t_uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_BOOLEAN:C305($b_prefMisAsig;$b_esResponsableNivel)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$profID:=STWA2_Session_GetProfID ($uuid)
$userID:=STWA2_Session_GetUserSTID ($uuid)
$admin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
$dato:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dato")
$fecha:=Date:C102(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"fecha"))
$l_dia:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dia"))
$l_reemplazoID:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"reemplazoID"))
$b_prefMisAsig:=Choose:C955(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"misasignaturas")="True";True:C214;False:C215)
$l_guardarPref:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"guardarPref"))
$b_esResponsableNivel:=False:C215

If ($fecha=!00-00-00!)
	$fecha:=Current date:C33
End if 
$fechaOld:=$fecha

Case of 
	: ($dato="asignaturas")
		C_OBJECT:C1216($ob_raiz;$o_resultado)
		C_BOOLEAN:C305($b_esAdministrador;$b_mostrarProfesor;$b_mostrarCurso;$b_sinAsignaturas;$b_filtrarAsig;$b_esProfeJefeg)
		C_BOOLEAN:C305($b_antesInicioPeriodo)  //20180126 RCH Ticket 197811
		C_TEXT:C284($t_antesInicioPeriodo)
		C_LONGINT:C283($i;$profID;$l_recNumAsignatura;$l_userId)
		C_TEXT:C284($t_currentOnErrorMethod;$t_json;$uuid;$t_mensajeFecha)
		$b_sinAsignaturas:=False:C215
		
		ARRAY TEXT:C222($at_asignaturasNombre;0)
		ARRAY TEXT:C222($at_Cursos;0)
		ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
		ARRAY LONGINT:C221($al_RecNumCurso;0)
		ARRAY LONGINT:C221($al_NivelNumeroCurso;0)
		ARRAY LONGINT:C221($al_ModoRegistroInasistencia;0)
		ARRAY LONGINT:C221($al_IdAsignaturaSesion;0)
		ARRAY TEXT:C222($at_CursosHora;0)
		ARRAY LONGINT:C221($recNumSesion;0)
		ARRAY INTEGER:C220($al_numeroHora;0)
		ARRAY LONGINT:C221($al_ModoRegistroHora;0)
		ARRAY TEXT:C222($at_asignaturaNombreSesion;0)
		ARRAY LONGINT:C221($al_nivelNumerohora;0)
		ARRAY LONGINT:C221($al_recNumAsigHora;0)
		ARRAY LONGINT:C221($al_ModoRegistroAsignatura;0)
		ARRAY LONGINT:C221($al_RecNumAsignaturasNiveles;0)  //niveles
		ARRAY BOOLEAN:C223($ab_ProfesorAsignatura;0)
		ARRAY BOOLEAN:C223($ab_ProfesorAsignaturaHora;0)
		ARRAY LONGINT:C221($al_AsignaturasReemplazo;0)
		
		  //cargo preferencia de mis asignaturas
		If ($l_guardarPref=1)
			PREF_Set ($userID;"MisAsignaturasSTWA";String:C10(Num:C11($b_prefMisAsig)))
		Else 
			$l_PrefMisAsig:=Num:C11(PREF_fGet ($userID;"MisAsignaturasSTWA";String:C10(Num:C11($b_prefMisAsig))))
			$b_prefMisAsig:=($l_PrefMisAsig=1)
		End if 
		
		  //cargo las asignaturas que el profesor puede ver.
		If ($l_reemplazoID=0)
			If (($profID=0) | ($admin))
				ALL RECORDS:C47([Asignaturas:18])
			Else 
				If ($b_prefMisAsig)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$profID;*)
					QUERY:C277([Asignaturas:18]; | ;[Asignaturas:18]profesor_firmante_numero:33=$profID)
				Else 
					dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
				End if 
			End if 
		Else 
			  //Para trabajar los reemplazos de profesores.
			AT_Initialize (->$al_AsignaturasReemplazo)
			$profID:=KRL_GetNumericFieldData (->[xShell_Users:47]No:1;->$l_reemplazoID;->[xShell_Users:47]NoEmployee:7)
			STWA2_ReemplazaUsuario ("inicializa")
			$b_filtrarAsig:=Choose:C955(STWA2_ReemplazaUsuario ("cargaAsignaturasReemplazo";$uuid;->$al_AsignaturasReemplazo)="True";True:C214;False:C215)
			dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
			
			If ($b_filtrarAsig)
				QUERY SELECTION WITH ARRAY:C1050([Asignaturas:18]Numero:1;$al_AsignaturasReemplazo)
			End if 
			
		End if 
		
		STR_VerificaBloqueoSitFinal 
		$l_firmanteProf:=Num:C11(PREF_fGet (0;"FirmantesAutorizados"))
		
		CREATE SET:C116([Asignaturas:18];"asignaturas")
		$b_mostrarCurso:=Choose:C955(PREF_fGet (0;"Muestra_Curso"+String:C10($userID);"True")="true";True:C214;False:C215)
		
		If (Records in selection:C76([Asignaturas:18])=0)
			$b_sinAsignaturas:=True:C214
		End if 
		
		$o_resultado:=STWA2_ValidaFechaPeriodo ([Asignaturas:18]Numero_del_Nivel:6;$fecha;1)
		$b_antesInicioPeriodo:=OB Get:C1224($o_resultado;"antesInicioPeriodo")
		$t_antesInicioPeriodo:=OB Get:C1224($o_resultado;"antesInicioPeriodoMsj")
		$t_mensajeFecha:=OB Get:C1224($o_resultado;"mensajeFecha")
		
		  //cargo datos de la asignatura actual (hora, nombre y RN)
		$b_Agrupar:=True:C214
		READ ONLY:C145([TMT_Horario:166])
		If (($userID<0) | ($admin))
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Teacher:9#0)
			$b_Agrupar:=False:C215
		Else 
			KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
		End if 
		
		$b_RegistroAsisMix:=False:C215
		KRL_RelateSelection (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;"")
		QUERY SELECTION:C341([xxSTR_Niveles:6];[xxSTR_Niveles:6]AttendanceMode:3=1)
		$b_RegistroAsisMix:=(Records in selection:C76([xxSTR_Niveles:6])>0)
		
		CREATE SET:C116([TMT_Horario:166];"horario")
		
		If ((Records in selection:C76([TMT_Horario:166])>0) & (Not:C34($b_RegistroAsisMix)))
			Repeat 
				USE SET:C118("horario")
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$fecha;*)
				QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$fecha)
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=DT_GetDayNumber_ISO8601 ($fecha))
				$l_cantidadHorario:=Records in selection:C76([TMT_Horario:166])
				If ($l_cantidadHorario=0)
					$fecha:=$fecha-1
					$t_mensajeFecha:="¡Atención! Está registrando inasistencias para una fecha distinta a hoy."
				End if 
				If (adSTR_Periodos_Desde{1}>=$fecha)
					$l_cantidadHorario:=1
					$fecha:=$fechaOld
				End if 
			Until ($l_cantidadHorario>0)
		End if 
		
		
		If ($fecha<Current date:C33(*))
			$t_mensajeFecha:=__ ("¡Atención! Está registrando inasistencias para una fecha distinta a hoy.")
		End if 
		ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2;>)
		  //CREATE SET([TMT_Horario];"horario")
		
		$b_conHorario:=(Records in selection:C76([TMT_Horario:166])>0)  //para validar si existe horario configurado
		
		QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]Desde:3<=Current time:C178)
		QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]Hasta:4>=Current time:C178)
		
		If (Records in selection:C76([TMT_Horario:166])>0)
			FIRST RECORD:C50([TMT_Horario:166])
			$l_recNumAsignaturaActual:=Find in field:C653([Asignaturas:18]Numero:1;[TMT_Horario:166]ID_Asignatura:5)
			$l_horaActual:=[TMT_Horario:166]NumeroHora:2
			$t_nombreAsignaturaActual:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Asignatura:3)
			$t_cursoActual:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Curso:5)
			
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[TMT_Horario:166]ID_Asignatura:5;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=[TMT_Horario:166]NumeroHora:2;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15=[TMT_Horario:166]NumeroDia:1)
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$fecha)
			$l_Idsesion:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
		Else 
			$l_horaActual:=-1
			$t_nombreAsignaturaActual:=""
			$l_recNumAsignaturaActual:=-1
			$t_cursoActual:=""
			$l_Idsesion:=-1
		End if 
		
		USE SET:C118("asignaturas")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Nivel:30;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]Asignatura:3;>)
		SELECTION TO ARRAY:C260([Asignaturas:18];$al_RecNumAsignaturas;[Asignaturas:18]Asignatura:3;$at_asignaturasNombre;[Asignaturas:18]Curso:5;$at_asignaturasCurso;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelNumeroAsignaturas;*)
		SELECTION TO ARRAY:C260([Asignaturas:18]Curso:5;$at_Cursos)
		SELECTION TO ARRAY:C260
		
		  //cargo tipo registro de ingreso de inasistencia correspondiente a los niveles 
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_noNiveles)
		
		  //Cargo la configuración de periodos para los distintos niveles
		  //20180630 ASM Ticket 210597
		ARRAY DATE:C224($ad_feriadosTemporal;0)
		ARRAY DATE:C224($ad_feriadosTodos;0)
		
		For ($i;1;Size of array:C274($al_noNiveles))
			PERIODOS_LoadData ($al_noNiveles{$i})
			COPY ARRAY:C226($ad_feriadosTodos;$ad_feriadosTemporal)
			AT_intersect (->adSTR_Calendario_Feriados;->$ad_feriadosTemporal;->$ad_feriadosTodos)
			If (Size of array:C274($ad_feriadosTodos)=0)
				COPY ARRAY:C226(adSTR_Calendario_Feriados;$ad_feriadosTodos)
			End if 
		End for 
		
		ARRAY TEXT:C222($at_feriadostexto;0)
		For ($l_feriados;1;Size of array:C274($ad_feriadosTodos))
			APPEND TO ARRAY:C911($at_feriadostexto;STWA2_MakeDate4JS ($ad_feriadosTodos{$l_feriados}))
		End for 
		
		C_OBJECT:C1216($ob_periodos;$ob_periodoTemp)
		$ob_periodos:=OB_Create 
		For ($i;1;Size of array:C274($al_noNiveles))
			$t_nombrePeriodo:=String:C10($al_noNiveles{$i})
			$ob_periodoTemp:=OB_Create 
			PERIODOS_LoadData ($al_noNiveles{$i})
			
			$l_cantidadPeriodo:=Size of array:C274(adSTR_Periodos_Desde)
			OB_SET ($ob_periodoTemp;->$l_cantidadPeriodo;"numeroPeriodo")
			OB_SET ($ob_periodoTemp;->adSTR_Periodos_Desde;"desde")
			OB_SET ($ob_periodoTemp;->adSTR_Periodos_Hasta;"hasta")
			OB_SET ($ob_periodoTemp;->atSTR_Periodos_Nombre;"nombre")
			OB_SET ($ob_periodoTemp;->adSTR_Periodos_Cierre;"cierre")
			OB_SET ($ob_periodoTemp;->$ad_feriadosTodos;"feriados")
			OB_SET ($ob_periodoTemp;->$at_feriadostexto;"feriadostexto")
			OB_SET ($ob_periodos;->$ob_periodoTemp;$t_nombrePeriodo)
		End for 
		
		
		
		USE SET:C118("asignaturas")
		ARRAY DATE:C224($ad_fechasSesion;0)
		  //PERIODOS_LoadData ([Asignaturas]Numero_del_Nivel)
		KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=adSTR_Periodos_Desde{1})
		AT_DistinctsFieldValues (->[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;->$ad_fechasSesion)
		
		
		  //cargo la información de las horas del horario y sesiones
		CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturas)
		KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$fecha)
		
		  //en caso de no existir sesiones para el día las creo
		If ((Records in selection:C76([Asignaturas_RegistroSesiones:168])=0) & ($b_conHorario))
			
			For ($i;1;Size of array:C274($al_RecNumAsignaturas))
				GOTO RECORD:C242([Asignaturas:18];$al_RecNumAsignaturas{$i})
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Asignaturas:18]Numero_del_Nivel:6)
				If ([xxSTR_Niveles:6]AttendanceMode:3=2)
					AS_CreaSesionesAsignatura ([Asignaturas:18]Numero:1;$fecha)
				End if 
			End for 
			
			CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturas)
			KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$fecha)
			
		End if 
		
		If ((Records in selection:C76([Asignaturas_RegistroSesiones:168])=0) & (Not:C34($b_RegistroAsisMix)))
			USE SET:C118("asignaturas")
			KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Año:13=<>gyear)
			AT_DistinctsFieldValues (->[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;->aQR_Date1)
			$fecha:=aQR_Date1{Size of array:C274(aQR_Date1)}
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$fecha)
			
		End if 
		
		  //Config Horario //MONO Ticket 144924
		ARRAY INTEGER:C220($aiSTR_Horario_HoraNo;0)
		ARRAY TEXT:C222($atSTR_Horario_HoraAlias;0)
		ARRAY TEXT:C222($at_horasAlias;0)
		$l_lastPeriodoCfgCharged:=0
		
		ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Hora:4;>;[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;>)
		SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168];$recNumSesion;[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;$al_IdAsignaturaSesion;[Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_IdSesion;*)
		SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Hora:4;$al_numeroHora;[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18;$ab_asistenciaRegistrada;*)
		SELECTION TO ARRAY:C260
		
		For ($i;1;Size of array:C274($al_IdAsignaturaSesion))
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_IdAsignaturaSesion{$i})
			APPEND TO ARRAY:C911($at_asignaturaNombreSesion;[Asignaturas:18]Asignatura:3)
			APPEND TO ARRAY:C911($al_nivelNumerohora;[Asignaturas:18]Numero_del_Nivel:6)
			APPEND TO ARRAY:C911($at_CursosHora;[Asignaturas:18]Curso:5)
			
			  //MONO Ticket 144924
			$l_reference:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
			If ($l_reference#$l_lastPeriodoCfgCharged)
				$l_lastPeriodoCfgCharged:=$l_reference
				$o_Horario:=KRL_GetObjectFieldData (->[xxSTR_Periodos:100]ID:1;->$l_reference;->[xxSTR_Periodos:100]Horario:14)
				OB GET ARRAY:C1229($o_Horario;"ai_HoraNo";$aiSTR_Horario_HoraNo)
				OB GET ARRAY:C1229($o_Horario;"at_HoraAlias";$atSTR_Horario_HoraAlias)
			End if 
			$fia:=Find in array:C230($aiSTR_Horario_HoraNo;$al_numeroHora{$i})
			If ($fia#-1)
				APPEND TO ARRAY:C911($at_horasAlias;$atSTR_Horario_HoraAlias{$fia})
			Else 
				APPEND TO ARRAY:C911($at_horasAlias;String:C10($al_numeroHora{$i}))
			End if 
			
		End for 
		
		  //agrupo hora por asignatura
		ARRAY LONGINT:C221($al_AgregarAlFinalAsig;0)
		ARRAY TEXT:C222($at_horaAgrupadas;0)
		ARRAY TEXT:C222($at_sesionesAgrupadas;0)
		ARRAY LONGINT:C221($al_idAsignatura;0)
		ARRAY LONGINT:C221($al_posAgregar;0)
		ARRAY BOOLEAN:C223($ab_ProfAsigAgrupadas;0)
		
		If ($b_Agrupar)
			For ($i;1;Size of array:C274($al_IdAsignaturaSesion))
				$l_pos:=Find in array:C230($al_idAsignatura;$al_IdAsignaturaSesion{$i})
				If ($l_pos=-1)
					$l_enArray:=Count in array:C907($al_IdAsignaturaSesion;$al_IdAsignaturaSesion{$i})
					If ($l_enArray=1)
						APPEND TO ARRAY:C911($al_AgregarAlFinalAsig;$al_IdAsignaturaSesion{$i})
					Else 
						  //APPEND TO ARRAY($at_horaAgrupadas;String($al_numeroHora{$i}))
						APPEND TO ARRAY:C911($at_horaAgrupadas;$at_horasAlias{$i})  //MONO Ticket 144924
						APPEND TO ARRAY:C911($al_idAsignatura;$al_IdAsignaturaSesion{$i})
						APPEND TO ARRAY:C911($al_posAgregar;($i-1))
						APPEND TO ARRAY:C911($at_sesionesAgrupadas;String:C10($al_IdSesion{$i}))
					End if 
				Else 
					  //$at_horaAgrupadas{$l_pos}:=$at_horaAgrupadas{$l_pos}+" - "+String($al_numeroHora{$i})
					$at_horaAgrupadas{$l_pos}:=$at_horaAgrupadas{$l_pos}+" - "+$at_horasAlias{$i}  //MONO Ticket 144924
					$at_sesionesAgrupadas{$l_pos}:=$at_sesionesAgrupadas{$l_pos}+"_"+String:C10($al_IdSesion{$i})
				End if 
			End for 
			
		End if 
		
		  //mando los curso ordenados acá
		ARRAY TEXT:C222($at_Cursos;0)
		ARRAY LONGINT:C221($al_nivelCurso;0)
		For ($i;1;Size of array:C274($at_asignaturasCurso))
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$at_asignaturasCurso{$i})
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Asignaturas:18]Numero_del_Nivel:6)
			If ([xxSTR_Niveles:6]AttendanceMode:3=1)
				If (Find in array:C230($at_Cursos;$at_asignaturasCurso{$i})=-1)
					APPEND TO ARRAY:C911($al_nivelCurso;[Asignaturas:18]Numero_del_Nivel:6)
					APPEND TO ARRAY:C911($at_Cursos;$at_asignaturasCurso{$i})
				End if 
			End if 
		End for 
		
		For ($i;1;Size of array:C274($at_CursosHora))
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$at_CursosHora{$i})
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Asignaturas:18]Numero_del_Nivel:6)
			If ([xxSTR_Niveles:6]AttendanceMode:3=2)
				If (Find in array:C230($at_Cursos;$at_CursosHora{$i})=-1)
					APPEND TO ARRAY:C911($al_nivelCurso;[Asignaturas:18]Numero_del_Nivel:6)
					APPEND TO ARRAY:C911($at_Cursos;$at_CursosHora{$i})
				End if 
			End if 
		End for 
		
		AT_MultiLevelSort (">>";->$al_nivelCurso;->$at_Cursos)
		
		  //verifico permisos de inasisntecias por hora y detallado
		$t_CursoProfJefe:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_profesor_jefe:2;->$profID;->[Cursos:3]Curso:1)
		$permisocrear:=USR_checkRights ("A";->[Asignaturas_Inasistencias:125];$userID)
		$permisoeliminar:=USR_checkRights ("D";->[Asignaturas_Inasistencias:125];$userID)
		$permisocrearDiario:=USR_checkRights ("A";->[Alumnos_Inasistencias:10];$userID)
		  //$permisoeliminarDiario:=((USR_checkRights ("D";->[Alumnos_Conducta];$userID)) & (USR_GetMethodAcces ("AL_EliminaInasistencia")))//MONO 150618 ticket 208223
		$permisoeliminarDiario:=((USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)) & (STWA2_Priv_GetMethodAccess ("AL_EliminaInasistencia";$userID)))  //MONO 150618 ticket 208223
		$permisocrearAtrasos:=USR_checkRights ("A";->[Alumnos_Conducta:8];$userID)
		$permisoEliminarAtrasos:=USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)
		$permisoModAtraso:=USR_checkRights ("M";->[Alumnos_Conducta:8];$userID)
		$permisoModInaDiaria:=USR_checkRights ("M";->[Alumnos_Conducta:8];$userID)
		$permisoModInaPorHora:=USR_checkRights ("M";->[Asignaturas_Inasistencias:125];$userID)
		$permisoconducta:=((USR_checkRights ("A";->[Alumnos_Conducta:8];$userID)) | (Find in array:C230($at_Cursos;$t_CursoProfJefe)#-1))
		$permisoconducta:=$permisoconducta | ((($permisocrear) | ($permisoeliminar) | ($permisocrearDiario) | ($permisoeliminarDiario) | ($permisocrearAtrasos) | ($permisocrearAtrasos)))
		$b_NoModificarNotas:=(<>viSTR_NoModificarNotas=1)
		$b_NoModificarNotas:=$b_NoModificarNotas & Not:C34(USR_checkRights ("D";->[Asignaturas_Inasistencias:125];$userID))
		$b_NoModificarNotas:=$b_NoModificarNotas & Not:C34(USR_checkRights ("D";->[Alumnos_Calificaciones:208];$userID))
		$l_NoModificarNotas:=Num:C11($b_NoModificarNotas)
		
		
		  //realizo validaciones para mostrar el curso para funcionario no profesor de asignatura
		  //$b_mostrarCurso:=((Size of array($al_RecNumAsignaturas)=0) & (($permisocrear) | ($permisoeliminar) | ($permisocrearDiario) | ($permisoeliminarDiario) | ($permisocrearAtrasos) | ($permisocrearAtrasos)))
		
		
		  //Cargo el modo de registro de asistencia para los niveles de las asignaturas
		
		For ($i;1;Size of array:C274($al_nivelNumeroAsignaturas))
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$al_nivelNumeroAsignaturas{$i})
			APPEND TO ARRAY:C911($al_ModoRegistroAsignatura;[xxSTR_Niveles:6]AttendanceMode:3)
			
			GOTO RECORD:C242([Asignaturas:18];$al_RecNumAsignaturas{$i})
			$l_profeID:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->[Asignaturas:18]Curso:5;->[Cursos:3]Numero_del_profesor_jefe:2)
			APPEND TO ARRAY:C911($ab_ProfesorAsignatura;False:C215)
			  //APPEND TO ARRAY($ab_ProfesorAsignatura;(([Asignaturas]Profesor_Numero=$profID) | (([Asignaturas]Profesor_firmante_numero=$profID) & ($l_firmanteProf=1))))
		End for 
		
		For ($i;1;Size of array:C274($al_IdAsignaturaSesion))
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_IdAsignaturaSesion{$i})
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Asignaturas:18]Numero_del_Nivel:6)
			APPEND TO ARRAY:C911($al_ModoRegistroHora;[xxSTR_Niveles:6]AttendanceMode:3)
			APPEND TO ARRAY:C911($al_recNumAsigHora;Record number:C243([Asignaturas:18]))
			APPEND TO ARRAY:C911($ab_ProfesorAsignaturaHora;(([Asignaturas:18]profesor_numero:4=$profID) | (([Asignaturas:18]profesor_firmante_numero:33=$profID) & ($l_firmanteProf=1))))
		End for 
		
		For ($i;1;Size of array:C274($al_NivelNumeroCurso))
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$al_NivelNumeroCurso{$i})
			APPEND TO ARRAY:C911($al_ModoRegistroInasistencia;[xxSTR_Niveles:6]AttendanceMode:3)
		End for 
		
		  //para manejar los mensajes de errores
		
		$t_mensajeError:=""
		Case of 
			: (($b_conHorario) & (Size of array:C274($al_IdSesion)=0))
				$t_mensajeError:=__ ("Existen asignaturas configuradas para ingreso de inasistencia por hora detallado que no se encuentran configuradas en el horario.")
				
			: ($b_sinAsignaturas)
				$t_mensajeError:=__ ("Funcionario sin asignaturas asociadas.")
		End case 
		
		$t_fecha:=String:C10($fecha;System date short:K1:1)  //MONO Ticket 187820
		$ob_raiz:=OB_Create 
		  //cargo los permisos del usuario sobre inasistencia y atrasos
		
		$t_mensajeBloqueo:=__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ (".")
		
		  //valido que existan cursos asociados al profesor o asignaturas
		$b_esResponsableNivel:=STR_ResponsableNiveles ("verificaUsuario";$profID)
		$b_DesplegarDialog:=True:C214
		If ((Size of array:C274($at_Cursos)=0) & (Size of array:C274($al_RecNumAsignaturas)=0) & (Size of array:C274($recNumSesion)=0) & ($t_CursoProfJefe="") & (Not:C34($b_esResponsableNivel)))
			$b_DesplegarDialog:=False:C215
		End if 
		
		
		C_OBJECT:C1216($ob_permisos;$ob_fechaDesglosada)
		
		$l_dia:=Day of:C23($fecha)
		$l_mes:=Month of:C24($fecha)
		$l_año:=Year of:C25($fecha)
		OB SET:C1220($ob_fechaDesglosada;"dia";$l_dia)
		OB SET:C1220($ob_fechaDesglosada;"mes";$l_mes)
		OB SET:C1220($ob_fechaDesglosada;"year";$l_año)
		
		$ob_permisos:=OB_Create 
		OB_SET ($ob_permisos;->$permisocrear;"permisoCrearDetalladoIna")
		OB_SET ($ob_permisos;->$permisoeliminar;"permisoEliminarDetalladoIna")
		OB_SET ($ob_permisos;->$permisocrearDiario;"permisoCrearDiarioIna")
		OB_SET ($ob_permisos;->$permisoeliminarDiario;"permisoEliminarDiarioIna")
		OB_SET ($ob_permisos;->$permisocrearAtrasos;"permisoCrearAtraso")
		OB_SET ($ob_permisos;->$permisoEliminarAtrasos;"permisoEliminarAtraso")
		OB_SET ($ob_permisos;->$permisoModAtraso;"permisoModificarAtraso")
		OB_SET ($ob_permisos;->$permisoModInaDiaria;"permisoModificarInaDiaria")
		OB_SET ($ob_permisos;->$permisoModInaPorHora;"permisoModificarInaHora")
		OB_SET ($ob_permisos;->$b_conHorario;"conHorario")
		OB_SET ($ob_permisos;->$b_mostrarCurso;"mostrarCurso")
		OB_SET ($ob_permisos;->$t_fecha;"fecha")  //MONO Ticket 187820
		OB_SET ($ob_permisos;->$fecha;"fechaDatePicker")  //MONO Ticket 187820
		OB_SET ($ob_permisos;->$t_mensajeFecha;"atencion")
		OB_SET ($ob_permisos;->$l_NoModificarNotas;"postIngreso")
		OB_SET ($ob_permisos;->$permisoconducta;"permisoconducta")
		OB_SET ($ob_permisos;-><>vb_BloquearModifSituacionFinal;"bloquear")
		OB_SET ($ob_permisos;->$t_mensajeBloqueo;"mensajeBloqueo")
		OB_SET ($ob_permisos;->$b_esResponsableNivel;"esResponsableNivel")
		OB_SET ($ob_permisos;->$ob_fechaDesglosada;"fechaDesglosada")
		
		  //envio información de cursos
		C_OBJECT:C1216($ob_cursos)
		$ob_cursos:=OB_Create 
		OB_SET ($ob_cursos;->$at_Cursos;"curso")
		OB_SET ($ob_cursos;->$al_nivelCurso;"nivel_curso")
		
		  //envio informacion de periodos y feriados para los calendarios
		C_OBJECT:C1216($ob_periodo)
		$ob_periodo:=OB_Create 
		OB_SET ($ob_periodo;->$ob_periodos;"periodos")
		OB_SET ($ob_periodo;->$ad_fechasSesion;"fechasesiones")
		OB_SET ($ob_periodo;->$b_antesInicioPeriodo;"fechaAnteriorAInicioAño")  //20180126 RCH Ticket 197811
		OB_SET ($ob_periodo;->$t_antesInicioPeriodo;"mensaje")  //20180126 RCH Ticket 197811
		
		  //Envio asignaturas del profesor
		C_OBJECT:C1216($ob_asignaturas)
		$ob_asignaturas:=OB_Create 
		OB_SET ($ob_asignaturas;->$al_RecNumAsignaturas;"rnAsignatura")
		OB_SET ($ob_asignaturas;->$at_asignaturasNombre;"nombreAsignatura")
		OB_SET ($ob_asignaturas;->$at_asignaturasCurso;"cursoAsignatura")
		OB_SET ($ob_asignaturas;->$al_nivelNumeroAsignaturas;"nivelAsignatura")
		OB_SET ($ob_asignaturas;->$al_ModoRegistroAsignatura;"ModoRegistroAsignatura")
		OB_SET ($ob_asignaturas;->$ab_ProfesorAsignatura;"profesorAsignatura")
		
		  //Envio de asignatura actual y hora según configuración de horario
		C_OBJECT:C1216($ob_horaActual)
		$ob_horaActual:=OB_Create 
		OB_SET ($ob_horaActual;->$t_cursoActual;"cursoActual")
		OB_SET ($ob_horaActual;->$t_nombreAsignaturaActual;"asignaturaActual")
		OB_SET ($ob_horaActual;->$l_recNumAsignaturaActual;"recNumAsignaturaActual")
		OB_SET ($ob_horaActual;->$l_horaActual;"horaActual")
		OB_SET ($ob_horaActual;->$l_Idsesion;"idsesion")
		
		  //envio datos de horas de horario
		C_OBJECT:C1216($ob_horas)
		$ob_horas:=OB_Create 
		OB_SET ($ob_horas;->$al_IdSesion;"idSesion")
		OB_SET ($ob_horas;->$al_IdAsignaturaSesion;"idAsignaturaSesion")
		OB_SET ($ob_horas;->$recNumSesion;"recNumSesion")
		OB_SET ($ob_horas;->$al_numeroHora;"hora")
		OB_SET ($ob_horas;->$at_horasAlias;"horaAlias")  //MONO Ticket 144924
		OB_SET ($ob_horas;->$al_nivelNumerohora;"nivelHora")
		OB_SET ($ob_horas;->$at_asignaturaNombreSesion;"asignatura")
		OB_SET ($ob_horas;->$al_ModoRegistroHora;"ModoRegistroHora")
		OB_SET ($ob_horas;->$at_horaAgrupadas;"agrupadas")
		OB_SET ($ob_horas;->$al_posAgregar;"posicion")
		OB_SET ($ob_horas;->$at_sesionesAgrupadas;"sesionesagrupadas")
		OB_SET ($ob_horas;->$al_recNumAsigHora;"rnAsignatura")
		OB_SET ($ob_horas;->$at_CursosHora;"cursosHoras")
		OB_SET ($ob_horas;->$ab_asistenciaRegistrada;"asistenciaRegistrada")
		OB_SET ($ob_horas;->$ab_ProfesorAsignaturaHora;"profesorAsignatura")
		OB_SET ($ob_horas;->$ab_ProfAsigAgrupadas;"profesorAsignaturaAgrupadas")
		
		  //Envio datos de atrasos
		C_OBJECT:C1216($ob_confAtrasos)
		$ob_confAtrasos:=OB_Create 
		STR_LeePreferenciasAtrasos2 
		ST_JustificacionAtrasos ("cargaVariables")
		
		OB_SET ($ob_confAtrasos;-><>vr_InasistenciasXatrasos;"inasistenciaXatrasos")
		OB_SET ($ob_confAtrasos;->vt_Intervalos;"intervalos")
		OB_SET ($ob_confAtrasos;->vi_RegistrarMinutosEnAtrasos;"registraMinutos")
		OB_SET ($ob_confAtrasos;->at_JustificacionNombre;"motivosNombre")
		OB_SET ($ob_confAtrasos;->al_JustificacionID;"motivosID")
		
		
		  //cargo los datos
		$b_esProfeJefe:=($t_CursoProfJefe#"")
		OB_SET ($ob_raiz;->$ob_permisos;"permisos")
		OB_SET ($ob_raiz;->$ob_cursos;"cursos")
		OB_SET ($ob_raiz;->$ob_periodo;"periodos")
		OB_SET ($ob_raiz;->$ob_asignaturas;"asignaturas")
		OB_SET ($ob_raiz;->$ob_horaActual;"actual")
		OB_SET ($ob_raiz;->$ob_horas;"horas")
		OB_SET ($ob_raiz;->$ob_confAtrasos;"configAtrasos")
		OB_SET ($ob_raiz;-><>aJustAbs;"motivoJustificacion")  //cargo los motivos de justificación de inasistencias
		OB_SET ($ob_raiz;->$t_mensajeError;"mensajeError")
		OB_SET ($ob_raiz;->$b_prefMisAsig;"misasignaturas")
		OB_SET ($ob_raiz;->$b_esProfeJefe;"esProfeJefe")
		OB_SET ($ob_raiz;->$b_DesplegarDialog;"desplegarDialog")
		
		$json:=OB_Object2Json ($ob_raiz)
		SET_ClearSets ("asignaturas")
		$0:=$json
		
	: ($dato="horario")
		
		C_OBJECT:C1216($ob_horariotemporal)
		C_TEXT:C284($t_desde;$t_hasta)
		ARRAY LONGINT:C221($al_recNumhorario;0)
		ARRAY LONGINT:C221($al_numeroDia;0)
		
		  //***** MONO 144924 ALIAS DE LAS HORA****//
		C_TEXT:C284($t_aliasHora)
		C_LONGINT:C283($l_NivAsig;$l_confPeriodo;$last_idConfPeriodo;$last_NoNivel;$fia)
		ARRAY INTEGER:C220($aiSTR_Horario_HoraNo;0)
		ARRAY TEXT:C222($atSTR_Horario_HoraAlias;0)
		  //***** MONO 144924 ALIAS DE LAS HORA****//
		
		$ob_raiz:=OB_Create 
		
		READ ONLY:C145([TMT_Horario:166])
		If (($userID<0) | ($admin))
			  //QUERY([TMT_Horario];[TMT_Horario]ID_Teacher#0)
			$t_nombreProfesor:=""
		Else 
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Teacher:9=$profID)
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=$profID)
			$t_nombreProfesor:=[Profesores:4]Nombre_comun:21
		End if 
		AT_DistinctsFieldValues (->[TMT_Horario:166]NumeroDia:1;->$al_numeroDia)
		CREATE SET:C116([TMT_Horario:166];"horario")
		
		For ($i;1;Size of array:C274($al_numeroDia))
			USE SET:C118("horario")
			QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$al_numeroDia{$i})
			ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2;>)
			SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroHora:2;$al_tmt_noHora;[TMT_Horario:166]Sala:8;$at_tmt_sala;[TMT_Horario:166]ID_Asignatura:5;$al_tmt_IdAsignatura;[TMT_Horario:166]Desde:3;$ah_tmt_desde;[TMT_Horario:166]Hasta:4;$ah_tmt_hasta)
			$ob_horario:=OB_Create 
			For ($ii;1;Size of array:C274($al_tmt_noHora))
				$ob_horariotemporal:=OB_Create 
				$t_desde:=Time string:C180($ah_tmt_desde{$ii})
				$t_hasta:=Time string:C180($ah_tmt_hasta{$ii})
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_tmt_IdAsignatura{$ii})
				  //***** MONO 144924 ALIAS DE LAS HORA****//
				If ($last_NoNivel#[Asignaturas:18]Numero_del_Nivel:6)
					$last_NoNivel:=[Asignaturas:18]Numero_del_Nivel:6
					$l_confPeriodo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
					If ($last_idConfPeriodo#$l_confPeriodo)
						$last_idConfPeriodo:=$l_confPeriodo
						$o_horario:=KRL_GetObjectFieldData (->[xxSTR_Periodos:100]ID:1;->$l_confPeriodo;->[xxSTR_Periodos:100]Horario:14)
						OB GET ARRAY:C1229($o_horario;"ai_HoraNo";$aiSTR_Horario_HoraNo)
						OB GET ARRAY:C1229($o_horario;"at_HoraAlias";$atSTR_Horario_HoraAlias)
					End if 
				End if 
				$t_aliasHora:=""
				$fia:=Find in array:C230($aiSTR_Horario_HoraNo;$al_tmt_noHora{$ii})
				If ($fia>0)
					$t_aliasHora:=$atSTR_Horario_HoraAlias{$fia}
				End if 
				
				OB_SET ($ob_horariotemporal;->$t_aliasHora;"horaAlias")
				OB_SET ($ob_horariotemporal;->$al_tmt_noHora{$ii};"hora")
				OB_SET ($ob_horariotemporal;->$t_desde;"horadesde")
				OB_SET ($ob_horariotemporal;->$t_hasta;"horahasta")
				OB_SET ($ob_horariotemporal;->[Asignaturas:18]Asignatura:3;"asignatura")
				OB_SET ($ob_horariotemporal;->[Asignaturas:18]Curso:5;"curso")
				OB_SET ($ob_horariotemporal;->$at_tmt_sala{$ii};"sala")
				OB_SET ($ob_horario;->$ob_horariotemporal;"hora"+String:C10($al_tmt_noHora{$ii}))
			End for 
			OB_SET ($ob_raiz;->$ob_horario;String:C10($al_numeroDia{$i}))
		End for 
		
		$b_quitarSabado:=(Find in array:C230($al_numeroDia;6)=-1)
		OB_SET ($ob_raiz;->$t_nombreProfesor;"profesor_nombre")
		OB_SET ($ob_raiz;->$b_quitarSabado;"quitar_sabado")
		
		SET_ClearSets ("horario")
		$json:=OB_Object2Json ($ob_raiz)
		$0:=$json
		
	: ($dato="setPreferencia")
		C_OBJECT:C1216($ob_raiz)
		
		$t_mostrar_curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mostrar_curso")
		PREF_Set (0;"Muestra_Curso"+String:C10($userID);$t_mostrar_curso)
		
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$t_mostrar_curso;"registrado")
		$json:=OB_Object2Json ($ob_raiz)
		SET_ClearSets ("asignaturas")
		$0:=$json
		
	: ($dato="AtrasosPorAlumno")
		
		ARRAY TEXT:C222($at_NombreJustificacion;0)
		ARRAY TEXT:C222($at_NombreAsignatura;0)
		ARRAY TEXT:C222($at_fechaAtraso;0)
		
		C_OBJECT:C1216($ob_atrasos)
		
		$l_rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnalumno"))
		GOTO RECORD:C242([Alumnos:2];$l_rnAlumno)
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Año:6=<>gyear)
		ORDER BY:C49([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2;<)
		SELECTION TO ARRAY:C260([Alumnos_Atrasos:55];$al_RNAtrasos;[Alumnos_Atrasos:55]Fecha:2;$ad_fechaAtrasos;[Alumnos_Atrasos:55]Observaciones:3;$at_obsAtrasos;*)
		SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4;$ab_esInterSesiones;[Alumnos_Atrasos:55]justificado:14;$ab_justificado;*)
		SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]id_justificacion:13;$al_idJustificacion;[Alumnos_Atrasos:55]ID_Asignatura:15;$al_asignaturaAtrasoID;*)
		SELECTION TO ARRAY:C260
		
		ST_JustificacionAtrasos ("cargaVariables")
		For ($i;1;Size of array:C274($al_idJustificacion))
			QUERY:C277([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1=$al_idJustificacion{$i})
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_asignaturaAtrasoID{$i})
			APPEND TO ARRAY:C911($at_NombreJustificacion;[xxSTR_JustificacionAtrasos:227]Motivo:2)
			APPEND TO ARRAY:C911($at_NombreAsignatura;[Asignaturas:18]Asignatura:3)
			APPEND TO ARRAY:C911($at_fechaAtraso;String:C10($ad_fechaAtrasos{$i};System date short:K1:1))
		End for 
		
		OB SET ARRAY:C1227($ob_atrasos;"rn";$al_RNAtrasos)
		OB SET ARRAY:C1227($ob_atrasos;"fecha";$at_fechaAtraso)
		OB SET ARRAY:C1227($ob_atrasos;"obs";$at_obsAtrasos)
		OB SET ARRAY:C1227($ob_atrasos;"inter";$ab_esInterSesiones)
		OB SET ARRAY:C1227($ob_atrasos;"justificado";$ab_justificado)
		OB SET ARRAY:C1227($ob_atrasos;"motivo";$at_NombreJustificacion)
		OB SET ARRAY:C1227($ob_atrasos;"asignatura";$at_NombreAsignatura)
		
		$json:=JSON Stringify:C1217($ob_atrasos)
		$0:=$json
		
	: ($dato="conducta")
		C_OBJECT:C1216($ob_raiz;$ob_permisos;$ob_asignaturas;$ob_cursos;$ob_json;$ob_alumnos)
		$t_mensajeErrorPermisos:=""
		$accion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"accion")
		$parametros:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"parametros")
		
		Case of 
			: ($accion="cargaSuspension")
				C_OBJECT:C1216($o_castigo;$o_alumno;$ob_raiz;$o_temporal)
				C_TEXT:C284($t_fecha)
				ARRAY OBJECT:C1221($ao_alumno;0)
				$ob_json:=OB_JsonToObject ($parametros)
				$t_uuid:=OB Get:C1224($ob_json;"uuid")
				
				QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Auto_UUID:12=$t_uuid)
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_Suspensiones:12]Profesor_Numero:4)
				
				OB SET:C1220($o_castigo;"uuid";[Alumnos_Suspensiones:12]Auto_UUID:12)
				OB SET:C1220($o_castigo;"desde";STWA2_MakeDate4JS ([Alumnos_Suspensiones:12]Desde:5))
				OB SET:C1220($o_castigo;"hasta";STWA2_MakeDate4JS ([Alumnos_Suspensiones:12]Hasta:6))
				OB SET:C1220($o_castigo;"obs";[Alumnos_Suspensiones:12]Observaciones:8)
				OB SET:C1220($o_castigo;"motivo";[Alumnos_Suspensiones:12]Motivo:2)
				OB SET:C1220($o_castigo;"profesor_nombre";[Profesores:4]Apellidos_y_nombres:28)
				OB SET:C1220($o_castigo;"profesor_numero";[Profesores:4]Numero:1)
				
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Suspensiones:12]Alumno_Numero:7)
				OB SET:C1220($o_alumno;"idalumno";[Alumnos:2]numero:1)
				OB SET:C1220($o_alumno;"nombre";[Alumnos:2]apellidos_y_nombres:40)
				OB SET:C1220($o_alumno;"orden";0)
				APPEND TO ARRAY:C911($ao_alumno;$o_alumno)
				
				C_OBJECT:C1216($o_adjunto)
				$o_adjunto:=STWA2_ResponsiveAdjuntos ("load";->[Alumnos_Suspensiones:12];->[Alumnos_Suspensiones:12]ID:9)
				
				OB SET:C1220($ob_raiz;"adjunto";$o_adjunto)
				OB SET ARRAY:C1227($ob_raiz;"alumnos";$ao_alumno)
				OB SET:C1220($ob_raiz;"suspension";$o_castigo)
				OB SET:C1220($ob_raiz;"edision";True:C214)
				
			: ($accion="cargaCastigo")
				C_OBJECT:C1216($o_castigo;$o_alumno;$ob_raiz;$o_temporal)
				C_TEXT:C284($t_fecha)
				ARRAY OBJECT:C1221($ao_alumno;0)
				$ob_json:=OB_JsonToObject ($parametros)
				$t_uuid:=OB Get:C1224($ob_json;"uuid")
				
				QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Auto_UUID:12=$t_uuid)
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_Castigos:9]Profesor_Numero:6)
				
				OB SET:C1220($o_castigo;"uuid";[Alumnos_Castigos:9]Auto_UUID:12)
				OB SET:C1220($o_castigo;"horas";[Alumnos_Castigos:9]Horas_de_castigo:7)
				OB SET:C1220($o_castigo;"motivo";[Alumnos_Castigos:9]Motivo:2)
				OB SET:C1220($o_castigo;"obs";[Alumnos_Castigos:9]Observaciones:3)
				OB SET:C1220($o_castigo;"profesor_numero";[Alumnos_Castigos:9]Profesor_Numero:6)
				OB SET:C1220($o_castigo;"profesor_nombre";[Profesores:4]Apellidos_y_nombres:28)
				OB SET:C1220($o_castigo;"fecha";STWA2_MakeDate4JS ([Alumnos_Castigos:9]Fecha:9))
				OB SET:C1220($o_castigo;"cumplido";[Alumnos_Castigos:9]Castigo_cumplido:4)
				
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Castigos:9]Alumno_Numero:8)
				OB SET:C1220($o_alumno;"idalumno";[Alumnos:2]numero:1)
				OB SET:C1220($o_alumno;"nombre";[Alumnos:2]apellidos_y_nombres:40)
				OB SET:C1220($o_alumno;"orden";0)
				APPEND TO ARRAY:C911($ao_alumno;$o_alumno)
				
				C_OBJECT:C1216($o_adjunto)
				$o_adjunto:=STWA2_ResponsiveAdjuntos ("load";->[Alumnos_Castigos:9];->[Alumnos_Castigos:9]ID:10)
				
				OB SET:C1220($ob_raiz;"adjunto";$o_adjunto)
				OB SET ARRAY:C1227($ob_raiz;"alumnos";$ao_alumno)
				OB SET:C1220($ob_raiz;"castigo";$o_castigo)
				OB SET:C1220($ob_raiz;"edision";True:C214)
				
			: ($accion="cargaAnotacion")
				
				C_OBJECT:C1216($o_anotacion;$o_alumno;$ob_raiz;$o_temporal)
				C_TEXT:C284($t_fecha)
				ARRAY OBJECT:C1221($ao_alumno;0)
				$ob_json:=OB_JsonToObject ($parametros)
				$t_uuid:=OB Get:C1224($ob_json;"uuid")
				
				QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Auto_UUID:15=$t_uuid)
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_Anotaciones:11]Profesor_Numero:5)
				
				OB SET:C1220($o_anotacion;"uuid";[Alumnos_Anotaciones:11]Auto_UUID:15)
				OB SET:C1220($o_anotacion;"categoria";[Alumnos_Anotaciones:11]Categoria:8)
				OB SET:C1220($o_anotacion;"es_positiva";[Alumnos_Anotaciones:11]Es_Positiva:2)
				OB SET:C1220($o_anotacion;"fecha";STWA2_MakeDate4JS ([Alumnos_Anotaciones:11]Fecha:1))
				OB SET:C1220($o_anotacion;"motivo";[Alumnos_Anotaciones:11]Motivo:3)
				OB SET:C1220($o_anotacion;"profesor_numero";[Alumnos_Anotaciones:11]Profesor_Numero:5)
				OB SET:C1220($o_anotacion;"obs";[Alumnos_Anotaciones:11]Observaciones:4)
				OB SET:C1220($o_anotacion;"profesor_nombre";[Profesores:4]Apellidos_y_nombres:28)
				OB SET:C1220($o_anotacion;"asignatura";[Alumnos_Anotaciones:11]Asignatura:10)
				OB SET:C1220($o_anotacion;"signo";[Alumnos_Anotaciones:11]Signo:7)
				
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Anotaciones:11]Alumno_Numero:6)
				OB SET:C1220($o_alumno;"idalumno";[Alumnos:2]numero:1)
				OB SET:C1220($o_alumno;"nombre";[Alumnos:2]apellidos_y_nombres:40)
				OB SET:C1220($o_alumno;"orden";0)
				APPEND TO ARRAY:C911($ao_alumno;$o_alumno)
				
				C_OBJECT:C1216($o_adjunto)
				$o_adjunto:=STWA2_ResponsiveAdjuntos ("load";->[Alumnos_Anotaciones:11];->[Alumnos_Anotaciones:11]ID:12)
				
				OB SET:C1220($ob_raiz;"adjunto";$o_adjunto)
				OB SET ARRAY:C1227($ob_raiz;"alumnos";$ao_alumno)
				OB SET:C1220($ob_raiz;"anotacion";$o_anotacion)
				OB SET:C1220($ob_raiz;"edision";True:C214)
				
			: ($accion="cargaLicencia")
				C_OBJECT:C1216($o_anotacion;$o_alumno;$ob_raiz;$o_temporal;$o_licencia)
				C_TEXT:C284($t_fecha)
				ARRAY OBJECT:C1221($ao_alumno;0)
				$ob_json:=OB_JsonToObject ($parametros)
				$t_uuid:=OB Get:C1224($ob_json;"uuid")
				
				QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Auto_UUID:12=$t_uuid)
				
				OB SET:C1220($o_licencia;"uuid";[Alumnos_Licencias:73]Auto_UUID:12)
				OB SET:C1220($o_licencia;"desde";STWA2_MakeDate4JS ([Alumnos_Licencias:73]Desde:2))
				OB SET:C1220($o_licencia;"hasta";STWA2_MakeDate4JS ([Alumnos_Licencias:73]Hasta:3))
				OB SET:C1220($o_licencia;"obs";[Alumnos_Licencias:73]Observaciones:5)
				OB SET:C1220($o_licencia;"motivo";[Alumnos_Licencias:73]Tipo_licencia:4)
				OB SET:C1220($o_licencia;"motivoespecial";[Alumnos_Licencias:73]Motivo_especial:13)
				
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Licencias:73]Alumno_numero:1)
				OB SET:C1220($o_alumno;"idalumno";[Alumnos:2]numero:1)
				OB SET:C1220($o_alumno;"nombre";[Alumnos:2]apellidos_y_nombres:40)
				OB SET:C1220($o_alumno;"orden";0)
				APPEND TO ARRAY:C911($ao_alumno;$o_alumno)
				
				C_OBJECT:C1216($o_adjunto)
				$o_adjunto:=STWA2_ResponsiveAdjuntos ("load";->[Alumnos_Licencias:73];->[Alumnos_Licencias:73]ID:6)
				
				OB SET:C1220($ob_raiz;"adjunto";$o_adjunto)
				OB SET ARRAY:C1227($ob_raiz;"alumnos";$ao_alumno)
				OB SET:C1220($ob_raiz;"licencias";$o_licencia)
				OB SET:C1220($ob_raiz;"edision";True:C214)
				
			: ($accion="cargaAlumnos")
				C_OBJECT:C1216($ob_raiz)
				$ob_json:=OB_JsonToObject ($parametros)
				OB SET:C1220($ob_json;"alumnoClickID";0)
				STWA2_MO_BuildCargaAlumnoCond ($ob_json;->$ob_raiz)
				
			: ($accion="build")
				ARRAY TEXT:C222($at_cursoGrupo;0)
				ARRAY LONGINT:C221($al_AsignaturasReemplazo;0)
				C_BOOLEAN:C305($b_filtrarAsig)
				
				  //verifico permisos del profesor para ingresar a los distintos funcionalidades de conducta.
				$t_CursoProfJefe:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_profesor_jefe:2;->$profID;->[Cursos:3]Curso:1)
				  //$b_permisoConducta:=(USR_checkRights ("A";->[Alumnos_Conducta];$userID) | ($t_CursoProfJefe=[Alumnos]Curso))
				  //$b_ModificarConducta:=(USR_checkRights ("M";->[Alumnos_Conducta];$userID) | ($t_CursoProfJefe=[Alumnos]Curso))
				  //$b_eliminarConducta:=(USR_checkRights ("D";->[Alumnos_Conducta];$userID) | ($t_CursoProfJefe=[Alumnos]Curso))
				$b_permisoConductaLeer:=USR_checkRights ("L";->[Alumnos_Conducta:8];$userID)
				$b_permisoConducta:=USR_checkRights ("A";->[Alumnos_Conducta:8];$userID)
				$b_ModificarConducta:=USR_checkRights ("M";->[Alumnos_Conducta:8];$userID)
				$b_eliminarConducta:=USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)
				
				
				  //If ($b_permisoConducta)
				  //sigo cargando la información de alumnos 
				If ($l_reemplazoID=0)
					If (($profID=0) | ($admin))
						ALL RECORDS:C47([Asignaturas:18])
					Else 
						dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
					End if 
				Else 
					  //Para trabajar los reemplazos de profesores.
					AT_Initialize (->$al_AsignaturasReemplazo)
					$profID:=KRL_GetNumericFieldData (->[xShell_Users:47]No:1;->$l_reemplazoID;->[xShell_Users:47]NoEmployee:7)
					STWA2_ReemplazaUsuario ("inicializa")
					$b_filtrarAsig:=Choose:C955(STWA2_ReemplazaUsuario ("cargaAsignaturasReemplazo";$uuid;->$al_AsignaturasReemplazo)="True";True:C214;False:C215)
					dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
					
					If ($b_filtrarAsig)
						QUERY SELECTION WITH ARRAY:C1050([Asignaturas:18]Numero:1;$al_AsignaturasReemplazo)
					End if 
					
				End if 
				
				
				STR_VerificaBloqueoSitFinal 
				$l_firmanteProf:=Num:C11(PREF_fGet (0;"FirmantesAutorizados"))
				
				  //verifico asignaturas para los usuario de los niveles
				CREATE SET:C116([Asignaturas:18];"1")
				STR_ResponsableNiveles ("cargaAsignaturas";$profID;->$al_RecNumAsignaturasNiveles)
				CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturasNiveles)
				CREATE SET:C116([Asignaturas:18];"2")
				UNION:C120("1";"2";"3")
				USE SET:C118("3")
				SET_ClearSets ("1";"2";"3")
				
				CREATE SET:C116([Asignaturas:18];"asignaturas")
				ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]ordenGeneral:105;>)  //20180820 ASM Ticket 214723
				SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$at_denominacionInterna;[Asignaturas:18]Numero:1;$al_AsignaturaID;[Asignaturas:18]Asignatura:3;$at_asignaturas;[Asignaturas:18]Curso:5;$at_asignaturasCurso;[Asignaturas:18]Numero_del_Nivel:6;$al_noNiveles;*)
				SELECTION TO ARRAY:C260([Asignaturas:18]Numero_del_Nivel:6;$al_numeNivelAsignaturas;*)
				SELECTION TO ARRAY:C260
				For ($i;1;Size of array:C274($at_asignaturasCurso))
					If (Find in array:C230($at_cursoGrupo;$at_asignaturasCurso{$i})=-1)
						APPEND TO ARRAY:C911($at_cursoGrupo;$at_asignaturasCurso{$i})
					End if 
					If ($at_denominacionInterna{$i}=$at_asignaturas{$i})
						$at_denominacionInterna{$i}:=""
					Else 
						$at_denominacionInterna{$i}:="("+$at_denominacionInterna{$i}+")"
					End if 
				End for 
				
				OB SET ARRAY:C1227($ob_asignaturas;"id";$al_AsignaturaID)
				OB SET ARRAY:C1227($ob_asignaturas;"nombre";$at_asignaturas)
				OB SET ARRAY:C1227($ob_asignaturas;"curso";$at_asignaturasCurso)
				OB SET ARRAY:C1227($ob_asignaturas;"nivel";$al_numeNivelAsignaturas)
				OB SET ARRAY:C1227($ob_asignaturas;"denominacioninterna";$at_denominacionInterna)
				OB SET ARRAY:C1227($ob_cursos;"cursos";$at_cursoGrupo)
				
				AT_DistinctsArrayValues (->$al_noNiveles)
				C_OBJECT:C1216($ob_periodo;$ob_periodoTemp)
				$ob_periodo:=OB_Create 
				For ($i;1;Size of array:C274($al_noNiveles))
					$t_nombrePeriodo:=String:C10($al_noNiveles{$i})
					$ob_periodoTemp:=OB_Create 
					PERIODOS_LoadData ($al_noNiveles{$i})
					If (Current date:C33(*)<=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
						$t_fechaHasta:=STWA2_MakeDate4JS (Current date:C33(*))
					Else 
						$t_fechaHasta:=STWA2_MakeDate4JS (adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
					End if 
					$l_cantidadPeriodo:=Size of array:C274(adSTR_Periodos_Desde)
					OB_SET ($ob_periodoTemp;->$l_cantidadPeriodo;"numeroPeriodo")
					OB_SET ($ob_periodoTemp;->adSTR_Periodos_Desde;"desde")
					OB_SET ($ob_periodoTemp;->adSTR_Periodos_Hasta;"hasta")
					OB_SET ($ob_periodoTemp;->atSTR_Periodos_Nombre;"nombre")
					  //OB_SET ($ob_periodoTemp;->adSTR_Calendario_Feriados;"feriados")
					ARRAY TEXT:C222($at_feriodosTexto;0)
					For ($l_indice;1;Size of array:C274(adSTR_Calendario_Feriados))
						APPEND TO ARRAY:C911($at_feriodosTexto;STWA2_MakeDate4JS (adSTR_Calendario_Feriados{$l_indice}))
					End for 
					OB_SET ($ob_periodoTemp;->$at_feriodosTexto;"feriados")
					OB_SET ($ob_periodoTemp;->adSTR_Periodos_Cierre;"cierre")
					OB_SET ($ob_periodoTemp;->$t_fechaHasta;"fechaHasta")
					OB_SET ($ob_periodo;->$ob_periodoTemp;$t_nombrePeriodo)
				End for 
				
				  //cargo a todos los profesores y las asignaturas que imparten
				  //cargo a todos los profesores y las asignaturas que imparten
				C_OBJECT:C1216($ob_profesores;$o_parametros)
				OB SET:C1220($o_parametros;"userID";$userID)
				
				$ob_profesores:=STWA2_MO_CargaInfoConducta ("ProfesoresConducta")
				
				  //cargo las opciones de anotaciones
				C_OBJECT:C1216($ob_anotaciones;$ob_castigos;$ob_suspensiones;$ob_licencias)
				$ob_anotaciones:=STWA2_MO_CargaInfoConducta ("MotivosAnotaciones")
				$ob_castigos:=STWA2_MO_CargaInfoConducta ("MotivosMedidas")  //cargo las opciones de medidas disciplinarias (castigos)
				$ob_suspensiones:=STWA2_MO_CargaInfoConducta ("MotivosSuspensiones";$o_parametros)  //cargo las opciones de suspensiones
				$ob_licencias:=STWA2_MO_CargaInfoConducta ("OpcionesLicencias";$o_parametros)  //cargo las opciones de licencias
				
				  //Else 
				  //$t_mensajeErrorPermisos:=__ ("Lo siento, Ud. no dispone de la autorización necesaria para agregar información a este archivo.")
				  //End if 
				
				OB SET:C1220($ob_permisos;"permisos";$b_permisoConducta)
				OB SET:C1220($ob_permisos;"editar";$b_ModificarConducta)
				OB SET:C1220($ob_permisos;"eliminar";$b_eliminarConducta)
				OB SET:C1220($ob_permisos;"leer";$b_permisoConductaLeer)
				OB SET:C1220($ob_permisos;"mensajeError";$t_mensajeErrorPermisos)
				
				OB SET:C1220($ob_raiz;"permisos";$ob_permisos)
				OB SET:C1220($ob_raiz;"asignaturas";$ob_asignaturas)
				OB SET:C1220($ob_raiz;"cursos";$ob_cursos)
				OB SET:C1220($ob_raiz;"periodo";$ob_periodo)
				OB SET:C1220($ob_raiz;"anotaciones";$ob_anotaciones)
				OB SET:C1220($ob_raiz;"profesores";$ob_profesores)
				OB SET:C1220($ob_raiz;"castigos";$ob_castigos)
				OB SET:C1220($ob_raiz;"suspensiones";$ob_suspensiones)
				OB SET:C1220($ob_raiz;"licencias";$ob_licencias)
				
			: ($accion="funciones")
				$t_dispositivo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dispositivo")
				$ob_raiz:=SC_ObtieneUrlDocsFunciones ($t_dispositivo;$uuid)
		End case 
		
		$json:=JSON Stringify:C1217($ob_raiz)
		$0:=$json
		
	: ($dato="cargaReemplazo")
		$json:=STWA2_ReemplazaUsuario ("CargaUsuarioReemplazo";$uuid)
		$0:=$json
End case 
