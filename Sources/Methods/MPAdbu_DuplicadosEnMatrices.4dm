//%attributes = {}
  // MPAdbu_DuplicadosEnMatrices()
  // 
  //
If (False:C215)
	  // ---------------------------------------------
	  // Usuario (OS): Alberto Bachler
	  // Fecha: 08/01/13, 16:33:07
	  // ---------------------------------------------
End if 


  // CODIGO
_O_C_INTEGER:C282($i_duplicados;$i_Matrices;$i_Registros)
C_LONGINT:C283($l_IdCompetencia;$l_IdDimension;$l_IdEje;$l_IdMatriz;$l_numDuplicados;$l_PeriodosAplicacion;$l_recNumObjeto)

ARRAY LONGINT:C221($al_PeriodosAplicacion;0)
ARRAY LONGINT:C221($al_PeriodosEvaluados;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_RecNums_a_Eliminar;0)
ARRAY LONGINT:C221($al_recNumsDuplicados;0)
ARRAY TEXT:C222($at_valoresDuplicados;0)




  // CÓDIGO

ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];$al_RecNums;"")
For ($i_Matrices;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$al_RecNums{$i_Matrices})
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	$l_numDuplicados:=KRL_ValoresDuplicados (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$al_recNumsDuplicados;->$at_valoresDuplicados)
	For ($i_duplicados;1;$l_numDuplicados)
		$l_recNumObjeto:=$al_recNumsDuplicados{$i_duplicados}
		$l_IdMatriz:=Num:C11(ST_GetWord ($at_valoresDuplicados{$i_duplicados};2;"."))
		$l_IdEje:=Num:C11(ST_GetWord ($at_valoresDuplicados{$i_duplicados};3;"."))
		$l_IdDimension:=Num:C11(ST_GetWord ($at_valoresDuplicados{$i_duplicados};4;"."))
		$l_IdCompetencia:=Num:C11(ST_GetWord ($at_valoresDuplicados{$i_duplicados};5;"."))
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;=;$l_IdMatriz;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_IdDimension;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;=;$l_IdCompetencia)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10;$al_PeriodosAplicacion;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63;$al_PeriodosEvaluados)
		
		$l_PeriodosAplicacion:=0
		For ($i_Registros;1;Size of array:C274($al_PeriodosAplicacion))
			If ($al_PeriodosAplicacion{$i_Registros}=0)
				$l_PeriodosAplicacion:=$l_PeriodosAplicacion ?+ 0
			End if 
			If ($al_PeriodosAplicacion{$i_Registros} ?? 0)
				$l_PeriodosAplicacion:=$l_PeriodosAplicacion ?+ 0
			End if 
			If (($al_PeriodosAplicacion{$i_Registros} ?? 1) | ($al_PeriodosEvaluados{$i_Registros} ?? 1))
				$l_PeriodosAplicacion:=$l_PeriodosAplicacion ?+ 1
			End if 
			If (($al_PeriodosAplicacion{$i_Registros} ?? 2) | ($al_PeriodosEvaluados{$i_Registros} ?? 2))
				$l_PeriodosAplicacion:=$l_PeriodosAplicacion ?+ 2
			End if 
			If (($al_PeriodosAplicacion{$i_Registros} ?? 3) | ($al_PeriodosEvaluados{$i_Registros} ?? 3))
				$l_PeriodosAplicacion:=$l_PeriodosAplicacion ?+ 3
			End if 
			If (($al_PeriodosAplicacion{$i_Registros} ?? 4) | ($al_PeriodosEvaluados{$i_Registros} ?? 4))
				$l_PeriodosAplicacion:=$l_PeriodosAplicacion ?+ 4
			End if 
			If (($al_PeriodosAplicacion{$i_Registros} ?? 5) | ($al_PeriodosEvaluados{$i_Registros} ?? 5))
				$l_PeriodosAplicacion:=$l_PeriodosAplicacion ?+ 5
			End if 
		End for 
		
		KRL_GotoRecord (->[MPA_ObjetosMatriz:204];$l_recNumObjeto;True:C214)
		If ([MPA_ObjetosMatriz:204]Periodos:7#$l_PeriodosAplicacion)
			[MPA_ObjetosMatriz:204]Periodos:7:=$l_PeriodosAplicacion
			SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			UNLOAD RECORD:C212([MPA_ObjetosMatriz:204])
		End if 
		
		For ($i;$i_duplicados+1;Size of array:C274($al_recNumsDuplicados))
			If ($at_valoresDuplicados{$i}=$at_valoresDuplicados{$i-1})
				APPEND TO ARRAY:C911($al_RecNums_a_Eliminar;$al_recNumsDuplicados{$i})
			Else 
				$i:=Size of array:C274($al_recNumsDuplicados)
			End if 
		End for 
	End for 
End for 

If (Size of array:C274($al_RecNums_a_Eliminar)>0)
	ARRAY TEXT:C222($at_Areas;0)
	ARRAY TEXT:C222($at_Nivel;0)
	ARRAY TEXT:C222($at_Matriz;0)
	ARRAY TEXT:C222($at_Competencias;0)
	ARRAY TEXT:C222($at_Dimensiones;0)
	ARRAY TEXT:C222($at_Ejes;0)
	ARRAY TEXT:C222($at_Errores;0)
	ARRAY TEXT:C222($at_TitulosColumnas;0)
	ARRAY LONGINT:C221($al_estilos;0)
	ARRAY LONGINT:C221($al_Colores;0)
	For ($i;1;Size of array:C274($al_RecNums_a_Eliminar))
		$l_recNumObjeto:=$al_RecNums_a_Eliminar{$i}
		KRL_GotoRecord (->[MPA_ObjetosMatriz:204];$l_recNumObjeto)
		$l_IdMatriz:=[MPA_ObjetosMatriz:204]ID_Matriz:1
		$l_IdArea:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IdMatriz;->[MPA_AsignaturasMatrices:189]ID_Area:22)
		$l_Nivel:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IdMatriz;->[MPA_AsignaturasMatrices:189]NumeroNivel:4)
		APPEND TO ARRAY:C911($at_Errores;__ ("Enunciado duplicado en la matriz"))
		APPEND TO ARRAY:C911($at_Areas;KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->$l_IdArea;->[MPA_DefinicionAreas:186]AreaAsignatura:4))
		APPEND TO ARRAY:C911($at_Nivel;KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_Nivel;->[xxSTR_Niveles:6]Nivel:1))
		APPEND TO ARRAY:C911($at_Matriz;KRL_GetTextFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IdMatriz;->[MPA_AsignaturasMatrices:189]NombreMatriz:2))
		APPEND TO ARRAY:C911($at_Ejes;KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_ObjetosMatriz:204]ID_Eje:3;->[MPA_DefinicionEjes:185]Nombre:3))
		APPEND TO ARRAY:C911($at_Dimensiones;KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]Dimensión:4))
		APPEND TO ARRAY:C911($at_Competencias;KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;->[MPA_DefinicionCompetencias:187]Competencia:6))
		APPEND TO ARRAY:C911($al_estilos;0)
		APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
	End for 
	
	
	
	CREATE SELECTION FROM ARRAY:C640([MPA_ObjetosMatriz:204];$al_RecNums_a_Eliminar)
	KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
	
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Area")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Nivel")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Matriz")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Eje")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Dimensión")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Competencia")
	
	
	$t_Encabezado:="Detección de asignaciones duplicadas en matrices de Evaluaciones de Aprendizaje"
	$t_descripcion:="Se encontraron enunciados duplicados en algunas matrices de Evaluación de Aprendizajes.\r\r"
	$t_descripcion:=$t_descripcion+"La lista a continuación muestra los enunciados duplicados que fueron eliminados."
	$t_contenidoTexto:=""
	$t_mensajeFalla:="Se encontraron enunciados duplicados en algunas matrices de Evaluación de Aprendizajes.\r\rEl detalle será mostrado en el centro de notificaciones."
	$t_mensajeExito:="No se encontró ningún enunciado duplicado en ninguna matriz de Evaluaciones de Aprendizaje."
	
	AT_MultiLevelSort (">>>>>>";->$at_errores;->$at_Areas;->$at_Nivel;->$at_Matriz;->$at_Ejes;->$at_Dimensiones;->$at_Competencias;->$al_estilos;->$al_Colores)
	
	
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_Areas;->$at_Nivel;->$at_Matriz;->$at_Ejes;->$at_Dimensiones;->$at_Competencias)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
End if 





