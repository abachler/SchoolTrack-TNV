//%attributes = {}
  //MPAdbu_ImportConfig

  //20120718 RCH Se colocan mensajes para evitar eliminacion involuntaria de informacion.
C_LONGINT:C283($vl_resp)

$vl_resp:=CD_Dlog (0;"Este script elimina TODA la información de configuración y evaluaciones de TODOS los mapas de aprendizaje ingresados en la base de datos."+"\r\r"+"Este script debe ser utilizado solamente en bases de datos nuevas o si se necesita inicializar toda la información de mapas de aprendizaje."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
If ($vl_resp=1)
	$vl_resp:=CD_Dlog (0;"Es necesario hacer un respaldo manual de la base de datos antes de ejecutar este script."+"\r\r"+"Si no ha realizado el respaldo, presione No, cierre la aplicación, haga el respaldo de los archivos y ejecute nuevamente este script."+"\r\r"+"¿Ya realizó el respaldo?";"";"Si";"No")
	If ($vl_resp=1)
		LOG_RegisterEvt ("Inicio de script de eliminación de mapas de aprendizaje iniciado. Script "+Current method name:C684+".")
		
		ALL RECORDS:C47([MPA_DefinicionAreas:186])
		KRL_DeleteSelection (->[MPA_DefinicionAreas:186])
		
		ALL RECORDS:C47([MPA_DefinicionEjes:185])
		KRL_DeleteSelection (->[MPA_DefinicionEjes:185])
		
		ALL RECORDS:C47([MPA_DefinicionDimensiones:188])
		KRL_DeleteSelection (->[MPA_DefinicionDimensiones:188])
		
		ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
		KRL_DeleteSelection (->[MPA_DefinicionCompetencias:187])
		
		ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
		KRL_DeleteSelection (->[MPA_DefinicionCompetencias:187])
		
		ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
		KRL_DeleteSelection (->[MPA_AsignaturasMatrices:189])
		
		ALL RECORDS:C47([MPA_ObjetosMatriz:204])
		KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
		
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
		KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
		
		
		
		ARRAY LONGINT:C221($aIDEstiloArchivo;0)
		ARRAY LONGINT:C221($aIDEstiloNuevo;0)
		
		
		_O_C_STRING:C293(255;$tableName)
		C_LONGINT:C283($i;$j;$records;$tableNumber;$tables2import)
		SET CHANNEL:C77(10;"")
		
		If (ok=1)
			RECEIVE VARIABLE:C81($tables2import)
			For ($j;1;$tables2import)
				RECEIVE VARIABLE:C81($tablenumber)
				RECEIVE VARIABLE:C81($tableName)
				RECEIVE VARIABLE:C81($records)
				$RCVtablename:=Table name:C256($tableNumber)
				If ($tablename=$RCVtablename)
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando registros en el archivo ")+$tableName)
					For ($i;1;$records)
						RECEIVE RECORD:C79(Table:C252($tableNumber)->)  //mono ticket 147894 
						Case of 
							: ($tableNumber=Table:C252(->[xxSTR_EstilosEvaluacion:44]))
								$nuevoIdEstilo:=SQ_SeqNumber (->[xxSTR_EstilosEvaluacion:44]ID:1)
								APPEND TO ARRAY:C911($aIDEstiloArchivo;[xxSTR_EstilosEvaluacion:44]ID:1)
								APPEND TO ARRAY:C911($aIDEstiloNuevo;$nuevoIdEstilo)
								[xxSTR_EstilosEvaluacion:44]ID:1:=$nuevoIdEstilo
								[xxSTR_EstilosEvaluacion:44]Name:2:=[xxSTR_EstilosEvaluacion:44]Name:2+" [import]"
								[xxSTR_EstilosEvaluacion:44]Name:2:=Replace string:C233([xxSTR_EstilosEvaluacion:44]Name:2;" [import] [import]";" [import]")
								[xxSTR_EstilosEvaluacion:44]Observaciones:10:="Importado con la configuración de mapas de aprendizaje el "+String:C10(Current date:C33(*);7)+String:C10(Current time:C178(*);HH MM:K7:2)
								SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
								
							: ($tableNumber=Table:C252(->[MPA_DefinicionAreas:186]))
								SAVE RECORD:C53([MPA_DefinicionAreas:186])
								
							: ($tableNumber=Table:C252(->[MPA_DefinicionEjes:185]))
								$el:=Find in array:C230($aIDEstiloArchivo;[MPA_DefinicionEjes:185]EstiloEvaluación:13)
								If ($el>0)
									[MPA_DefinicionEjes:185]EstiloEvaluación:13:=$aIDEstiloNuevo{$el}
								Else 
									
								End if 
								SAVE RECORD:C53([MPA_DefinicionEjes:185])
								
							: ($tableNumber=Table:C252(->[MPA_DefinicionDimensiones:188]))
								$el:=Find in array:C230($aIDEstiloArchivo;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
								If ($el>0)
									[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=$aIDEstiloNuevo{$el}
								Else 
									
								End if 
								SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
								
							: ($tableNumber=Table:C252(->[MPA_DefinicionCompetencias:187]))
								$el:=Find in array:C230($aIDEstiloArchivo;[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
								If ($el>0)
									[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=$aIDEstiloNuevo{$el}
								Else 
									
								End if 
								SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
								
							: ($tableNumber=Table:C252(->[xxSTR_Materias:20]))
								If ([xxSTR_Materias:20]ID_Materia:16#0)
									$idArchivo:=[xxSTR_Materias:20]ID_Materia:16
									$idActual:=[xxSTR_Materias:20]ID_Materia:16
									$area:=[xxSTR_Materias:20]AreaMPA:4
									$recNum:=Find in field:C653([xxSTR_Materias:20]Materia:2;[xxSTR_Materias:20]Materia:2)
									If ($recNum>=0)
										GOTO RECORD:C242([xxSTR_Materias:20];$recNum)
										$idActual:=[xxSTR_Materias:20]ID_Materia:16
										[xxSTR_Materias:20]AreaMPA:4:=$area
										SAVE RECORD:C53([xxSTR_Materias:20])
										If ($idArchivo#$idActual)
											QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3;=;$idArchivo)
											READ WRITE:C146([MPA_DefinicionCompetencias:187])
											APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3:=$idActual)
											UNLOAD RECORD:C212([MPA_DefinicionCompetencias:187])
										End if 
									Else 
										$recNum:=Find in field:C653([xxSTR_Materias:20]ID_Materia:16;[xxSTR_Materias:20]ID_Materia:16)
										$area:=[xxSTR_Materias:20]AreaMPA:4
										If ($recNum>=0)
											[xxSTR_Materias:20]ID_Materia:16:=SQ_SeqNumber (->[xxSTR_Materias:20]ID_Materia:16)
											$idActual:=[xxSTR_Materias:20]ID_Materia:16
											[xxSTR_Materias:20]AreaMPA:4:=$area
										End if 
										SAVE RECORD:C53([xxSTR_Materias:20])
										If ($idArchivo#$idActual)
											QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3;=;$idArchivo)
											READ WRITE:C146([MPA_DefinicionCompetencias:187])
											APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3:=$idActual)
											UNLOAD RECORD:C212([MPA_DefinicionCompetencias:187])
										End if 
									End if 
								End if 
						End case 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$records)
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				Else 
					ALERT:C41("Los datos exportados no corresponden al archivo que debe recibirlos")
					$j:=$tables2import
				End if 
			End for 
			
			ALL RECORDS:C47([MPA_DefinicionAreas:186])
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionAreas:186];$aRecNums;"")
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando subsectores y asignaturas...."))
			For ($i;1;Size of array:C274($aRecNums))
				READ WRITE:C146([MPA_DefinicionAreas:186])
				GOTO RECORD:C242([MPA_DefinicionAreas:186];$aRecNums{$i})
				QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2;=;[MPA_DefinicionAreas:186]ID:1)
				$id_Estilo:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
				QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4=[MPA_DefinicionAreas:186]AreaAsignatura:4)
				ARRAY LONGINT:C221($aRecNumMaterias;0)
				LONGINT ARRAY FROM SELECTION:C647([xxSTR_Materias:20];$aRecNumMaterias;"")
				If (BLOB size:C605([MPA_DefinicionAreas:186]xEtapas:10)#0)
					BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
					SORT ARRAY:C229(alMPA_NivelDesde;>)
					SORT ARRAY:C229(alMPA_NivelHasta;>)
					
					For ($iMaterias;1;Size of array:C274($aRecNumMaterias))
						GOTO RECORD:C242([xxSTR_Materias:20];$aRecNumMaterias{$iMaterias})
						For ($iNiveles;alMPA_NivelDesde{1};alMPA_NivelHasta{Size of array:C274(alMPA_NivelHasta)})
							$nivel:=$iNiveles
							QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel)
							ARRAY LONGINT:C221($aRecNumCursos;0)
							LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$aRecNumCursos;"")
							For ($iCursos;1;Size of array:C274($aRecNumCursos))
								GOTO RECORD:C242([Cursos:3];$aRecNumCursos{$iCursos})
								QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
								QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=[Cursos:3]Curso:1)
								If (Records in selection:C76([Asignaturas:18])=0)
									CREATE RECORD:C68([Asignaturas:18])
									[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
									[Asignaturas:18]CHILE_CodigoMineduc:41:=[xxSTR_Materias:20]Codigo:10
									[Asignaturas:18]Asignatura:3:=[xxSTR_Materias:20]Materia:2
									[Asignaturas:18]denominacion_interna:16:=[xxSTR_Materias:20]Denominación_Interna:18
									[Asignaturas:18]Abreviación:26:=[xxSTR_Materias:20]Abreviatura:8
									[Asignaturas:18]Materia_UUID:46:=[xxSTR_Materias:20]Auto_UUID:21  //Asignatura, Materia Auto uuid
									[Asignaturas:18]Curso:5:=[Cursos:3]Curso:1
									[Asignaturas:18]Numero_del_Curso:25:=[Cursos:3]Numero_del_curso:6
									[Asignaturas:18]Numero_del_Nivel:6:=[Cursos:3]Nivel_Numero:7
									[Asignaturas:18]Sector:9:=[xxSTR_Materias:20]Area:12
									[Asignaturas:18]Nivel:30:=[Cursos:3]Nivel_Nombre:10
									[Asignaturas:18]Incide_en_promedio:27:=True:C214
									[Asignaturas:18]IncideEnPromedioInterno:64:=True:C214
									[Asignaturas:18]posicion_en_informes_de_notas:36:=0
									[Asignaturas:18]ordenGeneral:105:=""
									[Asignaturas:18]Numero_de_evaluaciones:38:=12
									[Asignaturas:18]Incluida_en_Actas:44:=True:C214
									[Asignaturas:18]Es_Optativa:70:=False:C215
									[Asignaturas:18]Electiva:11:=False:C215
									[Asignaturas:18]En_InformesInternos:14:=True:C214
									[Asignaturas:18]Seleccion_por_sexo:24:=1
									[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=$id_Estilo
									SAVE RECORD:C53([Asignaturas:18])
									InscriptOK:=True:C214
								End if 
								
								If ([Asignaturas:18]Numero:1#0)
									QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Asignaturas:18]Curso:5)
									ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
									ARRAY LONGINT:C221($aRecNumsAlumnos;0)
									LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNumsAlumnos;"")
									For ($iAlumnos;1;Size of array:C274($aRecNumsAlumnos))
										GOTO RECORD:C242([Alumnos:2];$aRecNumsAlumnos{$iAlumnos})
										AS_CreaRegistrosEvaluacion ([Alumnos:2]numero:1;[Asignaturas:18]Numero:1)
									End for 
								End if 
								
							End for 
						End for 
						
					End for 
					
				End if 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Actualizando subsectores y asignaturas...."))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			SQ_SetSequences 
			
			EVS_LoadStyles 
			  //mono ticket 147894 
			CREATE EMPTY SET:C140([MPA_AsignaturasMatrices:189];"$matrices_a_recalcular")
			CREATE EMPTY SET:C140([MPA_AsignaturasMatrices:189];"$matricesModificadas")
			CREATE EMPTY SET:C140([MPA_AsignaturasMatrices:189];"$matrices")
			
			ALL RECORDS:C47([MPA_DefinicionAreas:186])
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionAreas:186];$aRecNums;"")
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando matrices para la evaluación de aprendizajes..."))
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([MPA_DefinicionAreas:186];$aRecNums{$i})
				QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4=[MPA_DefinicionAreas:186]AreaAsignatura:4)
				SELECTION TO ARRAY:C260([xxSTR_Materias:20]AreaMPA:4;atMPA_AsignaturasArea)
				$result:=2
				MPAcfg_AsignaMapas ($aRecNums{$i};->atMPA_AsignaturasArea;4)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Creando matrices para la evaluación de aprendizajes..."))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
	End if 
End if 