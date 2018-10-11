//%attributes = {}
  // MÉTODO: MPAdbu_VerificaRegistrosEval
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 04/06/12, 10:07:45
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPAdbu_VerificaRegistrosEval()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_BOOLEAN:C305($b_createRecord)
_O_C_INTEGER:C282($i_alumnos;$i_asignaturas;$i_objetos;$i_registrosEvaluacion)
C_LONGINT:C283($l_idAlumno;$l_idAsignatura;$l_IdCompetencia;$l_IdDimension;$l_IdEje;$l_idMatriz;$l_indiceObjeto;$l_numeroNivel;$l_recNumRegistroAprendizaje)
C_TEXT:C284($t_llaveRegistroAprendizaje;$t_llaveObjeto)

ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_iDCompetencia;0)
ARRAY LONGINT:C221($al_IdDimension;0)
ARRAY LONGINT:C221($al_IdEje;0)
ARRAY LONGINT:C221($al_recNumAsignaturas;0)
ARRAY LONGINT:C221($al_recNumEvaluaciones;0)
ARRAY LONGINT:C221($al_recNumObjetos;0)
ARRAY LONGINT:C221($al_recNumObjetosInvalidos;0)
ARRAY LONGINT:C221($al_registrosInvalidos;0)
ARRAY LONGINT:C221($al_TipoObjeto;0)
ARRAY TEXT:C222($at_llavesObjetosValidos;0)
ARRAY TEXT:C222($at_nombreCompetencia;0)
ARRAY TEXT:C222($at_nombreDimension;0)
ARRAY TEXT:C222($at_nombreEje;0)
ARRAY TEXT:C222($at_sexoAlumnos;0)

ARRAY TEXT:C222($at_errores;0)
ARRAY TEXT:C222($at_Asignatura;0)
ARRAY TEXT:C222($at_Cursos;0)
ARRAY TEXT:C222($at_Alumnos;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_Colores;0)
ARRAY TEXT:C222($at_llaveAsignaturaAlumno;0)

  // CODIGO PRINCIPAL


  // busco las asignaturas con matriz de evaluación de aprendizajes asociada
QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>)

LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas;"")

$l_IdProcesoProgreso:=IT_Progress (1;0;0;"Verificando consistencia de registros de evaluación de aprendizajes.")
For ($i_asignaturas;1;Size of array:C274($al_recNumAsignaturas))
	$l_IdProcesoProgreso:=IT_Progress (0;$l_IdProcesoProgreso;$i_asignaturas/Size of array:C274($al_recNumAsignaturas);"Verificando consistencia de registros de evaluación de aprendizajes.")
	KRL_GotoRecord (->[Asignaturas:18];$al_recNumAsignaturas{$i_asignaturas})
	$l_idAsignatura:=[Asignaturas:18]Numero:1
	$l_idMatriz:=[Asignaturas:18]EVAPR_IdMatriz:91
	$l_numeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
	$t_nombreAsignatura:=[Asignaturas:18]denominacion_interna:16
	$t_curso:=[Asignaturas:18]Curso:5
	
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignatura)
	CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$registrosEvaluacionActuales")
	
	  // verifico que los objetos de la matriz estén definidos en los mapas
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_idMatriz)
	CREATE SET:C116([MPA_ObjetosMatriz:204];"$objetosActuales")
	SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Automatic:K51:4;Manual:K51:3)
	SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Automatic:K51:4;Manual:K51:3)
	SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Automatic:K51:4;Manual:K51:3)
	SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_recNumObjetos;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;$al_TipoObjeto;[MPA_ObjetosMatriz:204]ID_Eje:3;$al_IdEje;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEje;[MPA_ObjetosMatriz:204]ID_Dimension:4;$al_IdDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_nombreDimension;[MPA_ObjetosMatriz:204]ID_Competencia:5;$al_iDCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_nombreCompetencia)
	SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Structure configuration:K51:2;Structure configuration:K51:2)
	SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Structure configuration:K51:2;Structure configuration:K51:2)
	SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Structure configuration:K51:2;Structure configuration:K51:2)
	For ($i_objetos;Size of array:C274($al_recNumObjetos);1;-1)
		Case of 
			: (($al_TipoObjeto{$i_objetos}=Eje_Aprendizaje) & ($at_nombreEje{$i_objetos}=""))
				APPEND TO ARRAY:C911($al_recNumObjetosInvalidos;$al_recNumObjetos{$i_objetos})
				
			: (($al_TipoObjeto{$i_objetos}=Dimension_Aprendizaje) & ($at_nombreDimension{$i_objetos}=""))
				APPEND TO ARRAY:C911($al_recNumObjetosInvalidos;$al_recNumObjetos{$i_objetos})
				
			: (($al_TipoObjeto{$i_objetos}=Logro_Aprendizaje) & ($at_nombreCompetencia{$i_objetos}=""))
				APPEND TO ARRAY:C911($al_recNumObjetosInvalidos;$al_recNumObjetos{$i_objetos})
				
		End case 
	End for 
	
	If (Size of array:C274($al_recNumObjetosInvalidos)>0)
		CREATE EMPTY SET:C140([MPA_ObjetosMatriz:204];"$objetosInvalidos")
		CREATE EMPTY SET:C140([Alumnos_EvaluacionAprendizajes:203];"$registrosEvaluacionInvalidos")
		For ($i_objetos;1;Size of array:C274($al_recNumObjetosInvalidos))
			KRL_GotoRecord (->[MPA_ObjetosMatriz:204];$al_recNumObjetosInvalidos{$i_objetos})
			If (OK=1)
				$l_IdEje:=[MPA_ObjetosMatriz:204]ID_Eje:3
				$l_IdDimension:=[MPA_ObjetosMatriz:204]ID_Dimension:4
				$l_IdCompetencia:=[MPA_ObjetosMatriz:204]ID_Competencia:5
				Case of 
					: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
						SET_UseSet ("$objetosActuales")
						QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$l_IdEje)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"$objetos")
						UNION:C120("$objetosInvalidos";"$objetos";"$objetosInvalidos")
						SET_UseSet ("$registrosEvaluacionActuales")
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$l_IdEje)
						CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$registrosEvaluacion")
						UNION:C120("$registrosEvaluacionInvalidos";"$registrosEvaluacion";"$registrosEvaluacionInvalidos")
						
					: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
						SET_UseSet ("$objetosActuales")
						QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$l_IdDimension)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"$objetos")
						UNION:C120("$objetosInvalidos";"$objetos";"$objetosInvalidos")
						SET_UseSet ("$registrosEvaluacionActuales")
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$l_IdDimension)
						CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$registrosEvaluacion")
						UNION:C120("$registrosEvaluacionInvalidos";"$registrosEvaluacion";"$registrosEvaluacionInvalidos")
						
					: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
						SET_UseSet ("$objetosActuales")
						QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$l_IdDimension)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"$objetos")
						UNION:C120("$objetosInvalidos";"$objetos";"$objetosInvalidos")
						SET_UseSet ("$registrosEvaluacionActuales")
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$l_IdDimension)
						CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$registrosEvaluacion")
						UNION:C120("$registrosEvaluacionInvalidos";"$registrosEvaluacion";"$registrosEvaluacionInvalidos")
						
				End case 
			End if 
		End for 
		
		If (Records in set:C195("$objetosInvalidos")>0)
			SET_UseSet ("$objetosInvalidos")
			KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
		End if 
		If (Records in set:C195("$registrosEvaluacionInvalidos")>0)
			SET_UseSet ("$registrosEvaluacionInvalidos")
			KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
		End if 
		
		
		APPEND TO ARRAY:C911($at_errores;"En la matriz de evaluación asignada a la asignatura existían enunciados no definidos en los mapas de aprendizajes. Fueron eliminados.")
		APPEND TO ARRAY:C911($at_Asignatura;$t_nombreAsignatura)
		APPEND TO ARRAY:C911($at_Cursos;$t_curso)
		APPEND TO ARRAY:C911($at_Alumnos;"")
		APPEND TO ARRAY:C911($al_estilos;0)
		APPEND TO ARRAY:C911($al_Colores;Black:K11:16)
		
	End if 
	
	  // cargo los record numbers de los objetos de evaluación definidos en la matriz definición de objetos
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_idMatriz)
	LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_recNumObjetos;"")
	SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_recNumObjetos;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;$al_tipoObjeto;[MPA_ObjetosMatriz:204]ID_Eje:3;$al_IdEje;[MPA_ObjetosMatriz:204]ID_Dimension:4;$al_IdDimension;[MPA_ObjetosMatriz:204]ID_Competencia:5;$al_IdCompetencia)
	
	For ($i_objetos;1;Size of array:C274($al_recNumObjetos))
		READ WRITE:C146([MPA_ObjetosMatriz:204])
		KRL_GotoRecord (->[MPA_ObjetosMatriz:204];$al_recNumObjetos{$i_objetos})
		If (OK=1)
			APPEND TO ARRAY:C911($at_llavesObjetosValidos;String:C10($al_IdEje{$i_objetos})+"."+String:C10($al_IdDimension{$i_objetos})+"."+String:C10($al_IdCompetencia{$i_objetos}))
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_idAsignatura)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40)
			SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Manual:K51:3)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos;[Alumnos:2]Sexo:49;$at_sexoAlumnos)
			For ($i_alumnos;1;Size of array:C274($al_IdAlumnos))
				$l_idAlumno:=$al_IdAlumnos{$i_alumnos}
				$t_sexoAlumno:=$at_sexoAlumnos{$i_alumnos}
				Case of 
					: (([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje))
						$t_llaveRegistroAprendizaje:=String:C10($l_idAsignatura)+"."+String:C10($l_idAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
						$l_recNumRegistroAprendizaje:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistroAprendizaje)
						$b_createRecord:=($l_recNumRegistroAprendizaje<0)
						
					: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
						RELATE ONE:C42([MPA_ObjetosMatriz:204]ID_Competencia:5)
						Case of 
							: ([MPA_DefinicionCompetencias:187]RestriccionSexo:27=0)
								$t_llaveRegistroAprendizaje:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
								$l_recNumRegistroAprendizaje:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistroAprendizaje)
								$b_createRecord:=($l_recNumRegistroAprendizaje<0)
								
							: ((([MPA_DefinicionCompetencias:187]RestriccionSexo:27=1) & ($t_sexoAlumno="F")) | (([MPA_DefinicionCompetencias:187]RestriccionSexo:27=2) & ($t_sexoAlumno="M")))
								$t_llaveRegistroAprendizaje:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
								$l_recNumRegistroAprendizaje:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistroAprendizaje)
								$b_createRecord:=($l_recNumRegistroAprendizaje<0)
						End case 
				End case 
				
				If ($b_createRecord)
					CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
					[Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78:=<>gInstitucion
					[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
					[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=$l_idAlumno
					[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=$l_idAsignatura
					[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=[MPA_ObjetosMatriz:204]ID_Competencia:5
					[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
					[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=[MPA_ObjetosMatriz:204]ID_Dimension:4
					[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=[MPA_ObjetosMatriz:204]Tipo_Objeto:2
					[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[MPA_ObjetosMatriz:204]ID_Matriz:1
					[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=$l_numeroNivel
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
					SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
					MPA_RecuperaEvalCicloAnterior 
					$t_llaveAsignaturaAlumno:=String:C10($l_idAsignatura)+"."+String:C10($l_idAlumno)
					If (Find in array:C230($at_llaveAsignaturaAlumno;$t_llaveAsignaturaAlumno)<0)
						APPEND TO ARRAY:C911($at_llaveAsignaturaAlumno;$t_llaveAsignaturaAlumno)
					End if 
				Else 
					KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNumRegistroAprendizaje;True:C214)
					If ((OK=1) & ([MPA_ObjetosMatriz:204]Periodos:7#[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10))
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
						SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
						UNLOAD RECORD:C212([Alumnos_EvaluacionAprendizajes:203])
					End if 
				End if 
			End for 
		End if 
	End for 
	
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignatura)
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;$al_IdEje;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;$al_IdDimension;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;$al_IdCompetencia;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;$al_TipoObjeto)
	For ($i_registrosEvaluacion;1;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
		$t_llaveObjeto:=String:C10($al_IdEje{$i_registrosEvaluacion})+"."+String:C10($al_IdDimension{$i_registrosEvaluacion})+"."+String:C10($al_IdCompetencia{$i_registrosEvaluacion})
		$l_indiceObjeto:=Find in array:C230($at_llavesObjetosValidos;$t_llaveObjeto)
		If ($l_indiceObjeto<0)  // si el enunciado no está definido en la matriz
			Case of 
				: ($al_TipoObjeto{$i_registrosEvaluacion}=Eje_Aprendizaje)
					$l_recNumDefinicion:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;$al_IdCompetencia{$i_registrosEvaluacion})
				: ($al_TipoObjeto{$i_registrosEvaluacion}=Dimension_Aprendizaje)
					$l_recNumDefinicion:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;$al_IdDimension{$i_registrosEvaluacion})
				: ($al_TipoObjeto{$i_registrosEvaluacion}=Logro_Aprendizaje)
					$l_recNumDefinicion:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;$al_IdCompetencia{$i_registrosEvaluacion})
			End case 
			If ($l_recNumDefinicion<0)  // y si el registro de definición no existe, no hay forma de recuperarlo. Lo agregamos al arreglo de registro de evaluación de aprendizajes inválidos
				APPEND TO ARRAY:C911($al_registrosInvalidos;$al_recNumEvaluaciones{$i_registrosEvaluacion})
			End if 
		End if 
	End for 
End for 

If (Size of array:C274($al_registrosInvalidos)>0)
	CREATE SELECTION FROM ARRAY:C640([Alumnos_EvaluacionAprendizajes:203];$al_registrosInvalidos)
	KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
End if 


For ($i;1;Size of array:C274($at_llaveAsignaturaAlumno))
	$l_idAsignatura:=Num:C11(ST_GetWord ($at_llaveAsignaturaAlumno{$i};1;"."))
	$l_idAlumno:=Num:C11(ST_GetWord ($at_llaveAsignaturaAlumno{$i};2;"."))
	KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idAsignatura)
	KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_idAlumno)
	APPEND TO ARRAY:C911($at_errores;"La grilla de evaluación de aprendizajes del alumno en la asignatura estaba incompleta. Fue completada.")
	APPEND TO ARRAY:C911($at_Asignatura;[Asignaturas:18]denominacion_interna:16)
	APPEND TO ARRAY:C911($at_Cursos;[Asignaturas:18]Curso:5)
	APPEND TO ARRAY:C911($at_Alumnos;[Alumnos:2]apellidos_y_nombres:40)
	APPEND TO ARRAY:C911($al_estilos;0)
	APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
End for 

If (Size of array:C274($at_Errores)>0)
	$t_Encabezado:="Verificación de grillas de evaluación de aprendizajes."
	$t_descripcion:="Se detectaron enunciados no definidos en los mapas de aprendizaje o enunciados faltantes en las grillas de evaluación de alumnos.\r"
	$t_descripcion:=$t_descripcion+"Normalmente esto no representa un problema ya que las grillas se construyen automáticamente previo al registro de evaluaciones "
	$t_descripcion:=$t_descripcion+"o a la impresión de informes."
	$t_contenidoTexto:=""
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Asignatura")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Curso")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Alumno")
	
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_Asignatura;->$at_Cursos;->$at_Alumnos)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	
	$t_mensajeFalla:="Se detectaron grillas de evaluación de aprendizaje incompletas.\r\rEl detalle será mostrado en el centro de notificaciones."
	$t_mensajeExito:="No se detectó ningún problema en las grillas de evaluación de aprendizaje."
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
Else 
	$0:=0
End if 

$l_IdProcesoProgreso:=IT_Progress (-1;$l_IdProcesoProgreso)
SET_ClearSets ("$registrosEvaluacionInvalidos";"$registrosEvaluacion";"$registrosEvaluacionInvalidos";"$objetosInvalidos";"$objetos";"$objetosInvalidos";"$registrosEvaluacionActuales")

KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])

