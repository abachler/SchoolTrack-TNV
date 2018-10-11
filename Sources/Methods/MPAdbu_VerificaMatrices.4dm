//%attributes = {}
  // MÉTODO: MPAdbu_VerificaMatrices
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 04/06/12, 16:45:54
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPAdbu_VerificaMatrices()
  // ----------------------------------------------------
C_BLOB:C604($x_contenidoBlob)
_O_C_INTEGER:C282($i_matrices;$i_objetos;$i_periodos)
C_LONGINT:C283($l_bitsPeriodos;$l_bitsPeriodos;$l_IdCompetencia;$l_IdDimension;$l_IdEje;$l_IdMatriz;$l_numeroNivel;$l_processID)
C_TEXT:C284($t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_nombreMatriz;$t_uuid;$t_nombreNivel;$t_nombreMatriz)

ARRAY LONGINT:C221($al_IdCompetencias;0)
ARRAY LONGINT:C221($al_IdDimensiones;0)
ARRAY LONGINT:C221($al_RecNumMatrices;0)
ARRAY LONGINT:C221($al_RecNumObjetos;0)
ARRAY TEXT:C222($at_errores;0)
ARRAY TEXT:C222($at_nivelNombre;0)
ARRAY TEXT:C222($at_NombreCompetencia;0)
ARRAY TEXT:C222($at_NombreDimension;0)
ARRAY TEXT:C222($at_nombreEje;0)
ARRAY TEXT:C222($at_nombreMatriz;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_Colores;0)




  // CODIGO PRINCIPAL

  //Limpieza inicial: Elimino objetos sin el ID correspondiente al tipo de objeto
QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3;=;0;*)
QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Eje_Aprendizaje)
KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])

QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Dimension_Aprendizaje)
QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3;=;0;*)
QUERY SELECTION:C341([MPA_ObjetosMatriz:204]; | ;[MPA_ObjetosMatriz:204]ID_Dimension:4;=;0)
KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])

QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje;*)
QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Competencia:5;=;0)
KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])

READ ONLY:C145([MPA_AsignaturasMatrices:189])
ALL RECORDS:C47([MPA_AsignaturasMatrices:189])

LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];$al_RecNumMatrices;"")
For ($i_matrices;1;Size of array:C274($al_RecNumMatrices))
	
	  // para cada matriz definida en la base de datos
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$al_RecNumMatrices{$i_matrices})
	$l_numeroNivel:=[MPA_AsignaturasMatrices:189]NumeroNivel:4
	$l_IdMatriz:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
	$t_nombreMatriz:=[MPA_AsignaturasMatrices:189]NombreMatriz:2
	$t_nombreNivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[MPA_AsignaturasMatrices:189]NumeroNivel:4;->[xxSTR_Niveles:6]Nivel:1)
	
	  // VERIFICO QUE LOS EJES Y DIMENSIONES ASOCIADOS A LAS COMPETENCIAS DE LA MATRIZ ESTEN ASIGNADOS A LA MATRIZ Y HABILITADOS EN LOS MISMOS PERIODOS QUE LAS COMPETENCIAS
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje)
	
	
	LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_RecNumObjetos;"")
	For ($i_objetos;1;Size of array:C274($al_RecNumObjetos))
		
		  // para cada competencia de la matriz
		GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumObjetos{$i_objetos})
		$l_IdEje:=[MPA_ObjetosMatriz:204]ID_Eje:3
		$l_IdDimension:=[MPA_ObjetosMatriz:204]ID_Dimension:4
		$l_IdCompetencia:=[MPA_ObjetosMatriz:204]ID_Competencia:5
		$l_bitsPeriodos:=[MPA_ObjetosMatriz:204]Periodos:7
		
		  // si la competencia está asociada a una dimension
		If ($l_IDDimension#0)  //
			$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10($l_IDEje)+"."+String:C10($l_IdDimension)+"."+String:C10(0)
			$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
			If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
				  // si la dimensión a la que que está asignada la competencia no está definida en la matriz y el calculo de dimensiones se basa en las competencias, 
				  // agrego la Dimensión a la matriz y la habilito para los mismos períodos que la competencia
				CREATE RECORD:C68([MPA_ObjetosMatriz:204])
				[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
				[MPA_ObjetosMatriz:204]ID_Dimension:4:=$l_IdDimension
				[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_IDEje
				[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
				[MPA_ObjetosMatriz:204]Periodos:7:=$l_bitsPeriodos
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				  // inserto en arreglos los datos para generar el mensaje de la aplicación
				APPEND TO ARRAY:C911($at_errores;__ ("La dimensión a la que están asignadas competencias no estaba definida en la matriz de evaluación. La Dimensión de Aprendizaje fue agregada a la matriz."))  // error
				APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
				APPEND TO ARRAY:C911($at_nivelNombre;$t_nombreNivel)  // nivel
				APPEND TO ARRAY:C911($at_nombreMatriz;$t_nombreMatriz)  // matriz
				APPEND TO ARRAY:C911($at_nombreEje;"")  // eje
				APPEND TO ARRAY:C911($at_NombreDimension;KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->$l_IdDimension;->[MPA_DefinicionDimensiones:188]Dimensión:4))  // dimension
				APPEND TO ARRAY:C911($at_NombreCompetencia;KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->$l_IdCompetencia;->[MPA_DefinicionCompetencias:187]Competencia:6))  // competencia
				APPEND TO ARRAY:C911($al_Estilos;0)
			End if 
			
			
			  // si la dimensión no está habilitada en alguno de los periodos para los que la competencia está habilitada y el calculo de dimensiones se basa en las competencias, 
			  // habilito la Dimensión para los mismos períodos que la competencia
			$b_cambiosEnPeriodos:=False:C215
			For ($i_periodos;0;5)
				If (($l_bitsPeriodos ?? $i_Periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
					[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
					$b_cambiosEnPeriodos:=True:C214
				End if 
			End for 
			
			If ($b_cambiosEnPeriodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				  // inserto en arreglos los datos para generar el mensaje de la aplicación
				APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
				APPEND TO ARRAY:C911($at_errores;__ ("La dimensión a la que están asignadas competencias no estaba definida en la matriz de evaluación en uno o mas de los periodos habilitados para la competencia. La Dimensión de Aprendizaje fue habilitada para los períodos necesarios."))  // error
				APPEND TO ARRAY:C911($at_nivelNombre;$t_nombreNivel)  // nivel
				APPEND TO ARRAY:C911($at_nombreMatriz;$t_nombreMatriz)  // matriz
				APPEND TO ARRAY:C911($at_nombreEje;"")  // eje
				APPEND TO ARRAY:C911($at_NombreDimension;KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->$l_IdDimension;->[MPA_DefinicionDimensiones:188]Dimensión:4))  // dimension
				APPEND TO ARRAY:C911($at_NombreCompetencia;KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->$l_IdCompetencia;->[MPA_DefinicionCompetencias:187]Competencia:6))  // competencia
				APPEND TO ARRAY:C911($al_Estilos;0)
			End if 
		End if 
		
		GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumObjetos{$i_objetos})
		
		  // si la competencia está asociada a un eje
		If ($l_IDEje#0)
			  // busco en la matriz el eje al que está asociado la competencia
			$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10($l_IDEje)+"."+String:C10(0)+"."+String:C10(0)
			$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
			If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
				  // si el eje al que que está asignado la competencia no está definido en la matriz y el eje es calculado en base a las competencias,
				  // agrego el Eje a la matriz y lo habilito para los mismos períodos que la competencia
				CREATE RECORD:C68([MPA_ObjetosMatriz:204])
				[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
				[MPA_ObjetosMatriz:204]ID_Competencia:5:=0
				[MPA_ObjetosMatriz:204]ID_Dimension:4:=0
				[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_IDEje
				[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
				[MPA_ObjetosMatriz:204]Periodos:7:=$l_bitsPeriodos
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				
				  // inserto en arreglos los datos para generar el mensaje de la aplicación
				APPEND TO ARRAY:C911($at_errores;__ ("El eje al que están asignadas competencias no estaba definido en la matriz de evaluación. El Eje de Aprendizaje fue agregado a la matriz."))  // error)
				APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
				APPEND TO ARRAY:C911($at_nivelNombre;$t_nombreNivel)  // nivel
				APPEND TO ARRAY:C911($at_nombreMatriz;$t_nombreMatriz)  // matriz
				APPEND TO ARRAY:C911($at_nombreEje;KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->$l_IdEje;->[MPA_DefinicionEjes:185]Nombre:3))  // eje
				APPEND TO ARRAY:C911($at_NombreDimension;"")  // dimension
				APPEND TO ARRAY:C911($at_NombreCompetencia;"")  // competencia
				APPEND TO ARRAY:C911($al_Estilos;0)
			End if 
			
			  // si el eje no está habilitado en alguno de los periodos para los que la competencia está habilitada y los ejes son calculados sobre la base de las competencias, 
			  // habilito el eje en los mismos periodos que la competencia.
			$b_cambiosEnPeriodos:=False:C215
			For ($i_periodos;0;5)
				If (($l_bitsPeriodos ?? $i_Periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
					[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
					$b_cambiosEnPeriodos:=True:C214
				End if 
			End for 
			
			If ($b_cambiosEnPeriodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				  // inserto en arreglos los datos para generar el mensaje de la aplicación
				APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
				APPEND TO ARRAY:C911($at_errores;__ ("El eje al que están asignadas competencias no estaba definido en la matriz de evaluación en uno o mas de los periodos habilitados para la competencia. El Eje de Aprendizaje fue habilitado en los períodos necesarios."))  // error
				APPEND TO ARRAY:C911($at_nivelNombre;$t_nombreNivel)  // nivel
				APPEND TO ARRAY:C911($at_nombreMatriz;$t_nombreMatriz)  // matriz
				APPEND TO ARRAY:C911($at_nombreEje;KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->$l_IdEje;->[MPA_DefinicionEjes:185]Nombre:3))  // eje
				APPEND TO ARRAY:C911($at_NombreDimension;"")  // dimension
				APPEND TO ARRAY:C911($at_NombreCompetencia;"")  // competencia
				APPEND TO ARRAY:C911($al_Estilos;0)
			End if 
		End if 
		
		
		GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumObjetos{$i_objetos})
		
	End for 
	
	  // VERIFICO QUE LOS EJES ASOCIADOS A LAS DIMENSIONES DE LA MATRIZ ESTEN ASIGNADOS A LA MATRIZ Y ASOCIADOS EN LOS MISMOS PERIODOS
	READ WRITE:C146([MPA_ObjetosMatriz:204])
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Dimension_Aprendizaje)
	SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Competencia:5;$al_IdDimensiones)
	LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_RecNumObjetos;"")
	
	For ($i_objetos;1;Size of array:C274($al_RecNumObjetos))
		  // para cada dimensión de la matriz
		GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumObjetos{$i_objetos})
		$l_IdEje:=[MPA_ObjetosMatriz:204]ID_Eje:3
		$l_IdDimension:=[MPA_ObjetosMatriz:204]ID_Dimension:4
		$l_bitsPeriodos:=[MPA_ObjetosMatriz:204]Periodos:7
		
		If ($l_IDEje#0)
			  // busco en la matriz el eje al que está asociado la dimensión
			$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10($l_IDEje)+"."+String:C10(0)+"."+String:C10(0)
			$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
			If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
				  // si el eje al que que está asignada la dimensión no está definido en la matriz y los ejes son calculados sobre la base de las dimensiones, 
				  // agrego el eje a la matriz y lo habilito en los mismos períodos que la dimensión
				CREATE RECORD:C68([MPA_ObjetosMatriz:204])
				[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
				[MPA_ObjetosMatriz:204]ID_Competencia:5:=0
				[MPA_ObjetosMatriz:204]ID_Dimension:4:=0
				[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_IDEje
				[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
				[MPA_ObjetosMatriz:204]Periodos:7:=$l_bitsPeriodos
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				
				
				  // inserto en arreglos los datos para generar el mensaje de la aplicación
				APPEND TO ARRAY:C911($at_errores;__ ("El eje al que están asignadas dimensiones no estaba definido en la matriz de evaluación. El Eje de Aprendizaje fue agregado a la matriz."))  // error)  
				APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
				APPEND TO ARRAY:C911($at_nivelNombre;$t_nombreNivel)  // nivel
				APPEND TO ARRAY:C911($at_nombreMatriz;$t_nombreMatriz)  // matriz
				APPEND TO ARRAY:C911($at_nombreEje;KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->$l_IdEje;->[MPA_DefinicionEjes:185]Nombre:3))  // eje
				APPEND TO ARRAY:C911($at_NombreDimension;KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->$l_IdCompetencia;->[MPA_DefinicionCompetencias:187]Competencia:6))  // dimension
				APPEND TO ARRAY:C911($at_NombreCompetencia;"")  // competencia
				APPEND TO ARRAY:C911($al_Estilos;0)
			End if 
			
			
			  // si el eje no está habilitado en alguno de los periodos para los que la dimensión está habilitada los ejes son calculados sobre la base de las dimensiones, 
			  // habilito el eje en los mismos periodos que la dimensión.
			$b_cambiosEnPeriodos:=False:C215
			For ($i_periodos;0;5)
				If (($l_bitsPeriodos ?? $i_Periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
					[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
					$b_cambiosEnPeriodos:=True:C214
				End if 
			End for 
			
			If ($b_cambiosEnPeriodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				  // inserto en arreglos los datos para generar el mensaje de la aplicación
				APPEND TO ARRAY:C911($at_errores;__ ("El eje al que están asignadas dimensiones no estaba definido en la matriz de evaluación en uno o mas de los periodos habilitados para la dimensión. El Eje de Aprendizaje fue habilitado en los períodos necesarios."))  // error
				APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
				APPEND TO ARRAY:C911($at_nivelNombre;$t_nombreNivel)  // nivel
				APPEND TO ARRAY:C911($at_nombreMatriz;$t_nombreMatriz)  // matriz
				APPEND TO ARRAY:C911($at_nombreEje;KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->$l_IdEje;->[MPA_DefinicionEjes:185]Nombre:3))  // eje
				APPEND TO ARRAY:C911($at_NombreDimension;"")  // dimension
				APPEND TO ARRAY:C911($at_NombreCompetencia;KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->$l_IdCompetencia;->[MPA_DefinicionCompetencias:187]Competencia:6))  // competencia
				APPEND TO ARRAY:C911($al_Estilos;0)
			End if 
			
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumObjetos{$i_objetos})
		End if 
	End for 
End for 

KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])


If (Size of array:C274($at_errores)>0)
	AT_MultiLevelSort (">>";->$at_nombreMatriz;->$at_nivelNombre;->$at_nombreEje;->$at_NombreDimension;->$at_NombreCompetencia;->$at_errores;->$al_Colores;->$al_Estilos)
	$t_Encabezado:="Verificación de la configuración de matrices de evaluación"
	$t_descripcion:="Durante el análisis de las opciones de cálculos en las matrices de aprendizajes se detectaron inconsistencias "
	$t_descripcion:=$t_descripcion+"en la jerarquía de evaluación:\r\r"
	$t_descripcion:=$t_descripcion+"Ejes o Dimensiones de aprendizajes de los cuales dependen Competencias o Dimensiones no estaban definidos en algunas matrices"
	$t_descripcion:=$t_descripcion+"o bien no estaban habilitados en los períodos en los cuales estaban habilitados los enunciados de nivel inferior.\r"
	$t_descripcion:=$t_descripcion+"Si una competencia depende de una Dimensión o Eje de aprendizaje, estos deben ser asignados a la matriz y habilitados en los mismos períodos."
	$t_descripcion:=$t_descripcion+"Una Dimensión de aprendizaje, por otra parte depende siempre de un Eje. Ese eje debe necesariamente estar definido en la matriz de evaluación."
	$t_descripcion:=$t_descripcion+" En la lista a continuación encontrará una descripción detallada de las inconsistencias detectadas y corregidas"
	$t_contenidoTexto:=""
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Nivel")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Matriz")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Eje")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Dimensión")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Competencia")
	
	  //ARRAY LONGINT($al_estilos;Size of array($at_errores))
	  //ARRAY LONGINT($al_Colores;Size of array($at_errores))
	
	
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_nivelNombre;->$at_nombreMatriz;->$at_nombreEje;->$at_NombreDimension;->$at_NombreCompetencia)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	$t_mensajeFalla:="Se detectaron inconsistencias en la configuración de matrices de evaluación.\r\rEl detalle será mostrado en el centro de notificaciones."
	$t_mensajeExito:="No se detectó ninguna inconsistencia en las matrices de evaluación."
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
	
Else 
	
	$0:=0
End if 



