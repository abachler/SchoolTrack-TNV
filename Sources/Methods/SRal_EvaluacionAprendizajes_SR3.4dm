//%attributes = {}
  // SRal_EvaluacionAprendizajes_SR3()
  // Por: Alberto Bachler K.: 15-08-15, 14:08:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)

C_BOOLEAN:C305($b_crearRegistro;$b_enunciadoDefinido)
C_LONGINT:C283($l_columnas;$l_elemento;$l_elementoArreglo;$l_error;$l_filas;$l_IdAlumno;$l_idObjeto;$l_idx;$l_idx_Styles;$l_idxAprendizajes)
C_LONGINT:C283($l_numeroCampo;$l_numeroTabla;$l_opciones;$l_orden;$l_PosAbajo;$l_PosArriba;$l_PosDerecha;$l_PosIzquierda;$l_recNum)
C_LONGINT:C283($l_recNumAlumno;$l_recNumEval;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV;$l_restriccionPeriodo;$l_seleccionado;$l_soloEnInformesInternos;$l_tipoCalculo;$l_tipoObjeto;$l_tipoVariable)
C_LONGINT:C283($l_usarIndentacion)
C_TEXT:C284($t_descripcionSimbolo;$t_faseImpresion;$t_llaveRegistroEvaluacion;$t_noEvaluado;$t_nombreObjeto;$t_sexoAlumno;$t_nombreCalculo)

ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_IdEstilosEvaluacion;0)
ARRAY LONGINT:C221($al_idMatriz;0)
ARRAY LONGINT:C221($al_IdObjetos;0)
ARRAY LONGINT:C221($al_recNumObjetosMatriz;0)
ARRAY TEXT:C222($at_llaveRegistros;0)
ARRAY TEXT:C222($at_nombreAsignaturas;0)
ARRAY TEXT:C222($at_simbolo_y_Descripcion;0)



If (False:C215)
	C_TEXT:C284(SRal_EvaluacionAprendizajes_SR3 ;$1)
	C_LONGINT:C283(SRal_EvaluacionAprendizajes_SR3 ;$2)
	C_LONGINT:C283(SRal_EvaluacionAprendizajes_SR3 ;$3)
	C_TEXT:C284(SRal_EvaluacionAprendizajes_SR3 ;$4)
	C_LONGINT:C283(SRal_EvaluacionAprendizajes_SR3 ;$5)
End if 

$t_faseImpresion:=$1
$l_usarIndentacion:=1
$l_restriccionPeriodo:=0
$l_soloEnInformesInternos:=0
Case of 
	: (Count parameters:C259=5)
		$t_noEvaluado:=$4
		$l_restriccionPeriodo:=$3
		$l_usarIndentacion:=$2
		$l_soloEnInformesInternos:=$5
		If ($t_noEvaluado="")
			$t_noEvaluado:="N/E"
		End if 
	: (Count parameters:C259=4)
		$t_noEvaluado:=$4
		$l_restriccionPeriodo:=$3
		$l_usarIndentacion:=$2
		If ($t_noEvaluado="")
			$t_noEvaluado:="N/E"
		End if 
	: (Count parameters:C259=3)
		$l_restriccionPeriodo:=$3
		$l_usarIndentacion:=$2
		$t_noEvaluado:="N/E"
	: (Count parameters:C259=2)
		$l_usarIndentacion:=$2
End case 







Case of 
	: ($t_faseImpresion="Inicio")
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		If (Count parameters:C259=3)
			$l_restriccionPeriodo:=$3
		End if 
		$t_sexoAlumno:=[Alumnos:2]Sexo:49
		$l_IdAlumno:=[Alumnos:2]numero:1
		$l_recNumAlumno:=Record number:C243([Alumnos:2])
		SRcust_InitEvaluationVariables 
		  //SRal_FotoDelAlumno //MONO 18-07-2018 Ticket 210195
		SRal_InformacionConductual (vPeriodo)
		SRal_LeePromediosGenerales 
		
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([MPA_ObjetosMatriz:204])
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]EVAPR_IdMatriz:91>0)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IdAsignaturas;[Asignaturas:18]EVAPR_IdMatriz:91;$al_idMatriz;[Asignaturas:18]Asignatura:3;$at_nombreAsignaturas)
		
		
		KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215)
		
		For ($l_idx;1;Size of array:C274($al_IdAsignaturas))
			QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ID_Matriz:1=$al_idMatriz{$l_idx})
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$al_idMatriz{$l_idx})
			LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_recNumObjetosMatriz)
			
			For ($l_idxAprendizajes;1;Size of array:C274($al_recNumObjetosMatriz))
				GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_recNumObjetosMatriz{$l_idxAprendizajes})
				
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
								$t_llaveRegistroEvaluacion:=String:C10($al_IdAsignaturas{$l_idx})+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
								APPEND TO ARRAY:C911($at_llaveRegistros;$t_llaveRegistroEvaluacion)
								$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistroEvaluacion)
								$b_crearRegistro:=($l_recNumEval<0)
								
							: ((([MPA_DefinicionCompetencias:187]RestriccionSexo:27=1) & ($t_sexoAlumno="F")) | (([MPA_DefinicionCompetencias:187]RestriccionSexo:27=2) & ($t_sexoAlumno="M")))
								$t_llaveRegistroEvaluacion:=String:C10($al_IdAsignaturas{$l_idx})+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
								APPEND TO ARRAY:C911($at_llaveRegistros;$t_llaveRegistroEvaluacion)
								$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistroEvaluacion)
								$b_crearRegistro:=($l_recNumEval<0)
						End case 
					Else 
						$t_llaveRegistroEvaluacion:=String:C10($al_IdAsignaturas{$l_idx})+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
						APPEND TO ARRAY:C911($at_llaveRegistros;$t_llaveRegistroEvaluacion)  //Agregado
						$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistroEvaluacion)
						$b_crearRegistro:=($l_recNumEval<0)
					End if 
					
					  //si la competencia se utiliza para ambos sexos o si el sexo dela alumno corresponde a la limitación definida en la competencia
					If ($b_crearRegistro)
						CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
						[Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78:=<>gInstitucion
						[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
						[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=$l_IdAlumno
						[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=$al_IdAsignaturas{$l_idx}
						[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=[MPA_ObjetosMatriz:204]ID_Dimension:4
						[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
						[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=[MPA_ObjetosMatriz:204]ID_Competencia:5
						[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=$al_idMatriz{$l_idx}
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
		
		If ($l_soloEnInformesInternos=0)
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Asignaturas:18]En_InformesInternos:14=True:C214)
		End if 
		
		KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215)
		If ($l_restriccionPeriodo>0)
			QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? vPeriodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
			KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215)
		End if 
		CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"Aprendizajes")
		
		  //descripción de los simbolos utilizados
		KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;"")
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7#0)
		AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$al_IdEstilosEvaluacion)
		For ($l_idx_Styles;1;Size of array:C274($al_IdEstilosEvaluacion))
			EVS_ReadStyleData ($al_IdEstilosEvaluacion{$l_idx_Styles})
			If (iPrintMode=Simbolos)
				For ($l_idx;1;Size of array:C274(aSymbol))
					$t_descripcionSimbolo:=ST_ClearSpaces (aSymbol{$l_idx}+" = "+aSymbDesc{$l_idx})
					$l_elemento:=Find in array:C230($at_simbolo_y_Descripcion;$t_descripcionSimbolo)
					If ($l_elemento<0)
						APPEND TO ARRAY:C911($at_simbolo_y_Descripcion;$t_descripcionSimbolo)
					End if 
				End for 
			End if 
		End for 
		vt_DescripcionSimbolos:=AT_array2text (->$at_simbolo_y_Descripcion;"; ")
		USE SET:C118("Aprendizajes")
		ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Asignaturas:18]ordenGeneral:105;>;[Asignaturas:18]denominacion_interna:16;>;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>)
		
		
	: ($t_faseImpresion="Cuerpo")
		Case of 
			: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
				[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionCompetencias:187]Competencia:6
				
			: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
				[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionDimensiones:188]Dimensión:4
				
			: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
				[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionEjes:185]Nombre:3
				
		End case 
		vt_EVAPR_Enunciado:=[Alumnos_EvaluacionAprendizajes:203]Enunciado:9
		
		  //MONO 13-06-2018 esto SRP ya no lo maneja así, hay que trabajarlo directo dentro de cada informe.
		
		  //$l_error:=SR Get Object Properties (SRArea;SRObjectPrintRef;$t_nombreObjeto;$l_PosArriba;$l_PosIzquierda;$l_PosAbajo;$l_PosDerecha;$l_tipoObjeto;$l_opciones;$l_orden;$l_seleccionado;$l_numeroTabla;$l_numeroCampo;$l_tipoVariable;$l_elementoArreglo;$l_tipoCalculo;$t_nombreCalculo;$l_filas;$l_columnas;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV)
		  //If ($t_nombreObjeto="vt_EvApr_Enunciado")
		  //vl_IDObjetoEnunciado:=SRObjectPrintRef
		  //vl_RecLeftEnunciado:=$l_PosIzquierda
		  //vl_RecRightEnunciado:=$l_PosDerecha
		  //Case of 
		  //: ([Alumnos_EvaluacionAprendizajes]ID_Competencia#0)
		  //$l_error:=SR Set Object Properties (SRArea;vl_IDObjetoEnunciado;SR Property Position;$t_nombreObjeto;$l_PosArriba;vl_RecLeftEnunciado+20;$l_PosAbajo;vl_RecRightEnunciado+20;$l_tipoObjeto;$l_opciones;$l_orden;$l_seleccionado;$l_numeroTabla;$l_numeroCampo;$l_tipoVariable;$l_elementoArreglo;$l_tipoCalculo;$t_nombreCalculo;$l_filas;$l_columnas;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV)
		
		  //: ([Alumnos_EvaluacionAprendizajes]ID_Dimension#0)
		  //$l_error:=SR Set Object Properties (SRArea;vl_IDObjetoEnunciado;SR Property Position;$t_nombreObjeto;$l_PosArriba;vl_RecLeftEnunciado+10;$l_PosAbajo;vl_RecRightEnunciado+10;$l_tipoObjeto;$l_opciones;$l_orden;$l_seleccionado;$l_numeroTabla;$l_numeroCampo;$l_tipoVariable;$l_elementoArreglo;$l_tipoCalculo;$t_nombreCalculo;$l_filas;$l_columnas;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV)
		
		  //: ([Alumnos_EvaluacionAprendizajes]ID_Eje#0)
		  //End case 
		  //End if 
		
		
		
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
		
	: ($t_faseImpresion="Fin")
		If (vl_IDObjetoEnunciado>0)  //restauro la posición del objeto Enunciado
			  //MONO 18-07-2018 Ticket 210195
			  //$l_error:=SR Get Object Properties (SRArea;vl_IDObjetoEnunciado;$t_nombreObjeto;$l_PosArriba;$l_PosIzquierda;$l_PosAbajo;$l_PosDerecha;$l_tipoObjeto;$l_opciones;$l_orden;$l_seleccionado;$l_numeroTabla;$l_numeroCampo;$l_tipoVariable;$l_elementoArreglo;$l_tipoCalculo;$t_nombreCalculo;$l_filas;$l_columnas;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV)
			  //$l_error:=SR Set Object Properties (SRArea;vl_IDObjetoEnunciado;SR Property Position;$t_nombreObjeto;$l_PosArriba;vl_RecLeftEnunciado;$l_PosAbajo;vl_RecRightEnunciado;$l_tipoObjeto;$l_opciones;$l_orden;$l_seleccionado;$l_numeroTabla;$l_numeroCampo;$l_tipoVariable;$l_elementoArreglo;$l_tipoCalculo;$t_nombreCalculo;$l_filas;$l_columnas;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV)
		End if 
		CLEAR SET:C117("Aprendizajes")
End case 



