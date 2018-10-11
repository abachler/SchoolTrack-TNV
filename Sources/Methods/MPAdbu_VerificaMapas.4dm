//%attributes = {}
  // MÉTODO: MPAdbu_VerificaMapas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/05/12, 11:13:07
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Verifica la integridad de la configuración de mapas 
  // - competencias únicas en un mismo contenedor (error si no lo son)
  // - dimensiones asociadas a ejes (error si no lo están)
  // - competencias asociadas a ejes o dimensiones (advertencia si no lo están)
  //
  // PARÁMETROS
  // UD_v20120529_CompetenciasUnicas()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_BLOB:C604($x_contenidoBlob)
C_LONGINT:C283($l_duplicados;$i)
C_TEXT:C284($t_area;$t_contenidoTexto;$t_descripcion;$t_dimension;$t_eje;$t_errorDuplicacion;$t_TituloVentana;$t_uuid)

ARRAY LONGINT:C221($aRecNums;0)
ARRAY TEXT:C222($at_Areas;0)
ARRAY TEXT:C222($at_Competencias;0)
ARRAY TEXT:C222($at_Dimensiones;0)
ARRAY TEXT:C222($at_Ejes;0)
ARRAY TEXT:C222($at_Errores;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_Colores;0)

  // CODIGO PRINCIPAL

READ WRITE:C146([MPA_DefinicionCompetencias:187])
ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1:=[MPA_DefinicionCompetencias:187]ID:1)

READ WRITE:C146([MPA_DefinicionDimensiones:188])
ALL RECORDS:C47([MPA_DefinicionDimensiones:188])
APPLY TO SELECTION:C70([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1:=[MPA_DefinicionDimensiones:188]ID:1)

READ WRITE:C146([MPA_DefinicionEjes:185])
ALL RECORDS:C47([MPA_DefinicionEjes:185])
APPLY TO SELECTION:C70([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1:=[MPA_DefinicionEjes:185]ID:1)
KRL_UnloadAll 


ALL RECORDS:C47([MPA_DefinicionEjes:185])
ORDER BY:C49([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2;>;[MPA_DefinicionEjes:185]ID:1;>)

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([MPA_DefinicionEjes:185];$aRecNums{$i})
	
	If (Not:C34(MPAcfg_Eje_EsUnico ))
		KRL_GotoRecord (->[MPA_DefinicionEjes:185];$aRecNums{$i};True:C214)
		[MPA_DefinicionEjes:185]Nombre:3:="["+String:C10([MPA_DefinicionEjes:185]ID:1)+"] "+[MPA_DefinicionEjes:185]Nombre:3
		SAVE RECORD:C53([MPA_DefinicionEjes:185])
		$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionEjes:185]ID_Area:2;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		$t_eje:=[MPA_DefinicionEjes:185]Nombre:3
		$t_dimension:=""
		$t_errorDuplicacion:="Nombre de Eje duplicado en el mismo contenedor. El eje fue renombrado anteponiendo su identificador interno."
		APPEND TO ARRAY:C911($at_Areas;$t_area)
		APPEND TO ARRAY:C911($at_Ejes;$t_eje)
		APPEND TO ARRAY:C911($at_Dimensiones;$t_dimension)
		APPEND TO ARRAY:C911($at_Competencias;"")
		APPEND TO ARRAY:C911($at_Errores;$t_errorDuplicacion)
		APPEND TO ARRAY:C911($al_estilos;0)
		APPEND TO ARRAY:C911($al_colores;Green:K11:9)
	End if 
End for 






ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11;>;[MPA_DefinicionCompetencias:187]ID_Eje:2;>;[MPA_DefinicionCompetencias:187]ID_Dimension:23;>;[MPA_DefinicionCompetencias:187]Competencia:6;>)

LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$aRecNums{$i})
	
	If (Not:C34(MPAcfg_Dim_EsUnica ))
		KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$aRecNums{$i};True:C214)
		[MPA_DefinicionDimensiones:188]Dimensión:4:="["+String:C10([MPA_DefinicionDimensiones:188]ID:1)+"] "+[MPA_DefinicionDimensiones:188]Dimensión:4
		SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
		$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionDimensiones:188]ID_Area:2;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionDimensiones:188]ID_Eje:3;->[MPA_DefinicionEjes:185]Nombre:3)
		$t_dimension:=[MPA_DefinicionDimensiones:188]Dimensión:4
		$t_errorDuplicacion:="Nombre de Dimensión duplicada en el mismo contenedor. La Dimensión fue renombrada anteponiendo su identificador interno."
		APPEND TO ARRAY:C911($at_Areas;$t_area)
		APPEND TO ARRAY:C911($at_Ejes;$t_eje)
		APPEND TO ARRAY:C911($at_Dimensiones;$t_dimension)
		APPEND TO ARRAY:C911($at_Competencias;"")
		APPEND TO ARRAY:C911($at_Errores;$t_errorDuplicacion)
		APPEND TO ARRAY:C911($al_estilos;0)
		APPEND TO ARRAY:C911($al_colores;Green:K11:9)
	End if 
	
	
	
	If ([MPA_DefinicionDimensiones:188]ID_Eje:3=0)
		$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionDimensiones:188]ID_Area:2;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionDimensiones:188]ID_Eje:3;->[MPA_DefinicionEjes:185]Nombre:3)
		$t_error:="Dimensión no asociada a ningún Eje de Aprendizaje."
		APPEND TO ARRAY:C911($at_Areas;$t_area)
		APPEND TO ARRAY:C911($at_Ejes;$t_eje)
		APPEND TO ARRAY:C911($at_Dimensiones;[MPA_DefinicionDimensiones:188]Dimensión:4)
		APPEND TO ARRAY:C911($at_Competencias;"")
		APPEND TO ARRAY:C911($at_Errores;$t_error)
		APPEND TO ARRAY:C911($al_estilos;0)
		APPEND TO ARRAY:C911($al_colores;Red:K11:4)
	Else 
		$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionDimensiones:188]ID_Eje:3;->[MPA_DefinicionEjes:185]Nombre:3)
		If ($t_eje="")
			$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionDimensiones:188]ID_Area:2;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
			$t_error:="La Dimensión está asociada a un Eje de Aprendizaje que ya no existe."
			APPEND TO ARRAY:C911($at_Areas;$t_area)
			APPEND TO ARRAY:C911($at_Ejes;$t_eje)
			APPEND TO ARRAY:C911($at_Dimensiones;[MPA_DefinicionDimensiones:188]Dimensión:4)
			APPEND TO ARRAY:C911($at_Competencias;"")
			APPEND TO ARRAY:C911($at_Errores;$t_error)
			APPEND TO ARRAY:C911($al_estilos;0)
			APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		End if 
	End if 
End for 

QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=0)
KRL_DeleteSelection (->[MPA_DefinicionCompetencias:187])
QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=0)
KRL_DeleteSelection (->[MPA_DefinicionDimensiones:188])
QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=0)
KRL_DeleteSelection (->[MPA_DefinicionEjes:185])

ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11;>;[MPA_DefinicionCompetencias:187]ID_Eje:2;>;[MPA_DefinicionCompetencias:187]ID_Dimension:23;>;[MPA_DefinicionCompetencias:187]Competencia:6;>)

LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$aRecNums{$i})
	
	If ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=0)
		$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
		$t_dimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]Dimensión:4)
		$t_error:="No estaba definido el tipo de evaluación. Se le asignó el tipo de evaluación "+ST_Qte (__ ("Según Estilo de Evaluación"))+__ (" y el estilo de evaluación por defecto")
		KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$aRecNums{$i};True:C214)
		[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=3
		[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=-5
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		APPEND TO ARRAY:C911($at_Areas;$t_area)
		APPEND TO ARRAY:C911($at_Ejes;$t_eje)
		APPEND TO ARRAY:C911($at_Dimensiones;$t_dimension)
		APPEND TO ARRAY:C911($at_Competencias;[MPA_DefinicionCompetencias:187]Competencia:6)
		APPEND TO ARRAY:C911($at_Errores;$t_error)
		APPEND TO ARRAY:C911($al_estilos;0)
		APPEND TO ARRAY:C911($al_colores;Green:K11:9)
	End if 
	
	If ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2)
		If (([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17="") | ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17=";"))
			$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
			$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
			$t_dimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]Dimensión:4)
			$t_error:=__ ("El tipo de la evaluación es binario pero no estan definidos los símbolos para aprobación/reprobación. Se asignaron los símbolos por defecto (L y NL)")
			[MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17:=__ ("L;NL")
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$aRecNums{$i};True:C214)
			SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
			APPEND TO ARRAY:C911($at_Areas;$t_area)
			APPEND TO ARRAY:C911($at_Ejes;$t_eje)
			APPEND TO ARRAY:C911($at_Dimensiones;$t_dimension)
			APPEND TO ARRAY:C911($at_Competencias;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($at_Errores;$t_error)
			APPEND TO ARRAY:C911($al_estilos;0)
			APPEND TO ARRAY:C911($al_colores;Green:K11:9)
		End if 
		If (([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18="") | ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18=";"))
			$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
			$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
			$t_dimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]Dimensión:4)
			$t_error:=__ ("El tipo de la evaluación es binario pero no estan definidas las despcripciones para aprobación/reprobación. Se asignaron las descripciones por defecto por defecto (Logrado y No Logrado)")
			[MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18:=__ ("Logrado;No Logrado")
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$aRecNums{$i};True:C214)
			SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
			APPEND TO ARRAY:C911($at_Areas;$t_area)
			APPEND TO ARRAY:C911($at_Ejes;$t_eje)
			APPEND TO ARRAY:C911($at_Dimensiones;$t_dimension)
			APPEND TO ARRAY:C911($at_Competencias;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($at_Errores;$t_error)
			APPEND TO ARRAY:C911($al_estilos;0)
			APPEND TO ARRAY:C911($al_colores;Green:K11:9)
		End if 
	End if 
	
	
	If (([MPA_DefinicionCompetencias:187]ID_Eje:2=0) & ([MPA_DefinicionCompetencias:187]ID_Dimension:23=0))
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_DefinicionCompetencias:187]ID:1)
		KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Logro_Aprendizaje;*)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje)
		If (Records in selection:C76([MPA_AsignaturasMatrices:189])>0)
			$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
			$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
			$t_dimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]Dimensión:4)
			$t_error:="Competencia no está asociada a ningún Eje ni Dimensión de Aprendizaje."
			APPEND TO ARRAY:C911($at_Areas;$t_area)
			APPEND TO ARRAY:C911($at_Ejes;$t_eje)
			APPEND TO ARRAY:C911($at_Dimensiones;$t_dimension)
			APPEND TO ARRAY:C911($at_Competencias;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($at_Errores;$t_error)
			APPEND TO ARRAY:C911($al_estilos;0)
			APPEND TO ARRAY:C911($al_colores;Black:K11:16)
		End if 
	End if 
	
	If (([MPA_DefinicionCompetencias:187]ID_Eje:2=0) & ([MPA_DefinicionCompetencias:187]ID_Dimension:23#0))
		$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
		$t_dimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]Dimensión:4)
		$l_IdEjeDimension:=KRL_GetNumericFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]ID_Eje:3)
		If ($l_IdEjeDimension#0)
			$t_error:="La Competencia estaba asociada a una Dimensión pero no al Eje asociado a la Dimensión. La Competencia fue asociada al eje."
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$aRecNums{$i};True:C214)
			[MPA_DefinicionCompetencias:187]ID_Eje:2:=$l_IdEjeDimension
			SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
			APPEND TO ARRAY:C911($al_colores;Green:K11:9)
		Else 
			$t_error:="La Competencia está asociada a una Dimensión que no está no asociada a ningún Eje."
			APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		End if 
		APPEND TO ARRAY:C911($at_Areas;$t_area)
		APPEND TO ARRAY:C911($at_Ejes;$t_eje)
		APPEND TO ARRAY:C911($at_Dimensiones;$t_dimension)
		APPEND TO ARRAY:C911($at_Competencias;[MPA_DefinicionCompetencias:187]Competencia:6)
		APPEND TO ARRAY:C911($at_Errores;$t_error)
		APPEND TO ARRAY:C911($al_estilos;0)
	End if 
	
	If (Not:C34(MPAcfg_Comp_EsUnica ))
		KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$aRecNums{$i};True:C214)
		[MPA_DefinicionCompetencias:187]Competencia:6:="["+String:C10([MPA_DefinicionCompetencias:187]ID:1)+"] "+[MPA_DefinicionCompetencias:187]Competencia:6
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
		$t_dimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]Dimensión:4)
		$t_errorDuplicacion:="Nombre de competencia duplicada en el mismo contenedor. La competencia fue renombrada anteponiendo su identificador interno."
		APPEND TO ARRAY:C911($at_Areas;$t_area)
		APPEND TO ARRAY:C911($at_Ejes;$t_eje)
		APPEND TO ARRAY:C911($at_Dimensiones;$t_dimension)
		APPEND TO ARRAY:C911($at_Competencias;[MPA_DefinicionCompetencias:187]Competencia:6)
		APPEND TO ARRAY:C911($at_Errores;$t_errorDuplicacion)
		APPEND TO ARRAY:C911($al_estilos;0)
		APPEND TO ARRAY:C911($al_colores;Green:K11:9)
	End if 
	
	
	If ([MPA_DefinicionCompetencias:187]ID_Eje:2#0)
		$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
		If ($t_eje="")
			$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
			$t_error:="La Competencia está asociada a un Eje de Aprendizaje que ya no existe."
			APPEND TO ARRAY:C911($at_Areas;$t_area)
			APPEND TO ARRAY:C911($at_Ejes;$t_eje)
			APPEND TO ARRAY:C911($at_Dimensiones;"")
			APPEND TO ARRAY:C911($at_Competencias;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($at_Errores;$t_error)
			APPEND TO ARRAY:C911($al_estilos;0)
			APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		End if 
	End if 
	
	If ([MPA_DefinicionCompetencias:187]ID_Dimension:23#0)
		$t_dimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]Dimensión:4)
		If ($t_dimension="")
			$t_area:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
			$t_eje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
			$t_error:="La Competencia está asociada a una Dimensión de Aprendizaje que ya no existe."
			APPEND TO ARRAY:C911($at_Areas;$t_area)
			APPEND TO ARRAY:C911($at_Ejes;$t_eje)
			APPEND TO ARRAY:C911($at_Dimensiones;"")
			APPEND TO ARRAY:C911($at_Competencias;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($at_Errores;$t_error)
			APPEND TO ARRAY:C911($al_estilos;0)
			APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		End if 
	End if 
	
End for 
KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])





If (Size of array:C274($at_Errores)>0)
	$t_Encabezado:="Verificación de la configuración de mapas de aprendizaje"
	$t_descripcion:="Durante un análisis de los mapas de aprendizajes se encontraron inconsistencias en la configuración de mapas de aprendizajes.\r"
	$t_descripcion:=$t_descripcion+"La lista a continuación detalla esas inconsistencias."
	$t_contenidoTexto:=""
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Area")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Eje")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Dimensión")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Competencia")
	$t_mensajeFalla:="Se detectaron posibles inconsistencias en la configuración de mapas de aprendizaje.\r\rEl detalle será mostrado en el centro de notificaciones."
	$t_mensajeExito:="No se detectó ninguna inconsistencia en la configuración de mapas de aprendizaje."
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_Areas;->$at_Ejes;->$at_Dimensiones;->$at_Competencias)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
	
Else 
	$0:=0
End if 

