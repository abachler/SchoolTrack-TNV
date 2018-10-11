//%attributes = {}
C_PICTURE:C286($picture)
C_BLOB:C604($blob)
C_TEXT:C284($base64archivo;$base64thumbnail)
C_LONGINT:C283($table)
C_OBJECT:C1216($object)

$y_campo:=$1
$valor:=$2
$0:=True:C214
Case of 
	: ($y_campo=(->[Familia:78]Fecha_de_creación:27))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Familia:78]Fecha_de_Modificacion:28))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Familia:78]Fecha_Matrimonio_Civil:37))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Familia:78]Fecha_Matrimonio_Religioso:39))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos:2]Fecha_de_nacimiento:7))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos:2]Fecha_Deceso:98))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos_SintesisAnual:210]NumeroNivel:6))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;$y_campo;->[xxSTR_Niveles:6]Auto_UUID:51)
	: ($y_campo=(->[Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
		  //: ($y_campo=(->[Alumnos]Status))
		  //$valor->:=String(Num(Not((($y_campo->="Ret@") | ($y_campo->="Egr@")))))  //Quien diablos hizo esto y para que???
	: ($y_campo=(->[Alumnos_Calificaciones:208]ID_Alumno:6))
		$id:=Abs:C99($y_campo->)
		$valor->:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$id;->[Alumnos:2]auto_uuid:72)
	: ($y_campo=(->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1))
		$valor->:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;$y_campo;->[Asignaturas:18]auto_uuid:12)
	: ($y_campo=(->[Asignaturas_Consolidantes:231]ID_ParentRecord:5))
		$valor->:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;$y_campo;->[Asignaturas:18]auto_uuid:12)
	: ($y_campo=(->[Asignaturas_Historico:84]Nivel:4))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]NumeroNivel:3;$y_campo;->[xxSTR_HistoricoNiveles:191]Auto_UUID:24)
	: ($y_campo=(->[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;$y_campo;->[xxSTR_HistoricoEstilosEval:88]Auto_UUID:7)
	: ($y_campo=(->[Asignaturas_Historico:84]Curso:14))
		READ ONLY:C145([Cursos_SintesisAnual:63])
		QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=$y_campo->;*)
		QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=[Asignaturas_Historico:84]Año:5)
		$valor->:=[Cursos_SintesisAnual:63]Auto_UUID:57
	: ($y_campo=(->[Asignaturas_Historico:84]Profesor_Numero:12))
		$valor->:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;$y_campo;->[Profesores:4]Auto_UUID:41)
	: ($y_campo=(->[Asignaturas:18]Configuracion:63))
		C_LONGINT:C283($rnAsignatura)
		C_OBJECT:C1216($o_nodo)
		$object:=OB_Create 
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			PERIODOS_Init 
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			For ($i;1;viSTR_Periodos_NumeroPeriodos)
				ARRAY LONGINT:C221($al_sourceID;0)
				ARRAY DATE:C224($ad_dueDate;0)
				ARRAY LONGINT:C221($al_Enterable;0)
				ARRAY TEXT:C222($at_sourceKey;0)
				ARRAY TEXT:C222($at_dueDate;0)
				$t_nodo:="P"+String:C10($i)
				OB_GET ([Asignaturas:18]Configuracion:63;->$o_nodo;$t_nodo)
				OB_GET ($o_nodo;->$al_sourceID;"SourceID")
				OB_GET ($o_nodo;->$ad_dueDate;"DueDate";"DD/MM/YYYY")
				For ($j;1;Size of array:C274($al_sourceID))
					Case of 
						: ($al_sourceID{$j}>0)
							$key:="1."+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$al_sourceID{$j};->[Asignaturas:18]auto_uuid:12;True:C214)
						: ($al_sourceID{$j}<0)
							$key:="-1"
						Else 
							$key:="0"
					End case 
					APPEND TO ARRAY:C911($at_sourceKey;$key)
					APPEND TO ARRAY:C911($at_dueDate;SN3_MakeDateInmune2LocalFormat ($ad_dueDate{$j}))
				End for 
				OB_SET ($o_nodo;->$at_sourceKey;"SourceID")
				OB_SET ($o_nodo;->$at_dueDate;"DueDate")
				OB_SET ($object;->$o_nodo;$t_nodo)
			End for 
		Else 
			ARRAY LONGINT:C221($al_sourceID;0)
			ARRAY DATE:C224($ad_dueDate;0)
			ARRAY LONGINT:C221($al_Enterable;0)
			ARRAY TEXT:C222($at_sourceKey;0)
			ARRAY TEXT:C222($at_dueDate;0)
			$t_nodo:="Anual"
			OB_GET ([Asignaturas:18]Configuracion:63;->$o_nodo;$t_nodo)
			OB_GET ($o_nodo;->$al_sourceID;"SourceID")
			OB_GET ($o_nodo;->$ad_dueDate;"DueDate";"DD/MM/YYYY")
			For ($j;1;Size of array:C274($al_sourceID))
				Case of 
					: ($al_sourceID{$j}>0)
						$key:="1."+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$al_sourceID{$j};->[Asignaturas:18]auto_uuid:12;True:C214)
					: ($al_sourceID{$j}<0)
						$key:="-1"
					Else 
						$key:="0"
				End case 
				APPEND TO ARRAY:C911($at_sourceKey;$key)
				APPEND TO ARRAY:C911($at_dueDate;SN3_MakeDateInmune2LocalFormat ($ad_dueDate{$j}))
			End for 
			OB_SET ($o_nodo;->$at_sourceKey;"SourceID")
			OB_SET ($o_nodo;->$at_dueDate;"DueDate")
			OB_SET ($object;->$o_nodo;$t_nodo)
		End if 
		ARRAY DATE:C224($ad_BloqueoParcial_p1;0)
		ARRAY DATE:C224($ad_BloqueoParcial_p2;0)
		ARRAY DATE:C224($ad_BloqueoParcial_p3;0)
		ARRAY DATE:C224($ad_BloqueoParcial_p4;0)
		ARRAY DATE:C224($ad_BloqueoParcial_p5;0)
		ARRAY TEXT:C222($at_BloqueoParcial_p1;0)
		ARRAY TEXT:C222($at_BloqueoParcial_p2;0)
		ARRAY TEXT:C222($at_BloqueoParcial_p3;0)
		ARRAY TEXT:C222($at_BloqueoParcial_p4;0)
		ARRAY TEXT:C222($at_BloqueoParcial_p5;0)
		OB_GET ([Asignaturas:18]Configuracion:63;->$ad_BloqueoParcial_p1;"LimiteIngresoParciales_P1";"DD/MM/YYYY")
		OB_GET ([Asignaturas:18]Configuracion:63;->$ad_BloqueoParcial_p2;"LimiteIngresoParciales_P2";"DD/MM/YYYY")
		OB_GET ([Asignaturas:18]Configuracion:63;->$ad_BloqueoParcial_p3;"LimiteIngresoParciales_P3";"DD/MM/YYYY")
		OB_GET ([Asignaturas:18]Configuracion:63;->$ad_BloqueoParcial_p4;"LimiteIngresoParciales_P4";"DD/MM/YYYY")
		OB_GET ([Asignaturas:18]Configuracion:63;->$ad_BloqueoParcial_p5;"LimiteIngresoParciales_P5";"DD/MM/YYYY")
		For ($i;1;Size of array:C274($ad_BloqueoParcial_p1))
			APPEND TO ARRAY:C911($at_BloqueoParcial_p1;SN3_MakeDateInmune2LocalFormat ($ad_BloqueoParcial_p1{$i}))
			APPEND TO ARRAY:C911($at_BloqueoParcial_p2;SN3_MakeDateInmune2LocalFormat ($ad_BloqueoParcial_p2{$i}))
			APPEND TO ARRAY:C911($at_BloqueoParcial_p3;SN3_MakeDateInmune2LocalFormat ($ad_BloqueoParcial_p3{$i}))
			APPEND TO ARRAY:C911($at_BloqueoParcial_p4;SN3_MakeDateInmune2LocalFormat ($ad_BloqueoParcial_p4{$i}))
			APPEND TO ARRAY:C911($at_BloqueoParcial_p5;SN3_MakeDateInmune2LocalFormat ($ad_BloqueoParcial_p5{$i}))
		End for 
		OB_SET ($object;->$at_BloqueoParcial_p1;"LimiteIngresoParciales_P1")
		OB_SET ($object;->$at_BloqueoParcial_p2;"LimiteIngresoParciales_P2")
		OB_SET ($object;->$at_BloqueoParcial_p3;"LimiteIngresoParciales_P3")
		OB_SET ($object;->$at_BloqueoParcial_p4;"LimiteIngresoParciales_P4")
		OB_SET ($object;->$at_BloqueoParcial_p5;"LimiteIngresoParciales_P5")
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[Asignaturas:18]OpcionesControles_y_Examenes:106))
		  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos
		$object:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[Asignaturas:18]Numero_del_Curso:25))
		$valor->:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_curso:6;$y_campo;->[Cursos:3]Auto_UUID:47)
	: ($y_campo=(->[Asignaturas:18]Numero_del_Nivel:6))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;$y_campo;->[xxSTR_Niveles:6]Auto_UUID:51)
	: ($y_campo=(->[Asignaturas:18]profesor_firmante_numero:33))
		$valor->:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;$y_campo;->[Profesores:4]Auto_UUID:41)
	: ($y_campo=(->[Asignaturas:18]profesor_numero:4))
		$valor->:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;$y_campo;->[Profesores:4]Auto_UUID:41)
	: ($y_campo=(->[Asignaturas:18]EVAPR_IdMatriz:91))
		$valor->:=KRL_GetTextFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;$y_campo;->[MPA_AsignaturasMatrices:189]Auto_UUID:32)
	: ($y_campo=(->[Asignaturas:18]ID_Objetivos:43))
		$valor->:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;$y_campo;->[Asignaturas_Objetivos:104]Auto_UUID:15)
	: ($y_campo=(->[Asignaturas:18]Numero_de_EstiloEvaluacion:39))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;$y_campo;->[xxSTR_EstilosEvaluacion:44]Auto_UUID:23)
	: ($y_campo=(->[xxSTR_HistoricoNiveles:191]NumeroNivel:3))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;$y_campo;->[xxSTR_Niveles:6]Auto_UUID:51)
	: ($y_campo=(->[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7))
		PERIODOS_LeeDatosHistoricos ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;[xxSTR_HistoricoNiveles:191]Año:2)
		ARRAY TEXT:C222($aPeriodos_Desde;Size of array:C274(adSTR_Periodos_Desde))
		ARRAY TEXT:C222($aPeriodos_Hasta;Size of array:C274(adSTR_Periodos_Hasta))
		ARRAY TEXT:C222($aPeriodos_Cierre;Size of array:C274(adSTR_Periodos_Cierre))
		If (Size of array:C274(adSTR_Periodos_Desde)>0)
			For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
				$aPeriodos_Desde{$i}:=SN3_MakeDateInmune2LocalFormat (adSTR_Periodos_Desde{$i})
				$aPeriodos_Hasta{$i}:=SN3_MakeDateInmune2LocalFormat (adSTR_Periodos_Hasta{$i})
				$aPeriodos_Cierre{$i}:=SN3_MakeDateInmune2LocalFormat (adSTR_Periodos_Cierre{$i})
			End for 
		End if 
		$object:=OB_Create 
		ARRAY TEXT:C222($aNombres;6)
		ARRAY POINTER:C280($aArreglos;6)
		$aNombres{1}:="numero"
		$aNombres{2}:="nombre"
		$aNombres{3}:="desde"
		$aNombres{4}:="hasta"
		$aNombres{5}:="cierre"
		$aNombres{6}:="dias"
		$aArreglos{1}:=->aiSTR_Periodos_Numero
		$aArreglos{2}:=->atSTR_Periodos_Nombre
		$aArreglos{3}:=->$aPeriodos_Desde
		$aArreglos{4}:=->$aPeriodos_Hasta
		$aArreglos{5}:=->$aPeriodos_Cierre
		$aArreglos{6}:=->aiSTR_Periodos_Dias
		OB_ArraysToObject ($object;->$aNombres;->$aArreglos)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10))
		$object:=OB_Create 
		OB_BlobToObject ($y_campo;->$object)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;$y_campo;->[xxSTR_HistoricoEstilosEval:88]Auto_UUID:7)
	: ($y_campo=(->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;$y_campo;->[xxSTR_HistoricoEstilosEval:88]Auto_UUID:7)
	: ($y_campo=(->[xxSTR_Niveles:6]ID_DirectorNivel:52))
		$valor->:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;$y_campo;->[Profesores:4]Auto_UUID:41)
	: ($y_campo=(->[xxSTR_Niveles:6]OrdenSubsectores:36))
		ARRAY TEXT:C222($at_OrdenAsignaturas;0)
		ARRAY TEXT:C222($aSubjectName;0)
		If (BLOB size:C605([xxSTR_Niveles:6]OrdenSubsectores:36)>32)
			BLOB_Blob2Vars (->[xxSTR_Niveles:6]OrdenSubsectores:36;0;->$at_OrdenAsignaturas;->$aSubjectName)
		End if 
		$object:=OB_Create 
		ARRAY TEXT:C222($aNombres;2)
		ARRAY POINTER:C280($aArreglos;2)
		$aNombres{1}:="orden"
		$aNombres{2}:="asignatura"
		$aArreglos{1}:=->$at_OrdenAsignaturas
		$aArreglos{2}:=->$aSubjectName
		OB_ArraysToObject ($object;->$aNombres;->$aArreglos)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[xxSTR_Niveles:6]Actas_y_Certificados:43))
		$object:=OB_Create 
		OB_BlobToObject ($y_campo;->$object)
		$valor->:=JSON Stringify:C1217($object)
		  //: ($y_campo=(->[xxSTR_Niveles]ObservacionesEvaluacion))
		  //No vamos a exportar obersvacionesevaluacion hasta que este el nuevo sistema
	: ($y_campo=(->[xxSTR_Niveles:6]xEventoCalendario:53))
		ARRAY TEXT:C222($at_EvtCalTipo;0)
		ARRAY LONGINT:C221($al_EvtCalMaxDay;0)
		ARRAY LONGINT:C221($al_EvtCalMaxWeek;0)
		If (BLOB size:C605([xxSTR_Niveles:6]xEventoCalendario:53)>32)
			BLOB_Blob2Vars (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->$at_EvtCalTipo;->$al_EvtCalMaxDay;->$al_EvtCalMaxWeek)
		End if 
		$object:=OB_Create 
		ARRAY TEXT:C222($aNombres;3)
		ARRAY POINTER:C280($aArreglos;3)
		$aNombres{1}:="tipo"
		$aNombres{2}:="maxdia"
		$aNombres{3}:="maxsemana"
		$aArreglos{1}:=->$at_EvtCalTipo
		$aArreglos{2}:=->$al_EvtCalMaxDay
		$aArreglos{3}:=->$al_EvtCalMaxWeek
		OB_ArraysToObject ($object;->$aNombres;->$aArreglos)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_Periodos:100]ID:1;$y_campo;->[xxSTR_Periodos:100]Auto_UUID:13)
	: ($y_campo=(->[xxSTR_Niveles:6]EvStyle_interno:33))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;$y_campo;->[xxSTR_EstilosEvaluacion:44]Auto_UUID:23)
	: ($y_campo=(->[xxSTR_Niveles:6]EvStyle_oficial:23))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;$y_campo;->[xxSTR_EstilosEvaluacion:44]Auto_UUID:23)
	: ($y_campo=(->[Cursos_SintesisAnual:63]Actas_y_Certificados:11))
		$object:=OB_Create 
		OB_BlobToObject ($y_campo;->$object)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[Cursos_SintesisAnual:63]ProfesorJefe_ID:8))
		READ ONLY:C145([Profesores:4])
		$valor->:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;$y_campo;->[Profesores:4]Auto_UUID:41)
	: ($y_campo=(->[Cursos_SintesisAnual:63]NumeroNivel:3))
		READ ONLY:C145([xxSTR_Niveles:6])
		$valor->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;$y_campo;->[xxSTR_Niveles:6]Auto_UUID:51)
	: ($y_campo=(->[Cursos:3]Numero_del_profesor_jefe:2))
		READ ONLY:C145([Profesores:4])
		$valor->:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;$y_campo;->[Profesores:4]Auto_UUID:41)
	: ($y_campo=(->[Cursos:3]Nivel_Numero:7))
		READ ONLY:C145([xxSTR_Niveles:6])
		$valor->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;$y_campo;->[xxSTR_Niveles:6]Auto_UUID:51)
	: ($y_campo=(->[Cursos:3]Director_IdFuncionario:42))
		READ ONLY:C145([Profesores:4])
		$valor->:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;$y_campo;->[Profesores:4]Auto_UUID:41)
	: ($y_campo=(->[Cursos:3]Orden_Subsectores:17))
		ARRAY TEXT:C222($at_OrdenAsignaturas;0)
		ARRAY TEXT:C222($aSubjectName;0)
		If (BLOB size:C605([Cursos:3]Orden_Subsectores:17)>32)
			BLOB_Blob2Vars (->[Cursos:3]Orden_Subsectores:17;0;->$at_OrdenAsignaturas;->$aSubjectName)
		End if 
		$object:=OB_Create 
		ARRAY TEXT:C222($aNombres;2)
		ARRAY POINTER:C280($aArreglos;2)
		$aNombres{1}:="orden"
		$aNombres{2}:="asignatura"
		$aArreglos{1}:=->$at_OrdenAsignaturas
		$aArreglos{2}:=->$aSubjectName
		OB_ArraysToObject ($object;->$aNombres;->$aArreglos)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[Cursos:3]xCalendario_DiasBloq:48))
		ARRAY DATE:C224($ad_fechasBloqueadas;0)
		ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
		ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
		ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)
		ARRAY LONGINT:C221($al_HoraDesde;0)
		ARRAY LONGINT:C221($al_HoraHasta;0)
		If (BLOB size:C605([Cursos:3]xCalendario_DiasBloq:48)>32)
			BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
		End if 
		$object:=OB_Create 
		ARRAY TEXT:C222($aNombres;6)
		ARRAY POINTER:C280($aArreglos;6)
		$aNombres{1}:="fechasbloqueadasfecha"
		$aNombres{2}:="fechasbloaquedasmotivo"
		$aNombres{3}:="horasbloqueadasfecha"
		$aNombres{4}:="horasbloqueadasmotivo"
		$aNombres{5}:="horasdesde"
		$aNombres{6}:="horashasta"
		$aArreglos{1}:=->$ad_fechasBloqueadas
		$aArreglos{2}:=->$at_fechasBloqueadasMotivo
		$aArreglos{3}:=->$ad_HorasBloqueadasFechas
		$aArreglos{4}:=->$at_HorasBloqueadasMotivo
		$aArreglos{5}:=->$al_HoraDesde
		$aArreglos{6}:=->$al_HoraHasta
		OB_ArraysToObject ($object;->$aNombres;->$aArreglos)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[Cursos:3]Acta:34))
		$object:=OB_Create 
		OB_BlobToObject ($y_campo;->$object)
		$valor->:=JSON Stringify:C1217($object)
	: ($y_campo=(->[xShell_Users:47]xPass:13))
		$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
		TEXT TO BLOB:C554($storedPassword;$blob;UTF8 text without length:K22:17)
		BASE64 ENCODE:C895($blob;$valor->)
	: ($y_campo=(->[Alumnos:2]Familia_Número:24))
		READ ONLY:C145([Familia:78])
		$valor->:=KRL_GetTextFieldData (->[Familia:78]Numero:1;$y_campo;->[Familia:78]Auto_UUID:23)
	: ($y_campo=(->[Alumnos:2]Apoderado_académico_Número:27))
		READ ONLY:C145([Personas:7])
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36)
	: ($y_campo=(->[Alumnos:2]Apoderado_Cuentas_Número:28))
		READ ONLY:C145([Personas:7])
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36)
	: ($y_campo=(->[Profesores:4]Inactivo:62))
		$valor->:=ST_Boolean2Str ([Profesores:4]Inactivo:62;"0";"1")
	: ($y_campo=(->[Alumnos:2]Fecha_PrimeraMatricula:86))
		$valor->:=SN3_MakeDateInmune2LocalFormat (Date:C102([Alumnos:2]Fecha_PrimeraMatricula:86))
	: ($y_campo=(->[Familia:78]Padre_Número:5))
		READ ONLY:C145([Personas:7])
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36)
	: ($y_campo=(->[Familia:78]Madre_Número:6))
		READ ONLY:C145([Personas:7])
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36)
	: ($y_campo=(->[Familia:78]Inactiva:31))
		$valor->:=ST_Boolean2Str ([Familia:78]Inactiva:31;"0";"1")
	: ($y_campo=(->[Familia_RelacionesFamiliares:77]ID_Familia:2))
		READ ONLY:C145([Familia:78])
		$valor->:=KRL_GetTextFieldData (->[Familia:78]Numero:1;$y_campo;->[Familia:78]Auto_UUID:23)
	: ($y_campo=(->[Familia_RelacionesFamiliares:77]ID_Persona:3))
		READ ONLY:C145([Personas:7])
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36)
	: ($y_campo=(->[Familia:78]Fotografia:35))
		$table:=Table:C252(->[Familia:78])
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Familia:78]Numero:1)+PICT_GetDefaultExtension 
		$picture:=xDOC_ReadExternalPicture ($folder;$fileName)
		PICTURE TO BLOB:C692($picture;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
	: ($y_campo=(->[Profesores:4]Fotografia:59))
		$table:=Table:C252(->[Profesores:4])
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Profesores:4]Numero:1)+PICT_GetDefaultExtension 
		$picture:=xDOC_ReadExternalPicture ($folder;$fileName)
		PICTURE TO BLOB:C692($picture;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
	: ($y_campo=(->[Personas:7]Fotografia:43))
		$table:=Table:C252(->[Personas:7])
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Personas:7]No:1)+PICT_GetDefaultExtension 
		$picture:=xDOC_ReadExternalPicture ($folder;$fileName)
		PICTURE TO BLOB:C692($picture;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
	: ($y_campo=(->[Alumnos:2]Fotografía:78))
		$table:=Table:C252(->[Alumnos:2])
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Alumnos:2]numero:1)+PICT_GetDefaultExtension 
		$picture:=xDOC_ReadExternalPicture ($folder;$fileName)
		PICTURE TO BLOB:C692($picture;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
	: ($y_campo=(->[Familia_RelacionesFamiliares:77]Tipo_Relación:4))
		Case of 
			: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=0)
				$valor->:="Sin Información"
			: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4#11)
				$valor->:=<>aParentesco{[Familia_RelacionesFamiliares:77]Tipo_Relación:4}
			: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=11)
				$valor->:=[Familia_RelacionesFamiliares:77]Parentesco:6
		End case 
	: ($y_campo=(->[Personas:7]Inactivo:46))
		$valor->:=ST_Boolean2Text ($y_campo->;"0";"1")
	: ($y_campo=(->[Personas:7]Fecha_de_nacimiento:5))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Personas:7]Fecha_Deceso:89))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Personas:7]ACT_ReceptorDT_id_Ter:114))
		$valor->:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;$y_campo;->[ACT_Terceros:138]Auto_UUID:73)
	: ($y_campo=(->[Personas:7]ACT_ReceptorDT_id_Apdo:113))
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36;True:C214)
	: ($y_campo=(->[Familia_RelacionesFamiliares:77]ID_Familia:2))
		$valor->:=KRL_GetTextFieldData (->[Familia:78]Numero:1;$y_campo;->[Familia:78]Auto_UUID:23)
	: ($y_campo=(->[Profesores:4]Inactivo:62))
		$valor->:=ST_Boolean2Text ($y_campo->;"0";"1")
	: ($y_campo=(->[Alumnos:2]Fecha_de_Ingreso:41))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos:2]Fecha_de_retiro:42))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos:2]Fecha_PrimeraMatricula:86))
		$valor->:=SN3_MakeDateInmune2LocalFormat (Date:C102($y_campo->))
	: ($y_campo=(->[Alumnos:2]Fecha_Matricula:108))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos:2]Apoderado_académico_Número:27))
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36;True:C214)
	: ($y_campo=(->[Alumnos:2]Apoderado_Cuentas_Número:28))
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36;True:C214)
	: ($y_campo=(->[Alumnos:2]Familia_Número:24))
		$valor->:=KRL_GetTextFieldData (->[Familia:78]Numero:1;$y_campo;->[Familia:78]Auto_UUID:23)
	: ($y_campo=(->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33))
		If (($y_campo-><0) | ($y_campo->>100))
			$y_campo->:=100
		End if 
		$valor->:=String:C10($y_campo->;"###,##")
	: ($y_campo=(->[Alumnos_SintesisAnual:210]P01_PorcentajeAsistencia:100))
		If (($y_campo-><0) | ($y_campo->>100))
			$y_campo->:=100
		End if 
		$valor->:=String:C10($y_campo->;"###,##")
	: ($y_campo=(->[Alumnos_SintesisAnual:210]P02_PorcentajeAsistencia:129))
		If (($y_campo-><0) | ($y_campo->>100))
			$y_campo->:=100
		End if 
		$valor->:=String:C10($y_campo->;"###,##")
	: ($y_campo=(->[Alumnos_SintesisAnual:210]P03_PorcentajeAsistencia:158))
		If (($y_campo-><0) | ($y_campo->>100))
			$y_campo->:=100
		End if 
		$valor->:=String:C10($y_campo->;"###,##")
	: ($y_campo=(->[Alumnos_SintesisAnual:210]P04_PorcentajeAsistencia:187))
		If (($y_campo-><0) | ($y_campo->>100))
			$y_campo->:=100
		End if 
		$valor->:=String:C10($y_campo->;"###,##")
	: ($y_campo=(->[Alumnos_SintesisAnual:210]P05_PorcentajeAsistencia:216))
		If (($y_campo-><0) | ($y_campo->>100))
			$y_campo->:=100
		End if 
		$valor->:=String:C10($y_campo->;"###,##")
	: ($y_campo=(->[Profesores:4]Fecha_de_nacimiento:6))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Profesores:4]Fecha_Deceso:71))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos:2]Fecha_de_Creacion:21))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos:2]Fecha_de_modificacion:22))
		$valor->:=SN3_MakeDateInmune2LocalFormat ($y_campo->)
	: ($y_campo=(->[Alumnos:2]nivel_numero:29))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;$y_campo;->[xxSTR_Niveles:6]Auto_UUID:51)
	: ($y_campo=(->[Alumnos:2]Tutor_numero:36))
		$valor->:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;$y_campo;->[Profesores:4]Auto_UUID:41)
	: ($y_campo=(->[Alumnos:2]NoNIvel_alRetirarse:84))
		$valor->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;$y_campo;->[xxSTR_Niveles:6]Auto_UUID:51)
	: ($y_campo=(->[Alumnos:2]ID_Custodio:99))
		$valor->:=KRL_GetTextFieldData (->[Personas:7]No:1;$y_campo;->[Personas:7]Auto_UUID:36)
		
	Else 
		$0:=False:C215
End case 
