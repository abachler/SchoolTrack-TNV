//%attributes = {}
  // MÉTODO: MPAdbu_CompactaMapas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/12, 10:02:50
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPAdbu_CompactaMapas()
  // ----------------------------------------------------

C_BLOB:C604($x_evaluacionesExistentes;$x_indicadores;$x_registroErrores)
C_LONGINT:C283($i;$iAreas;$iBits;$iCompetencias;$id_Dimension_Duplicada;$id_Eje_Duplicado;$l_IdCompetenciaDuplicada;$iDimensiones;$iDuplicados;$iEtapas)
C_LONGINT:C283($l_indexNivel;$iNiveles;$l_asignado_a_Etapa;$l_IdCompetencia;$l_IdDimension;$l_IdEje;$l_IdEstiloEvaluacion;$l_IdProcesoUTherm;$l_nivelesAsignados;$l_nivelesDeAplicacion)
C_LONGINT:C283($l_primerNivelAsignado;$l_restriccionMateria;$l_restriccionSexo;$l_tipoEvaluacion;$l_ultimoNivelAsignado)
C_TIME:C306($h_referenciaDocumento)
C_REAL:C285($r_maximoEscala;$r_minimoAprobacion;$r_minimoEscala)
C_TEXT:C284($t_enunciado;$t_mensajeError;$t_mnemoVariante;$t_nombreCompetencia;$t_nombreDimension;$t_nombreEje;$t_simbolosBinarios)

ARRAY LONGINT:C221($aI_IdCompetenciasEliminadas;0)
ARRAY LONGINT:C221($al_IdAlumno;0)
ARRAY LONGINT:C221($al_IdAsignatura;0)
ARRAY LONGINT:C221($al_IdCompetencias;0)
ARRAY LONGINT:C221($al_IdDimensiones;0)
ARRAY LONGINT:C221($al_IdEjes;0)
ARRAY LONGINT:C221($al_recNumDimensiones;0)
ARRAY LONGINT:C221($al_recNumDuplicados;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY LONGINT:C221($al_recNumsAreas;0)
ARRAY LONGINT:C221($al_recNumsCompetencias;0)
ARRAY LONGINT:C221($al_tipoObjeto;0)
ARRAY TEXT:C222($at_errores;0)
ARRAY TEXT:C222($at_literalFinal;0)
ARRAY TEXT:C222($at_literalP1;0)
ARRAY TEXT:C222($at_literalP2;0)
ARRAY TEXT:C222($at_literalP3;0)
ARRAY TEXT:C222($at_literalP4;0)
ARRAY TEXT:C222($at_literalP5;0)
ARRAY TEXT:C222($at_nombreCompetencias;0)
ARRAY TEXT:C222($at_nombreDimensiones;0)
ARRAY TEXT:C222($at_nombreEjes;0)





  // CODIGO PRINCIPAL
START TRANSACTION:C239

$l_IdProcesoUTherm:=IT_UThermometer (1;0;__ ("Verificando mapas de aprendizajes desde matrices de evaluación"))

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0;*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61#"")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;$al_IdAsignatura;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;$al_IdAlumno;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEjes;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_nombreDimensiones;[MPA_DefinicionCompetencias:187]Competencia:6;$at_nombreCompetencias;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;$al_tipoObjeto;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;$al_IdEjes;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;$al_IdDimensiones;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;$al_IdCompetencias)
SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13;$at_literalP1;[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25;$at_literalP2;[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37;$at_literalP3;[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49;$at_literalP4;[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66;$at_literalP5;[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61;$at_literalFinal)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
ARRAY TEXT:C222($at_llaveRegistroAprendizajes;Size of array:C274($al_IdAsignatura))
ARRAY TEXT:C222($at_evaluacionesExistentes;Size of array:C274($al_IdAsignatura))
For ($i;1;Size of array:C274($at_llaveRegistroAprendizajes))
	Case of 
		: ($al_tipoObjeto{$i}=Eje_Aprendizaje)
			$t_enunciado:=$at_nombreEjes{$i}
		: ($al_tipoObjeto{$i}=Dimension_Aprendizaje)
			$t_enunciado:=$at_nombreDimensiones{$i}
		: ($al_tipoObjeto{$i}=Logro_Aprendizaje)
			$t_enunciado:=$at_nombreCompetencias{$i}
	End case 
	$at_llaveRegistroAprendizajes{$i}:=String:C10($al_IdAlumno{$i};"000000")+"."+String:C10($al_IdAsignatura{$i};"000000")+"."+String:C10($al_tipoObjeto{$i})+"."+Replace string:C233($t_enunciado;"\r";"¬")
	$at_evaluacionesExistentes{$i}:=$at_literalP1{$i}+"."+$at_literalP2{$i}+"."+$at_literalP3{$i}+"."+$at_literalP4{$i}+"."+$at_literalP5{$i}+"."+$at_literalFinal{$i}
End for 
SORT ARRAY:C229($at_llaveRegistroAprendizajes;$at_evaluacionesExistentes;>)
BLOB_Variables2Blob (->$x_evaluacionesExistentes;0;->$at_llaveRegistroAprendizajes;->$at_evaluacionesExistentes)
$h_referenciaDocumento:=Create document:C266("BLOB ANTES")
CLOSE DOCUMENT:C267($h_referenciaDocumento)
BLOB TO DOCUMENT:C526(document;$x_evaluacionesExistentes)

  //leo las matrices y verifico que los objetos asociados estén efectivamente en las etapas respectivas en los mapas
ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];$al_recNums;"")
For ($i;1;Size of array:C274($al_recNums))
	
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$al_recNums{$i})
	$l_indexNivel:=Find in array:C230(<>aNivNo;[MPA_AsignaturasMatrices:189]NumeroNivel:4)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	
	While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
		Case of 
			: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
				READ WRITE:C146([MPA_DefinicionEjes:185])
				QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=[MPA_ObjetosMatriz:204]ID_Eje:3)
				[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $l_indexNivel
				SAVE RECORD:C53([MPA_DefinicionEjes:185])
				
			: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
				READ WRITE:C146([MPA_DefinicionDimensiones:188])
				QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1=[MPA_ObjetosMatriz:204]ID_Dimension:4)
				[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?+ $l_indexNivel
				SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
				
			: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
				READ WRITE:C146([MPA_DefinicionCompetencias:187])
				QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=[MPA_ObjetosMatriz:204]ID_Competencia:5)
				[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_indexNivel
				SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
				
		End case 
		NEXT RECORD:C51([MPA_ObjetosMatriz:204])
	End while 
End for 

  //AGRUPACION DE COMPETENCIAS
  //para todas las areas verifico la existencia de competencias duplicadas y las centralizo en una sola cambiano los id respectivos en ObjetosMatriz y EvaluaciónAprendizajes
ALL RECORDS:C47([MPA_DefinicionAreas:186])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionAreas:186];$al_recNumsAreas;"")
CREATE EMPTY SET:C140([MPA_DefinicionCompetencias:187];"aEliminar")
For ($iAreas;1;Size of array:C274($al_recNumsAreas))
	GOTO RECORD:C242([MPA_DefinicionAreas:186];$al_recNumsAreas{$iAreas})
	QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=[MPA_DefinicionAreas:186]ID:1)
	ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
	CREATE SET:C116([MPA_DefinicionCompetencias:187];"CompetenciasArea")
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNums;"")
	
	For ($i;1;Size of array:C274($al_recNums))
		READ WRITE:C146([MPA_DefinicionCompetencias:187])
		GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNums{$i})
		If (Not:C34(Is in set:C273("aEliminar")))
			$t_nombreCompetencia:=[MPA_DefinicionCompetencias:187]Competencia:6
			$l_IdCompetencia:=[MPA_DefinicionCompetencias:187]ID:1
			$l_IdEje:=[MPA_DefinicionCompetencias:187]ID_Eje:2
			$l_IdDimension:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
			$l_nivelesDeAplicacion:=[MPA_DefinicionCompetencias:187]BitNiveles:28
			$l_tipoEvaluacion:=[MPA_DefinicionCompetencias:187]TipoEvaluacion:12
			$l_IdEstiloEvaluacion:=[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7
			$r_minimoEscala:=[MPA_DefinicionCompetencias:187]Escala_Minimo:20
			$r_maximoEscala:=[MPA_DefinicionCompetencias:187]Escala_Maximo:21
			$x_indicadores:=[MPA_DefinicionCompetencias:187]xIndicadores:14
			$t_simbolosBinarios:=[MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17
			$l_restriccionSexo:=[MPA_DefinicionCompetencias:187]RestriccionSexo:27
			$l_restriccionMateria:=[MPA_DefinicionCompetencias:187]RestriccionSubsector:3
			$t_mnemoVariante:=[MPA_DefinicionCompetencias:187]Mnemo:26
			
			USE SET:C118("CompetenciasArea")
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]Competencia:6=$t_nombreCompetencia)
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1#$l_IdCompetencia;*)
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]ID_Dimension:23#$l_IdDimension;*)
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]ID_Eje:2#$l_IdEje)
			
			Case of 
				: ($l_tipoEvaluacion=1)
					QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]TipoEvaluacion:12=$l_tipoEvaluacion)
					
				: ($l_tipoEvaluacion=2)
					QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]TipoEvaluacion:12=$l_tipoEvaluacion;*)
					QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17=$t_simbolosBinarios)
					
				: ($l_tipoEvaluacion=3)
					QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]TipoEvaluacion:12=$l_tipoEvaluacion;*)
					QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]EstiloEvaluacion:7=$l_IdEstiloEvaluacion)
					
			End case 
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSexo:27=$l_restriccionSexo;*)
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_restriccionMateria;*)
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]Mnemo:26=$t_mnemoVariante)
			
			If (Records in selection:C76([MPA_DefinicionCompetencias:187])>0)
				LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNumDuplicados;"")
				For ($iDuplicados;1;Size of array:C274($al_recNumDuplicados))
					GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNumDuplicados{$iDuplicados})
					$l_IdCompetenciaDuplicada:=[MPA_DefinicionCompetencias:187]ID:1
					If (((BLOB size:C605($x_indicadores)=BLOB size:C605([MPA_DefinicionCompetencias:187]xIndicadores:14)) & ($l_tipoEvaluacion=1)) | ($l_tipoEvaluacion>1))
						ADD TO SET:C119([MPA_DefinicionCompetencias:187];"aEliminar")
						For ($iNiveles;1;24)
							If ([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $iNiveles)
								$l_nivelesDeAplicacion:=$l_nivelesDeAplicacion ?+ $iNiveles
							End if 
						End for 
						$l_IdCompetenciaDuplicada:=[MPA_DefinicionCompetencias:187]ID:1
						READ WRITE:C146([MPA_ObjetosMatriz:204])
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$l_IdCompetenciaDuplicada)
						APPLY TO SELECTION:C70([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5:=$l_IdCompetencia)
						APPLY TO SELECTION:C70([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4:=$l_IdDimension)
						APPLY TO SELECTION:C70([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_IdEje)
						
						READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$l_IdCompetenciaDuplicada;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
						
						APPLY TO SELECTION:C70([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=$l_IdCompetencia)
						APPLY TO SELECTION:C70([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=$l_IdDimension)
						APPLY TO SELECTION:C70([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=$l_IdEje)
					End if 
				End for 
				
				GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNums{$i})
				[MPA_DefinicionCompetencias:187]BitNiveles:28:=$l_nivelesDeAplicacion
				SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
			End if 
			
		End if 
	End for 
End for 

  //elimino las competencias duplicadas
USE SET:C118("aEliminar")
SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]ID:1;$aI_IdCompetenciasEliminadas)
KRL_DeleteSelection (->[MPA_DefinicionCompetencias:187])




  //AGRUPACION DE DIMENSIONES
  //para todas las areas verifico la existencia de competencias duplicadas y las centralizo en una sola cambiano los id respectivos en ObjetosMatriz y EvaluaciónAprendizajes
ALL RECORDS:C47([MPA_DefinicionAreas:186])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionAreas:186];$al_recNumsAreas;"")
CREATE EMPTY SET:C140([MPA_DefinicionDimensiones:188];"aEliminar")
For ($iAreas;1;Size of array:C274($al_recNumsAreas))
	GOTO RECORD:C242([MPA_DefinicionAreas:186];$al_recNumsAreas{$iAreas})
	QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=[MPA_DefinicionAreas:186]ID:1)
	CREATE SET:C116([MPA_DefinicionDimensiones:188];"dimensionesArea")
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_recNums;"")
	For ($i;1;Size of array:C274($al_recNums))
		READ WRITE:C146([MPA_DefinicionDimensiones:188])
		GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNums{$i})
		If (Not:C34(Is in set:C273("aEliminar")))
			$t_nombreDimension:=[MPA_DefinicionDimensiones:188]Dimensión:4
			$l_IdDimension:=[MPA_DefinicionDimensiones:188]ID:1
			$l_IdEje:=[MPA_DefinicionDimensiones:188]ID_Eje:3
			$l_nivelesDeAplicacion:=[MPA_DefinicionDimensiones:188]BitsNiveles:21
			$l_tipoEvaluacion:=[MPA_DefinicionDimensiones:188]TipoEvaluacion:15
			$l_IdEstiloEvaluacion:=[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11
			$r_minimoEscala:=[MPA_DefinicionDimensiones:188]Escala_Minimo:12
			$r_maximoEscala:=[MPA_DefinicionDimensiones:188]Escala_Maximo:13
			$r_minimoAprobacion:=[MPA_DefinicionDimensiones:188]PctParaAprobacion:14
			$t_simbolosBinarios:=[MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17
			
			USE SET:C118("dimensionesArea")
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];([MPA_DefinicionDimensiones:188]Dimensión:4=$t_nombreDimension))
			QUERY SELECTION:C341([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1#$l_IdDimension)
			
			Case of 
				: ($l_tipoEvaluacion=1)
					QUERY SELECTION:C341([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]TipoEvaluacion:15=$l_tipoEvaluacion)
					
				: ($l_tipoEvaluacion=2)
					QUERY SELECTION:C341([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]TipoEvaluacion:15=$l_tipoEvaluacion;*)
					QUERY SELECTION:C341([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17=$t_simbolosBinarios)
					
				: ($l_tipoEvaluacion=3)
					QUERY SELECTION:C341([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]TipoEvaluacion:15=$l_tipoEvaluacion;*)
					QUERY SELECTION:C341([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=$l_IdEstiloEvaluacion;*)
					QUERY SELECTION:C341([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]Escala_Minimo:12=$r_minimoEscala;*)
					QUERY SELECTION:C341([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]Escala_Maximo:13=$r_maximoEscala;*)
					QUERY SELECTION:C341([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]PctParaAprobacion:14=$r_minimoAprobacion)
			End case 
			
			If (Records in selection:C76([MPA_DefinicionDimensiones:188])>0)
				LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_recNumDuplicados;"")
				For ($iDuplicados;1;Size of array:C274($al_recNumDuplicados))
					GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNumDuplicados{$iDuplicados})
					$id_Dimension_Duplicada:=[MPA_DefinicionDimensiones:188]ID:1
					ADD TO SET:C119([MPA_DefinicionDimensiones:188];"aEliminar")
					For ($iNiveles;1;24)
						If ([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $iNiveles)
							$l_nivelesDeAplicacion:=$l_nivelesDeAplicacion ?+ $iNiveles
						End if 
					End for 
					READ WRITE:C146([MPA_DefinicionCompetencias:187])
					QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$id_Dimension_Duplicada)
					APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23:=$l_IdDimension)
					
					READ WRITE:C146([MPA_ObjetosMatriz:204])
					QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$id_Dimension_Duplicada)
					APPLY TO SELECTION:C70([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4:=$l_IdDimension)
					APPLY TO SELECTION:C70([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_IdEje)
					
					READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$id_Dimension_Duplicada;*)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
					
					APPLY TO SELECTION:C70([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=$l_IdDimension)
					APPLY TO SELECTION:C70([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=$l_IdEje)
				End for 
				
				GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNums{$i})
				[MPA_DefinicionDimensiones:188]BitsNiveles:21:=$l_nivelesDeAplicacion
				SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
			End if 
			
		End if 
	End for 
End for 
USE SET:C118("aEliminar")
KRL_DeleteSelection (->[MPA_DefinicionDimensiones:188])

  //AGRUPACION DE EJES
  //para todas las areas verifico la existencia de ejes duplicados y loss centralizo en una sola cambiano los id respectivos en ObjetosMatriz y EvaluaciónAprendizajes
ALL RECORDS:C47([MPA_DefinicionAreas:186])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionAreas:186];$al_recNumsAreas;"")
CREATE EMPTY SET:C140([MPA_DefinicionEjes:185];"aEliminar")
For ($iAreas;1;Size of array:C274($al_recNumsAreas))
	GOTO RECORD:C242([MPA_DefinicionAreas:186];$al_recNumsAreas{$iAreas})
	QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=[MPA_DefinicionAreas:186]ID:1)
	CREATE SET:C116([MPA_DefinicionEjes:185];"EjesArea")
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$al_recNums;"")
	For ($i;1;Size of array:C274($al_recNums))
		READ WRITE:C146([MPA_DefinicionEjes:185])
		GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNums{$i})
		
		If (Not:C34(Is in set:C273("aEliminar")))
			$t_nombreEje:=[MPA_DefinicionEjes:185]Nombre:3
			$l_IdEje:=[MPA_DefinicionEjes:185]ID:1
			$l_nivelesDeAplicacion:=[MPA_DefinicionEjes:185]BitsNiveles:20
			$l_tipoEvaluacion:=[MPA_DefinicionEjes:185]TipoEvaluación:12
			$l_IdEstiloEvaluacion:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
			$r_minimoEscala:=[MPA_DefinicionEjes:185]Escala_Minimo:17
			$r_maximoEscala:=[MPA_DefinicionEjes:185]Escala_Maximo:18
			$r_minimoAprobacion:=[MPA_DefinicionEjes:185]PctParaAprobacion:16
			$t_simbolosBinarios:=[MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14
			
			USE SET:C118("EjesArea")
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionEjes:185];([MPA_DefinicionEjes:185]Nombre:3=$t_nombreEje))
			QUERY SELECTION:C341([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1#$l_IdEje)
			
			Case of 
				: ($l_tipoEvaluacion=1)
					QUERY SELECTION:C341([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]TipoEvaluación:12=$l_tipoEvaluacion)
					
				: ($l_tipoEvaluacion=2)
					QUERY SELECTION:C341([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]TipoEvaluación:12=$l_tipoEvaluacion;*)
					QUERY SELECTION:C341([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14=$t_simbolosBinarios)
					
				: ($l_tipoEvaluacion=3)
					QUERY SELECTION:C341([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]TipoEvaluación:12=$l_tipoEvaluacion;*)
					QUERY SELECTION:C341([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]EstiloEvaluación:13=$l_IdEstiloEvaluacion;*)
					QUERY SELECTION:C341([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]Escala_Minimo:17=$r_minimoEscala;*)
					QUERY SELECTION:C341([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]Escala_Maximo:18=$r_maximoEscala;*)
					QUERY SELECTION:C341([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]PctParaAprobacion:16=$r_minimoAprobacion)
			End case 
			
			If (Records in selection:C76([MPA_DefinicionEjes:185])>0)
				LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$al_recNumDuplicados;"")
				For ($iDuplicados;1;Size of array:C274($al_recNumDuplicados))
					GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNumDuplicados{$iDuplicados})
					$id_Eje_Duplicado:=[MPA_DefinicionEjes:185]ID:1
					ADD TO SET:C119([MPA_DefinicionEjes:185];"aEliminar")
					For ($iNiveles;1;24)
						If ([MPA_DefinicionEjes:185]BitsNiveles:20 ?? $iNiveles)
							$l_nivelesDeAplicacion:=$l_nivelesDeAplicacion ?+ $iNiveles
						End if 
					End for 
					
					READ WRITE:C146([MPA_DefinicionDimensiones:188])
					QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$id_Eje_Duplicado)
					APPLY TO SELECTION:C70([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3:=$l_IdEje)
					
					READ WRITE:C146([MPA_DefinicionCompetencias:187])
					QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$id_Eje_Duplicado)
					APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2:=$l_IdEje)
					
					READ WRITE:C146([MPA_ObjetosMatriz:204])
					QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$id_Eje_Duplicado)
					APPLY TO SELECTION:C70([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_IdEje)
					
					READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$id_Eje_Duplicado;*)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
					
					APPLY TO SELECTION:C70([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=$l_IdEje)
				End for 
				
				GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNums{$i})
				[MPA_DefinicionEjes:185]BitsNiveles:20:=$l_nivelesDeAplicacion
				SAVE RECORD:C53([MPA_DefinicionEjes:185])
			End if 
			
		End if 
	End for 
End for 
USE SET:C118("aEliminar")
KRL_DeleteSelection (->[MPA_DefinicionEjes:185])

  //verifico que los niveles asignados a las dimensiones y ejes sean consistentes con las competencias que dependen de ellos
ALL RECORDS:C47([MPA_DefinicionDimensiones:188])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_recNums;"")
For ($i;1;Size of array:C274($al_recNums))
	READ WRITE:C146([MPA_DefinicionDimensiones:188])
	GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNums{$i})
	If ([MPA_DefinicionDimensiones:188]DesdeGrado:6>-100)
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=[MPA_DefinicionDimensiones:188]ID:1)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNumsCompetencias;"")
		For ($iCompetencias;1;Size of array:C274($al_recNumsCompetencias))
			GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNumsCompetencias{$iCompetencias})
			For ($iBits;1;24)
				If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $iBits) & (Not:C34([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $iBits)))
					[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?+ $iBits
				End if 
			End for 
		End for 
	End if 
	SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
End for 

  //Verifico la validez de las etapas y niveles asignadas a los registros de definición de ejes, dimensiones y competencias
ALL RECORDS:C47([MPA_DefinicionEjes:185])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$al_recNums;"")
For ($i;1;Size of array:C274($al_recNums))
	READ WRITE:C146([MPA_DefinicionEjes:185])
	GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNums{$i})
	If ([MPA_DefinicionEjes:185]DesdeGrado:4>-100)
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=[MPA_DefinicionEjes:185]ID:1)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNumsCompetencias;"")
		For ($iCompetencias;1;Size of array:C274($al_recNumsCompetencias))
			GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNumsCompetencias{$iCompetencias})
			For ($iBits;1;24)
				If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $iBits) & (Not:C34([MPA_DefinicionEjes:185]BitsNiveles:20 ?? $iBits)))
					[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $iBits
				End if 
			End for 
		End for 
		
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=[MPA_DefinicionEjes:185]ID:1)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_recNumDimensiones;"")
		For ($iDimensiones;1;Size of array:C274($al_recNumDimensiones))
			GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNumDimensiones{$iDimensiones})
			For ($iBits;1;24)
				If (([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $iBits) & (Not:C34([MPA_DefinicionEjes:185]BitsNiveles:20 ?? $iBits)))
					[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $iBits
				End if 
			End for 
		End for 
		
	End if 
	SAVE RECORD:C53([MPA_DefinicionEjes:185])
End for 

ALL RECORDS:C47([MPA_DefinicionEjes:185])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$al_recNums;"")
For ($i;1;Size of array:C274($al_recNums))
	READ WRITE:C146([MPA_DefinicionEjes:185])
	GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNums{$i})
	QUERY:C277([MPA_DefinicionAreas:186];[MPA_DefinicionAreas:186]ID:1=[MPA_DefinicionEjes:185]ID_Area:2)
	ARRAY TEXT:C222(atMPA_EtapasArea;0)
	ARRAY LONGINT:C221(alMPA_NivelDesde;0)
	ARRAY LONGINT:C221(alMPA_NivelHasta;0)
	ARRAY TEXT:C222(atMPA_NivelDesde;0)
	ARRAY TEXT:C222(atMPA_NivelHasta;0)
	
	If (BLOB size:C605([MPA_DefinicionAreas:186]xEtapas:10)=0)
		BLOB_Variables2Blob (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	Else 
		BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	End if 
	
	$l_nivelesAsignados:=0
	$l_primerNivelAsignado:=100
	$l_ultimoNivelAsignado:=-100
	For ($iBits;1;24)
		If ([MPA_DefinicionEjes:185]BitsNiveles:20 ?? $iBits)
			$l_nivelesAsignados:=$l_nivelesAsignados+1
			If (<>aNivNo{$iBits}<$l_primerNivelAsignado)
				$l_primerNivelAsignado:=<>aNivNo{$iBits}
			End if 
			If (<>aNivNo{$iBits}>$l_ultimoNivelAsignado)
				$l_ultimoNivelAsignado:=<>aNivNo{$iBits}
			End if 
		End if 
	End for 
	If ($l_nivelesAsignados=24)
		[MPA_DefinicionEjes:185]DesdeGrado:4:=-100
		[MPA_DefinicionEjes:185]HastaGrado:5:=-100
	Else 
		$l_asignado_a_Etapa:=0
		For ($iEtapas;1;Size of array:C274(atMPA_EtapasArea))
			If (($l_primerNivelAsignado>=alMPA_NivelDesde{$iEtapas}) & ($l_ultimoNivelAsignado<=alMPA_NivelHasta{$iEtapas}))
				$l_asignado_a_Etapa:=$iEtapas
				$iEtapas:=Size of array:C274(atMPA_EtapasArea)
			End if 
		End for 
		If ($l_asignado_a_Etapa>0)
			[MPA_DefinicionEjes:185]DesdeGrado:4:=$l_primerNivelAsignado
			[MPA_DefinicionEjes:185]HastaGrado:5:=$l_ultimoNivelAsignado
		Else 
			[MPA_DefinicionEjes:185]DesdeGrado:4:=999
			[MPA_DefinicionEjes:185]HastaGrado:5:=999
		End if 
	End if 
	SAVE RECORD:C53([MPA_DefinicionEjes:185])
End for 

ALL RECORDS:C47([MPA_DefinicionDimensiones:188])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_recNums;"")
For ($i;1;Size of array:C274($al_recNums))
	READ WRITE:C146([MPA_DefinicionDimensiones:188])
	GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNums{$i})
	QUERY:C277([MPA_DefinicionAreas:186];[MPA_DefinicionAreas:186]ID:1=[MPA_DefinicionDimensiones:188]ID_Area:2)
	ARRAY TEXT:C222(atMPA_EtapasArea;0)
	ARRAY LONGINT:C221(alMPA_NivelDesde;0)
	ARRAY LONGINT:C221(alMPA_NivelHasta;0)
	ARRAY TEXT:C222(atMPA_NivelDesde;0)
	ARRAY TEXT:C222(atMPA_NivelHasta;0)
	
	If (BLOB size:C605([MPA_DefinicionAreas:186]xEtapas:10)=0)
		BLOB_Variables2Blob (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	Else 
		BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	End if 
	
	$l_nivelesAsignados:=0
	$l_primerNivelAsignado:=100
	$l_ultimoNivelAsignado:=-100
	For ($iBits;1;24)
		If ([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $iBits)
			$l_nivelesAsignados:=$l_nivelesAsignados+1
			If (<>aNivNo{$iBits}<$l_primerNivelAsignado)
				$l_primerNivelAsignado:=<>aNivNo{$iBits}
			End if 
			If (<>aNivNo{$iBits}>$l_ultimoNivelAsignado)
				$l_ultimoNivelAsignado:=<>aNivNo{$iBits}
			End if 
		End if 
	End for 
	If ($l_nivelesAsignados=24)
		[MPA_DefinicionDimensiones:188]DesdeGrado:6:=-100
		[MPA_DefinicionDimensiones:188]HastaGrado:7:=-100
	Else 
		$l_asignado_a_Etapa:=0
		For ($iEtapas;1;Size of array:C274(atMPA_EtapasArea))
			If (($l_primerNivelAsignado>=alMPA_NivelDesde{$iEtapas}) & ($l_ultimoNivelAsignado<=alMPA_NivelHasta{$iEtapas}))
				$l_asignado_a_Etapa:=$iEtapas
				$iEtapas:=Size of array:C274(atMPA_EtapasArea)
			End if 
		End for 
		If ($l_asignado_a_Etapa>0)
			[MPA_DefinicionDimensiones:188]DesdeGrado:6:=$l_primerNivelAsignado
			[MPA_DefinicionDimensiones:188]HastaGrado:7:=$l_ultimoNivelAsignado
		Else 
			[MPA_DefinicionDimensiones:188]DesdeGrado:6:=999
			[MPA_DefinicionDimensiones:188]HastaGrado:7:=999
		End if 
	End if 
	SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
End for 

ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNums;"")
For ($i;1;Size of array:C274($al_recNums))
	READ WRITE:C146([MPA_DefinicionCompetencias:187])
	GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNums{$i})
	QUERY:C277([MPA_DefinicionAreas:186];[MPA_DefinicionAreas:186]ID:1=[MPA_DefinicionCompetencias:187]ID_Area:11)
	ARRAY TEXT:C222(atMPA_EtapasArea;0)
	ARRAY LONGINT:C221(alMPA_NivelDesde;0)
	ARRAY LONGINT:C221(alMPA_NivelHasta;0)
	ARRAY TEXT:C222(atMPA_NivelDesde;0)
	ARRAY TEXT:C222(atMPA_NivelHasta;0)
	
	If (BLOB size:C605([MPA_DefinicionAreas:186]xEtapas:10)=0)
		BLOB_Variables2Blob (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	Else 
		BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	End if 
	
	$l_nivelesAsignados:=0
	$l_primerNivelAsignado:=100
	$l_ultimoNivelAsignado:=-100
	For ($iBits;1;24)
		If ([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $iBits)
			$l_nivelesAsignados:=$l_nivelesAsignados+1
			If (<>aNivNo{$iBits}<$l_primerNivelAsignado)
				$l_primerNivelAsignado:=<>aNivNo{$iBits}
			End if 
			If (<>aNivNo{$iBits}>$l_ultimoNivelAsignado)
				$l_ultimoNivelAsignado:=<>aNivNo{$iBits}
			End if 
		End if 
	End for 
	If ($l_nivelesAsignados=24)
		[MPA_DefinicionCompetencias:187]DesdeGrado:5:=-100
		[MPA_DefinicionCompetencias:187]HastaGrado:13:=-100
	Else 
		$l_asignado_a_Etapa:=0
		For ($iEtapas;1;Size of array:C274(atMPA_EtapasArea))
			If (($l_primerNivelAsignado>=alMPA_NivelDesde{$iEtapas}) & ($l_ultimoNivelAsignado<=alMPA_NivelHasta{$iEtapas}))
				$l_asignado_a_Etapa:=$iEtapas
				$iEtapas:=Size of array:C274(atMPA_EtapasArea)
			End if 
		End for 
		If ($l_asignado_a_Etapa>0)
			[MPA_DefinicionCompetencias:187]DesdeGrado:5:=$l_primerNivelAsignado
			[MPA_DefinicionCompetencias:187]HastaGrado:13:=$l_ultimoNivelAsignado
		Else 
			[MPA_DefinicionCompetencias:187]DesdeGrado:5:=999
			[MPA_DefinicionCompetencias:187]HastaGrado:13:=999
		End if 
	End if 
	SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
End for 

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
  //QUERY SELECTION([Alumnos_EvaluacionAprendizajes]; & [Alumnos_EvaluacionAprendizajes]PeriodosEvaluados_bitField=False)//Mono esto da error 
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63=0)
KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])

MPAdbu_EliminaItemsHuerfanos 

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0;*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"";*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | [Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61#"")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;$al_IdAsignatura;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;$al_IdAlumno;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEjes;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_nombreDimensiones;[MPA_DefinicionCompetencias:187]Competencia:6;$at_nombreCompetencias;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;$al_tipoObjeto;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;$al_IdEjes;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;$al_IdDimensiones;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;$al_IdCompetencias)
SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13;$at_literalP1;[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25;$at_literalP2;[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37;$at_literalP3;[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49;$at_literalP4;[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66;$at_literalP5;[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61;$at_literalFinal)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])#Size of array:C274($at_llaveRegistroAprendizajes))
	If (Application type:C494#4D Server:K5:6)
		CD_Dlog (0;__ ("Se produjo un error durante el compactaje (diferencias en el número de registros antes y depues de la operación).\r\rLa operación fue cancelada."))
	End if 
	LOG_RegisterEvt ("Se produjo un error durante el compactaje (diferencias en el número de registros "+"antes y depues de la operación). La operación fue cancelada.")
	CANCEL TRANSACTION:C241
Else 
	ARRAY TEXT:C222($aLlaveComparacionDespues;Size of array:C274($al_IdAsignatura))
	ARRAY TEXT:C222($at_evaluacionesPostCompact;Size of array:C274($al_IdAsignatura))
	For ($i;1;Size of array:C274($aLlaveComparacionDespues))
		Case of 
			: ($al_tipoObjeto{$i}=Eje_Aprendizaje)
				$t_enunciado:=$at_nombreEjes{$i}
			: ($al_tipoObjeto{$i}=Dimension_Aprendizaje)
				$t_enunciado:=$at_nombreDimensiones{$i}
			: ($al_tipoObjeto{$i}=Logro_Aprendizaje)
				$t_enunciado:=$at_nombreCompetencias{$i}
		End case 
		$at_llaveRegistroAprendizajes{$i}:=String:C10($al_IdAlumno{$i};"000000")+"."+String:C10($al_IdAsignatura{$i};"000000")+"."+String:C10($al_tipoObjeto{$i})+"."+Replace string:C233($t_enunciado;"\r";"¬")
		$at_evaluacionesPostCompact{$i}:=$at_literalP1{$i}+"."+$at_literalP2{$i}+"."+$at_literalP3{$i}+"."+$at_literalP4{$i}+"."+$at_literalP5{$i}+"."+$at_literalFinal{$i}
	End for 
	SORT ARRAY:C229($at_llaveRegistroAprendizajes;$at_evaluacionesPostCompact;>)
	
	For ($i;1;Size of array:C274($aLlaveComparacionDespues))
		If ($at_evaluacionesPostCompact{$i}#$at_evaluacionesExistentes{$i})
			APPEND TO ARRAY:C911($at_errores;"Evaluaciones diferentes\t"+$aLlaveComparacionDespues{$i}+Char:C90(Tab:K15:37)+$at_evaluacionesExistentes{$i}+Char:C90(Tab:K15:37)+$at_evaluacionesPostCompact{$i}+"\r")
		End if 
	End for 
	
	If (Size of array:C274($at_errores)>0)
		CLEAR PASTEBOARD:C402
		INSERT IN ARRAY:C227($at_errores;1;1)
		$at_errores{1}:="Error\tID Registro\tAntes\tDespues\r"
		$h_referenciaDocumento:=Create document:C266("Errores Compactaje MPA.txt";"TEXT")
		For ($i;1;Size of array:C274($at_errores))
			SEND PACKET:C103($h_referenciaDocumento;$at_errores{$i})
			TEXT TO BLOB:C554($at_errores{$i};$x_registroErrores;Mac text without length:K22:10)
		End for 
		CLOSE DOCUMENT:C267($h_referenciaDocumento)
		$t_mensajeError:="Se detectaron errores en la verificación de mapas de aprendizajes.\rUn archivo con"+" la descripción de errores fue guardada en un archivo almacenado junto a la aplic"+"a"+"ción. Adicionalmente el listado de errores fue copiado al portapapeles; puede peg"+"arlo en un planilla de cálculo o cualquier documento de texto."
		LOG_RegisterEvt ($t_mensajeError)
		If (Application type:C494#4D Server:K5:6)
			CD_Dlog (0;$t_mensajeError)
			APPEND DATA TO PASTEBOARD:C403("TEXT";$x_registroErrores)
		End if 
		CANCEL TRANSACTION:C241
		
	Else 
		$t_mensajeError:="La verificación y compactaje de mapas de aprendizajes resultó exitosa."
		LOG_RegisterEvt ($t_mensajeError)
		If (Application type:C494#4D Server:K5:6)
			CD_Dlog (0;$t_mensajeError)
		End if 
		VALIDATE TRANSACTION:C240
	End if 
End if 

IT_UThermometer (-2;$l_IdProcesoUTherm)

