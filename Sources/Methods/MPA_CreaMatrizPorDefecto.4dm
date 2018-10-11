//%attributes = {}
  // MPA_CreaMatrizPorDefecto()
  // 
  //
If (False:C215)
	  // Alberto Bachler: 06/03/12, 18:33:02
	  // 
	  // ---------------------------------------------
End if 
  // ----------------------------------------------------
  // Alberto Bachler: 09/01/13, 23:08:47
  // Verificación de la existencia del registro [MPA_ObjetoMatriz] sobre el campo [MPA_ObjetoMatriz]Llave_unica, reemplazando queries compuestos
  // ---------------------------------------------

C_LONGINT:C283($l_TransaccionOK)
C_LONGINT:C283($i;$iEtapas;$l_desdeNivel;$l_hastaNivel;$l_IdArea;$l_idAsignatura;$l_IdMateria;$l_IdMatrizPrincipal;$l_indexNivel;$l_numeroEtapa)
C_LONGINT:C283($l_numeroNivel)
C_TEXT:C284($t_nivelNombre;$t_nombreArea;$t_nombreAsignatura)

ARRAY LONGINT:C221($al_recNumCompetencias;0)
ARRAY LONGINT:C221($al_recNumDimensiones;0)
ARRAY LONGINT:C221($al_recNumEjes;0)





  // CODIGO PRINCIPAL
$l_numeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
$l_idAsignatura:=[Asignaturas:18]Numero:1
$t_nombreAsignatura:=[Asignaturas:18]Asignatura:3

READ ONLY:C145([xxSTR_Materias:20])
QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;=;[Asignaturas:18]Asignatura:3)
$l_IdMateria:=[xxSTR_Materias:20]ID_Materia:16
QUERY:C277([MPA_DefinicionAreas:186];[MPA_DefinicionAreas:186]AreaAsignatura:4;=;[xxSTR_Materias:20]AreaMPA:4)
If (Records in selection:C76([MPA_DefinicionAreas:186])=1)
	MPAcfg_LeeEtapasDelArea (Record number:C243([MPA_DefinicionAreas:186]))
	$l_numeroEtapa:=0
	For ($iEtapas;1;Size of array:C274(alMPA_NivelDesde))
		If (($l_numeroNivel>=alMPA_NivelDesde{$iEtapas}) & ($l_numeroNivel<=alMPA_NivelHasta{$iEtapas}))
			$l_numeroEtapa:=$iEtapas
			$iEtapas:=Size of array:C274(alMPA_NivelDesde)
		End if 
	End for 
	If ($l_numeroEtapa>0)
		$l_desdeNivel:=alMPA_NivelDesde{$l_numeroEtapa}
		$l_hastaNivel:=alMPA_NivelHasta{$l_numeroEtapa}
	End if 
	$l_IdArea:=[MPA_DefinicionAreas:186]ID:1
	$t_nombreArea:=[MPA_DefinicionAreas:186]AreaAsignatura:4
	
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$l_numeroNivel)
	$t_nivelNombre:=[xxSTR_Niveles:6]Nivel:1
	
	If (($l_desdeNivel#0) & ($l_hastaNivel#0))
		  //búsqueda de los ejes de la etapa correspondiente al nivel
		READ ONLY:C145([MPA_DefinicionEjes:185])
		QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_IdArea)
		$l_indexNivel:=Find in array:C230(<>aNivNo;$l_numeroNivel)
		QUERY SELECTION BY FORMULA:C207([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]BitsNiveles:20 ?? $l_indexNivel)
		SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185];$al_recNumEjes)
		
		If (Size of array:C274($al_recNumEjes)>0)
			CD_Dlog (0;__ ("No existe la configuración por defecto de Aprendizajes Esperados para esta asignatura en este nivel.\r\r La configuración por defecto será creada utilizando los Aprendizajes Esperados definidos en el mapa de aprendizaje del área correspondiente."))
			
			START TRANSACTION:C239
			  //búsqueda de las dimensiones de la etapa correspondiente al nivel
			READ ONLY:C145([MPA_DefinicionDimensiones:188])
			QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_IdArea)
			$l_indexNivel:=Find in array:C230(<>aNivNo;$l_numeroNivel)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $l_indexNivel)
			SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188];$al_recNumDimensiones)
			
			  //búsqueda de las competencias de la etapa correspondiente al nivel
			READ ONLY:C145([MPA_DefinicionCompetencias:187])
			QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea)
			$l_indexNivel:=Find in array:C230(<>aNivNo;$l_numeroNivel)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
			
			SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNumCompetencias)
			
			QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[Asignaturas:18]Asignatura:3;*)
			QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_numeroNivel;*)
			QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
			
			  //creación del registro de evaluación por defecto si no existe
			If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
				CREATE RECORD:C68([MPA_AsignaturasMatrices:189])
				[MPA_AsignaturasMatrices:189]ID_Matriz:1:=SQ_SeqNumber (->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
				[MPA_AsignaturasMatrices:189]Asignatura:3:=[Asignaturas:18]Asignatura:3
				[MPA_AsignaturasMatrices:189]Area:13:=$t_nombreArea
				[MPA_AsignaturasMatrices:189]ID_Area:22:=$l_IdArea
				[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=True:C214
				[MPA_AsignaturasMatrices:189]CreadaPor:15:=USR_GetUserName (USR_GetUserID )
				[MPA_AsignaturasMatrices:189]DTS_Creacion:16:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
				[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
				[MPA_AsignaturasMatrices:189]ID_Creador:20:=USR_GetUserID 
				[MPA_AsignaturasMatrices:189]ModificadaPor:17:=USR_GetUserName (USR_GetUserID )
				[MPA_AsignaturasMatrices:189]NombreMatriz:2:=[Asignaturas:18]Asignatura:3+", "+$t_nivelNombre
				[MPA_AsignaturasMatrices:189]NumeroNivel:4:=$l_numeroNivel
				[MPA_AsignaturasMatrices:189]PonderacionResultado:8:=0
				[MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7:=False:C215
				SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
			End if 
			$l_IdMatrizPrincipal:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
			
			  //eliminación de las evaluaciones de competencias
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignatura)
			$l_TransaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
			
			  //eliminación de los ejes de la matriz
			If ($l_TransaccionOK=1)
				READ WRITE:C146([MPA_ObjetosMatriz:204])
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_IdMatrizPrincipal)
				$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
			End if 
			
			If ($l_TransaccionOK=1)
				For ($i;1;Size of array:C274($al_recNumEjes))
					GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNumEjes{$i})
					$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizPrincipal)+"."+String:C10([MPA_DefinicionEjes:185]ID:1)+"."+String:C10(0)+"."+String:C10(0)
					$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
					If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
						CREATE RECORD:C68([MPA_ObjetosMatriz:204])
						[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionEjes:185]ID:1
						[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizPrincipal
						[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
						[MPA_ObjetosMatriz:204]Periodos:7:=1
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					Else 
						[MPA_ObjetosMatriz:204]Periodos:7:=1
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					End if 
				End for 
				
				For ($i;1;Size of array:C274($al_recNumDimensiones))
					GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNumDimensiones{$i})
					$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizPrincipal)+"."+String:C10([MPA_DefinicionDimensiones:188]ID_Eje:3)+"."+String:C10([MPA_DefinicionDimensiones:188]ID:1)+"."+String:C10(0)
					$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
					If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
						CREATE RECORD:C68([MPA_ObjetosMatriz:204])
						[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionDimensiones:188]ID_Eje:3
						[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionDimensiones:188]ID:1
						[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizPrincipal
						[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
						[MPA_ObjetosMatriz:204]Periodos:7:=1
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					Else 
						[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionDimensiones:188]ID_Eje:3
						[MPA_ObjetosMatriz:204]Periodos:7:=1
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					End if 
				End for 
				
				For ($i;1;Size of array:C274($al_recNumCompetencias))
					GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNumCompetencias{$i})
					If (([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0) | ([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria))
						READ WRITE:C146([MPA_ObjetosMatriz:204])
						$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizPrincipal)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Eje:2)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Dimension:23)+"."+String:C10([MPA_DefinicionCompetencias:187]ID:1)
						$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
						If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Logro_Aprendizaje))
							CREATE RECORD:C68([MPA_ObjetosMatriz:204])
							[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionCompetencias:187]ID_Eje:2
							[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
							[MPA_ObjetosMatriz:204]ID_Competencia:5:=[MPA_DefinicionCompetencias:187]ID:1
							[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizPrincipal
							[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Logro_Aprendizaje
							[MPA_ObjetosMatriz:204]Periodos:7:=1
							SAVE RECORD:C53([MPA_ObjetosMatriz:204])
						Else 
							[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionCompetencias:187]ID_Eje:2
							[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
							[MPA_ObjetosMatriz:204]Periodos:7:=1
							SAVE RECORD:C53([MPA_ObjetosMatriz:204])
						End if 
					End if 
				End for 
				LOG_RegisterEvt ("Matriz de Evaluación por omisión de "+$t_nombreAsignatura+", "+$t_nivelNombre+" regenerada.")
			End if 
			
			If ($l_TransaccionOK=1)
				$0:=$l_IdMatrizPrincipal
				VALIDATE TRANSACTION:C240
			Else 
				$0:=0
				CANCEL TRANSACTION:C241
			End if 
		Else 
			$0:=0
		End if 
	Else 
		$0:=0
	End if 
Else 
	$0:=0
End if 