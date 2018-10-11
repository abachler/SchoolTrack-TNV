//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 12-07-16, 12:33:46
  // ----------------------------------------------------
  // Método: STWA2_OWC_VistaDirector
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------


C_BOOLEAN:C305($b_complemento;$b_final;$b_ok)


ARRAY BOOLEAN:C223($ab_esElectiva;0)
ARRAY LONGINT:C221($al_nivelCursos;0)
ARRAY LONGINT:C221($al_numeroAlumno;0)
ARRAY LONGINT:C221($al_numeroNivel;0)
ARRAY LONGINT:C221($al_recNumAsig;0)
ARRAY LONGINT:C221($al_rnAlumnos;0)
ARRAY LONGINT:C221($al_rnAsignatura;0)
ARRAY LONGINT:C221($al_rnComplemento;0)
ARRAY LONGINT:C221($al_rnObsPeriodo;0)
ARRAY PICTURE:C279($ap_fotografia;0)
ARRAY TEXT:C222($at_promedioGeneral;0)
ARRAY TEXT:C222($at_asignatura;0)
ARRAY TEXT:C222($at_cursoAlumno;0)
ARRAY TEXT:C222($at_cursoAsignatura;0)
ARRAY TEXT:C222($at_cursos;0)
ARRAY TEXT:C222($at_foto64;0)
ARRAY TEXT:C222($at_NombreAlumno;0)
ARRAY TEXT:C222($at_nombreAsignaturaCategoria;0)
ARRAY TEXT:C222($at_nombreNivel;0)
ARRAY TEXT:C222($at_ObservacionAsigPeri;0)
ARRAY TEXT:C222($at_observacionesAsig;0)
ARRAY TEXT:C222($at_OservacionPeriodo;0)
ARRAY TEXT:C222($at_promedioAsignatura;0)
ARRAY TEXT:C222($at_abrevAsignaturaCategoria;0)
ARRAY TEXT:C222($at_autoUUID;0)
ARRAY BOOLEAN:C223($ab_condicional;0)
ARRAY TEXT:C222($at_status;0)

ARRAY TEXT:C222($at_inasistencia;0)
ARRAY TEXT:C222($at_pctInasistencia;0)
ARRAY TEXT:C222($at_atrasosInicio;0)
ARRAY TEXT:C222($at_atrasosInter;0)
ARRAY TEXT:C222($at_anotacionesPositivas;0)
ARRAY TEXT:C222($at_anotacionesNegativas;0)
ARRAY TEXT:C222($at_anotacionesNeutras;0)
ARRAY TEXT:C222($at_medidasDisciplinarias;0)
ARRAY TEXT:C222($at_suspensiones;0)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$userID:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)
$isAdmin:=USR_IsGroupMember_by_GrpID (-15001;$userID)

$t_accion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"action")
Case of 
	: ($t_accion="datosbuscadordirector")
		C_BOOLEAN:C305($b_cargaInicial;$bEsProfJefe)
		$bEsProfJefe:=False:C215
		$verfotos:=False:C215
		
		$t_periodo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo")
		$nivel:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"nivel")
		$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
		$rnAsig:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig")
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAlumno"))
		$cargaInicial:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"cargaInicial")
		$b_cargaInicial:=Choose:C955($cargaInicial="true";True:C214;False:C215)
		
		C_LONGINT:C283($l_verConducta;$l_verFoto)
		C_BOOLEAN:C305($b_marcado)
		$l_verConducta:=Num:C11(PREF_fGet ($userID;"STR_VD_VerInfoConducta";String:C10(Num:C11($b_marcado))))
		$l_verFoto:=Num:C11(PREF_fGet ($userID;"STR_VD_VerFotografia";String:C10(Num:C11($b_marcado))))
		$verfotos:=($l_verFoto=1)
		
		If ($t_periodo="all")
			$periodo:=-1
		Else 
			$periodo:=Num:C11($t_periodo)
		End if 
		
		If (NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"verfoto")="true")
			$verfotos:=True:C214
		End if 
		
		  //cargo los niveles
		If ((USR_LimitedSearch ($userID)) & (Not:C34($isAdmin)))
			dhSTWA2_SpecialSearch ("SchoolTrack";->[Alumnos:2];$profID)
			AT_DistinctsFieldValues (->[Alumnos:2]nivel_numero:29;->$al_numeroNivel)
			SORT ARRAY:C229($al_numeroNivel;>)
			
			For ($i;1;Size of array:C274($al_numeroNivel))
				APPEND TO ARRAY:C911($at_nombreNivel;KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$al_numeroNivel{$i};->[xxSTR_Niveles:6]Nivel:1))
			End for 
			
		Else 
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
			ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
			SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_numeroNivel;[xxSTR_Niveles:6]Nivel:1;$at_nombreNivel)
		End if 
		
		
		If ($nivel="all")
			If ($b_cargaInicial)
				  //si es carga inicial cargo todos los arreglos de los filtros
				  // verifico si está activa la opción de limitar las busquedas
				If ((USR_LimitedSearch ($userID)) & (Not:C34($isAdmin)))
					dhSTWA2_SpecialSearch ("SchoolTrack";->[Cursos:3];$profID)
					
					  //QUERY SELECTION([Cursos];[Cursos]Nivel_Numero=$al_numeroNivel{1})
					QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0;*)  // 20180304 RCH Ticket 160317
					QUERY SELECTION:C341([Cursos:3]; & ;[Cursos:3]Nivel_Numero:7=$al_numeroNivel{1})
					SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
					
					dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$al_numeroNivel{1})
					SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
					
					dhSTWA2_SpecialSearch ("SchoolTrack";->[Alumnos:2];$profID)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=$al_numeroNivel{1};*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)  //20180613 Ticket 209447
					
					SET FIELD RELATION:C919([Alumnos:2]curso:20;Automatic:K51:4;Structure configuration:K51:2)  // 20180304 RCH Ticket 160317
					QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
					SET FIELD RELATION:C919([Alumnos:2]curso:20;Structure configuration:K51:2;Structure configuration:K51:2)
					
					SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnosTemporal)
					PERIODOS_LoadData ($al_numeroNivel{1})
					
				Else 
					QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;$al_numeroNivel)
					  //QUERY SELECTION([Cursos];[Cursos]Nivel_Numero=$al_numeroNivel{1})
					QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0;*)
					QUERY SELECTION:C341([Cursos:3]; & ;[Cursos:3]Nivel_Numero:7=$al_numeroNivel{1})
					SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
					
					QUERY WITH ARRAY:C644([Asignaturas:18]Numero_del_Nivel:6;$al_numeroNivel)
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$al_numeroNivel{1})
					SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
					
					QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;$al_numeroNivel)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  //20180613 Ticket 209447
					
					SET FIELD RELATION:C919([Alumnos:2]curso:20;Automatic:K51:4;Structure configuration:K51:2)  // 20180304 RCH Ticket 160317
					QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
					SET FIELD RELATION:C919([Alumnos:2]curso:20;Structure configuration:K51:2;Structure configuration:K51:2)
					
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=$al_numeroNivel{1})
					SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnosTemporal)
					PERIODOS_LoadData ($al_numeroNivel{1})
				End if 
				
			Else 
				QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;$al_numeroNivel)
				
				QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  // 20180304 RCH Ticket 160317
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
				
				QUERY WITH ARRAY:C644([Asignaturas:18]Numero_del_Nivel:6;$al_numeroNivel)
				SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
				
				QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;$al_numeroNivel)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  //20180613 Ticket 209447
				
				SET FIELD RELATION:C919([Alumnos:2]curso:20;Automatic:K51:4;Structure configuration:K51:2)  // 20180304 RCH Ticket 160317
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
				SET FIELD RELATION:C919([Alumnos:2]curso:20;Structure configuration:K51:2;Structure configuration:K51:2)
				
				SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnosTemporal)
				PERIODOS_LoadData (-1)
			End if 
		Else 
			If ((USR_LimitedSearch ($userID)) & (Not:C34($isAdmin)))
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Cursos:3];$profID)
				
				  //QUERY SELECTION([Cursos];[Cursos]Nivel_Numero=Num($nivel))// 20180304 RCH Ticket 160317
				QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0;*)
				QUERY SELECTION:C341([Cursos:3]; & ;[Cursos:3]Nivel_Numero:7=Num:C11($nivel))
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
				
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=Num:C11($nivel))
				SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
				
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Alumnos:2];$profID)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=Num:C11($nivel);*)
				QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)  //20180613 Ticket 209447
				
				SET FIELD RELATION:C919([Alumnos:2]curso:20;Automatic:K51:4;Structure configuration:K51:2)  // 20180304 RCH Ticket 160317
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
				SET FIELD RELATION:C919([Alumnos:2]curso:20;Structure configuration:K51:2;Structure configuration:K51:2)
				
				SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnosTemporal)
			Else 
				QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=Num:C11($nivel))
				
				QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  // 20180304 RCH Ticket 160317
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=Num:C11($nivel))
				SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
				
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=Num:C11($nivel);*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)  //20180613 Ticket 209447
				
				SET FIELD RELATION:C919([Alumnos:2]curso:20;Automatic:K51:4;Structure configuration:K51:2)  // 20180304 RCH Ticket 160317
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
				SET FIELD RELATION:C919([Alumnos:2]curso:20;Structure configuration:K51:2;Structure configuration:K51:2)
				
				SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnosTemporal)
			End if 
		End if 
		
		
		If ($curso#"all")
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
			
			QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  // 20180304 RCH Ticket 160317
			
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
			
			If ((USR_LimitedSearch ($userID)) & (Not:C34($isAdmin)))
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Curso:5=$curso)
			Else 
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$curso)
			End if 
			
			SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
			
			  //QUERY([Alumnos];[Alumnos]Curso=$curso)
			  //CREATE SET([Alumnos];"1")
			  //KRL_RelateSelection (->[Alumnos_Calificaciones]ID_Asignatura;->[Asignaturas]Numero;"")
			  //KRL_RelateSelection (->[Alumnos]Número;->[Alumnos_Calificaciones]ID_Alumno;"")
			  //CREATE SET([Alumnos];"2")
			  //UNION("1";"2";"3")
			  //USE SET("3")
			  //SELECTION TO ARRAY([Alumnos];$al_rnAlumnosTemporal)
			
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso)  // 20180304 RCH Ticket 160317
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  //20180613 Ticket 209447
			
			CREATE SET:C116([Alumnos:2];"$1")
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
			CREATE SET:C116([Alumnos:2];"$2")
			UNION:C120("$1";"$2";"$3")
			USE SET:C118("$3")
			SET_ClearSets ("$1";"$2";"$3")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  //20180613 Ticket 209447
			SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnosTemporal)
		End if 
		
		
		For ($i;1;Size of array:C274($at_CursoAsignaturaTemporal))
			If (Find in array:C230($at_cursos;$at_CursoAsignaturaTemporal{$i})=-1)
				APPEND TO ARRAY:C911($at_cursos;$at_CursoAsignaturaTemporal{$i})
				APPEND TO ARRAY:C911($al_nivelCursos;$al_nivelASigTemporal{$i})
			End if 
		End for 
		
		For ($i;1;Size of array:C274($at_cursosTemporal))
			If (Find in array:C230($at_cursos;$at_cursosTemporal{$i})=-1)
				APPEND TO ARRAY:C911($at_cursos;$at_cursosTemporal{$i})
				APPEND TO ARRAY:C911($al_nivelCursos;$al_nivelCursoTemporal{$i})
			End if 
		End for 
		
		If (Num:C11($nivel)#0)
			PERIODOS_LoadData (Num:C11($nivel))
		End if 
		
		If ((USR_LimitedSearch ($userID)) & (Not:C34($isAdmin)))
			dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
			CREATE SET:C116([Asignaturas:18];"asigProf")
			QUERY WITH ARRAY:C644([Asignaturas:18]Curso:5;$at_cursos)
			CREATE SET:C116([Asignaturas:18];"asigCursos")
			INTERSECTION:C121("asigProf";"asigCursos";"asigProf")
			USE SET:C118("asigProf")
			SET_ClearSets ("asigProf";"asigCursos")
		Else 
			QUERY WITH ARRAY:C644([Asignaturas:18]Curso:5;$at_cursos)
		End if 
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]ordenGeneral:105;>)
		SELECTION TO ARRAY:C260([Asignaturas:18];$al_rnAsignatura;[Asignaturas:18]Asignatura:3;$at_asignatura;[Asignaturas:18]Curso:5;$at_cursoAsignatura;[Asignaturas:18]Electiva:11;$ab_esElectiva)
		
		If ((Num:C11($rnAsig)#-1) & ($rnAsig#"all"))
			GOTO RECORD:C242([Asignaturas:18];Num:C11($rnAsig))
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		End if 
		
		If ($rnAlumno#-1)
			GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		End if 
		
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnos;[Alumnos:2]apellidos_y_nombres:40;$at_NombreAlumno;[Alumnos:2]curso:20;$at_cursoAlumno;[Alumnos:2]numero:1;$al_numeroAlumno;*)
		SELECTION TO ARRAY:C260([Alumnos:2]Fotografía:78;$ap_fotografia;[Alumnos:2]Status:50;$at_status;[Alumnos:2]nivel_numero:29;$al_nivelAlumnos;[Alumnos:2]auto_uuid:72;$at_autoUUID;*)
		SELECTION TO ARRAY:C260
		
		For ($i;1;Size of array:C274($al_numeroAlumno))
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=$al_numeroAlumno{$i};*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=$al_nivelAlumnos{$i})
			APPEND TO ARRAY:C911($ab_condicional;[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)
		End for 
		
		REDUCE SELECTION:C351([Asignaturas:18];0)
		REDUCE SELECTION:C351([Alumnos:2];0)
		REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
		REDUCE SELECTION:C351([Cursos:3];0)
		REDUCE SELECTION:C351([xxSTR_Niveles:6];0)
		
		  //cargo los promedios generales del alumno y los promedios de o las asignaturas
		$b_final:=False:C215
		Case of 
			: ($periodo=0)
				$periodo:=1
				For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
					If ((adSTR_Periodos_Desde{$i}<=Current date:C33(*)) & (adSTR_Periodos_Hasta{$i}>=Current date:C33(*)))
						$periodo:=$i
						$i:=Size of array:C274(adSTR_Periodos_Desde)+1
					End if 
				End for 
			: ($periodo=-1)
				$b_final:=True:C214
		End case 
		
		Case of 
			: ($periodo=1)
				$y_promedioPeriodo:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
				$y_ObservacionPeriodo:=->[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
				$y_ObservacionAsignaturaPeriodo:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
			: ($periodo=2)
				$y_promedioPeriodo:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
				$y_ObservacionPeriodo:=->[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
				$y_ObservacionAsignaturaPeriodo:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
			: ($periodo=3)
				$y_promedioPeriodo:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
				$y_ObservacionPeriodo:=->[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
				$y_ObservacionAsignaturaPeriodo:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
			: ($periodo=4)
				$y_promedioPeriodo:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
				$y_ObservacionPeriodo:=->[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
				$y_ObservacionAsignaturaPeriodo:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
			: ($periodo=5)
				$y_promedioPeriodo:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416
				$y_ObservacionPeriodo:=->[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
				$y_ObservacionAsignaturaPeriodo:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
			: ($b_final)
				$y_promedioPeriodo:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
				$y_ObservacionPeriodo:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
				$y_ObservacionAsignaturaPeriodo:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
		End case 
		
		For ($i;1;Size of array:C274($al_numeroAlumno))
			$t_promedioAsignatura:=""
			$t_obsAsignatura:=""
			$rnComplemento:=-1
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=$al_numeroAlumno{$i};*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=$al_nivelAlumnos{$i})
			QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6=$al_numeroAlumno{$i})
			If ((Num:C11($rnAsig)#-1) & ($rnAsig#"all"))
				GOTO RECORD:C242([Asignaturas:18];Num:C11($rnAsig))
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$al_numeroAlumno{$i};*)
				QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				$t_promedioAsignatura:=$y_promedioPeriodo->
				
				QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				$t_obsAsignatura:=$y_ObservacionAsignaturaPeriodo->
				$rnComplemento:=Record number:C243([Alumnos_ComplementoEvaluacion:209])
			End if 
			$recnumSintesis:=Record number:C243([Alumnos_SintesisAnual:210])
			APPEND TO ARRAY:C911($at_promedioAsignatura;$t_promedioAsignatura)
			APPEND TO ARRAY:C911($at_promedioGeneral;[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)
			APPEND TO ARRAY:C911($al_rnObsPeriodo;$recnumSintesis)
			APPEND TO ARRAY:C911($at_OservacionPeriodo;$y_ObservacionPeriodo->)
			APPEND TO ARRAY:C911($at_ObservacionAsigPeri;$t_obsAsignatura)
			APPEND TO ARRAY:C911($al_rnComplemento;$rnComplemento)
			If ($verfotos)
				$t_foto64:=""
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_numeroAlumno{$i})
				$t_foto64:=STWA2_CreaImagenAlumnosEnDisco ("creaUrlImagenAlumno";$at_autoUUID{$i})
				APPEND TO ARRAY:C911($at_foto64;$t_foto64)
			End if 
			
			APPEND TO ARRAY:C911($at_inasistencia;String:C10([Alumnos_SintesisAnual:210]Inasistencias_Dias:30;"##0"))  // 20180304 RCH Ticket 160317
			APPEND TO ARRAY:C911($at_pctInasistencia;String:C10([Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;"|Pct_1Dec"))
			APPEND TO ARRAY:C911($at_atrasosInicio;String:C10([Alumnos_SintesisAnual:210]Atrasos_Jornada:40;"### ##0"))
			APPEND TO ARRAY:C911($at_atrasosInter;String:C10([Alumnos_SintesisAnual:210]Atrasos_Sesiones:41;"### ##0"))
			APPEND TO ARRAY:C911($at_anotacionesPositivas;String:C10([Alumnos_SintesisAnual:210]Anotaciones_Positivas:34;"### ##0"))
			APPEND TO ARRAY:C911($at_anotacionesNegativas;String:C10([Alumnos_SintesisAnual:210]Anotaciones_Negativas:36;"### ##0"))
			APPEND TO ARRAY:C911($at_anotacionesNeutras;String:C10([Alumnos_SintesisAnual:210]Anotaciones_Neutras:35;"### ##0"))
			APPEND TO ARRAY:C911($at_medidasDisciplinarias;String:C10([Alumnos_SintesisAnual:210]Castigos:43;"### ##0"))
			APPEND TO ARRAY:C911($at_suspensiones;String:C10([Alumnos_SintesisAnual:210]Suspensiones:44;"### ##0"))
			
		End for 
		
		$ob_raiz:=OB_Create 
		If ($verfotos)
			OB_SET ($ob_raiz;->$at_foto64;"fotoalumno64")
			OB_SET ($ob_raiz;->$al_rnAlumnos;"rnAlumnos")
		End if 
		
		OB_SET ($ob_raiz;->$at_inasistencia;"inasistencias")
		OB_SET ($ob_raiz;->$at_pctInasistencia;"pctInasistencia")
		OB_SET ($ob_raiz;->$at_atrasosInicio;"atrasosInicio")
		OB_SET ($ob_raiz;->$at_atrasosInter;"atrasosInter")
		OB_SET ($ob_raiz;->$at_anotacionesPositivas;"anotacionesPositivas")
		OB_SET ($ob_raiz;->$at_anotacionesNegativas;"anotacionesNegativas")
		OB_SET ($ob_raiz;->$at_anotacionesNeutras;"anotacionesNeutras")
		OB_SET ($ob_raiz;->$at_medidasDisciplinarias;"medidasDisciplinarias")
		OB_SET ($ob_raiz;->$at_suspensiones;"suspensiones")
		
		OB_SET ($ob_raiz;->atSTR_Periodos_Nombre;"periodoNombre")
		OB_SET ($ob_raiz;->$al_numeroNivel;"noNivel")
		OB_SET ($ob_raiz;->$at_nombreNivel;"nombreNivel")
		OB_SET ($ob_raiz;->$al_nivelCursos;"noNivelCurso")
		OB_SET ($ob_raiz;->$at_cursos;"curso")
		OB_SET ($ob_raiz;->$al_rnAlumnos;"rnAlumnos")
		OB_SET ($ob_raiz;->$at_cursoAlumno;"cursoAlumnos")
		OB_SET ($ob_raiz;->$at_NombreAlumno;"nombreAlumno")
		OB_SET ($ob_raiz;->$at_promedioGeneral;"promedioGeneral")
		OB_SET ($ob_raiz;->$at_promedioAsignatura;"promedioAsignatura")
		OB_SET ($ob_raiz;->$al_rnAsignatura;"rnAsignaturas")
		OB_SET ($ob_raiz;->$at_asignatura;"asignatura")
		OB_SET ($ob_raiz;->$at_cursoAsignatura;"cursoAsignatura")
		OB_SET ($ob_raiz;->$ab_esElectiva;"EsElectiva")
		OB_SET ($ob_raiz;->$at_OservacionPeriodo;"obsPeriodo")
		OB_SET ($ob_raiz;->$at_ObservacionAsigPeri;"obsAsigPeriodo")
		OB_SET ($ob_raiz;->$al_rnComplemento;"rnComplemento")
		OB_SET ($ob_raiz;->$al_rnObsPeriodo;"rnObsPeriodo")
		OB_SET ($ob_raiz;->$ab_condicional;"cond")
		OB_SET ($ob_raiz;->$at_status;"status")
		
		  //envia preferencia almacenada
		OB_SET ($ob_raiz;->$l_verConducta;"verconducta")
		OB_SET ($ob_raiz;->$l_verFoto;"verfotografia")
		OB_SET ($ob_raiz;->$periodo;"periodo_actual")
		
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="graficoAsignaturas")
		C_LONGINT:C283($l_estiloNivel)
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAlumno"))
		$l_estiloNivel:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"estilo"))
		
		GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Abreviación:26;$at_abrevAsignaturaCategoria;[Asignaturas:18]Asignatura:3;$at_nombreAsignaturaCategoria;[Asignaturas:18];$al_rnAsignatura)
		
		For ($i;1;Size of array:C274($al_rnAsignatura))
			GOTO RECORD:C242([Asignaturas:18];$al_rnAsignatura{$i})
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
			
			If (($l_estiloNivel=1) | (iEvaluationMode=Simbolos))
				$l_estiloEvaluacion:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
				EVS_ReadStyleData ($l_estiloEvaluacion)
				For ($indicePeriodo;1;Size of array:C274(atSTR_Periodos_Nombre))
					$y_pointer1:=Get pointer:C304("ar_promedioP"+String:C10($indicePeriodo))
					C_REAL:C285($r_Eval)
					Case of 
						: ($indicePeriodo=1)
							$r_Eval:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Final_Real:112)
							APPEND TO ARRAY:C911($y_pointer1->;$r_Eval)
						: ($indicePeriodo=2)
							$r_Eval:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Final_Real:187)
							APPEND TO ARRAY:C911($y_pointer1->;$r_Eval)
						: ($indicePeriodo=3)
							$r_Eval:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Final_Real:262)
							APPEND TO ARRAY:C911($y_pointer1->;$r_Eval)
						: ($indicePeriodo=4)
							$r_Eval:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Final_Real:337)
							APPEND TO ARRAY:C911($y_pointer1->;$r_Eval)
						: ($indicePeriodo=5)
							$r_Eval:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Final_Real:412)
							APPEND TO ARRAY:C911($y_pointer1->;$r_Eval)
					End case 
					
					If ($y_pointer1->{Size of array:C274($y_pointer1->)}=-10)
						$y_pointer1->{Size of array:C274($y_pointer1->)}:=0
					End if 
					
				End for 
			Else 
				For ($indicePeriodo;1;Size of array:C274(atSTR_Periodos_Nombre))
					$y_pointer1:=Get pointer:C304("ar_promedioP"+String:C10($indicePeriodo))
					Case of 
						: ($indicePeriodo=1)
							APPEND TO ARRAY:C911($y_pointer1->;Num:C11([Alumnos_Calificaciones:208]P01_Final_Literal:116))
						: ($indicePeriodo=2)
							APPEND TO ARRAY:C911($y_pointer1->;Num:C11([Alumnos_Calificaciones:208]P02_Final_Literal:191))
						: ($indicePeriodo=3)
							APPEND TO ARRAY:C911($y_pointer1->;Num:C11([Alumnos_Calificaciones:208]P03_Final_Literal:266))
						: ($indicePeriodo=4)
							APPEND TO ARRAY:C911($y_pointer1->;Num:C11([Alumnos_Calificaciones:208]P04_Final_Literal:341))
						: ($indicePeriodo=5)
							APPEND TO ARRAY:C911($y_pointer1->;Num:C11([Alumnos_Calificaciones:208]P05_Final_Literal:416))
					End case 
				End for 
			End if 
			
		End for 
		
		  //creo los datos para el gráfico
		
		C_OBJECT:C1216($ob_raiz;$ob_data)
		
		  //categorias
		OB SET ARRAY:C1227($ob_raiz;"categorias";$at_abrevAsignaturaCategoria)
		
		  //series
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			OB SET:C1220($ob_data;"serieName"+String:C10($i);atSTR_Periodos_Nombre{$i})
			$y_pointer1:=Get pointer:C304("ar_promedioP"+String:C10($i))
			OB SET ARRAY:C1227($ob_data;"serieDatos"+String:C10($i);$y_pointer1->)
		End for 
		OB SET:C1220($ob_raiz;"data";$ob_data)
		$cantPeriodos:=Size of array:C274(atSTR_Periodos_Nombre)
		OB SET:C1220($ob_raiz;"cantperiodos";$cantPeriodos)
		$nombre_alumno:=[Alumnos:2]apellidos_y_nombres:40
		OB SET:C1220($ob_raiz;"alumno";$nombre_alumno)
		OB SET:C1220($ob_raiz;"separador";<>vs_AppDecimalSeparator)
		$json:=JSON Stringify:C1217($ob_raiz)
		
		
	: ($t_accion="cargaFotosAlumnos")
		
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$nivel:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"nivel")
		$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
		$rnAsig:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig")
		
		C_BOOLEAN:C305($b_marcado)  // 20180304 RCH Ticket 160317
		$b_marcado:=Choose:C955(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"verFoto")="1";True:C214;False:C215)
		PREF_Set ($userID;"STR_VD_VerFotografia";String:C10(Num:C11($b_marcado)))
		
		If ($b_marcado)  // 20180304 RCH Ticket 160317
			Case of 
				: (($rnAsig#"all") & (Num:C11($rnAsig)#-1))
					GOTO RECORD:C242([Asignaturas:18];Num:C11($rnAsig))
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				: ($nivel#"all")
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=Num:C11($nivel))
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT@")
				: ($curso#"all")
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso)
				Else 
					  //cargar todos los alumnos
					QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
					KRL_RelateSelection (->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]NoNivel:5;"")
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT@")
			End case 
			
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
			SELECTION TO ARRAY:C260([Alumnos:2]Fotografía:78;$ap_fotografia;[Alumnos:2];$al_rnAlumnos;[Alumnos:2]auto_uuid:72;$at_autoUUID)
			
			  //cargo la fotografía del alumno en base64
			For ($i;1;Size of array:C274($ap_fotografia))
				GOTO RECORD:C242([Alumnos:2];$al_rnAlumnos{$i})
				$t_foto64:=""
				$t_foto64:=STWA2_CreaImagenAlumnosEnDisco ("creaUrlImagenAlumno";$at_autoUUID{$i})
				APPEND TO ARRAY:C911($at_foto64;$t_foto64)
			End for 
		Else 
			
		End if 
		
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$at_foto64;"fotoalumno64")
		OB_SET ($ob_raiz;->$al_rnAlumnos;"rnAlumnos")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="escribePreferenciaConducta")
		
		C_BOOLEAN:C305($b_marcado)
		$b_marcado:=Choose:C955(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"verConducta")="1";True:C214;False:C215)
		PREF_Set ($userID;"STR_VD_VerInfoConducta";String:C10(Num:C11($b_marcado)))
		C_OBJECT:C1216($ob_raiz)
		OB SET:C1220($ob_raiz;"ERR";0)
		$json:=JSON Stringify:C1217($ob_raiz)
		
	: ($t_accion="observacionesAsignaturas")
		$t_periodo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo")
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAlumno"))
		
		If ($t_periodo="all")
			$periodo:=-1
		Else 
			$periodo:=Num:C11($t_periodo)
		End if 
		  //cargo los promedios generales del alumno y los promedios de o las asignaturas
		  //PERIODOS_LoadData ([Asignaturas]Numero_del_Nivel)
		READ ONLY:C145([Alumnos:2])
		KRL_GotoRecord (->[Alumnos:2];$rnAlumno)  //20170808 RCH Se mueve el goto record y se cargan los periodos a partir del nivel del alumno
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		$b_final:=False:C215
		Case of 
			: ($periodo=0)
				$periodo:=1
				For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
					If ((adSTR_Periodos_Desde{$i}<=Current date:C33(*)) & (adSTR_Periodos_Hasta{$i}>=Current date:C33(*)))
						$periodo:=$i
						$i:=Size of array:C274(adSTR_Periodos_Desde)+1
					End if 
				End for 
			: ($periodo=-1)
				$b_final:=True:C214
		End case 
		
		Case of 
			: ($periodo=1)
				$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
				$t_titulo:="Observaciones "+atSTR_Periodos_Nombre{$periodo}+" (Acádemicas)"
			: ($periodo=2)
				$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
				$t_titulo:="Observaciones "+atSTR_Periodos_Nombre{$periodo}+" (Acádemicas)"
			: ($periodo=3)
				$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
				$t_titulo:="Observaciones "+atSTR_Periodos_Nombre{$periodo}+" (Acádemicas)"
			: ($periodo=4)
				$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
				$t_titulo:="Observaciones "+atSTR_Periodos_Nombre{$periodo}+" (Acádemicas)"
			: ($periodo=5)
				$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
				$t_titulo:="Observaciones "+atSTR_Periodos_Nombre{$periodo}+" (Acádemicas)"
			: ($b_final)
				$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
				$t_titulo:="Observaciones Finales (Acádemicas)"
		End case 
		
		
		GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		SET AUTOMATIC RELATIONS:C310(True:C214;True:C214)
		QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6=[Alumnos:2]numero:1)
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Asignaturas:18]ordenGeneral:105;>)
		SELECTION TO ARRAY:C260($y_ObservacionAsig->;$at_observacionesAsig;[Asignaturas:18]Asignatura:3;$at_asignatura;[Asignaturas:18];$al_recNumAsig;[Alumnos_ComplementoEvaluacion:209];$al_rnComplemento)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$at_observacionesAsig;"observaciones")
		OB_SET ($ob_raiz;->$at_asignatura;"asignatura")
		OB_SET ($ob_raiz;->$al_recNumAsig;"rnAsignatura")
		OB_SET ($ob_raiz;->$al_rnComplemento;"rnComplemento")
		OB_SET ($ob_raiz;->[Alumnos:2]apellidos_y_nombres:40;"alumno")
		OB_SET ($ob_raiz;->$t_titulo;"titulo")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="guardaObservacion")
		$t_periodo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnumber"))
		$rnAsig:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig")
		$t_observacion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"obs")
		$t_complemento:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"complemento")
		
		$b_complemento:=False:C215
		If ($t_complemento="True")
			$b_complemento:=True:C214
		End if 
		
		If ($t_periodo="all")
			$periodo:=-1
		Else 
			$periodo:=Num:C11($t_periodo)
		End if 
		
		  //cargo los promedios generales del alumno y los promedios de o las asignaturas
		  //ASM Ticket 216851
		$b_final:=False:C215
		If (($periodo=0) & ($rnAsig#""))
			GOTO RECORD:C242([Asignaturas:18];Num:C11($rnAsig))
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			$periodo:=1
			For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
				If ((adSTR_Periodos_Desde{$i}<=Current date:C33(*)) & (adSTR_Periodos_Hasta{$i}>=Current date:C33(*)))
					$periodo:=$i
					$i:=Size of array:C274(adSTR_Periodos_Desde)+1
				End if 
			End for 
		Else 
			If ($periodo=-1)
				$b_final:=True:C214
			End if 
		End if 
		
		If ($b_complemento)
			$y_tabla:=->[Alumnos_ComplementoEvaluacion:209]
			Case of 
				: ($periodo=1)
					$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
				: ($periodo=2)
					$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
				: ($periodo=3)
					$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
				: ($periodo=4)
					$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
				: ($periodo=5)
					$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
				: ($b_final)
					$y_ObservacionAsig:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
			End case 
		Else 
			$y_tabla:=->[Alumnos_SintesisAnual:210]
			Case of 
				: ($periodo=1)
					$y_ObservacionAsig:=->[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
				: ($periodo=2)
					$y_ObservacionAsig:=->[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
				: ($periodo=3)
					$y_ObservacionAsig:=->[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
				: ($periodo=4)
					$y_ObservacionAsig:=->[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
				: ($periodo=5)
					$y_ObservacionAsig:=->[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
				: ($b_final)
					$y_ObservacionAsig:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
			End case 
		End if 
		
		
		READ WRITE:C146($y_tabla->)
		GOTO RECORD:C242($y_tabla->;$rn)
		$y_ObservacionAsig->:=$t_observacion
		SAVE RECORD:C53($y_tabla->)
		$b_ok:=Not:C34(Locked:C147($y_tabla->))
		KRL_UnloadReadOnly ($y_tabla)
		
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$b_ok;"guardado")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($t_accion="datosbuscadordirectorUY")
		
		C_LONGINT:C283($l_periodo)
		C_TEXT:C284($curso)
		
		$l_periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
		
		If ($curso="")
			If ((USR_LimitedSearch ($userID)) & (Not:C34($isAdmin)))
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Cursos:3];$profID)
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
				
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
				SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
				
			Else 
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1#"@ADT")
				ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
				
				ALL RECORDS:C47([Asignaturas:18])
				ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
				SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
			End if 
			
		Else 
			If ((USR_LimitedSearch ($userID)) & (Not:C34($isAdmin)))
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Cursos:3];$profID)
				QUERY SELECTION:C341([Cursos:3];[Cursos:3]Curso:1=$curso)
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
				
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Curso:5=$curso)
				SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
			Else 
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosTemporal;[Cursos:3];$al_cursosRnTemporal;[Cursos:3]Nivel_Numero:7;$al_nivelCursoTemporal)
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$curso)
				ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
				SELECTION TO ARRAY:C260([Asignaturas:18];$al_RnAsignaturaTemporal;[Asignaturas:18]Curso:5;$at_CursoAsignaturaTemporal;[Asignaturas:18]Numero_del_Nivel:6;$al_nivelASigTemporal)
			End if 
		End if 
		
		For ($i;1;Size of array:C274($at_CursoAsignaturaTemporal))
			If (Find in array:C230($at_cursos;$at_CursoAsignaturaTemporal{$i})=-1)
				APPEND TO ARRAY:C911($at_cursos;$at_CursoAsignaturaTemporal{$i})
				APPEND TO ARRAY:C911($al_nivelCursos;$al_nivelASigTemporal{$i})
			End if 
		End for 
		
		For ($i;1;Size of array:C274($at_cursosTemporal))
			If (Find in array:C230($at_cursos;$at_cursosTemporal{$i})=-1)
				APPEND TO ARRAY:C911($at_cursos;$at_cursosTemporal{$i})
				APPEND TO ARRAY:C911($al_nivelCursos;$al_nivelCursoTemporal{$i})
			End if 
		End for 
		
		
		
		If (Size of array:C274($al_nivelCursos)>0)
			PERIODOS_LoadData ($al_nivelCursos{1})
			$b_final:=False:C215
			Case of 
				: ($l_periodo=0)
					$l_periodo:=1
					For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
						If ((adSTR_Periodos_Desde{$i}<=Current date:C33(*)) & (adSTR_Periodos_Hasta{$i}>=Current date:C33(*)))
							$l_periodo:=$i
							$i:=Size of array:C274(adSTR_Periodos_Desde)+1
						End if 
					End for 
				: ($l_periodo=-1)
					$b_final:=True:C214
			End case 
			
			  //cargo los alumnos del curso seleccionado
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$at_cursos{1})
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
			  //QUERY([Alumnos];[Alumnos]Curso=$at_cursos{1})
			ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_NombreAlumno;[Alumnos:2];$al_rnAlumnos)
			
			C_OBJECT:C1216($ob_raiz)
			$ob_raiz:=OB_Create 
			OB_SET ($ob_raiz;->atSTR_Periodos_Nombre;"periodoNombre")
			OB_SET ($ob_raiz;->$at_cursos;"curso")
			OB_SET ($ob_raiz;->$al_rnAlumnos;"rnAlumnos")
			OB_SET ($ob_raiz;->$at_NombreAlumno;"nombreAlumno")
			OB_SET ($ob_raiz;->$l_periodo;"periodoActual")
			$json:=OB_Object2Json ($ob_raiz)
			CLEAR VARIABLE:C89($ob_raiz)
			
		Else 
			  //agregar error Json
		End if 
	: ($t_accion="cargaDatosALumnoUY")
		
		ARRAY TEXT:C222($at_observacionAsignatura;0)
		ARRAY LONGINT:C221($al_recNumComplementoEval;0)
		ARRAY LONGINT:C221($al_recNumCalificaciones;0)
		ARRAY TEXT:C222($at_calificaciones;0)
		ARRAY BOOLEAN:C223($ab_Nocalculados;0)
		C_TEXT:C284($t_foto64)
		C_POINTER:C301($y_observacion)
		C_POINTER:C301($y_notaFinal)  //2080201 RCH Ticket 194347
		
		$l_periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$l_rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAlumno"))
		$b_final:=False:C215
		
		If ($l_rnAlumno#-1)
			GOTO RECORD:C242([Alumnos:2];$l_rnAlumno)
			
			If (Picture size:C356([Alumnos:2]Fotografía:78)>0)
				$t_foto64:=""
				PICTURE TO BLOB:C692([Alumnos:2]Fotografía:78;$x_blob;".jpg")
				BASE64 ENCODE:C895($x_blob;$t_foto64)
			End if 
			
			$t_apellidoPaterno:=[Alumnos:2]Apellido_paterno:3
			$t_apellidoMaterno:=[Alumnos:2]Apellido_materno:4
			$t_noLista:=String:C10([Alumnos:2]no_de_lista:53)
			$t_nombre:=[Alumnos:2]Nombres:2
			
			  //cargo las asignaturas que actualmente cursa el alumno
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
			CREATE SET:C116([Alumnos_Calificaciones:208];"calificaciones")
			KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
			ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>;[Asignaturas:18]Asignatura:3;>)
			SELECTION TO ARRAY:C260([Asignaturas:18];$al_recNumAsig;[Asignaturas:18]Asignatura:3;$at_asignatura;[Asignaturas:18]Numero:1;$al_NoAsignatura;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_estilosNo)
			
			Case of 
				: ($l_periodo=1)
					$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
					$y_evalRend:=->[Alumnos_Calificaciones:208]P01_Eval01_Literal:46
					$y_evalCond:=->[Alumnos_Calificaciones:208]P01_Control_Literal:111
					$y_promPeriodo:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
				: ($l_periodo=2)
					$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
					$y_evalRend:=->[Alumnos_Calificaciones:208]P02_Eval01_Literal:121
					$y_evalCond:=->[Alumnos_Calificaciones:208]P02_Control_Literal:186
					$y_promPeriodo:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
				: ($l_periodo=3)
					$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
					$y_evalRend:=->[Alumnos_Calificaciones:208]P03_Eval01_Literal:196
					$y_evalCond:=->[Alumnos_Calificaciones:208]P03_Control_Literal:261
					$y_promPeriodo:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
				: ($l_periodo=4)
					$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
					$y_evalRend:=->[Alumnos_Calificaciones:208]P04_Eval01_Literal:271
					$y_evalCond:=->[Alumnos_Calificaciones:208]P04_Control_Literal:336
					$y_promPeriodo:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
				: ($l_periodo=5)
					$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
					$y_evalRend:=->[Alumnos_Calificaciones:208]P05_Eval01_Literal:346
					$y_evalCond:=->[Alumnos_Calificaciones:208]P05_Control_Literal:411
					$y_promPeriodo:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416
				Else 
					  //$y_observacion:=->[Alumnos_ComplementoEvaluacion]Final_ObservacionesAcademicas
					  //$b_final:=True
			End case 
			$y_notaFinal:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30  //2080201 RCH Ticket 194347
			
			
			For ($i;1;Size of array:C274($al_NoAsignatura))
				USE SET:C118("calificaciones")
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_NoAsignatura{$i})
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				$l_recNumComplementoEval:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1)
				If ($l_recNumComplementoEval#-1)
					GOTO RECORD:C242([Alumnos_ComplementoEvaluacion:209];$l_recNumComplementoEval)
					APPEND TO ARRAY:C911($at_observacionAsignatura;Replace string:C233($y_observacion->;Char:C90(34);"'"))
					APPEND TO ARRAY:C911($al_recNumComplementoEval;$l_recNumComplementoEval)
				End if 
				If ($b_final)
					  //APPEND TO ARRAY($at_calificaciones;""+"--"+""+"--")
					APPEND TO ARRAY:C911($at_calificaciones;""+"--"+""+"--"+""+"--")
				Else 
					  //APPEND TO ARRAY($at_calificaciones;$y_evalCond->+"--"+$y_evalRend->+"--"+$y_promPeriodo->)
					APPEND TO ARRAY:C911($at_calificaciones;$y_evalCond->+"--"+$y_evalRend->+"--"+$y_promPeriodo->+"--"+$y_notaFinal->)  //2080201 RCH Ticket 194347
				End if 
				APPEND TO ARRAY:C911($al_recNumCalificaciones;Record number:C243([Alumnos_Calificaciones:208]))
				APPEND TO ARRAY:C911($ab_Nocalculados;Not:C34([Asignaturas:18]Resultado_no_calculado:47))
			End for 
			
			C_OBJECT:C1216($ob_raiz)
			C_BOOLEAN:C305($b_sinAlumno)
			$b_sinAlumno:=False:C215
			
			$ob_raiz:=OB_Create 
			OB_SET ($ob_raiz;->$b_sinAlumno;"sinAlumno")
			OB_SET ($ob_raiz;->$l_rnAlumno;"rnAlumno")
			OB_SET ($ob_raiz;->$t_foto64;"foto")
			OB_SET ($ob_raiz;->$t_noLista;"NoLista")
			OB_SET ($ob_raiz;->$t_apellidoPaterno;"ApellidoPaterno")
			OB_SET ($ob_raiz;->$t_apellidoMaterno;"ApellidoMaterno")
			OB_SET ($ob_raiz;->$t_nombre;"Nombres")
			OB_SET ($ob_raiz;->$at_asignatura;"asignaturas")
			OB_SET ($ob_raiz;->$al_recNumAsig;"rnAsignatura")
			OB_SET ($ob_raiz;->$at_observacionAsignatura;"observacionAsignatura")
			OB_SET ($ob_raiz;->$al_recNumComplementoEval;"recNumComplementoEval")
			OB_SET ($ob_raiz;->$at_calificaciones;"calificaciones")
			OB_SET ($ob_raiz;->$al_recNumCalificaciones;"recNumCalificaciones")
			OB_SET ($ob_raiz;->$ab_Nocalculados;"nocalculados")
			OB_SET ($ob_raiz;->[Alumnos:2]RUT:5;"rut")
			
			For ($i;1;Size of array:C274($al_estilosNo))
				  //realizo validaciones del estilo de evaluación de la asignatura
				EVS_ReadStyleData ($al_estilosNo{$i})
				Case of 
					: (iEvaluationMode=Notas)
						$r_minimo:=rGradesFrom
						$r_maximo:=rGradesTo
						$t_evaluacion:="Notas"
					: (iEvaluationMode=Puntos)
						$r_minimo:=rPointsFrom
						$r_maximo:=rPointsTo
						$t_evaluacion:="Puntos"
					: (iEvaluationMode=Simbolos)
						$r_minimo:=0
						$r_maximo:=100
						$t_evaluacion:="Simbolos"
					: (iEvaluationMode=Porcentaje)  //ASM Tcket 216581
						$r_minimo:=RPERCENTFROM
						$r_maximo:=RPERCENTTO
						$t_evaluacion:="Porcentaje"
				End case 
				
				$t_estilo:=String:C10(($i-1))
				C_OBJECT:C1216($ob_estilo)
				$ob_estilo:=OB_Create 
				OB_SET ($ob_estilo;-><>vs_AppDecimalSeparator;"separador")
				OB_SET ($ob_estilo;->$r_minimo;"minimo")
				OB_SET ($ob_estilo;->$r_maximo;"maximo")
				OB_SET ($ob_estilo;->aSymbol;"simbolos")
				OB_SET ($ob_estilo;->$t_evaluacion;"EvaluationMode")
				OB_SET ($ob_estilo;->iGradesDec;"iGradesDec")
				OB_SET ($ob_raiz;->$ob_estilo;$t_estilo)
			End for 
			
			  //cargo la observación final del periodo seleccionado
			C_TEXT:C284($t_observacionFinal)
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1)
			$y_observacionFinal:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($l_periodo)+"_Observaciones_Academicas")
			$t_observacionFinal:=$y_observacionFinal->
			OB_SET ($ob_raiz;->$t_observacionFinal;"observacionFinal")
			$json:=OB_Object2Json ($ob_raiz)
			CLEAR VARIABLE:C89($ob_raiz)
			CLEAR VARIABLE:C89($ob_estilo)
		Else 
			C_OBJECT:C1216($ob_raiz)
			C_BOOLEAN:C305($b_sinAlumno)
			$b_sinAlumno:=True:C214
			$ob_raiz:=OB_Create 
			OB_SET ($ob_raiz;->$b_sinAlumno;"sinAlumno")
			$json:=OB_Object2Json ($ob_raiz)
		End if 
End case 
$0:=$json



