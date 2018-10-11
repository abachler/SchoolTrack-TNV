//%attributes = {}
  //SRal_EvaluacionAprendizajes
  //para saltar la query selecciona las asignaturas en informes internos pasar como quinto parametro un numero superior a cero
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)

C_BOOLEAN:C305($b_enunciadoDefinido;$b_crearRegistro)
_O_C_INTEGER:C282($l_idxEstilos)
C_LONGINT:C283($l_elementoArreglo;$l_TipoCalculo;$l_columnas;$l_numeroCampo;$l_soloEnInformeInterno;$l_IdAlumno;$l_recNumEval;$l_IdObjeto;$l_tipoObjeto;$l_opciones)
C_LONGINT:C283($order;$rectBottom;$rectLeft;$rectRight;$rectTop;$repeatHOffset;$repeatVOffset;$restriccionPeriodo;$rows;$selected)
C_LONGINT:C283($tableNo;$usarIndentacion;$varType)
C_TEXT:C284($calcName;$objName;$section;$simboloNoEvaluado;$t_sexoAlumno)

ARRAY LONGINT:C221($aIDAsignaturas;0)
ARRAY LONGINT:C221($aIDMatriz;0)
ARRAY LONGINT:C221($aObjectsIds;0)
ARRAY LONGINT:C221($aRecNumObjetos;0)
ARRAY LONGINT:C221($aStyles;0)
ARRAY TEXT:C222($aAsignaturas;0)
ARRAY TEXT:C222($aSimbolos;0)
ARRAY TEXT:C222($at_llaveRegistros;0)

C_LONGINT:C283(vl_IDObjetoEnunciado;vl_RecLeftEnunciado;vl_RecRightEnunciado)

If (False:C215)
	C_TEXT:C284(SRal_EvaluacionAprendizajes ;$1)
	C_LONGINT:C283(SRal_EvaluacionAprendizajes ;$2)
	C_LONGINT:C283(SRal_EvaluacionAprendizajes ;$3)
	C_TEXT:C284(SRal_EvaluacionAprendizajes ;$4)
	C_LONGINT:C283(SRal_EvaluacionAprendizajes ;$5)
End if 

If (Application version:C493>="15@")
	  //168669 JVP 20160930
	
	Case of 
		: (Count parameters:C259=1)
			SRal_EvaluacionAprendizajes_SR3 ($1;1;1;"";1)
		: (Count parameters:C259=2)
			SRal_EvaluacionAprendizajes_SR3 ($1;$2;1;"";1)
		: (Count parameters:C259=3)
			SRal_EvaluacionAprendizajes_SR3 ($1;$2;$3;"";1)
		: (Count parameters:C259=4)
			SRal_EvaluacionAprendizajes_SR3 ($1;$2;$3;$4;1)
		: (Count parameters:C259=5)
			SRal_EvaluacionAprendizajes_SR3 ($1;$2;$3;$4;$5)
	End case 
	
Else 
	$section:=$1
	$usarIndentacion:=1
	$restriccionPeriodo:=0
	$l_soloEnInformeInterno:=0
	Case of 
		: (Count parameters:C259=5)
			$simboloNoEvaluado:=$4
			$restriccionPeriodo:=$3
			$usarIndentacion:=$2
			$l_soloEnInformeInterno:=$5
			If ($simboloNoEvaluado="")
				$simboloNoEvaluado:="N/E"
			End if 
		: (Count parameters:C259=4)
			$simboloNoEvaluado:=$4
			$restriccionPeriodo:=$3
			$usarIndentacion:=$2
			If ($simboloNoEvaluado="")
				$simboloNoEvaluado:="N/E"
			End if 
		: (Count parameters:C259=3)
			$restriccionPeriodo:=$3
			$usarIndentacion:=$2
			$simboloNoEvaluado:="N/E"
		: (Count parameters:C259=2)
			$usarIndentacion:=$2
	End case 
	
	
	
	
	
	
	
	Case of 
		: ($section="Inicio")
			PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
			If (Count parameters:C259=3)
				$restriccionPeriodo:=$3
			End if 
			$t_sexoAlumno:=[Alumnos:2]Sexo:49
			$l_IdAlumno:=[Alumnos:2]numero:1
			$recNumAlumno:=Record number:C243([Alumnos:2])
			SRcust_InitEvaluationVariables 
			SRal_FotoDelAlumno 
			SRal_InformacionConductual (vPeriodo)
			SRal_LeePromediosGenerales 
			
			READ ONLY:C145([Alumnos_Calificaciones:208])
			READ ONLY:C145([MPA_ObjetosMatriz:204])
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]EVAPR_IdMatriz:91>0)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$aIDAsignaturas;[Asignaturas:18]EVAPR_IdMatriz:91;$aIDMatriz;[Asignaturas:18]Asignatura:3;$aAsignaturas)
			
			
			KRL_GotoRecord (->[Alumnos:2];$recNumAlumno;False:C215)
			
			For ($i;1;Size of array:C274($aIDAsignaturas))
				QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ID_Matriz:1=$aIDMatriz{$i})
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$aIDMatriz{$i})
				LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$aRecNumObjetos)
				
				For ($iAprendizajes;1;Size of array:C274($aRecNumObjetos))
					GOTO RECORD:C242([MPA_ObjetosMatriz:204];$aRecNumObjetos{$iAprendizajes})
					
					  //20130911 ASM se verifica que el objeto matriz exista.
					Case of 
						: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
							$b_enunciadoDefinido:=(Find in field:C653([MPA_DefinicionEjes:185]ID:1;[MPA_ObjetosMatriz:204]ID_Eje:3)>=0)
						: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
							$b_enunciadoDefinido:=(Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[MPA_ObjetosMatriz:204]ID_Dimension:4)>=0)
						: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
							$b_enunciadoDefinido:=(Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[MPA_ObjetosMatriz:204]ID_Competencia:5)>=0)
					End case 
					
					If ($b_enunciadoDefinido)  // si existe la definición en mapas para el objeto asignado a la matriz
						
						If ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
							RELATE ONE:C42([MPA_ObjetosMatriz:204]ID_Competencia:5)
							Case of 
								: ([MPA_DefinicionCompetencias:187]RestriccionSexo:27=0)
									$key:=String:C10($aIDAsignaturas{$i})+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
									APPEND TO ARRAY:C911($at_llaveRegistros;$key)
									$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$key)
									$b_crearRegistro:=($l_recNumEval<0)
									
								: ((([MPA_DefinicionCompetencias:187]RestriccionSexo:27=1) & ($t_sexoAlumno="F")) | (([MPA_DefinicionCompetencias:187]RestriccionSexo:27=2) & ($t_sexoAlumno="M")))
									$key:=String:C10($aIDAsignaturas{$i})+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
									APPEND TO ARRAY:C911($at_llaveRegistros;$key)
									$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$key)
									$b_crearRegistro:=($l_recNumEval<0)
							End case 
						Else 
							$key:=String:C10($aIDAsignaturas{$i})+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
							APPEND TO ARRAY:C911($at_llaveRegistros;$key)  //Agregado
							$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$key)
							$b_crearRegistro:=($l_recNumEval<0)
						End if 
						
						  //si la competencia se utiliza para ambos sexos o si el sexo dela alumno corresponde a la limitación definida en la competencia
						If ($b_crearRegistro)
							CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
							[Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78:=<>gInstitucion
							[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
							[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=$l_IdAlumno
							[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=$aIDAsignaturas{$i}
							[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=[MPA_ObjetosMatriz:204]ID_Dimension:4
							[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
							[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=[MPA_ObjetosMatriz:204]ID_Competencia:5
							[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=$aIDMatriz{$i}
							[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=[MPA_ObjetosMatriz:204]Tipo_Objeto:2
							[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
							SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
							MPA_RecuperaEvalCicloAnterior 
						End if 
					End if 
				End for 
			End for 
			
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno)
			QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]Key:8;->$at_llaveRegistros;True:C214)  //Agregado
			
			If ($l_soloEnInformeInterno=0)
				QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Asignaturas:18]En_InformesInternos:14=True:C214)
			End if 
			
			KRL_GotoRecord (->[Alumnos:2];$recNumAlumno;False:C215)
			If ($restriccionPeriodo>0)
				QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? vPeriodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
				
				  //PS 28-05-2012: al ingresar a esta opcion se pierde el registro del alumno actual causando problemas en informes
				KRL_GotoRecord (->[Alumnos:2];$recNumAlumno;False:C215)
			End if 
			CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"Aprendizajes")
			
			  //descripción de los simbolos utilizados
			KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;"")
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7#0)
			AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$aStyles)
			For ($l_idxEstilos;1;Size of array:C274($aStyles))
				EVS_ReadStyleData ($aStyles{$l_idxEstilos})
				If (iPrintMode=Simbolos)
					For ($i;1;Size of array:C274(aSymbol))
						$descripcion:=ST_ClearSpaces (aSymbol{$i}+" = "+aSymbDesc{$i})
						$el:=Find in array:C230($aSimbolos;$descripcion)
						If ($el<0)
							APPEND TO ARRAY:C911($aSimbolos;$descripcion)
						End if 
					End for 
				End if 
			End for 
			vt_DescripcionSimbolos:=AT_array2text (->$aSimbolos;"; ")
			
			
			USE SET:C118("Aprendizajes")
			ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Asignaturas:18]ordenGeneral:105;>;[Asignaturas:18]denominacion_interna:16;>;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>)
			If ($usarIndentacion>0)
				$error:=SR Get Object IDs (SRArea;SR All Objects;$aObjectsIds)
				For ($i;1;Size of array:C274($aObjectsIds))
					$error:=SR Get Object Properties (SRArea;$aObjectsIds{$i};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
					If ($objName="vt_EvApr_Enunciado")
						$l_IdObjeto:=$aObjectsIds{$i}
						$i:=Size of array:C274($aObjectsIds)
						vl_IDObjetoEnunciado:=$l_IdObjeto
						vl_RecLeftEnunciado:=$rectLeft
						vl_RecRightEnunciado:=$rectRight
					End if 
				End for 
			Else 
				vl_IDObjetoEnunciado:=-1
				vl_RecLeftEnunciado:=0
				vl_RecRightEnunciado:=0
			End if 
			
			
		: ($section="Cuerpo")
			Case of 
				: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
					[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionCompetencias:187]Competencia:6
					
				: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
					[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionDimensiones:188]Dimensión:4
					
				: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
					[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionEjes:185]Nombre:3
					
			End case 
			vt_EVAPR_Enunciado:=[Alumnos_EvaluacionAprendizajes:203]Enunciado:9
			
			If (vl_IDObjetoEnunciado>0)
				Case of 
					: ([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7#0)
						$error:=SR Get Object Properties (SRArea;vl_IDObjetoEnunciado;$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
						$error:=SR Set Object Properties (SRArea;vl_IDObjetoEnunciado;SR Property Position;$objName;$rectTop;vl_RecLeftEnunciado+20;$rectBottom;vl_RecRightEnunciado+20;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
						
					: ([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6#0)
						$error:=SR Get Object Properties (SRArea;vl_IDObjetoEnunciado;$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
						$error:=SR Set Object Properties (SRArea;vl_IDObjetoEnunciado;SR Property Position;$objName;$rectTop;vl_RecLeftEnunciado+10;$rectBottom;vl_RecRightEnunciado+10;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
						
					: ([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5#0)
						$error:=SR Get Object Properties (SRArea;vl_IDObjetoEnunciado;$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
						$error:=SR Set Object Properties (SRArea;vl_IDObjetoEnunciado;SR Property Position;$objName;$rectTop;vl_RecLeftEnunciado;$rectBottom;vl_RecRightEnunciado;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
				End case 
			End if 
			
			
			Case of 
				: ([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7#0)
					If ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7#0)
						EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
						Case of 
							: (iPrintMode=Notas)
								vt_EVAPR_Maximo:=String:C10(rGradesTo)
							: (iPrintMode=Puntos)
								vt_EVAPR_Maximo:=String:C10(rPointsTo)
							: (iPrintMode=Porcentaje)
								vt_EVAPR_Maximo:="100"
							: (iPrintMode=Simbolos)
								vt_EVAPR_Maximo:=aSymbol{Size of array:C274(aSymbol)}
								For ($i;1;Size of array:C274(aSymbol))
									
								End for 
						End case 
					End if 
					
				: ([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6#0)
					If ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7#0)
						EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
						Case of 
							: (iPrintMode=Notas)
								vt_EVAPR_Maximo:=String:C10(rGradesTo)
							: (iPrintMode=Puntos)
								vt_EVAPR_Maximo:=String:C10(rPointsTo)
							: (iPrintMode=Porcentaje)
								vt_EVAPR_Maximo:="100"
							: (iPrintMode=Simbolos)
								vt_EVAPR_Maximo:=aSymbol{Size of array:C274(aSymbol)}
						End case 
					End if 
					
				: ([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5#0)
					If ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7#0)
						EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
						Case of 
							: (iPrintMode=Notas)
								vt_EVAPR_Maximo:=String:C10(rGradesTo)
							: (iPrintMode=Puntos)
								vt_EVAPR_Maximo:=String:C10(rPointsTo)
							: (iPrintMode=Porcentaje)
								vt_EVAPR_Maximo:="100"
							: (iPrintMode=Simbolos)
								vt_EVAPR_Maximo:=aSymbol{Size of array:C274(aSymbol)}
						End case 
					End if 
					
			End case 
			vt_EVAPR_P1:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
			vt_EVAPR_P2:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
			vt_EVAPR_P3:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
			vt_EVAPR_P4:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
			vt_EVAPR_P5:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
			vt_EVAPR_Indicador_P1:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
			vt_EVAPR_Indicador_P2:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
			vt_EVAPR_Indicador_P3:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
			vt_EVAPR_Indicador_P4:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
			vt_EVAPR_Indicador_P5:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
			Case of 
				: (vPeriodo=1)
					vt_EVAPR_Periodo:=vt_EVAPR_P1
					vt_EVAPR_Indicador_Periodo:=vt_EVAPR_Indicador_P1
				: (vPeriodo=2)
					vt_EVAPR_Periodo:=vt_EVAPR_P2
					vt_EVAPR_Indicador_Periodo:=vt_EVAPR_Indicador_P2
				: (vPeriodo=3)
					vt_EVAPR_Periodo:=vt_EVAPR_P3
					vt_EVAPR_Indicador_Periodo:=vt_EVAPR_Indicador_P3
				: (vPeriodo=4)
					vt_EVAPR_Periodo:=vt_EVAPR_P4
					vt_EVAPR_Indicador_Periodo:=vt_EVAPR_Indicador_P4
				: (vPeriodo=5)
					vt_EVAPR_Periodo:=vt_EVAPR_P5
					vt_EVAPR_Indicador_Periodo:=vt_EVAPR_Indicador_P5
			End case 
			
		: ($section="Fin")
			If (vl_IDObjetoEnunciado>0)  //restauro la posición del objeto Enunciado
				$error:=SR Get Object Properties (SRArea;vl_IDObjetoEnunciado;$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
				$error:=SR Set Object Properties (SRArea;vl_IDObjetoEnunciado;SR Property Position;$objName;$rectTop;vl_RecLeftEnunciado;$rectBottom;vl_RecRightEnunciado;$l_tipoObjeto;$l_opciones;$order;$selected;$tableNo;$l_numeroCampo;$varType;$l_elementoArreglo;$l_TipoCalculo;$calcName;$rows;$l_columnas;$repeatHOffset;$repeatVOffset)
			End if 
			CLEAR SET:C117("Aprendizajes")
	End case 
End if 