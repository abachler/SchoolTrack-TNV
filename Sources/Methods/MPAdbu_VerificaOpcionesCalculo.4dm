//%attributes = {}
  // MÉTODO: MPAdbu_VerificaOpcionesCalculo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/05/12, 19:06:58
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // MPAdbu_DetectaFallasEnMatrices()
  // ----------------------------------------------------
ARRAY LONGINT:C221($al_IdMatrices;0)
ARRAY LONGINT:C221($al_IdCompetencias;0)
ARRAY LONGINT:C221($al_IdDimensiones;0)
ARRAY LONGINT:C221($al_IdEjes;0)
ARRAY LONGINT:C221($al_RecNumDimensiones;0)
ARRAY LONGINT:C221($al_RecNumMatrices;0)
ARRAY LONGINT:C221($al_RecNumEjes;0)
ARRAY TEXT:C222($at_errores;0)

ARRAY LONGINT:C221($al_Colores;0)
ARRAY LONGINT:C221($al_Estilos;0)

  // CODIGO PRINCIPAL
ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];$al_RecNumMatrices;"")
For ($i;1;Size of array:C274($al_RecNumMatrices))
	
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$al_RecNumMatrices{$i})
	If ([MPA_AsignaturasMatrices:189]ID_Matriz:1=36)
		
	End if 
	
	  // si el calculo de las dimensiones se hace sobre las evaluaciones de competencias
	If ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje)
		  //Busco las dimensiones de la matriz
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Dimension_Aprendizaje)
		
		  // para cada dimensión de la matriz
		LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_RecNumDimensiones;"")
		For ($i_dimensiones;1;Size of array:C274($al_RecNumDimensiones))
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumDimensiones{$i_dimensiones})
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_competencias)
			  // busco las competencias asociadas a la dimension
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4;=;[MPA_ObjetosMatriz:204]ID_Dimension:4;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje)
			  // si no encuentro competencias registro los ID de la matriz y de la dimension en arreglos
			If ($l_competencias=0)
				APPEND TO ARRAY:C911($al_IdMatrices;[MPA_ObjetosMatriz:204]ID_Matriz:1)
				APPEND TO ARRAY:C911($al_IdEjes;[MPA_ObjetosMatriz:204]ID_Eje:3)
				APPEND TO ARRAY:C911($al_IdDimensiones;[MPA_ObjetosMatriz:204]ID_Dimension:4)
				APPEND TO ARRAY:C911($al_IdCompetencias;0)
				APPEND TO ARRAY:C911($at_errores;__ ("La matriz está configurada para que las dimensiones de aprendizaje sean calculadas sobre la base de las evaluaciones de competencias pero no hay competencias asociadas a la dimension."))
				APPEND TO ARRAY:C911($al_colores;Red:K11:4)
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End for 
	End if 
	
	  // si el calculo de los Ejes se hace sobre las evaluaciones de competencias
	If ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Logro_Aprendizaje)
		  //Busco los Eje de la matriz
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Eje_Aprendizaje)
		
		  // para cada dimensión de la matriz
		LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_RecNumEjes;"")
		For ($i_ejes;1;Size of array:C274($al_RecNumEjes))
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumEjes{$i_ejes})
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_competencias)
			  // busco las competencias asociadas al eje
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3;=;[MPA_ObjetosMatriz:204]ID_Eje:3;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje)
			  // si no encuentro competencias registro los ID de la matriz y del eje en arreglos
			If ($l_competencias=0)
				APPEND TO ARRAY:C911($al_IdMatrices;[MPA_ObjetosMatriz:204]ID_Matriz:1)
				APPEND TO ARRAY:C911($al_IdEjes;[MPA_ObjetosMatriz:204]ID_Eje:3)
				APPEND TO ARRAY:C911($al_IdDimensiones;0)
				APPEND TO ARRAY:C911($al_IdCompetencias;0)
				APPEND TO ARRAY:C911($at_errores;__ ("La matriz está configurada para que los ejes de aprendizaje sean calculados sobre la base de las evaluaciones de competencias pero no hay competencias asociadas al eje."))
				APPEND TO ARRAY:C911($al_colores;Red:K11:4)
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End for 
	End if 
	
	
	  // si el calculo de los Ejes se hace sobre las evaluaciones de dimension
	If ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Dimension_Aprendizaje)
		  //Busco los Eje de la matriz
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Eje_Aprendizaje)
		
		  // para cada dimensión de la matriz
		LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_RecNumEjes;"")
		For ($i_ejes;1;Size of array:C274($al_RecNumEjes))
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumEjes{$i_ejes})
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_dimensiones)
			  // busco las dimensiones asociadas al eje
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3;=;[MPA_ObjetosMatriz:204]ID_Eje:3;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Dimension_Aprendizaje)
			  // si no encuentro dimensiones registro los ID de la matriz y del eje en arreglos
			If ($l_dimensiones=0)
				APPEND TO ARRAY:C911($al_IdMatrices;[MPA_ObjetosMatriz:204]ID_Matriz:1)
				APPEND TO ARRAY:C911($al_IdEjes;[MPA_ObjetosMatriz:204]ID_Eje:3)
				APPEND TO ARRAY:C911($al_IdDimensiones;0)
				APPEND TO ARRAY:C911($al_IdCompetencias;0)
				APPEND TO ARRAY:C911($at_errores;__ ("La matriz está configurada para que los ejes de aprendizaje sean calculados sobre la base de las evaluaciones de dimensiones de aprendizaje pero no hay dimensiones asociadas al eje."))
				APPEND TO ARRAY:C911($al_colores;Red:K11:4)
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End for 
	End if 
	
	If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_ejes)
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Eje_Aprendizaje)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_ejes=0)
			APPEND TO ARRAY:C911($al_IdMatrices;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
			APPEND TO ARRAY:C911($al_IdEjes;0)
			APPEND TO ARRAY:C911($al_IdDimensiones;0)
			APPEND TO ARRAY:C911($al_IdCompetencias;0)
			APPEND TO ARRAY:C911($at_errores;__ ("La matriz está configurada para que el resultado de la conversión sea calculado sobre la base de las evaluaciones de ejes de aprendizaje pero no hay ejes asignados a la matriz."))
		End if 
	End if 
	
	If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_dimensiones)
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Dimension_Aprendizaje)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_dimensiones=0)
			APPEND TO ARRAY:C911($al_IdMatrices;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
			APPEND TO ARRAY:C911($al_IdEjes;0)
			APPEND TO ARRAY:C911($al_IdDimensiones;0)
			APPEND TO ARRAY:C911($al_IdCompetencias;0)
			APPEND TO ARRAY:C911($at_errores;__ ("La matriz está configurada para que el resultado de la conversión sea calculado sobre la base de las evaluaciones de dimensiones de aprendizaje pero no hay dimensiones asignadas a la matriz."))
			APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		End if 
	End if 
	
	If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_competencias)
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_competencias=0)
			APPEND TO ARRAY:C911($al_IdMatrices;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
			APPEND TO ARRAY:C911($al_IdEjes;0)
			APPEND TO ARRAY:C911($al_IdDimensiones;0)
			APPEND TO ARRAY:C911($al_IdCompetencias;0)
			APPEND TO ARRAY:C911($at_errores;__ ("La matriz está configurada para que el resultado de la conversión sea calculado sobre la base de las evaluaciones de competencias pero no hay competencias asignadas a la matriz."))
			APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		End if 
	End if 
	
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$aRecNums;"")
	For ($i_Objetos;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([MPA_ObjetosMatriz:204];$aRecNums{$i_Objetos})
		Case of 
			: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
				$l_indexNivel:=Find in array:C230(<>aNivNo;[MPA_AsignaturasMatrices:189]NumeroNivel:4)
				QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=[MPA_ObjetosMatriz:204]ID_Competencia:5)
				If (Records in selection:C76([MPA_DefinicionCompetencias:187])>0)
					QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
					If (Records in selection:C76([MPA_DefinicionCompetencias:187])=0)
						APPEND TO ARRAY:C911($al_IdMatrices;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
						APPEND TO ARRAY:C911($al_IdEjes;0)
						APPEND TO ARRAY:C911($al_IdDimensiones;0)
						APPEND TO ARRAY:C911($al_IdCompetencias;[MPA_DefinicionCompetencias:187]ID:1)
						APPEND TO ARRAY:C911($at_errores;__ ("Competencia existía en matriz pero no en en el mapa correspondiente al nivel.\r\rFue retirada de la matriz."))
						APPEND TO ARRAY:C911($al_colores;Green:K11:9)
						KRL_DeleteRecord (->[MPA_ObjetosMatriz:204])
					End if 
				Else 
					KRL_DeleteRecord (->[MPA_ObjetosMatriz:204])
				End if 
				
			: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
				$l_indexNivel:=Find in array:C230(<>aNivNo;[MPA_AsignaturasMatrices:189]NumeroNivel:4)
				QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1=[MPA_ObjetosMatriz:204]ID_Dimension:4)
				If (Records in selection:C76([MPA_DefinicionDimensiones:188])>0)
					QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $l_indexNivel)
					If (Records in selection:C76([MPA_DefinicionDimensiones:188])=0)
						APPEND TO ARRAY:C911($al_IdMatrices;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
						APPEND TO ARRAY:C911($al_IdEjes;0)
						APPEND TO ARRAY:C911($al_IdDimensiones;[MPA_ObjetosMatriz:204]ID_Dimension:4)
						APPEND TO ARRAY:C911($al_IdCompetencias;0)
						APPEND TO ARRAY:C911($at_errores;__ ("Dimensión existía en la matriz pero no en en el mapa correspondiente al nivel.\r\rFue retirada de la matriz."))
						APPEND TO ARRAY:C911($al_colores;Green:K11:9)
						KRL_DeleteRecord (->[MPA_ObjetosMatriz:204])
					End if 
				Else 
					KRL_DeleteRecord (->[MPA_ObjetosMatriz:204])
				End if 
				
			: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
				$l_indexNivel:=Find in array:C230(<>aNivNo;[MPA_AsignaturasMatrices:189]NumeroNivel:4)
				QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=[MPA_ObjetosMatriz:204]ID_Eje:3)
				If (Records in selection:C76([MPA_DefinicionEjes:185])>0)
					QUERY SELECTION BY FORMULA:C207([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]BitsNiveles:20 ?? $l_indexNivel)
					If (Records in selection:C76([MPA_DefinicionEjes:185])=0)
						APPEND TO ARRAY:C911($al_IdMatrices;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
						APPEND TO ARRAY:C911($al_IdEjes;[MPA_ObjetosMatriz:204]ID_Eje:3)
						APPEND TO ARRAY:C911($al_IdDimensiones;0)
						APPEND TO ARRAY:C911($al_IdCompetencias;0)
						APPEND TO ARRAY:C911($at_errores;__ ("Eje existía en matriz pero no en en el mapa correspondiente al nivel.\r\rFue retirado de la matriz"))
						APPEND TO ARRAY:C911($al_colores;Green:K11:9)
						KRL_DeleteRecord (->[MPA_ObjetosMatriz:204])
					End if 
				Else 
					KRL_DeleteRecord (->[MPA_ObjetosMatriz:204])
				End if 
		End case 
	End for 
End for 


If (Size of array:C274($at_errores)>0)
	ARRAY TEXT:C222($at_nivelNombre;0)
	ARRAY TEXT:C222($at_nombreMatriz;0)
	ARRAY TEXT:C222($at_nombreEje;0)
	ARRAY TEXT:C222($at_NombreDimension;0)
	ARRAY TEXT:C222($at_NombreCompetencia;0)
	
	For ($i;1;Size of array:C274($at_errores))
		$l_IdMatriz:=$al_IdMatrices{$i}
		$t_nombreMatriz:=KRL_GetTextFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IdMatriz;->[MPA_AsignaturasMatrices:189]Asignatura:3)
		$l_nivelMatriz:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IdMatriz;->[MPA_AsignaturasMatrices:189]NumeroNivel:4)
		$t_nivelNombre:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelMatriz;->[xxSTR_Niveles:6]Nivel:1)
		$l_IDEje:=$al_IdEjes{$i}
		$t_nombreEje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->$l_IDEje;->[MPA_DefinicionEjes:185]Nombre:3)
		$l_IdDimension:=$al_IdDimensiones{$i}
		$t_NombreDimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->$l_IdDimension;->[MPA_DefinicionDimensiones:188]Dimensión:4)
		$l_IdCompetencia:=$al_IdCompetencias{$i}
		$t_NombreCompetencia:=KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->$l_IdCompetencia;->[MPA_DefinicionCompetencias:187]Competencia:6)
		
		APPEND TO ARRAY:C911($at_nivelNombre;$t_nivelNombre)  // nivel
		APPEND TO ARRAY:C911($at_nombreMatriz;$t_nombreMatriz)  // matriz
		APPEND TO ARRAY:C911($at_nombreEje;$t_nombreEje)  // eje
		APPEND TO ARRAY:C911($at_NombreDimension;$t_NombreDimension)  // dimension
		APPEND TO ARRAY:C911($at_NombreCompetencia;$t_NombreCompetencia)  // dimension
		
	End for 
	
	AT_MultiLevelSort (">>";->$at_nombreMatriz;->$at_nivelNombre;->$at_nombreEje;->$at_NombreDimension;->$at_NombreCompetencia;->$at_errores;->$al_colores)
	$t_Encabezado:="Verificación de la configuración opciones de cálculos de matrices de evaluación"
	$t_descripcion:="Durante el análisis de las opciones de cálculos en las matrices de aprendizajes se detectaron inconsistencias "
	$t_descripcion:=$t_descripcion+"entre la modalidad de calculos configuradas y los items de evaluación existentes.\r"
	$t_descripcion:=$t_descripcion+"En la lista a  la derecha encontrará una descripción detallada de las inconsistencias detectadas.\r\r"
	$t_descripcion:=$t_descripcion+"Para evitar errores en los cálculos le recomendamos resolver estas inconsistencias lo antes posible."
	$t_contenidoTexto:=""
	
	ARRAY TEXT:C222($at_TitulosColumnas;0)
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Nivel")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Matriz")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Eje")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Dimensión")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Competencia")
	
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_nivelNombre;->$at_nombreMatriz;->$at_nombreEje;->$at_NombreDimension;->$at_NombreCompetencia)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	$t_mensajeFalla:="Se detectaron inconsistencias en la configuración opciones de cálculos de matrices de evaluación.\r\rEl detalle será mostrado en el centro de notificaciones."
	$t_mensajeExito:="No se detectó ninguna inconsistencia en opciones de cálculos de matrices de evaluación."
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
	
Else 
	
	$0:=0
	
End if 




