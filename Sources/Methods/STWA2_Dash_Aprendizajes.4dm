//%attributes = {}
  //STWA2_Dash_Aprendizajes

C_POINTER:C301($parameterNames;$parameterValues)
C_TEXT:C284($action)
C_LONGINT:C283($l_pos)

ARRAY LONGINT:C221($cantidades;0)
ARRAY LONGINT:C221($cantidades2;0)
ARRAY TEXT:C222($categorias;0)
ARRAY TEXT:C222($evaluaciones;0)
ARRAY LONGINT:C221($al_tipoObjeto;0)
ARRAY TEXT:C222($at_glosaMapa;0)
ARRAY TEXT:C222($at_serieLogros;0)
ARRAY OBJECT:C1221($ao_objetoDatos;0)
ARRAY TEXT:C222($at_coloresHexa;0)
ARRAY LONGINT:C221($al_alumnosID;0)

C_LONGINT:C283($idAsignatura)
C_TEXT:C284($curso)
C_LONGINT:C283($periodo;$nivel)
C_OBJECT:C1216($o_nodo)

$parameterNames:=$1
$parameterValues:=$2
$action:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"action")
$uuid:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"UUID")
$userID:=STWA2_Session_GetUserSTID ($uuid)

Case of 
	: ($action="dashboard")
		ARRAY LONGINT:C221($al_idObjeto;0)
		ARRAY LONGINT:C221($al_idCompetencia;0)
		$idAsignatura:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"id_asignatura"))
		$rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"rnAsig"))
		$curso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"periodo"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"rnAlumno"))
		
		NIV_LoadArrays 
		PERIODOS_Init 
		
		  // Cargo niveles, cursos y asignaturas Activas (todas)
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_noNivel;[xxSTR_Niveles:6]Nivel:1;$at_nombreNivel)
		
		If ($nivel=0)
			If (Size of array:C274($al_noNivel)>0)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$al_noNivel{1})
				$nivel:=$al_noNivel{1}
			End if 
		Else 
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$nivel)
		End if 
		
		  //QUERY SELECTION([Cursos];[Cursos]Curso#"@ADT@")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Curso:5;$at_Curso)
		
		For ($l_indice;Size of array:C274($at_Curso);2;-1)
			If ($at_Curso{$l_indice}=$at_Curso{$l_indice-1})
				DELETE FROM ARRAY:C228($at_Curso;$l_indice)
			End if 
		End for 
		
		If ($curso="")
			If (Size of array:C274($at_Curso)>0)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$at_Curso{1})
			End if 
		Else 
			If ($curso#"")
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$curso;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=$nivel)
			End if 
		End if 
		
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Curso:5;>;[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Asignatura:3;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_nombreAsignatura;[Asignaturas:18]Numero:1;$al_IdAsignatura)
		
		
		If ($idAsignatura#0)
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero:1=$idAsignatura)
			$l_posicionAsig:=Find in array:C230($al_IdAsignatura;$idAsignatura)
		Else 
			$l_posicionAsig:=1
		End if 
		
		If ($rnAsig#0)
			GOTO RECORD:C242([Asignaturas:18];$rnAsig)
			$nivel:=[Asignaturas:18]Numero_del_Nivel:6
			$curso:=[Asignaturas:18]Curso:5
		End if 
		
		If (Size of array:C274($al_IdAsignatura)>0)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_IdAsignatura{$l_posicionAsig})
			  //Cargo los datos de mapa de aprendizajes para el detalle
			ARRAY LONGINT:C221($al_alumnosID;0)
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$al_IdAsignatura{$l_posicionAsig};*)
			QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)
			AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$al_alumnosID)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
		Else 
			If ($curso="")
				If (Size of array:C274($at_Curso)>0)
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$at_Curso{1};*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)
				End if 
			Else 
				If ($curso#"")
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso;*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)
				End if 
			End if 
		End if 
		SELECTION TO ARRAY:C260([Alumnos:2];$al_RecNumALumnos;[Alumnos:2]apellidos_y_nombres:40;$at_alumnosNombres)
		
		QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
		QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
		QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
		$b_noEvaluados:=False:C215
		
		If (Records in selection:C76([MPA_AsignaturasMatrices:189])>0)
			  //SI NO HAY REGISTRO LOS DEJO A TODOS COMO NO EVALUADOS
			QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->$al_alumnosID)
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1)
			If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
				$b_noEvaluados:=False:C215
			Else 
				$b_noEvaluados:=True:C214
			End if 
		End if 
		
		  //verifico el periodo
		$b_comparado:=False:C215
		PERIODOS_LoadData ($nivel)
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
				$b_comparado:=True:C214
		End case 
		
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
		QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
		SET AUTOMATIC RELATIONS:C310(True:C214;True:C214)
		ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_RecNumObjeto)
		
		For ($indice;1;Size of array:C274($al_RecNumObjeto))
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumObjeto{$indice})
			Case of 
				: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
					QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=[MPA_ObjetosMatriz:204]ID_Eje:3)
					$l_pos:=Find in array:C230($al_idObjeto;[MPA_ObjetosMatriz:204]ID_Eje:3)
					If (Find in array:C230($al_idObjeto;[MPA_DefinicionEjes:185]ID:1)=-1)
						APPEND TO ARRAY:C911($at_glosaMapa;[MPA_DefinicionEjes:185]Nombre:3)
						APPEND TO ARRAY:C911($al_tipoObjeto;Eje_Aprendizaje)
						APPEND TO ARRAY:C911($al_idObjeto;[MPA_DefinicionEjes:185]ID:1)
					Else 
						If ($al_tipoObjeto{$l_pos}#Eje_Aprendizaje)
							APPEND TO ARRAY:C911($at_glosaMapa;[MPA_DefinicionEjes:185]Nombre:3)
							APPEND TO ARRAY:C911($al_tipoObjeto;Eje_Aprendizaje)
							APPEND TO ARRAY:C911($al_idObjeto;[MPA_DefinicionEjes:185]ID:1)
						End if 
					End if 
				: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
					QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1=[MPA_ObjetosMatriz:204]ID_Dimension:4)
					$l_pos:=Find in array:C230($al_idObjeto;[MPA_DefinicionDimensiones:188]ID:1)
					If ($l_pos=-1)
						APPEND TO ARRAY:C911($at_glosaMapa;[MPA_DefinicionDimensiones:188]Dimensión:4)
						APPEND TO ARRAY:C911($al_tipoObjeto;Dimension_Aprendizaje)
						APPEND TO ARRAY:C911($al_idObjeto;[MPA_DefinicionDimensiones:188]ID:1)
					Else 
						If ($al_tipoObjeto{$l_pos}#Dimension_Aprendizaje)
							APPEND TO ARRAY:C911($at_glosaMapa;[MPA_DefinicionDimensiones:188]Dimensión:4)
							APPEND TO ARRAY:C911($al_tipoObjeto;Dimension_Aprendizaje)
							APPEND TO ARRAY:C911($al_idObjeto;[MPA_DefinicionDimensiones:188]ID:1)
						End if 
					End if 
				: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
					QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=[MPA_ObjetosMatriz:204]ID_Competencia:5)
					$l_pos:=Find in array:C230($al_idObjeto;[MPA_DefinicionCompetencias:187]ID:1)
					If ($l_pos=-1)
						APPEND TO ARRAY:C911($at_glosaMapa;[MPA_DefinicionCompetencias:187]Competencia:6)
						APPEND TO ARRAY:C911($al_tipoObjeto;Logro_Aprendizaje)
						APPEND TO ARRAY:C911($al_idObjeto;[MPA_DefinicionCompetencias:187]ID:1)
					Else 
						If ($al_tipoObjeto{$l_pos}#Logro_Aprendizaje)
							APPEND TO ARRAY:C911($at_glosaMapa;[MPA_DefinicionCompetencias:187]Competencia:6)
							APPEND TO ARRAY:C911($al_tipoObjeto;Logro_Aprendizaje)
							APPEND TO ARRAY:C911($al_idObjeto;[MPA_DefinicionCompetencias:187]ID:1)
						End if 
					End if 
			End case 
		End for 
		
		ARRAY TEXT:C222($at_indicadorEvaluacion;0)
		
		C_POINTER:C301(vQR_pointer1)
		C_LONGINT:C283($contadorIndicador)
		ARRAY TEXT:C222($at_indicadorGrafico;0)
		$contadorIndicador:=0
		ARRAY LONGINT:C221($l_noEvaluadosLogros;0)
		
		  //cargo los datos de evaluaciones para las series del gráfico
		Case of 
			: ($periodo=1)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
			: ($periodo=2)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
			: ($periodo=3)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
			: ($periodo=4)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
			: ($periodo=5)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
		End case 
		
		  //cargo las series (simbolos estilo de evaluación)
		For ($i;1;Size of array:C274($al_idObjeto))
			Case of 
				: ($al_tipoObjeto{$i}=Logro_Aprendizaje)
					QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=$al_idObjeto{$i})
					$contadorIndicador:=$contadorIndicador+1
					APPEND TO ARRAY:C911($at_serieLogros;[MPA_DefinicionCompetencias:187]Competencia:6)
					APPEND TO ARRAY:C911($at_indicadorGrafico;"Ind "+String:C10($contadorIndicador))
					APPEND TO ARRAY:C911($al_idCompetencia;[MPA_DefinicionCompetencias:187]ID:1)
					EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
					SORT ARRAY:C229(aSymbDesc;aSymbol;aSTWAColorRGB;aSTWAColorHexa;<)
					For ($x;1;Size of array:C274(aSymbDesc))
						If (Find in array:C230($at_indicadorEvaluacion;aSymbDesc{$x})=-1)
							APPEND TO ARRAY:C911($at_indicadorEvaluacion;aSymbDesc{$x})
							APPEND TO ARRAY:C911($at_coloresHexa;aSTWAColorHexa{$x})
						End if 
					End for 
			End case 
		End for 
		
		
		Case of 
			: (Not:C34($b_comparado))
				For ($i;1;Size of array:C274($al_idObjeto))
					Case of 
						: ($al_tipoObjeto{$i}=Logro_Aprendizaje)
							
							QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=$al_idObjeto{$i})
							
							If (Not:C34($b_noEvaluados))
								  //cargo las evaluaciones
								QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
								QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1)
								QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1)
								
								If ($rnAlumno#-1)
									GOTO RECORD:C242([Alumnos:2];$rnAlumno)
									QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=[Alumnos:2]numero:1)
								End if 
								
								CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"logros")
								
								C_LONGINT:C283($l_Evaluados)
								$l_Evaluados:=0
								For ($x;1;Size of array:C274($at_indicadorEvaluacion))
									vQR_pointer1:=Get pointer:C304("al_seriedata_"+String:C10($x))
									USE SET:C118("logros")
									QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];$y_aprendizajeCampo->=$at_indicadorEvaluacion{$x})
									APPEND TO ARRAY:C911(vQR_pointer1->;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
									$l_Evaluados:=$l_Evaluados+Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
								End for 
								
								vQR_pointer1:=Get pointer:C304("al_seriedata_"+String:C10(Size of array:C274($at_indicadorEvaluacion)+1))
								APPEND TO ARRAY:C911(vQR_pointer1->;Size of array:C274($al_alumnosID)-$l_Evaluados)
								
								
							Else 
								C_LONGINT:C283($total)
								vQR_pointer1:=Get pointer:C304("al_seriedata_"+String:C10(Size of array:C274($at_indicadorEvaluacion)+1))
								If ($rnAlumno#-1)
									$total:=1
									APPEND TO ARRAY:C911(vQR_pointer1->;$total)
								Else 
									$total:=Size of array:C274($al_alumnosID)
									APPEND TO ARRAY:C911(vQR_pointer1->;$total)
								End if 
							End if 
					End case 
				End for 
			Else 
				  // para cargar los datos de los gráficos comparados por periodo configurado
				  //recorro los periodos configurados
				For ($l_indicePeriodo;1;Size of array:C274(atSTR_Periodos_Nombre))
					
					Case of 
						: ($l_indicePeriodo=1)
							$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
						: ($l_indicePeriodo=2)
							$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
						: ($l_indicePeriodo=3)
							$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
						: ($l_indicePeriodo=4)
							$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
						: ($l_indicePeriodo=5)
							$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
					End case 
					
					For ($i;1;Size of array:C274($al_idObjeto))
						Case of 
							: ($al_tipoObjeto{$i}=Logro_Aprendizaje)
								QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=$al_idObjeto{$i})
								If (Not:C34($b_noEvaluados))
									
									  //cargo las evaluaciones
									QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
									QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1)
									QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1)
									
									If ($rnAlumno#-1)
										GOTO RECORD:C242([Alumnos:2];$rnAlumno)
										QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=[Alumnos:2]numero:1)
									End if 
									
									CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"logros")
									
									C_LONGINT:C283($l_Evaluados)
									$l_Evaluados:=0
									For ($x;1;Size of array:C274($at_indicadorEvaluacion))
										vQR_pointer1:=Get pointer:C304("al_seriedata_"+String:C10($x)+"_periodo_"+String:C10($l_indicePeriodo))
										USE SET:C118("logros")
										QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];$y_aprendizajeCampo->=$at_indicadorEvaluacion{$x})
										APPEND TO ARRAY:C911(vQR_pointer1->;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
										$l_Evaluados:=$l_Evaluados+Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
									End for 
									
									vQR_pointer1:=Get pointer:C304("al_seriedata_"+String:C10(Size of array:C274($at_indicadorEvaluacion)+1)+"_periodo_"+String:C10($l_indicePeriodo))
									APPEND TO ARRAY:C911(vQR_pointer1->;Size of array:C274($al_alumnosID)-$l_Evaluados)
									
								Else 
									C_LONGINT:C283($total)
									vQR_pointer1:=Get pointer:C304("al_seriedata_"+String:C10(Size of array:C274($at_indicadorEvaluacion)+1)+"_periodo_"+String:C10($l_indicePeriodo))
									If ($rnAlumno#-1)
										$total:=1
										APPEND TO ARRAY:C911(vQR_pointer1->;$total)
									Else 
										$total:=Size of array:C274($al_alumnosID)
										APPEND TO ARRAY:C911(vQR_pointer1->;$total)
									End if 
								End if 
						End case 
					End for 
				End for 
		End case 
		
		
		C_OBJECT:C1216($ob_raiz)
		
		  //datos alumnos
		OB SET ARRAY:C1227($ob_raiz;"rnAlumnos";$al_RecNumALumnos)
		OB SET ARRAY:C1227($ob_raiz;"nombreAlumnos";$at_alumnosNombres)
		
		  //periodos
		OB SET ARRAY:C1227($ob_raiz;"periodo";atSTR_Periodos_Nombre)
		OB SET:C1220($ob_raiz;"numero_periodo";$periodo)
		
		  //datos de niveles
		OB SET ARRAY:C1227($ob_raiz;"nombre_nivel";$at_nombreNivel)
		OB SET ARRAY:C1227($ob_raiz;"numero_nivel";$al_noNivel)
		
		  //cursos
		OB SET ARRAY:C1227($ob_raiz;"curso";$at_Curso)
		
		  //datos de asignaturas
		OB SET ARRAY:C1227($ob_raiz;"asignatura";$at_nombreAsignatura)
		OB SET ARRAY:C1227($ob_raiz;"numero_asignatura";$al_IdAsignatura)
		
		  //Envio datos del Mapa de aprendizaje
		OB SET ARRAY:C1227($ob_raiz;"glosa_mapa";$at_glosaMapa)
		OB SET ARRAY:C1227($ob_raiz;"tipo_mapa";$al_tipoObjeto)
		OB SET ARRAY:C1227($ob_raiz;"id_objeto";$al_idObjeto)
		
		  // datos de grafico (mapas)
		OB SET ARRAY:C1227($ob_raiz;"categoria";$at_serieLogros)
		OB SET ARRAY:C1227($ob_raiz;"Categoriaindicador";$at_indicadorGrafico)
		OB SET ARRAY:C1227($ob_raiz;"id_competencia";$al_idCompetencia)
		
		C_OBJECT:C1216($ob_serie;$o_color)
		
		For ($i;1;Size of array:C274($at_indicadorEvaluacion))
			$t_nombre:="serie_name"+String:C10($i)
			OB SET:C1220($ob_serie;$t_nombre;$at_indicadorEvaluacion{$i})
			OB SET:C1220($o_color;"color_"+String:C10($i);$at_coloresHexa{$i})
		End for 
		$t_nombre:="serie_name"+String:C10((Size of array:C274($at_indicadorEvaluacion)+1))
		OB SET:C1220($ob_serie;$t_nombre;"No evaluado")
		OB SET:C1220($o_color;"color_"+String:C10((Size of array:C274($at_indicadorEvaluacion)+1));"#c7ccc8")
		OB SET:C1220($ob_raiz;"serie";$ob_serie)
		OB SET:C1220($ob_raiz;"color";$o_color)
		
		If (Not:C34($b_comparado))
			C_LONGINT:C283($l_hasta)
			C_POINTER:C301(vQR_pointer2)
			
			If (Size of array:C274($at_indicadorEvaluacion)>0)
				$l_hasta:=Size of array:C274($at_indicadorEvaluacion)+1
				C_OBJECT:C1216($ob_data)
				
				For ($i;1;$l_hasta)
					vQR_pointer2:=Get pointer:C304("al_seriedata_"+String:C10($i))
					If (Not:C34(Is nil pointer:C315(vQR_pointer2)) & (Not:C34(Undefined:C82(vQR_pointer2->))))
						$t_nombreData:="serie_data"+String:C10($i)
						OB SET ARRAY:C1227($ob_data;$t_nombreData;vQR_pointer2->)
					Else 
						$t_nombreData:="serie_data"+String:C10($i)
						OB SET:C1220($ob_data;$t_nombreData;0)
					End if 
				End for 
				OB SET:C1220($ob_raiz;"data";$ob_data)
			End if 
			
		Else 
			C_LONGINT:C283($l_hasta)
			C_POINTER:C301(vQR_pointer2)
			
			If (Size of array:C274($at_indicadorEvaluacion)>0)
				$l_hasta:=Size of array:C274($at_indicadorEvaluacion)+1
				C_OBJECT:C1216($ob_data)
				
				For ($l_indicePeriodo;1;Size of array:C274(atSTR_Periodos_Nombre))
					For ($i;1;$l_hasta)
						vQR_pointer2:=Get pointer:C304("al_seriedata_"+String:C10($i)+"_periodo_"+String:C10($l_indicePeriodo))
						If (Not:C34(Is nil pointer:C315(vQR_pointer2)) & (Not:C34(Undefined:C82(vQR_pointer2->))))
							$t_nombreData:=String:C10($l_indicePeriodo)+"_serie_data"+String:C10($i)+"_periodo_"+String:C10($l_indicePeriodo)
							OB SET ARRAY:C1227($ob_data;$t_nombreData;vQR_pointer2->)
						Else 
							$t_nombreData:=String:C10($l_indicePeriodo)+"_serie_data"+String:C10($i)+"_periodo_"+String:C10($l_indicePeriodo)
							OB SET:C1220($ob_data;$t_nombreData;0)
						End if 
					End for 
				End for 
				OB SET:C1220($ob_raiz;"data";$ob_data)
			End if 
			
		End if 
		$o_nodo:=STWA2_Dash_PrefGrafAprendizajes ("LeePreferencia";$parameterNames;$parameterValues)
		OB SET:C1220($ob_raiz;"sepDecimal";<>tXS_RS_DecimalSeparator)
		OB SET:C1220($ob_raiz;"sepMiles";<>tXS_RS_ThousandsSeparator)
		OB SET:C1220($ob_raiz;"preferencia";$o_nodo)
		$json:=JSON Stringify:C1217($ob_raiz)
		$0:=$json
		
	: ($action="cargaAsignatura")
		$curso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso")
		$l_nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$curso;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=$l_nivel)
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_asignatura;[Asignaturas:18]Numero:1;$al_iDasignatura)
		C_OBJECT:C1216($ob_raiz)
		
		OB SET ARRAY:C1227($ob_raiz;"asignatura";$at_asignatura)
		OB SET ARRAY:C1227($ob_raiz;"numero_asignatura";$al_iDasignatura)
		$json:=JSON Stringify:C1217($ob_raiz)
		$0:=$json
		
	: ($action="cargaDatosNivel")
		$l_nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		PERIODOS_LoadData ($l_nivel)  //MONO TICKET 185582
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel)
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Curso:5;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Curso:5;$at_curso)
		
		For ($l_indice;Size of array:C274($at_Curso);2;-1)
			If ($at_Curso{$l_indice}=$at_Curso{$l_indice-1})
				DELETE FROM ARRAY:C228($at_Curso;$l_indice)
			End if 
		End for 
		
		  //cargo las asignaturas del primer curso
		If (Size of array:C274($at_Curso)>0)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$at_curso{1};*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=$l_nivel)
		End if 
		
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_asignatura;[Asignaturas:18]Numero:1;$al_iDasignatura)
		
		C_OBJECT:C1216($ob_raiz)
		
		OB SET ARRAY:C1227($ob_raiz;"curso";$at_curso)
		OB SET ARRAY:C1227($ob_raiz;"asignatura";$at_asignatura)
		OB SET ARRAY:C1227($ob_raiz;"numero_asignatura";$al_iDasignatura)
		OB SET ARRAY:C1227($ob_raiz;"periodo";atSTR_Periodos_Nombre)  //MONO TICKET 185582
		OB SET ARRAY:C1227($ob_raiz;"num_periodo";aiSTR_Periodos_Numero)  //MONO TICKET 185582
		$json:=JSON Stringify:C1217($ob_raiz)
		$0:=$json
		
	: ($action="cargaAlumnosGrafico")
		
		$l_rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"rnAsig"))
		$idAsignatura:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"idasignatura"))
		$curso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"periodo"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$id_competencia:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"id_competencia"))
		$indicador:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"indicador")
		
		If ($idAsignatura=0)
			GOTO RECORD:C242([Asignaturas:18];$l_rnAsig)
			$idAsignatura:=[Asignaturas:18]Numero:1
		End if 
		
		Case of 
			: ($periodo=1)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
			: ($periodo=2)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
			: ($periodo=3)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
			: ($periodo=4)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
			: ($periodo=5)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
		End case 
		
		If ($indicador="No evaluado")
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$id_competencia)
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$idAsignatura)
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];$y_aprendizajeCampo->="")
		Else 
			QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=$id_competencia)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$id_competencia)
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$idAsignatura)
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];$y_aprendizajeCampo->=$indicador)
		End if 
		
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;"")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_idAlumno;[Alumnos:2]apellidos_y_nombres:40;$at_alumnosNombre)
		
		C_OBJECT:C1216($ob_raiz)
		
		OB SET ARRAY:C1227($ob_raiz;"numero_alumnos";$al_idAlumno)
		OB SET ARRAY:C1227($ob_raiz;"nombre_alumnos";$at_alumnosNombre)
		$json:=JSON Stringify:C1217($ob_raiz)
		$0:=$json
		
	: ($action="initMapaNiveles")
		C_POINTER:C301($y_aprendizajeCampo)
		
		ARRAY LONGINT:C221($al_noNivel;0)
		ARRAY TEXT:C222($at_NivelNombre;0)
		ARRAY TEXT:C222($at_cursos;0)
		ARRAY TEXT:C222($at_simbolo;0)
		ARRAY LONGINT:C221($al_IDAsignaturas;0)
		ARRAY LONGINT:C221($al_IdAlumnos;0)
		ARRAY LONGINT:C221($al_idCompetencia;0)
		ARRAY LONGINT:C221($al_numEstiloEval;0)
		ARRAY OBJECT:C1221($ao_objetoDatos;0)
		C_LONGINT:C283($i;$aluIndice;$l_noEvaluado)
		
		$l_idAsignatura:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"id_asignatura"))
		$t_curso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso")
		$l_periodo:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"periodo"))
		$t_nivel:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel")
		$t_ubicacion:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"ubicacion")
		
		  //cargo el numero de nivel 
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]Nivel:1=$t_nivel)
		$l_nivel:=[xxSTR_Niveles:6]NoNivel:5
		If ($l_nivel=0)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_curso)
			$l_nivel:=[Asignaturas:18]Numero_del_Nivel:6
		End if 
		
		Case of 
			: ($l_periodo=1)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
			: ($l_periodo=2)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
			: ($l_periodo=3)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
			: ($l_periodo=4)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
			: ($l_periodo=5)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
			Else 
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
		End case 
		
		Case of 
			: ($t_ubicacion="init")
				
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
				ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
				SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_nivelesNumero;[xxSTR_Niveles:6]Nivel:1;$at_NivelNombre)
				KRL_RelateSelection (->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]NoNivel:5;"")
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
				
				While (Not:C34(End selection:C36([Asignaturas:18])))
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
					KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
					KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
					AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$al_numEstiloEval)
					
					For ($l_estiloIndice;1;Size of array:C274($al_numEstiloEval))
						$l_numeroEstilo:=Choose:C955($al_numEstiloEval{$l_estiloIndice}=0;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_numEstiloEval{$l_estiloIndice})
						EVS_ReadStyleData ($l_numeroEstilo)
						SORT ARRAY:C229(aSymbDesc;aSymbol;aSTWAColorRGB;aSTWAColorHexa;<)
						For ($indicestilo;1;Size of array:C274(aSymbDesc))
							If (Find in array:C230($at_simbolo;aSymbDesc{$indicestilo})=-1)
								APPEND TO ARRAY:C911($at_simbolo;aSymbDesc{$indicestilo})
								APPEND TO ARRAY:C911($at_coloresHexa;aSTWAColorHexa{$indicestilo})
							End if 
						End for 
					End for 
					NEXT RECORD:C51([Asignaturas:18])
				End while 
				
				$l_posNoEvaluado:=Find in array:C230($at_simbolo;"No evaluado")
				If ($l_posNoEvaluado=-1)
					AT_Insert (0;1;->$at_simbolo;->$at_coloresHexa)
					$at_simbolo{Size of array:C274($at_simbolo)}:="No evaluado"
					$at_coloresHexa{Size of array:C274($at_coloresHexa)}:="#c7ccc8"
					$l_posNoEvaluado:=Size of array:C274($at_coloresHexa)
				End if 
				
				
				For ($l_indiceNivel;1;Size of array:C274($al_nivelesNumero))
					ARRAY LONGINT:C221($al_simboloEvaluacion;0)
					ARRAY LONGINT:C221($al_simboloEvaluacion;Size of array:C274($at_simbolo))
					
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$al_nivelesNumero{$l_indiceNivel};*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)  //MONO
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
					KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
					SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IDAsignaturas)
					
					For ($i;1;Size of array:C274($al_IDAsignaturas))
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_IDAsignaturas{$i})
						QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
						QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
						QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
						
						KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
						KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
						SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]ID:1;$al_idCompetencia)
						
						QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos)
						
						For ($aluIndice;1;Size of array:C274($al_IdAlumnos))
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$al_IdAlumnos{$aluIndice};*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1)
							If (Size of array:C274($al_idCompetencia)>Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
								$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+Size of array:C274($al_idCompetencia)-Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
							Else 
								While (Not:C34(End selection:C36([Alumnos_EvaluacionAprendizajes:203])))
									$l_pos:=Find in array:C230($at_simbolo;$y_aprendizajeCampo->)
									If ($l_pos#-1)
										$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
									Else 
										If ($y_aprendizajeCampo->="")
											$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+1
										Else 
											$t_Simbolos:=EV2_Real_a_Simbolo ($y_aprendizajeReal->)
											$l_pos:=Find in array:C230(aSymbol;$t_Simbolos)
											If ($l_pos#-1)
												$l_pos:=Find in array:C230($at_simbolo;aSymbDesc{$l_pos})
												If ($l_pos#-1)
													$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
												End if 
											End if 
											
										End if 
									End if 
									NEXT RECORD:C51([Alumnos_EvaluacionAprendizajes:203])
								End while 
								
							End if 
						End for 
					End for 
					
					  //guardo la información de los cursos en un objeto
					C_OBJECT:C1216($ob_nivel)
					$t_nivel:=$at_NivelNombre{$l_indiceNivel}
					OB SET:C1220($ob_nivel;$t_nivel;$t_nivel)
					OB SET ARRAY:C1227($ob_nivel;"simbolos";$at_simbolo)
					OB SET ARRAY:C1227($ob_nivel;"evaluacion";$al_simboloEvaluacion)
					APPEND TO ARRAY:C911($ao_objetoDatos;$ob_nivel)
					CLEAR VARIABLE:C89($ob_nivel)
				End for 
				
				  //creo json con las series correspondientes para entregar al gráfico
				PERIODOS_LoadData ($l_periodo)
				ARRAY OBJECT:C1221($ao_series;0)
				C_OBJECT:C1216($ob_grafico;$ob_serie)
				
				OB SET ARRAY:C1227($ob_grafico;"categories";$at_NivelNombre)
				OB SET ARRAY:C1227($ob_grafico;"periodo";atSTR_Periodos_Nombre)
				OB SET ARRAY:C1227($ob_grafico;"numero_nivel";$al_nivelesNumero)
				OB SET ARRAY:C1227($ob_grafico;"nombre_nivel";$at_NivelNombre)
				OB SET:C1220($ob_grafico;"tipo_pagina";"init")
				OB SET:C1220($ob_grafico;"categoria_seleccionada";"init")
				
				
				For ($i;1;Size of array:C274($at_simbolo))
					ARRAY LONGINT:C221($al_datosSerie;0)
					
					OB SET:C1220($ob_serie;"name";$at_simbolo{$i})
					
					For ($x;1;Size of array:C274($ao_objetoDatos))
						ARRAY TEXT:C222($at_arraySimbolos;0)
						ARRAY LONGINT:C221($at_arrayevaluacion;0)
						
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"simbolos";$at_arraySimbolos)
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"evaluacion";$at_arrayevaluacion)
						
						$l_pos:=Find in array:C230($at_arraySimbolos;$at_simbolo{$i})
						$l_cantidad:=$at_arrayevaluacion{$l_pos}
						APPEND TO ARRAY:C911($al_datosSerie;$l_cantidad)
					End for 
					
					OB SET:C1220($ob_serie;"color";$at_coloresHexa{$i})
					OB SET ARRAY:C1227($ob_serie;"data";$al_datosSerie)
					APPEND TO ARRAY:C911($ao_series;$ob_serie)
					CLEAR VARIABLE:C89($ob_serie)
				End for 
				$o_nodo:=STWA2_Dash_PrefGrafAprendizajes ("LeePreferencia";$parameterNames;$parameterValues)
				OB SET ARRAY:C1227($ob_grafico;"series";$ao_series)
				OB SET:C1220($ob_grafico;"sepDecimal";<>tXS_RS_DecimalSeparator)
				OB SET:C1220($ob_grafico;"sepMiles";<>tXS_RS_ThousandsSeparator)
				OB SET:C1220($ob_grafico;"preferencia";$o_nodo)
				
			: ($t_ubicacion="pornivel")
				
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
				ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
				SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_nivelesNumero;[xxSTR_Niveles:6]Nivel:1;$at_NivelNombre)
				
				  //busco todas las cursos segun el nivel solicitado
				If ($l_nivel#-1)
					QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$l_nivel)
				Else 
					QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$al_nivelesNumero{1})
				End if 
				QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  //20160621 ASM Ticket 209357
				ORDER BY:C49([Cursos:3];[Cursos:3]Curso:1;>;[Cursos:3]Nivel_Numero:7;>)
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursos)
				
				  //cargo todos los estilos de evaluación del nivel y los simbolos
				QUERY WITH ARRAY:C644([Alumnos:2]curso:20;$at_cursos)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  //MONO
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
				KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
				
				While (Not:C34(End selection:C36([Asignaturas:18])))
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
					KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
					KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
					AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$al_numEstiloEval)
					
					For ($l_estiloIndice;1;Size of array:C274($al_numEstiloEval))
						$l_numeroEstilo:=Choose:C955($al_numEstiloEval{$l_estiloIndice}=0;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_numEstiloEval{$l_estiloIndice})
						EVS_ReadStyleData ($l_numeroEstilo)
						SORT ARRAY:C229(aSymbDesc;aSymbol;aSTWAColorRGB;aSTWAColorHexa;<)
						For ($indicestilo;1;Size of array:C274(aSymbDesc))
							If (Find in array:C230($at_simbolo;aSymbDesc{$indicestilo})=-1)
								APPEND TO ARRAY:C911($at_simbolo;aSymbDesc{$indicestilo})
								APPEND TO ARRAY:C911($at_coloresHexa;aSTWAColorHexa{$indicestilo})
							End if 
						End for 
					End for 
					NEXT RECORD:C51([Asignaturas:18])
				End while 
				
				$l_posNoEvaluado:=Find in array:C230($at_simbolo;"No evaluado")
				If ($l_posNoEvaluado=-1)
					AT_Insert (0;1;->$at_simbolo;->$at_coloresHexa)
					$at_simbolo{Size of array:C274($at_simbolo)}:="No evaluado"
					$at_coloresHexa{Size of array:C274($at_coloresHexa)}:="#c7ccc8"
					$l_posNoEvaluado:=Size of array:C274($at_coloresHexa)
				End if 
				
				For ($l_indiceCursos;1;Size of array:C274($at_cursos))
					
					ARRAY LONGINT:C221($al_simboloEvaluacion;0)
					ARRAY LONGINT:C221($al_simboloEvaluacion;Size of array:C274($at_simbolo))
					
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$at_cursos{$l_indiceCursos};*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)  //MONO
					
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
					KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
					
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
					SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IDAsignaturas)
					
					For ($i;1;Size of array:C274($al_IDAsignaturas))
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_IDAsignaturas{$i})
						QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
						QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
						QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
						
						KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
						KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
						SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]ID:1;$al_idCompetencia)
						
						QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos)
						
						For ($aluIndice;1;Size of array:C274($al_IdAlumnos))
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$al_IdAlumnos{$aluIndice};*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1)
							If (Size of array:C274($al_idCompetencia)>Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
								$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+Size of array:C274($al_idCompetencia)-Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
							Else 
								While (Not:C34(End selection:C36([Alumnos_EvaluacionAprendizajes:203])))
									$l_pos:=Find in array:C230($at_simbolo;$y_aprendizajeCampo->)
									If ($l_pos#-1)
										$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
									Else 
										If ($y_aprendizajeCampo->="")
											$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+1
										Else 
											$t_Simbolos:=EV2_Real_a_Simbolo ($y_aprendizajeReal->)
											$l_pos:=Find in array:C230(aSymbol;$t_Simbolos)
											If ($l_pos#-1)
												$l_pos:=Find in array:C230($at_simbolo;aSymbDesc{$l_pos})
												If ($l_pos#-1)
													$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
												End if 
											End if 
											
										End if 
									End if 
									NEXT RECORD:C51([Alumnos_EvaluacionAprendizajes:203])
								End while 
								
							End if 
						End for 
					End for 
					
					  //guardo la información de los cursos en un objeto
					C_OBJECT:C1216($ob_curso)
					$t_curso:=$at_cursos{$l_indiceCursos}
					
					OB SET:C1220($ob_curso;$t_curso;$t_curso)
					OB SET ARRAY:C1227($ob_curso;"simbolos";$at_simbolo)
					OB SET ARRAY:C1227($ob_curso;"evaluacion";$al_simboloEvaluacion)
					APPEND TO ARRAY:C911($ao_objetoDatos;$ob_curso)
					CLEAR VARIABLE:C89($ob_curso)
				End for 
				
				
				  //creo json con las series correspondientes para entregar al gráfico
				PERIODOS_LoadData ($l_periodo)
				ARRAY OBJECT:C1221($ao_series;0)
				C_OBJECT:C1216($ob_grafico;$ob_serie)
				
				OB SET ARRAY:C1227($ob_grafico;"categories";$at_Cursos)
				OB SET ARRAY:C1227($ob_grafico;"periodo";atSTR_Periodos_Nombre)
				OB SET ARRAY:C1227($ob_grafico;"numero_nivel";$al_nivelesNumero)
				OB SET ARRAY:C1227($ob_grafico;"nombre_nivel";$at_NivelNombre)
				OB SET:C1220($ob_grafico;"tipo_pagina";"pornivel")
				OB SET:C1220($ob_grafico;"titulo";"Nivel: "+$t_nivel)
				OB SET:C1220($ob_grafico;"categoria_seleccionada";$t_nivel)
				
				For ($i;1;Size of array:C274($at_simbolo))
					ARRAY LONGINT:C221($al_datosSerie;0)
					
					OB SET:C1220($ob_serie;"name";$at_simbolo{$i})
					
					For ($x;1;Size of array:C274($ao_objetoDatos))
						ARRAY TEXT:C222($at_arraySimbolos;0)
						ARRAY LONGINT:C221($at_arrayevaluacion;0)
						
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"simbolos";$at_arraySimbolos)
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"evaluacion";$at_arrayevaluacion)
						
						$l_pos:=Find in array:C230($at_arraySimbolos;$at_simbolo{$i})
						$l_cantidad:=$at_arrayevaluacion{$l_pos}
						APPEND TO ARRAY:C911($al_datosSerie;$l_cantidad)
					End for 
					
					OB SET:C1220($ob_serie;"color";$at_coloresHexa{$i})
					OB SET ARRAY:C1227($ob_serie;"data";$al_datosSerie)
					APPEND TO ARRAY:C911($ao_series;$ob_serie)
					CLEAR VARIABLE:C89($ob_serie)
				End for 
				OB SET ARRAY:C1227($ob_grafico;"series";$ao_series)
				
			: ($t_ubicacion="porcurso")
				
				  //cargo todos los estilos de evaluación del nivel y los simbolos
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_curso;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)  //MONO
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
				KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
				
				SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IDAsignaturas;[Asignaturas:18]Asignatura:3;$at_asignaturasNombre)
				LOAD RECORD:C52([Asignaturas:18])
				
				While (Not:C34(End selection:C36([Asignaturas:18])))
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
					KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
					KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
					AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$al_numEstiloEval)
					
					For ($l_estiloIndice;1;Size of array:C274($al_numEstiloEval))
						$l_numeroEstilo:=Choose:C955($al_numEstiloEval{$l_estiloIndice}=0;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_numEstiloEval{$l_estiloIndice})
						EVS_ReadStyleData ($l_numeroEstilo)
						SORT ARRAY:C229(aSymbDesc;aSymbol;aSTWAColorRGB;aSTWAColorHexa;<)
						For ($indicestilo;1;Size of array:C274(aSymbDesc))
							If (Find in array:C230($at_simbolo;aSymbDesc{$indicestilo})=-1)
								APPEND TO ARRAY:C911($at_simbolo;aSymbDesc{$indicestilo})
								APPEND TO ARRAY:C911($at_coloresHexa;aSTWAColorHexa{$indicestilo})
							End if 
						End for 
					End for 
					NEXT RECORD:C51([Asignaturas:18])
				End while 
				
				$l_posNoEvaluado:=Find in array:C230($at_simbolo;"No evaluado")
				If ($l_posNoEvaluado=-1)
					AT_Insert (0;1;->$at_simbolo;->$at_coloresHexa)
					$at_simbolo{Size of array:C274($at_simbolo)}:="No evaluado"
					$at_coloresHexa{Size of array:C274($at_coloresHexa)}:="#c7ccc8"
					$l_posNoEvaluado:=Size of array:C274($at_coloresHexa)
				End if 
				
				For ($i;1;Size of array:C274($al_IDAsignaturas))
					
					ARRAY LONGINT:C221($al_simboloEvaluacion;0)
					ARRAY LONGINT:C221($al_simboloEvaluacion;Size of array:C274($at_simbolo))
					
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_IDAsignaturas{$i})
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
					
					KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
					KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
					SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]ID:1;$al_idCompetencia)
					
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos)
					
					For ($aluIndice;1;Size of array:C274($al_IdAlumnos))
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$al_IdAlumnos{$aluIndice};*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1)
						If (Size of array:C274($al_idCompetencia)>Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
							$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+Size of array:C274($al_idCompetencia)-Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
						Else 
							While (Not:C34(End selection:C36([Alumnos_EvaluacionAprendizajes:203])))
								$l_pos:=Find in array:C230($at_simbolo;$y_aprendizajeCampo->)
								If ($l_pos#-1)
									$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
								Else 
									If ($y_aprendizajeCampo->="")
										$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+1
									Else 
										$t_Simbolos:=EV2_Real_a_Simbolo ($y_aprendizajeReal->)
										$l_pos:=Find in array:C230(aSymbol;$t_Simbolos)
										If ($l_pos#-1)
											$l_pos:=Find in array:C230($at_simbolo;aSymbDesc{$l_pos})
											If ($l_pos#-1)
												$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
											End if 
										End if 
									End if 
								End if 
								NEXT RECORD:C51([Alumnos_EvaluacionAprendizajes:203])
							End while 
							
						End if 
					End for 
					
					  //guardo la información de los cursos en un objeto
					C_OBJECT:C1216($ob_curso)
					$t_asignatura:=$at_asignaturasNombre{$i}
					OB SET:C1220($ob_curso;$t_asignatura;$t_asignatura)
					OB SET ARRAY:C1227($ob_curso;"simbolos";$at_simbolo)
					OB SET ARRAY:C1227($ob_curso;"evaluacion";$al_simboloEvaluacion)
					APPEND TO ARRAY:C911($ao_objetoDatos;$ob_curso)
					CLEAR VARIABLE:C89($ob_curso)
				End for 
				
				  //creo json con las series correspondientes para entregar al gráfico
				PERIODOS_LoadData ($l_periodo)
				ARRAY OBJECT:C1221($ao_series;0)
				C_OBJECT:C1216($ob_grafico;$ob_serie)
				
				OB SET ARRAY:C1227($ob_grafico;"categories";$at_asignaturasNombre)
				OB SET ARRAY:C1227($ob_grafico;"idasignaturas";$al_IDAsignaturas)
				OB SET ARRAY:C1227($ob_grafico;"periodo";atSTR_Periodos_Nombre)
				OB SET:C1220($ob_grafico;"tipo_pagina";"porcurso")
				OB SET:C1220($ob_grafico;"titulo";"Curso: "+$t_curso)
				OB SET:C1220($ob_grafico;"curso";$t_curso)
				OB SET:C1220($ob_grafico;"categoria_seleccionada";$t_curso)
				For ($i;1;Size of array:C274($at_simbolo))
					ARRAY LONGINT:C221($al_datosSerie;0)
					
					OB SET:C1220($ob_serie;"name";$at_simbolo{$i})
					
					For ($x;1;Size of array:C274($ao_objetoDatos))
						ARRAY TEXT:C222($at_arraySimbolos;0)
						ARRAY LONGINT:C221($at_arrayevaluacion;0)
						
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"simbolos";$at_arraySimbolos)
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"evaluacion";$at_arrayevaluacion)
						
						$l_pos:=Find in array:C230($at_arraySimbolos;$at_simbolo{$i})
						$l_cantidad:=$at_arrayevaluacion{$l_pos}
						APPEND TO ARRAY:C911($al_datosSerie;$l_cantidad)
					End for 
					
					OB SET:C1220($ob_serie;"color";$at_coloresHexa{$i})
					OB SET ARRAY:C1227($ob_serie;"data";$al_datosSerie)
					APPEND TO ARRAY:C911($ao_series;$ob_serie)
					CLEAR VARIABLE:C89($ob_serie)
				End for 
				OB SET ARRAY:C1227($ob_grafico;"series";$ao_series)
				
			: ($t_ubicacion="porasignatura")
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idAsignatura)
				$t_asignatura:=[Asignaturas:18]Asignatura:3
				QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
				KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
				KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
				AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$al_numEstiloEval)
				
				For ($l_estiloIndice;1;Size of array:C274($al_numEstiloEval))
					$l_numeroEstilo:=Choose:C955($al_numEstiloEval{$l_estiloIndice}=0;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_numEstiloEval{$l_estiloIndice})
					EVS_ReadStyleData ($l_numeroEstilo)
					SORT ARRAY:C229(aSymbDesc;aSymbol;aSTWAColorRGB;aSTWAColorHexa;<)
					For ($indicestilo;1;Size of array:C274(aSymbDesc))
						If (Find in array:C230($at_simbolo;aSymbDesc{$indicestilo})=-1)
							APPEND TO ARRAY:C911($at_simbolo;aSymbDesc{$indicestilo})
							APPEND TO ARRAY:C911($at_coloresHexa;aSTWAColorHexa{$indicestilo})
						End if 
					End for 
				End for 
				
				$l_posNoEvaluado:=Find in array:C230($at_simbolo;"No evaluado")
				If ($l_posNoEvaluado=-1)
					AT_Insert (0;1;->$at_simbolo;->$at_coloresHexa)
					$at_simbolo{Size of array:C274($at_simbolo)}:="No evaluado"
					$at_coloresHexa{Size of array:C274($at_coloresHexa)}:="#c7ccc8"
					$l_posNoEvaluado:=Size of array:C274($at_coloresHexa)
				End if 
				
				ARRAY TEXT:C222($at_alumnosNombre;0)
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idAsignatura)
				QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
				
				KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
				KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
				SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]ID:1;$al_idCompetencia)
				
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				SET AUTOMATIC RELATIONS:C310(True:C214;True:C214)
				ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnos)
				
				For ($aluIndice;1;Size of array:C274($al_IdAlumnos))
					ARRAY LONGINT:C221($al_simboloEvaluacion;0)
					ARRAY LONGINT:C221($al_simboloEvaluacion;Size of array:C274($at_simbolo))
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_IdAlumnos{$aluIndice})
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$al_IdAlumnos{$aluIndice};*)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1)
					If (Size of array:C274($al_idCompetencia)>Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
						$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+Size of array:C274($al_idCompetencia)-Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
					Else 
						While (Not:C34(End selection:C36([Alumnos_EvaluacionAprendizajes:203])))
							$l_pos:=Find in array:C230($at_simbolo;$y_aprendizajeCampo->)
							If ($l_pos#-1)
								$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
							Else 
								If ($y_aprendizajeCampo->="")
									$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+1
								Else 
									$t_Simbolos:=EV2_Real_a_Simbolo ($y_aprendizajeReal->)
									$l_pos:=Find in array:C230(aSymbol;$t_Simbolos)
									$l_pos:=Find in array:C230($at_simbolo;aSymbDesc{$l_pos})
									$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
								End if 
							End if 
							NEXT RECORD:C51([Alumnos_EvaluacionAprendizajes:203])
						End while 
					End if 
					APPEND TO ARRAY:C911($at_alumnosNombre;[Alumnos:2]apellidos_y_nombres:40)
					
					  //guardo la información de los cursos en un objeto
					C_OBJECT:C1216($ob_alumnos)
					$t_alumno:=[Alumnos:2]apellidos_y_nombres:40
					
					OB SET:C1220($ob_alumnos;$t_alumno;$t_alumno)
					OB SET ARRAY:C1227($ob_alumnos;"simbolos";$at_simbolo)
					OB SET ARRAY:C1227($ob_alumnos;"evaluacion";$al_simboloEvaluacion)
					APPEND TO ARRAY:C911($ao_objetoDatos;$ob_alumnos)
					CLEAR VARIABLE:C89($ob_alumnos)
					
				End for 
				
				
				
				  //creo json con las series correspondientes para entregar al gráfico
				PERIODOS_LoadData ($l_periodo)
				ARRAY OBJECT:C1221($ao_series;0)
				C_OBJECT:C1216($ob_grafico;$ob_serie)
				OB SET ARRAY:C1227($ob_grafico;"categories";$at_alumnosNombre)
				OB SET:C1220($ob_grafico;"tipo_pagina";"porasignatura")
				OB SET:C1220($ob_grafico;"titulo";"Asignatura: "+$t_asignatura)
				OB SET:C1220($ob_grafico;"categoria_seleccionada";$t_asignatura)
				For ($i;1;Size of array:C274($at_simbolo))
					ARRAY LONGINT:C221($al_datosSerie;0)
					
					OB SET:C1220($ob_serie;"name";$at_simbolo{$i})
					
					For ($x;1;Size of array:C274($ao_objetoDatos))
						ARRAY TEXT:C222($at_arraySimbolos;0)
						ARRAY LONGINT:C221($at_arrayevaluacion;0)
						
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"simbolos";$at_arraySimbolos)
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"evaluacion";$at_arrayevaluacion)
						
						$l_pos:=Find in array:C230($at_arraySimbolos;$at_simbolo{$i})
						$l_cantidad:=$at_arrayevaluacion{$l_pos}
						APPEND TO ARRAY:C911($al_datosSerie;$l_cantidad)
					End for 
					
					OB SET:C1220($ob_serie;"color";$at_coloresHexa{$i})
					OB SET ARRAY:C1227($ob_serie;"data";$al_datosSerie)
					APPEND TO ARRAY:C911($ao_series;$ob_serie)
					CLEAR VARIABLE:C89($ob_serie)
				End for 
				OB SET ARRAY:C1227($ob_grafico;"series";$ao_series)
		End case 
		$json:=JSON Stringify:C1217($ob_grafico)
		$0:=$json
		
		
		
	: ($action="grafico_alumno")
		$t_ubicacion:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"ubicacion")
		$t_curso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso")
		$l_periodo:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"periodo"))
		$l_nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$t_alumno:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"alumno")
		$l_idAlumno:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"idalumno"))
		
		ARRAY TEXT:C222($at_simbolo;0)
		ARRAY TEXT:C222($at_cursoGrupo;0)
		ARRAY TEXT:C222($at_NivelCursoGrupo;0)
		ARRAY LONGINT:C221($al_numeroNivelCursoGrupo;0)
		ARRAY LONGINT:C221($al_idCompetencia;0)
		
		Case of 
			: ($l_periodo=1)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
			: ($l_periodo=2)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
			: ($l_periodo=3)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
			: ($l_periodo=4)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
			: ($l_periodo=5)
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
			Else 
				$y_aprendizajeCampo:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
				$y_aprendizajeReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
		End case 
		
		
		  //cargo los filtros
		
		C_OBJECT:C1216($ob_niveles;$ob_cursos)
		C_LONGINT:C283($l_nivelActivo)
		C_TEXT:C284($t_cursoActivo)
		
		
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_numeroNivelCursoGrupo)
		
		For ($i;1;Size of array:C274($al_numeroNivelCursoGrupo))
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$al_numeroNivelCursoGrupo{$i})
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$al_numeroNivelCursoGrupo{$i})
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
			$t_nombreNivel:=[xxSTR_Niveles:6]Nivel:1
			If (Records in selection:C76([Asignaturas:18])>0)
				AT_DistinctsFieldValues (->[Asignaturas:18]Curso:5;->$at_cursoGrupo)
				SORT ARRAY:C229($at_cursoGrupo;>)
				OB SET ARRAY:C1227($ob_cursos;"cursos";$at_cursoGrupo)
				OB SET:C1220($ob_cursos;"nivel";$al_numeroNivelCursoGrupo{$i})
				OB SET:C1220($ob_cursos;"nivel_nombre";$t_nombreNivel)
				OB SET:C1220($ob_niveles;String:C10($al_numeroNivelCursoGrupo{$i});$ob_cursos)
				CLEAR VARIABLE:C89($ob_cursos)
			End if 
		End for 
		
		
		Case of 
			: ($t_ubicacion="init")
				
				  //20180621 ASM Ticket 209358
				If (($l_nivel=0) & ($t_curso=""))
					ARRAY TEXT:C222($t_cursosTemporal;0)
					ARRAY TEXT:C222($at_nombreAtributos;0)
					C_OBJECT:C1216($o_temporal)
					OB GET PROPERTY NAMES:C1232($ob_niveles;$at_nombreAtributos)
					If (Size of array:C274($at_nombreAtributos)>0)
						$o_temporal:=OB Get:C1224($ob_niveles;$at_nombreAtributos{1})
						OB GET ARRAY:C1229($o_temporal;"cursos";$t_cursosTemporal)
						$l_nivel:=OB Get:C1224($o_temporal;"nivel")
						$t_curso:=$t_cursosTemporal{1}
						$l_nivelSeleccionado:=$l_nivel
						$t_cursoGrupo:=$t_curso
					Else 
						$l_nivel:=$al_numeroNivelCursoGrupo{1}
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel)
						$t_curso:=[Asignaturas:18]Curso:5
					End if 
				End if 
				
				
				If ($l_nivel=0)
					$l_nivelSeleccionado:=$l_nivelActivo
				Else 
					$l_nivelSeleccionado:=$l_nivel
				End if 
				
				If ($t_curso="")
					$t_cursoGrupo:=$t_cursoActivo
				Else 
					$t_cursoGrupo:=$t_curso
				End if 
				
				  //guardo el nombre del nivel seleccionado
				$t_nivelNombre:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelSeleccionado;->[xxSTR_Niveles:6]Nivel:1)
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_cursoGrupo;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=$l_nivelSeleccionado)
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  //MONO
				  //ORDER BY([Alumnos];[Alumnos]No_de_lista;>)
				ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
				SELECTION TO ARRAY:C260([Alumnos:2];$al_recNumAlumno;[Alumnos:2]numero:1;$al_IdAlumnos;[Alumnos:2]apellidos_y_nombres:40;$at_nombreAlumnos)
				
				  //caego los simbolos según el estilo de evaluación configurado en las competencias.
				While (Not:C34(End selection:C36([Asignaturas:18])))
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
					KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
					KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
					AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$al_numEstiloEval)
					
					For ($l_estiloIndice;1;Size of array:C274($al_numEstiloEval))
						$l_numeroEstilo:=Choose:C955($al_numEstiloEval{$l_estiloIndice}=0;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_numEstiloEval{$l_estiloIndice})
						EVS_ReadStyleData ($l_numeroEstilo)
						SORT ARRAY:C229(aSymbDesc;aSymbol;aSTWAColorRGB;aSTWAColorHexa;<)
						For ($indicestilo;1;Size of array:C274(aSymbDesc))
							If (Find in array:C230($at_simbolo;aSymbDesc{$indicestilo})=-1)
								APPEND TO ARRAY:C911($at_simbolo;aSymbDesc{$indicestilo})
								APPEND TO ARRAY:C911($at_coloresHexa;aSTWAColorHexa{$indicestilo})
							End if 
						End for 
					End for 
					NEXT RECORD:C51([Asignaturas:18])
				End while 
				
				$l_posNoEvaluado:=Find in array:C230($at_simbolo;"No evaluado")
				If ($l_posNoEvaluado=-1)
					AT_Insert (0;1;->$at_simbolo;->$at_coloresHexa)
					$at_simbolo{Size of array:C274($at_simbolo)}:="No evaluado"
					$at_coloresHexa{Size of array:C274($at_coloresHexa)}:="#c7ccc8"
					$l_posNoEvaluado:=Size of array:C274($at_coloresHexa)
				End if 
				
				
				For ($aluIndice;1;Size of array:C274($al_IdAlumnos))
					ARRAY LONGINT:C221($al_simboloEvaluacion;0)
					ARRAY LONGINT:C221($al_simboloEvaluacion;Size of array:C274($at_simbolo))
					
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$al_IdAlumnos{$aluIndice})
					KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
					
					SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IDAsignaturas;[Asignaturas:18]Asignatura:3;$at_asignaturasNombre)
					
					For ($l_indiceAsignatura;1;Size of array:C274($al_IDAsignaturas))
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$al_IdAlumnos{$aluIndice};*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$al_IDAsignaturas{$l_indiceAsignatura})
						If (Size of array:C274($al_idCompetencia)>Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
							$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+Size of array:C274($al_idCompetencia)-Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
						Else 
							While (Not:C34(End selection:C36([Alumnos_EvaluacionAprendizajes:203])))
								$l_pos:=Find in array:C230($at_simbolo;$y_aprendizajeCampo->)
								If ($l_pos#-1)
									$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
								Else 
									If ($y_aprendizajeCampo->="")
										$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+1
									Else 
										$t_Simbolos:=EV2_Real_a_Simbolo ($y_aprendizajeReal->)
										$l_pos:=Find in array:C230(aSymbol;$t_Simbolos)
										If ($l_pos#-1)
											$l_pos:=Find in array:C230($at_simbolo;aSymbDesc{$l_pos})
											If ($l_pos#-1)
												$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
											End if 
										End if 
									End if 
								End if 
								NEXT RECORD:C51([Alumnos_EvaluacionAprendizajes:203])
							End while 
							
						End if 
					End for 
					
					  //guardo la información de los alumno en un objeto
					C_OBJECT:C1216($ob_alumnos)
					$t_nombreAlumno:=$at_nombreAlumnos{$aluIndice}
					
					OB SET ARRAY:C1227($ob_alumnos;$t_nombreAlumno;$t_nombreAlumno)
					OB SET ARRAY:C1227($ob_alumnos;"simbolos";$at_simbolo)
					OB SET ARRAY:C1227($ob_alumnos;"evaluacion";$al_simboloEvaluacion)
					APPEND TO ARRAY:C911($ao_objetoDatos;$ob_alumnos)
					CLEAR VARIABLE:C89($ob_alumnos)
					
				End for 
				
				
				  //creo json con las series correspondientes para entregar al gráfico
				ARRAY OBJECT:C1221($ao_series;0)
				C_OBJECT:C1216($ob_grafico;$ob_serie)
				
				PERIODOS_LoadData ($l_periodo)
				
				OB SET ARRAY:C1227($ob_grafico;"categories";$at_nombreAlumnos)
				OB SET ARRAY:C1227($ob_grafico;"id_alumnos";$al_IdAlumnos)
				OB SET ARRAY:C1227($ob_grafico;"periodo";atSTR_Periodos_Nombre)
				OB SET ARRAY:C1227($ob_grafico;"cursos";$at_cursoGrupo)
				OB SET:C1220($ob_grafico;"niveles";$ob_niveles)
				OB SET:C1220($ob_grafico;"titulo";"NIVEL: "+$t_nivelNombre+" - CURSO: "+$t_cursoGrupo)
				OB SET:C1220($ob_grafico;"curso";$t_cursoGrupo)
				OB SET:C1220($ob_grafico;"categoria_seleccionada";$t_cursoGrupo)
				
				For ($i;1;Size of array:C274($at_simbolo))
					ARRAY LONGINT:C221($al_datosSerie;0)
					
					OB SET:C1220($ob_serie;"name";$at_simbolo{$i})
					
					For ($x;1;Size of array:C274($ao_objetoDatos))
						ARRAY TEXT:C222($at_arraySimbolos;0)
						ARRAY LONGINT:C221($at_arrayevaluacion;0)
						
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"simbolos";$at_arraySimbolos)
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"evaluacion";$at_arrayevaluacion)
						
						$l_pos:=Find in array:C230($at_arraySimbolos;$at_simbolo{$i})
						$l_cantidad:=$at_arrayevaluacion{$l_pos}
						APPEND TO ARRAY:C911($al_datosSerie;$l_cantidad)
					End for 
					
					OB SET:C1220($ob_serie;"color";$at_coloresHexa{$i})
					OB SET ARRAY:C1227($ob_serie;"data";$al_datosSerie)
					APPEND TO ARRAY:C911($ao_series;$ob_serie)
					CLEAR VARIABLE:C89($ob_serie)
				End for 
				$o_nodo:=STWA2_Dash_PrefGrafAprendizajes ("LeePreferencia";$parameterNames;$parameterValues)
				OB SET ARRAY:C1227($ob_grafico;"series";$ao_series)
				OB SET:C1220($ob_grafico;"sepDecimal";<>tXS_RS_DecimalSeparator)
				OB SET:C1220($ob_grafico;"sepMiles";<>tXS_RS_ThousandsSeparator)
				OB SET:C1220($ob_grafico;"preferencia";$o_nodo)
				
			: ($t_ubicacion="alumno")
				
				  //busco al Alumno seleccionado
				If ($l_idAlumno#-1)
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$l_idAlumno)
				Else 
					QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=$t_alumno)
				End if 
				
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
				KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91>0)
				
				  //caego los simbolos según el estilo de evaluación configurado en las competencias.
				While (Not:C34(End selection:C36([Asignaturas:18])))
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
					KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
					KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;"")
					AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$al_numEstiloEval)
					
					For ($l_estiloIndice;1;Size of array:C274($al_numEstiloEval))
						$l_numeroEstilo:=Choose:C955($al_numEstiloEval{$l_estiloIndice}=0;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_numEstiloEval{$l_estiloIndice})
						EVS_ReadStyleData ($l_numeroEstilo)
						SORT ARRAY:C229(aSymbDesc;aSymbol;aSTWAColorRGB;aSTWAColorHexa;<)
						For ($indicestilo;1;Size of array:C274(aSymbDesc))
							If (Find in array:C230($at_simbolo;aSymbDesc{$indicestilo})=-1)
								APPEND TO ARRAY:C911($at_simbolo;aSymbDesc{$indicestilo})
								APPEND TO ARRAY:C911($at_coloresHexa;aSTWAColorHexa{$indicestilo})
							End if 
						End for 
					End for 
					NEXT RECORD:C51([Asignaturas:18])
				End while 
				
				$l_posNoEvaluado:=Find in array:C230($at_simbolo;"No evaluado")
				If ($l_posNoEvaluado=-1)
					AT_Insert (0;1;->$at_simbolo;->$at_coloresHexa)
					$at_simbolo{Size of array:C274($at_simbolo)}:="No evaluado"
					$at_coloresHexa{Size of array:C274($at_coloresHexa)}:="#c7ccc8"
					$l_posNoEvaluado:=Size of array:C274($at_coloresHexa)
				End if 
				
				
				SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IDAsignaturas;[Asignaturas:18]Asignatura:3;$at_nombreAsignatura)
				
				For ($l_indiceAsignatura;1;Size of array:C274($al_IDAsignaturas))
					ARRAY LONGINT:C221($al_simboloEvaluacion;0)
					ARRAY LONGINT:C221($al_simboloEvaluacion;Size of array:C274($at_simbolo))
					
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$al_IDAsignaturas{$l_indiceAsignatura})
					If (Size of array:C274($al_idCompetencia)>Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
						$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+Size of array:C274($al_idCompetencia)-Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
					Else 
						While (Not:C34(End selection:C36([Alumnos_EvaluacionAprendizajes:203])))
							$l_pos:=Find in array:C230($at_simbolo;$y_aprendizajeCampo->)
							If ($l_pos#-1)
								$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
							Else 
								If ($y_aprendizajeCampo->="")
									$al_simboloEvaluacion{$l_posNoEvaluado}:=$al_simboloEvaluacion{$l_posNoEvaluado}+1
								Else 
									$t_Simbolos:=EV2_Real_a_Simbolo ($y_aprendizajeReal->)
									$l_pos:=Find in array:C230(aSymbol;$t_Simbolos)
									If ($l_pos#-1)
										$l_pos:=Find in array:C230($at_simbolo;aSymbDesc{$l_pos})
										If ($l_pos#-1)
											$al_simboloEvaluacion{$l_pos}:=$al_simboloEvaluacion{$l_pos}+1
										End if 
									End if 
								End if 
							End if 
							NEXT RECORD:C51([Alumnos_EvaluacionAprendizajes:203])
						End while 
						
					End if 
					
					  //guardo la información de los alumno en un objeto
					C_OBJECT:C1216($ob_asignaturas)
					$t_asignatura:=$at_nombreAsignatura{$l_indiceAsignatura}
					
					OB SET:C1220($ob_asignaturas;$t_asignatura;$t_asignatura)
					OB SET ARRAY:C1227($ob_asignaturas;"simbolos";$at_simbolo)
					OB SET ARRAY:C1227($ob_asignaturas;"evaluacion";$al_simboloEvaluacion)
					OB SET ARRAY:C1227($ob_asignaturas;"color";$at_coloresHexa)
					APPEND TO ARRAY:C911($ao_objetoDatos;$ob_asignaturas)
					CLEAR VARIABLE:C89($ob_alumnos)
					
				End for 
				
				
				  //creo json con las series correspondientes para entregar al gráfico
				ARRAY OBJECT:C1221($ao_series;0)
				C_OBJECT:C1216($ob_grafico;$ob_serie)
				
				PERIODOS_LoadData ($l_periodo)
				
				OB SET ARRAY:C1227($ob_grafico;"categories";$at_nombreAsignatura)
				OB SET ARRAY:C1227($ob_grafico;"periodo";atSTR_Periodos_Nombre)
				OB SET:C1220($ob_grafico;"titulo";"ALUMNO: "+[Alumnos:2]apellidos_y_nombres:40)
				For ($i;1;Size of array:C274($at_simbolo))
					ARRAY LONGINT:C221($al_datosSerie;0)
					
					OB SET:C1220($ob_serie;"name";$at_simbolo{$i})
					
					For ($x;1;Size of array:C274($ao_objetoDatos))
						ARRAY TEXT:C222($at_arraySimbolos;0)
						ARRAY LONGINT:C221($at_arrayevaluacion;0)
						
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"simbolos";$at_arraySimbolos)
						OB GET ARRAY:C1229($ao_objetoDatos{$x};"evaluacion";$at_arrayevaluacion)
						
						$l_pos:=Find in array:C230($at_arraySimbolos;$at_simbolo{$i})
						$l_cantidad:=$at_arrayevaluacion{$l_pos}
						APPEND TO ARRAY:C911($al_datosSerie;$l_cantidad)
					End for 
					
					OB SET:C1220($ob_serie;"color";$at_coloresHexa{$i})
					OB SET ARRAY:C1227($ob_serie;"data";$al_datosSerie)
					APPEND TO ARRAY:C911($ao_series;$ob_serie)
					CLEAR VARIABLE:C89($ob_serie)
				End for 
				OB SET ARRAY:C1227($ob_grafico;"series";$ao_series)
				
				
		End case 
		$json:=JSON Stringify:C1217($ob_grafico)
		$0:=$json
End case 