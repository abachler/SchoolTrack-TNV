//%attributes = {}
  // MPAdbu_ReconstruyeMatrices()
  // Reconstruye las matrices de evaluación a partir de los registros de evaluación existentes
  // sin importar que se hayan registrado evaluacione o no.
  // Deja registro en el centro de notificaciones (11.1 o superior)
  //
If (False:C215)
	  // Alberto Bachler: 24/11/12, 17:08:45
	  // ---------------------------------------------
	  // Alberto Bachler: 09/01/13, 23:22:08
	  // Verificación de la existencia del registro [MPA_ObjetoMatriz] sobre el campo [MPA_ObjetoMatriz]Llave_unica, reemplazando queries compuestos
	  // ---------------------------------------------
End if 



  // CÓDIGO


C_LONGINT:C283($0)
C_BOOLEAN:C305($b_actualizaAprendizaje;$b_actualizaObjeto)
C_LONGINT:C283($i_aprendizajes;$i_Matrices;$i_periodos)
C_LONGINT:C283($l_bitPeriodoAntes;$l_Nivel;$l_progressPocess)
C_TEXT:C284($t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_Ids;$t_mensajeExito;$t_mensajeFalla;$t_NombreMatriz;$t_NombreNivel;$t_uuid)

ARRAY LONGINT:C221(al_colores;0)
ARRAY LONGINT:C221(al_estilos;0)
ARRAY LONGINT:C221(al_RecNumsAprendizajes;0)
ARRAY LONGINT:C221(al_RecNumsMatrices;0)
ARRAY TEXT:C222(at_Errores;0)
ARRAY TEXT:C222(at_Matriz;0)
ARRAY TEXT:C222(at_Nivel;0)
ARRAY TEXT:C222(at_Objeto;0)
ARRAY TEXT:C222(at_TitulosColumnas;0)
ARRAY TEXT:C222(at_Referencias;0)

STR_ReadGlobals 

  // CODIGO
  // seleccionamos todas las matrices y las ordenamos por nivel y nombre
$l_progressPocess:=IT_Progress (1;0;0;"Reconstruyendo matrices de evaluación...")
ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
ORDER BY:C49([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]NumeroNivel:4;[MPA_AsignaturasMatrices:189]NombreMatriz:2)
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];al_RecNumsMatrices;"")
For ($i_Matrices;1;Size of array:C274(al_RecNumsMatrices))
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];al_RecNumsMatrices{$i_Matrices})
	$t_NombreNivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[MPA_AsignaturasMatrices:189]NumeroNivel:4;->[xxSTR_Niveles:6]Nivel:1)
	$t_NombreMatriz:=[MPA_AsignaturasMatrices:189]Area:13+": "+[MPA_AsignaturasMatrices:189]NombreMatriz:2
	$l_progressPocess:=IT_Progress (0;$l_progressPocess;$i_Matrices/Size of array:C274(al_RecNumsMatrices);"Reconstruyendo matrices de evaluación...\r"+$t_NombreMatriz)
	
	  // Buscamos todos los registros de evaluación asociados a cada matriz
	READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77;=;<>gYear)
	If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];al_RecNumsAprendizajes;"")
		For ($i_aprendizajes;1;Size of array:C274(al_RecNumsAprendizajes))
			GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];al_RecNumsAprendizajes{$i_aprendizajes})
			$l_Nivel:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;->[Asignaturas:18]Numero_del_Nivel:6)
			PERIODOS_LoadData ($l_Nivel)
			$b_actualizaObjeto:=False:C215
			$b_actualizaAprendizaje:=False:C215
			
			If (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5#0))
				
				  //si se trata de un eje de aprendizaje buscamos el registro correspondiente al eje en la tabla [MPA_ObjetosMatriz]...
				$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10(0)+"."+String:C10(0)
				$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
				If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
					  // si no existe lo creamos...
					CREATE RECORD:C68([MPA_ObjetosMatriz:204])
					[MPA_ObjetosMatriz:204]ID_Matriz:1:=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2
					[MPA_ObjetosMatriz:204]ID_Eje:3:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
					[MPA_ObjetosMatriz:204]Periodos:7:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10
					[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
					$b_actualizaObjeto:=True:C214
				End if 
				  // si existe nos aseguramos que esté habilitado en el período habilitado en el registro [Alumnos_EvaluacionAprendizajes]...
				  // y/o en los períodos en que se han registrado evaluaciones
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 1)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 1
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 2)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 2
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 3)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 3
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 4)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 4
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 5)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 5
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=1)
					  // si hay un solo periodo por definición el aprendizaje es utilizado en todos los períodos
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=2)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				If (viSTR_Periodos_NumeroPeriodos=3)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				If (viSTR_Periodos_NumeroPeriodos=4)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=5)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				
				$l_bitPeriodoAntes:=[MPA_ObjetosMatriz:204]Periodos:7
				If ([MPA_ObjetosMatriz:204]Periodos:7#[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10)
					If ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1)
						For ($i_periodos;1;5)
							If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $i_periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
								[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
							End if 
						End for 
					Else 
						[MPA_ObjetosMatriz:204]Periodos:7:=1
					End if 
					$b_actualizaObjeto:=True:C214
				End if 
				
				If ($b_actualizaObjeto)
					SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					  // si el registro en la tabla [MPA_ObjetosMatriz] fue recreado o actualizado lo almacenamos y creamos una entrada para el centro de notificaciones.
					If ($l_bitPeriodoAntes#[MPA_ObjetosMatriz:204]Periodos:7)
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Eje: "+KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_ObjetosMatriz:204]ID_Eje:3;->[MPA_DefinicionEjes:185]Nombre:3))
							APPEND TO ARRAY:C911(at_Errores;"El eje existía en la matriz pero no estaba habilitado en períodos en los se registraron evaluaciones.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
					Else 
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Eje: "+KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_ObjetosMatriz:204]ID_Eje:3;->[MPA_DefinicionEjes:185]Nombre:3))
							APPEND TO ARRAY:C911(at_Errores;"Existía el registro de evaluación de competencias pero no estaba definido en la matriz.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
					End if 
				End if 
			End if 
			
			If (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6#0))
				  //si se trata de una dimensión de aprendizaje buscamos el registro correspondiente sa la dimensión en la tabla [MPA_ObjetosMatriz]...
				$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)+"."+String:C10(0)
				$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
				If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
					  // si existe nos aseguramos que esté habilitado en el período habilitado en el registro [Alumnos_EvaluacionAprendizajes]...
					CREATE RECORD:C68([MPA_ObjetosMatriz:204])
					[MPA_ObjetosMatriz:204]ID_Matriz:1:=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2
					[MPA_ObjetosMatriz:204]ID_Eje:3:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
					[MPA_ObjetosMatriz:204]ID_Dimension:4:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
					[MPA_ObjetosMatriz:204]Periodos:7:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10
					[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
					$b_actualizaObjeto:=True:C214
				End if 
				
				  // si existe nos aseguramos que esté habilitado en el período habilitado en el registro [Alumnos_EvaluacionAprendizajes]...
				  // y/o en los períodos en que se han registrado evaluaciones
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 1)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 1
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 2)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 2
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 3)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 3
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 4)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 4
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 5)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 5
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=1)
					  // si hay un solo periodo por definición el aprendizaje es utilizado en todos los períodos
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=2)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				If (viSTR_Periodos_NumeroPeriodos=3)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				If (viSTR_Periodos_NumeroPeriodos=4)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=5)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				
				$l_bitPeriodoAntes:=[MPA_ObjetosMatriz:204]Periodos:7
				If ([MPA_ObjetosMatriz:204]Periodos:7#[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10)
					If ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1)
						For ($i_periodos;1;5)
							If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $i_periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
								[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
							End if 
						End for 
					Else 
						[MPA_ObjetosMatriz:204]Periodos:7:=1
					End if 
					$b_actualizaObjeto:=True:C214
				End if 
				
				If ($b_actualizaObjeto)
					SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					  // si el registro en la tabla [MPA_ObjetosMatriz] fue recreado o actualizado lo almacenamos y creamos una entrada para el centro de notificaciones.
					If ($l_bitPeriodoAntes#[MPA_ObjetosMatriz:204]Periodos:7)
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Dimension: "+KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]Dimensión:4))
							APPEND TO ARRAY:C911(at_Errores;"La dimensión existía en la matriz pero no estaba habilitada en períodos en los se registraron evaluaciones.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
					Else 
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Dimension: "+KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]Dimensión:4))
							APPEND TO ARRAY:C911(at_Errores;"La dimensión no estaba definida en la matriz.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
					End if 
				End if 
				
				If ([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5>0)
					$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10(0)+"."+String:C10(0)
					$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
					If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
						CREATE RECORD:C68([MPA_ObjetosMatriz:204])
						[MPA_ObjetosMatriz:204]ID_Matriz:1:=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2
						[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
						[MPA_ObjetosMatriz:204]ID_Eje:3:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
						[MPA_ObjetosMatriz:204]ID_Dimension:4:=0
						[MPA_ObjetosMatriz:204]ID_Competencia:5:=0
						[MPA_ObjetosMatriz:204]Periodos:7:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Dimension: "+KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]Dimensión:4))
							APPEND TO ARRAY:C911(at_Errores;"La dimensión no estaba definida en la matriz.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
					Else 
						$l_bitPeriodoAntes:=[MPA_ObjetosMatriz:204]Periodos:7
						If ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1)
							For ($i_periodos;1;5)
								If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $i_periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
									[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
								End if 
							End for 
						Else 
							[MPA_ObjetosMatriz:204]Periodos:7:=1
						End if 
						If ($l_bitPeriodoAntes=[MPA_ObjetosMatriz:204]Periodos:7)
							$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
							If (Find in array:C230(at_Referencias;$t_Ids)<0)
								APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
								APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
								APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
								APPEND TO ARRAY:C911(at_objeto;"Dimension: "+KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]Dimensión:4))
								APPEND TO ARRAY:C911(at_Errores;"La dimensión existía en la matriz pero no estaba habilitada en períodos en los se registraron evaluaciones.")
								APPEND TO ARRAY:C911(al_estilos;0)
								APPEND TO ARRAY:C911(al_colores;Green:K11:9)
							End if 
							SAVE RECORD:C53([MPA_ObjetosMatriz:204])
						End if 
					End if 
				End if 
			End if 
			
			If (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7#0))
				  //si se trata de una competencia de aprendizaje buscamos el registro correspondiente sa la dimensión en la tabla [MPA_ObjetosMatriz]...
				$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
				If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Logro_Aprendizaje))
					  // si existe nos aseguramos que esté habilitado en el período habilitado en el registro [Alumnos_EvaluacionAprendizajes]...
					CREATE RECORD:C68([MPA_ObjetosMatriz:204])
					[MPA_ObjetosMatriz:204]ID_Matriz:1:=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2
					[MPA_ObjetosMatriz:204]ID_Eje:3:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
					[MPA_ObjetosMatriz:204]ID_Dimension:4:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
					[MPA_ObjetosMatriz:204]ID_Competencia:5:=[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7
					[MPA_ObjetosMatriz:204]Periodos:7:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10
					[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Logro_Aprendizaje
					$b_actualizaObjeto:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=85))
					
				End if 
				
				  // si existe nos aseguramos que esté habilitado en el período habilitado en el registro [Alumnos_EvaluacionAprendizajes]...
				  // y/o en los períodos en que se han registrado evaluaciones
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 1)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 1
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 2)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 2
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 3)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 3
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 4)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 4
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"") & ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 5)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 5
					$b_actualizaAprendizaje:=True:C214
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=1)
					  // si hay un solo periodo por definición el aprendizaje es utilizado en todos los períodos
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=2)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				If (viSTR_Periodos_NumeroPeriodos=3)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				If (viSTR_Periodos_NumeroPeriodos=4)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				
				If (viSTR_Periodos_NumeroPeriodos=5)
					If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"") & ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#""))
						  // el aprendizaje está evaluado en todos los períodos, se configura como común a todos los períodos
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 0
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 1
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 2
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 3
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 4
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?- 5
						$b_actualizaObjeto:=True:C214
					End if 
				End if 
				
				$l_bitPeriodoAntes:=[MPA_ObjetosMatriz:204]Periodos:7
				If ([MPA_ObjetosMatriz:204]Periodos:7#[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10)
					If ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1)
						For ($i_periodos;1;5)
							If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $i_periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
								[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
							End if 
						End for 
					Else 
						[MPA_ObjetosMatriz:204]Periodos:7:=1
					End if 
					$b_actualizaObjeto:=True:C214
				End if 
				
				If ($b_actualizaObjeto)
					SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					  // si el registro en la tabla [MPA_ObjetosMatriz] fue recreado o actualizado lo almacenamos y creamos una entrada para el centro de notificaciones.
					If ($l_bitPeriodoAntes#[MPA_ObjetosMatriz:204]Periodos:7)
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Competencia: "+KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;->[MPA_DefinicionCompetencias:187]Competencia:6))
							APPEND TO ARRAY:C911(at_Errores;"La competencia existía en la matriz pero no estaba habilitada en períodos en los se registraron evaluaciones.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
					Else 
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Competencia: "+KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->[MPA_ObjetosMatriz:204]ID_Competencia:5;->[MPA_DefinicionCompetencias:187]Competencia:6))
							APPEND TO ARRAY:C911(at_Errores;"La competencia no estaba estaba definida en la matriz.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
					End if 
				End if 
			End if 
			If ([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5>0)
				$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10(0)+"."+String:C10(0)
				$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
				If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
					CREATE RECORD:C68([MPA_ObjetosMatriz:204])
					[MPA_ObjetosMatriz:204]ID_Matriz:1:=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2
					[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
					[MPA_ObjetosMatriz:204]ID_Eje:3:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
					[MPA_ObjetosMatriz:204]ID_Dimension:4:=0
					[MPA_ObjetosMatriz:204]ID_Competencia:5:=0
					[MPA_ObjetosMatriz:204]Periodos:7:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10
					SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
					If (Find in array:C230(at_Referencias;$t_Ids)<0)
						APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
						APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
						APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
						APPEND TO ARRAY:C911(at_objeto;"Eje: "+KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_ObjetosMatriz:204]ID_Eje:3;->[MPA_DefinicionEjes:185]Nombre:3))
						APPEND TO ARRAY:C911(at_Errores;"El eje no estaba definido en la matriz.")
						APPEND TO ARRAY:C911(al_estilos;0)
						APPEND TO ARRAY:C911(al_colores;Green:K11:9)
					End if 
				Else 
					$l_bitPeriodoAntes:=[MPA_ObjetosMatriz:204]Periodos:7
					If ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1)
						For ($i_periodos;1;5)
							If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $i_periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
								[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
							End if 
						End for 
					Else 
						[MPA_ObjetosMatriz:204]Periodos:7:=1
					End if 
					If ($l_bitPeriodoAntes#[MPA_ObjetosMatriz:204]Periodos:7)
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Eje: "+KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_ObjetosMatriz:204]ID_Eje:3;->[MPA_DefinicionEjes:185]Nombre:3))
							APPEND TO ARRAY:C911(at_Errores;"El eje de aprendizaje no estaba habilitado en Los períodos en los que está habilitada la competencia.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
					End if 
					SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				End if 
			End if 
			
			If ([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6>0)
				$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)+"."+String:C10(0)
				$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
				If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
					CREATE RECORD:C68([MPA_ObjetosMatriz:204])
					[MPA_ObjetosMatriz:204]ID_Matriz:1:=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2
					[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
					[MPA_ObjetosMatriz:204]ID_Eje:3:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
					[MPA_ObjetosMatriz:204]ID_Dimension:4:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
					[MPA_ObjetosMatriz:204]ID_Competencia:5:=0
					[MPA_ObjetosMatriz:204]Periodos:7:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10
					SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
					If (Find in array:C230(at_Referencias;$t_Ids)<0)
						APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
						APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
						APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
						APPEND TO ARRAY:C911(at_objeto;"Dimensión: "+KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]Dimensión:4))
						APPEND TO ARRAY:C911(at_Errores;"La dimensión no estaba definida en la matriz.")
						APPEND TO ARRAY:C911(al_estilos;0)
						APPEND TO ARRAY:C911(al_colores;Green:K11:9)
					End if 
				Else 
					$l_bitPeriodoAntes:=[MPA_ObjetosMatriz:204]Periodos:7
					If ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1)
						For ($i_periodos;1;5)
							If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $i_periodos) & (Not:C34([MPA_ObjetosMatriz:204]Periodos:7 ?? $i_periodos)))
								[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $i_Periodos
							End if 
						End for 
					Else 
						[MPA_ObjetosMatriz:204]Periodos:7:=1
					End if 
					If ($l_bitPeriodoAntes#[MPA_ObjetosMatriz:204]Periodos:7)
						$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						If (Find in array:C230(at_Referencias;$t_Ids)<0)
							APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
							APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
							APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
							APPEND TO ARRAY:C911(at_objeto;"Dimensión: "+KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]Dimensión:4))
							APPEND TO ARRAY:C911(at_Errores;"La dimensión de aprendizaje no estaba habilitada en Los períodos en los que está habilitada la competencia.")
							APPEND TO ARRAY:C911(al_estilos;0)
							APPEND TO ARRAY:C911(al_colores;Green:K11:9)
						End if 
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					End if 
				End if 
			End if 
			
			If ($b_actualizaAprendizaje)
				SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
				$t_Ids:=KRL_MakeStringAccesKey (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				If (Find in array:C230(at_Referencias;$t_Ids)<0)
					APPEND TO ARRAY:C911(at_Referencias;$t_Ids)
					APPEND TO ARRAY:C911(at_Nivel;$t_NombreNivel)
					APPEND TO ARRAY:C911(at_Matriz;$t_NombreMatriz)
					If ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
						APPEND TO ARRAY:C911(at_objeto;"Competencia: "+KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;->[MPA_DefinicionCompetencias:187]Competencia:6))
					End if 
					If ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
						APPEND TO ARRAY:C911(at_objeto;"Dimension: "+KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[MPA_DefinicionDimensiones:188]Dimensión:4))
					End if 
					If ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
						APPEND TO ARRAY:C911(at_objeto;"Eje: "+KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[MPA_DefinicionEjes:185]Nombre:3))
					End if 
					APPEND TO ARRAY:C911(at_Errores;"El registro de evaluación de aprendizajes estaba evaluado en un periodo que no estaba activado en la matriz de evaluación. El período fue activado.")
					APPEND TO ARRAY:C911(al_estilos;0)
					APPEND TO ARRAY:C911(al_colores;Green:K11:9)
				End if 
			End if 
		End for 
		KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
	End if 
End for 
KRL_UnloadReadOnly (->[MPA_AsignaturasMatrices:189])
$l_progressPocess:=IT_Progress (-1;$l_progressPocess)

If (Size of array:C274(at_Errores)>0)
	$t_Encabezado:="Verificación de la consistencia entre matrices de evaluación y registros de competencias evaluados"
	$t_descripcion:="Se detectaron registros de evaluación de competencias evaluados sin que los enunciados correspondientes estuvieran definidos en las matrices de evaluación.\r"
	$t_descripcion:=$t_descripcion+"La lista a continuación contiene el detalle de las matrices en las que se recrearon los enunciados faltantes."
	$t_contenidoTexto:=""
	
	APPEND TO ARRAY:C911(at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911(at_TitulosColumnas;"Nivel")
	APPEND TO ARRAY:C911(at_TitulosColumnas;"Area y matriz")
	APPEND TO ARRAY:C911(at_TitulosColumnas;"Enunciado")
	$t_mensajeFalla:="Se detectaron inconsistencias entre los registros de evaluación y los enunciados en las matrices de evaluación"
	$t_mensajeExito:="No se detectó ninguna inconsistencia entre los registros de evaluación y los enunciados en las matrices de evaluación."
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->at_TitulosColumnas;->at_errores;->at_Nivel;->at_Matriz;->at_objeto)
	NTC_Mensaje_EstilosColores ($t_uuid;->al_estilos;->al_Colores)
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
Else 
	$0:=0
End if 
