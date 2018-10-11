//%attributes = {}
  // MPAcfg_ActualizaMatrices()
  // 
  //
If (False:C215)
	  // Alberto Bachler: 23/07/12, 13:17:20
	  // 
	  // ---------------------------------------------
	  // Alberto Bachler: 09/01/13, 23:13:50
	  // Verificación de la existencia del registro [MPA_ObjetoMatriz] sobre el campo [MPA_ObjetoMatriz]Llave_unica, reemplazando queries compuestos
	  // Corrección de errores que podían permitir la asignación de enunciados no aplicaples en el nivel
	  // ---------------------------------------------
End if 
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_BOOLEAN:C305($6)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_BOOLEAN:C305($6)

C_BOOLEAN:C305($b_recalcular)
_O_C_INTEGER:C282($i_Asignaturas;$i_Niveles)
C_LONGINT:C283($i;$l_bitNivelActivo;$l_desdeNivel;$l_elemento;$l_hastaNivel;$l_IdAreaAprendizajes;$l_idDimension;$l_idEje;$l_IdMateria;$l_IdMatrizEvaluacionMPA)
C_LONGINT:C283($l_recNumAreaAprendizajes;$l_recNumNivel;$l_recNumObjeto;$l_recNumObjetoMatriz;$l_Records;$l_RecordsAsignaturas;$l_tipoObjeto;$records)
C_TEXT:C284($t_llaveObjetoMatriz;$t_nombreAreaAprendizajes;$t_nombreNivel)

ARRAY BOOLEAN:C223($ab_MatricesRecalculo_Dimensione;0)
ARRAY BOOLEAN:C223($ab_MatricesRecalculo_Ejes;0)
ARRAY BOOLEAN:C223($ab_MatricesRecalculo_Finales;0)
ARRAY LONGINT:C221($al_IdMaterias;0)
ARRAY LONGINT:C221($al_MatricesRecalculo_Id;0)
ARRAY TEXT:C222($at_Asignaturas;0)

If (False:C215)
	C_LONGINT:C283(MPAcfg_ActualizaMatrices ;$1)
	C_LONGINT:C283(MPAcfg_ActualizaMatrices ;$2)
	C_LONGINT:C283(MPAcfg_ActualizaMatrices ;$3)
	C_LONGINT:C283(MPAcfg_ActualizaMatrices ;$4)
	C_LONGINT:C283(MPAcfg_ActualizaMatrices ;$5)
	C_BOOLEAN:C305(MPAcfg_ActualizaMatrices ;$6)
End if 




$l_recNumAreaAprendizajes:=$1
$l_tipoObjeto:=$2
$l_desdeNivel:=$3
$l_hastaNivel:=$4
$l_recNumObjeto:=$5

If (Count parameters:C259=6)
	$b_recalcular:=$6
Else 
	$b_recalcular:=True:C214
End if 

If (($l_desdeNivel=-100) & ($l_hastaNivel=-100))
	$l_desdeNivel:=-6
	$l_hastaNivel:=18
End if 

KRL_GotoRecord (->[MPA_DefinicionAreas:186];$l_recNumAreaAprendizajes;False:C215)
If (OK=1)
	$l_IdAreaAprendizajes:=[MPA_DefinicionAreas:186]ID:1
	$t_nombreAreaAprendizajes:=[MPA_DefinicionAreas:186]AreaAsignatura:4
	
	READ ONLY:C145([xxSTR_Materias:20])
	QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4=$t_nombreAreaAprendizajes)
	SELECTION TO ARRAY:C260([xxSTR_Materias:20]Materia:2;$at_Asignaturas;[xxSTR_Materias:20]ID_Materia:16;$al_IdMaterias)
	
	For ($i_Niveles;$l_desdeNivel;$l_hastaNivel)
		$l_recNumNivel:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;$i_Niveles)
		If ($l_recNumNivel>=0)
			READ ONLY:C145([xxSTR_Niveles:6])
			GOTO RECORD:C242([xxSTR_Niveles:6];$l_recNumNivel)
			$t_nombreNivel:=[xxSTR_Niveles:6]Nivel:1
			For ($i_Asignaturas;1;Size of array:C274($at_Asignaturas))
				$l_IdMateria:=$al_IdMaterias{$i_Asignaturas}
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_RecordsAsignaturas)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=$at_Asignaturas{$i_Asignaturas};*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=$i_Niveles)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				If ($l_RecordsAsignaturas>0)
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=$at_Asignaturas{$i_Asignaturas};*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$i_Niveles;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
					If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
						CREATE RECORD:C68([MPA_AsignaturasMatrices:189])
						[MPA_AsignaturasMatrices:189]ID_Matriz:1:=SQ_SeqNumber (->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
						[MPA_AsignaturasMatrices:189]Asignatura:3:=$at_Asignaturas{$i_Asignaturas}
						[MPA_AsignaturasMatrices:189]Area:13:=$t_nombreAreaAprendizajes
						[MPA_AsignaturasMatrices:189]ID_Area:22:=$l_IdAreaAprendizajes
						[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=True:C214
						[MPA_AsignaturasMatrices:189]CreadaPor:15:=USR_GetUserName (USR_GetUserID )
						[MPA_AsignaturasMatrices:189]DTS_Creacion:16:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
						[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
						[MPA_AsignaturasMatrices:189]ID_Creador:20:=USR_GetUserID 
						[MPA_AsignaturasMatrices:189]ModificadaPor:17:=USR_GetUserName (USR_GetUserID )
						[MPA_AsignaturasMatrices:189]NombreMatriz:2:=$at_Asignaturas{$i_Asignaturas}+", "+$t_nombreNivel
						[MPA_AsignaturasMatrices:189]NumeroNivel:4:=$i_Niveles
						[MPA_AsignaturasMatrices:189]PonderacionResultado:8:=0
						[MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7:=False:C215
						SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
					End if 
					$l_IdMatrizEvaluacionMPA:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
					
					
					Case of 
						: ($l_tipoObjeto=Eje_Aprendizaje)
							GOTO RECORD:C242([MPA_DefinicionEjes:185];$l_recNumObjeto)
							$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizEvaluacionMPA)+"."+String:C10([MPA_DefinicionEjes:185]ID:1)+"."+String:C10(0)+"."+String:C10(0)
							$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
							Case of 
								: (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
									CREATE RECORD:C68([MPA_ObjetosMatriz:204])
									[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionEjes:185]ID:1
									[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizEvaluacionMPA
									[MPA_ObjetosMatriz:204]Periodos:7:=1
									[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
									SAVE RECORD:C53([MPA_ObjetosMatriz:204])
								: (($l_recNumObjetoMatriz>=0) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? 0)))
									KRL_ReloadInReadWriteMode (->[MPA_ObjetosMatriz:204])
									[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ 0
									SAVE RECORD:C53([MPA_ObjetosMatriz:204])
									KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
							End case 
							
							
						: ($l_tipoObjeto=Dimension_Aprendizaje)
							GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$l_recNumObjeto)
							$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizEvaluacionMPA)+"."+String:C10([MPA_DefinicionDimensiones:188]ID_Eje:3)+"."+String:C10([MPA_DefinicionDimensiones:188]ID:1)+"."+String:C10(0)
							$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
							Case of 
								: (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
									CREATE RECORD:C68([MPA_ObjetosMatriz:204])
									[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionDimensiones:188]ID:1
									[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizEvaluacionMPA
									[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionDimensiones:188]ID_Eje:3
									[MPA_ObjetosMatriz:204]Periodos:7:=1
									[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
									SAVE RECORD:C53([MPA_ObjetosMatriz:204])
									$l_idEje:=[MPA_DefinicionDimensiones:188]ID_Eje:3
								: (($l_recNumObjetoMatriz>=0) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? 0)))
									KRL_ReloadInReadWriteMode (->[MPA_ObjetosMatriz:204])
									[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ 0
									SAVE RECORD:C53([MPA_ObjetosMatriz:204])
									$l_idEje:=[MPA_DefinicionDimensiones:188]ID_Eje:3
									KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
							End case 
							
							If ($l_idEje>0)
								QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=$l_IdMatrizEvaluacionMPA;*)
								QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje;*)
								QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$l_idEje)
								$records:=Records in selection:C76([MPA_ObjetosMatriz:204])
								Case of 
									: ($records=0)
										QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=$l_idEje)
										MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Eje_Aprendizaje;[MPA_DefinicionEjes:185]DesdeGrado:4;[MPA_DefinicionEjes:185]HastaGrado:5;Record number:C243([MPA_DefinicionEjes:185]))
									: (($records=1) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? 0)))
										KRL_ReloadInReadWriteMode (->[MPA_ObjetosMatriz:204])
										[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ 0
										SAVE RECORD:C53([MPA_ObjetosMatriz:204])
										KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
								End case 
							End if 
							
							
						: ($l_tipoObjeto=Logro_Aprendizaje)
							GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$l_recNumObjeto)
							$l_bitNivelActivo:=Find in array:C230(<>aNivNo;$i_Niveles)
							If ([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_bitNivelActivo)
								If (([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0) | ([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria))
									$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatrizEvaluacionMPA)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Eje:2)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Dimension:23)+"."+String:C10([MPA_DefinicionCompetencias:187]ID:1)
									$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
									Case of 
										: (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Logro_Aprendizaje))
											CREATE RECORD:C68([MPA_ObjetosMatriz:204])
											[MPA_ObjetosMatriz:204]ID_Competencia:5:=[MPA_DefinicionCompetencias:187]ID:1
											[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatrizEvaluacionMPA
											[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionCompetencias:187]ID_Eje:2
											[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
											[MPA_ObjetosMatriz:204]Periodos:7:=1
											[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Logro_Aprendizaje
											SAVE RECORD:C53([MPA_ObjetosMatriz:204])
											$l_idEje:=[MPA_DefinicionCompetencias:187]ID_Eje:2
											$l_idDimension:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
										: (($l_recNumObjetoMatriz>=0) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? 0)))
											KRL_ReloadInReadWriteMode (->[MPA_ObjetosMatriz:204])
											[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ 0
											SAVE RECORD:C53([MPA_ObjetosMatriz:204])
											$l_idEje:=[MPA_DefinicionCompetencias:187]ID_Eje:2
											$l_idDimension:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
											KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
									End case 
									If ($l_idDimension>0)
										QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=$l_IdMatrizEvaluacionMPA;*)
										QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje;*)
										QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4=$l_idDimension)
										$records:=Records in selection:C76([MPA_ObjetosMatriz:204])
										Case of 
											: ($records=0)
												QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1=$l_idDimension)
												MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Dimension_Aprendizaje;[MPA_DefinicionDimensiones:188]DesdeGrado:6;[MPA_DefinicionDimensiones:188]HastaGrado:7;Record number:C243([MPA_DefinicionDimensiones:188]))
											: (($records=1) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? 0)))
												KRL_ReloadInReadWriteMode (->[MPA_ObjetosMatriz:204])
												[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ 0
												SAVE RECORD:C53([MPA_ObjetosMatriz:204])
												KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
										End case 
									End if 
									
									If ($l_idEje>0)
										QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=$l_IdMatrizEvaluacionMPA;*)
										QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje;*)
										QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$l_idEje)
										$records:=Records in selection:C76([MPA_ObjetosMatriz:204])
										Case of 
											: ($records=0)
												QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=$l_idEje)
												MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Eje_Aprendizaje;[MPA_DefinicionEjes:185]DesdeGrado:4;[MPA_DefinicionEjes:185]HastaGrado:5;Record number:C243([MPA_DefinicionEjes:185]))
											: (($records=1) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? 0)))
												KRL_ReloadInReadWriteMode (->[MPA_ObjetosMatriz:204])
												[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ 0
												SAVE RECORD:C53([MPA_ObjetosMatriz:204])
												KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
										End case 
									End if 
								End if 
							End if 
					End case 
				End if 
			End for 
		End if 
	End for 
End if 

