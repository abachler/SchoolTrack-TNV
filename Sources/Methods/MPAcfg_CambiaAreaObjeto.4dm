//%attributes = {}
  // MÉTODO: MPAcfg_CambiaAreaObjeto
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 01/03/12, 12:51:06
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EVLG_CambiaAreaObjeto()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_transferirEnunciados)
C_LONGINT:C283($i;$l_ID_AreaDestino;$l_IdCompetencia;$l_IdEje;$l_recNum_AreaDestino;$l_recNum_AreaOrigen;$l_recNumObjeto;$l_tipoObjeto;$l_transaccionOK)

ARRAY LONGINT:C221($al_RecNums;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_CambiaAreaObjeto ;$1)
	C_LONGINT:C283(MPAcfg_CambiaAreaObjeto ;$2)
	C_LONGINT:C283(MPAcfg_CambiaAreaObjeto ;$3)
End if 

  // CODIGO PRINCIPAL
$l_tipoObjeto:=$1
$l_recNumObjeto:=$2
$l_recNum_AreaDestino:=$3

$b_transferirEnunciados:=False:C215

REDUCE SELECTION:C351([MPA_DefinicionEjes:185];0)
REDUCE SELECTION:C351([MPA_DefinicionDimensiones:188];0)
REDUCE SELECTION:C351([MPA_DefinicionCompetencias:187];0)

  // obtengo los ids del área de destino
KRL_GotoRecord (->[MPA_DefinicionAreas:186];$l_recNum_AreaDestino)
$l_ID_AreaDestino:=[MPA_DefinicionAreas:186]ID:1



If (OK=1)
	Case of 
		: ($l_tipoObjeto=Eje_Aprendizaje)
			KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumObjeto)
			If ($l_ID_AreaDestino=[MPA_DefinicionEjes:185]ID_Area:2)
				CD_Dlog (0;"Este eje ya está asignado a estea área.")
			Else 
				
				[MPA_DefinicionEjes:185]ID_Area:2:=$l_ID_AreaDestino  // asigno (en memoria, sin guardar la asignación) al eje el Id del área de destino para verificar si no hay otro eje con el mismo nombre
				If (Not:C34(MPAcfg_Eje_EsUnico ))
					  // ya existe un eje con el mismo nombre en el area de destino. No puede ser transferido ni copiado
					CD_Dlog (0;"Ya existe un Eje de aprendizaje con el mismo nombre en el area de destino.\r\rEl eje no puede ser desplazado o copiado")
					$l_recNumObjeto:=-1
				End if 
				
				
				
				If ($l_recNumObjeto>=0)
					KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumObjeto;True:C214)
					$l_IdEje:=[MPA_DefinicionEjes:185]ID:1
					QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$l_IdEje)
					If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
						  // El eje es utilizado en matrices. No puede ser transferido pero si copiado. El método EVLG_CopiaObjetoEnArea se encarga de hacerlo con o sin sus dependencias
						OK:=CD_Dlog (0;Replace string:C233(__ ("Este Eje de aprendizaje es utilizado en matrices de evaluación de asignaturas del área seleccionada.\rNo es posible transferirlo a otra área, pero sí puede ser copiado.\r\r¿Desea copiar el Eje de aprendizaje al área \"^0\"?");__ ("^0");[MPA_DefinicionAreas:186]AreaAsignatura:4);__ ("");__ ("Si. Copiar");__ ("Cancelar"))
						If (OK=1)
							$l_recNumObjeto:=MPAcfg_CopiaObjetoEnArea ($l_tipoObjeto;$l_recNumObjeto;$l_recNum_AreaDestino)
						End if 
					Else 
						  // El eje no esta asignado a ninguna matriz. Puede ser transferido con todas su dependencias
						  // Creo conjuntos para procesar la transferencia en una transacción más abajo en este método
						CREATE SET:C116([MPA_DefinicionEjes:185];"Ejes")
						QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_IdEje)
						CREATE SET:C116([MPA_DefinicionDimensiones:188];"Dimensiones")
						QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_IdEje)
						CREATE SET:C116([MPA_DefinicionCompetencias:187];"Competencias")
						$b_transferirEnunciados:=True:C214
					End if 
				End if 
			End if 
			
		: ($l_tipoObjeto=Logro_Aprendizaje)
			
			  // cargo el registro de definición de competencia (solo lectura por ahora, sólo para verificar si no hay un homónimo en la misma área)
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumObjeto)
			[MPA_DefinicionCompetencias:187]ID_Area:11:=$l_ID_AreaDestino  // asigno providoriamente (en memoria, sin guardar la asignación) al eje el Id del área de destino para verificar si no hay otro eje con el mismo nombre
			If (Not:C34(MPAcfg_Comp_EsUnica ))
				  // ya existe una competencia con el mismo nombre en el area de destino. No puede ser transferida ni copiada
				CD_Dlog (0;"Ya existe un Competencia con el mismo nombre en el area de destino.\r\rLa Competencia no puede ser desplazada o copiada")
				$l_recNumObjeto:=-1
			Else 
				[MPA_DefinicionCompetencias:187]ID_Area:11:=Old:C35([MPA_DefinicionCompetencias:187]ID_Area:11)  // reestablezco el ID de area previo al test de unicidad
			End if 
			
			
			If ($l_recNumObjeto>=0)  // si el registro puede ser transferido
				Case of 
					: (([MPA_DefinicionCompetencias:187]ID_Area:11=$l_ID_AreaDestino) & ([MPA_DefinicionCompetencias:187]ID_Eje:2=0))
						  // si la competencia ya está asociada directamente al área, informo al usuario y aborto el cambio de área
						CD_Dlog (0;__ ("Esta Competencia ya está asociada directamente al área"))
						$b_transferirEnunciados:=False:C215
						
					: (([MPA_DefinicionCompetencias:187]ID_Area:11=$l_ID_AreaDestino) & ([MPA_DefinicionCompetencias:187]ID_Eje:2#0))
						  // el área actual es la misma que el área de destino, no habrá transferencia a otra área
						$b_transferirEnunciados:=False:C215
						  //El usuario busca asociar directamente al área una competencia actualmente asociada a un eje
						  // Informo al usuario y solicito confirmación
						$l_respuestaUsuario:=CD_Dlog (0;__ ("Esta Competencia está asociada a un Eje de aprendizaje asociado al área.\r\r¿Desea disociarla del Eje y asociarla directamente al área?");"";__ ("Aceptar");__ ("Cancelar"))
						
						
						
						  // si el usuario confirma inicio una transacción en la que la competencia será disociada del eje 
						If ($l_respuestaUsuario=1)
							
							  // busco los objetos en matrices correspondientes a la competencia en proceso
							QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_DefinicionCompetencias:187]ID:1)
							CREATE SET:C116([MPA_ObjetosMatriz:204];"$objetos")
							
							  // busco los registros de evaluación aprendizajes correspondientes a la competencia en proceso
							USE SET:C118("$objetos")
							KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;->[MPA_ObjetosMatriz:204]ID_Competencia:5)
							CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$aprendizajes")
							
							  // busco y pongo en el el conjunto $matricesModificadas las matrices que podrían requerir recalculos de promedios
							USE SET:C118("$objetos")
							KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1)
							CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
							
							
							START TRANSACTION:C239
							KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumObjeto;True:C214)  // cargo el registro de definición de competencia en modo escritura
							If (OK=1)
								  //disocio los registros de evaluación de aprendizajes de la dimensión y el eje al que estaban asociados
								USE SET:C118("$aprendizajes")
								ARRAY LONGINT:C221($al_Zero;Records in set:C195("$aprendizajes"))
								OK:=KRL_Array2Selection (->$al_Zero;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->$al_Zero;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
								
								If (OK=1)
									  //disocio los objetos de matrices de la dimensión y el eje al que estaban asociados
									USE SET:C118("$objetos")
									ARRAY LONGINT:C221($al_Zero;Records in set:C195("$objetos"))
									OK:=KRL_Array2Selection (->$al_Zero;->[MPA_ObjetosMatriz:204]ID_Eje:3;->$al_Zero;->[MPA_ObjetosMatriz:204]ID_Dimension:4)
								End if 
								
								If (OK=1)
									KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumObjeto;True:C214)
									[MPA_DefinicionCompetencias:187]ID_Eje:2:=0  // disocio la comptencia del eje a la que estaba asociado
									[MPA_DefinicionCompetencias:187]ID_Dimension:23:=0  // disocio la comptencia del eje a la que estaba asociado
									SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
									VALIDATE TRANSACTION:C240
									
									  //Agrego al conjunto de matrices a recalcular las matrices modificadas durante este cambio
									  // (el conjunto $matrices_a_recalcular es manejado en el método asociado al panel de configuración de mapas de aprendizaje)
									UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
								Else 
									CANCEL TRANSACTION:C241
								End if 
							End if 
						End if 
						
						
						
					Else 
						KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumObjeto)
						$l_IdCompetencia:=[MPA_DefinicionCompetencias:187]ID:1
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$l_IdCompetencia)
						If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
							  // La competencia es utilizada en matrices. No puede ser transferida pero si copiada. El método EVLG_CopiaObjetoEnArea se encarga de hacerlo.
							OK:=CD_Dlog (0;Replace string:C233(__ ("Esta Competencia es utilizada en matrices de evaluación de asignaturas del área seleccionada.\rNo es posible transferirla a otra área, pero sí puede ser copiada.\r\r¿Desea copiar la Competencia al área \"^0\"\"?");__ ("^0");[MPA_DefinicionAreas:186]AreaAsignatura:4);__ ("");__ ("Si. Copiar");__ ("Cancelar"))
							If (OK=1)
								$l_recNumObjeto:=MPAcfg_CopiaObjetoEnArea ($l_tipoObjeto;$l_recNumObjeto;$l_recNum_AreaDestino)
							End if 
						Else 
							  // La competencia no esta asignada a ninguna matriz. Puede ser transferida al area de destino
							  // Creo conjuntos para procesar la transferencia en una transacción más abajo en este método
							CREATE SET:C116([MPA_DefinicionCompetencias:187];"Competencias")
							$b_transferirEnunciados:=True:C214
						End if 
				End case 
			End if 
	End case 
End if 







  // TRANSFERENCIA DE ENUNCIADOS NO ASIGNADOS A MATRICES AL AREA DE DESTINO
If ($b_transferirEnunciados)
	$l_transaccionOK:=1
	START TRANSACTION:C239
	
	SET_UseSet ("Competencias")
	ARRAY LONGINT:C221($al_ID_areaDestino;Records in selection:C76([MPA_DefinicionCompetencias:187]))
	AT_Populate (->$al_ID_areaDestino;->$l_ID_AreaDestino)
	$l_transaccionOK:=KRL_Array2Selection (->$al_ID_areaDestino;->[MPA_DefinicionCompetencias:187]ID_Area:11)
	If ((cb_AutoActualizaMatricesMPA=1) & ($l_transaccionOK=1))
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_RecNums;"")
		For ($i;1;Size of array:C274($al_RecNums))
			GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_RecNums{$i})
			MPAcfg_ActualizaMatrices ($l_recNum_AreaDestino;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;Record number:C243([MPA_DefinicionCompetencias:187]))
		End for 
	End if 
	
	If ($l_transaccionOK=1)
		SET_UseSet ("Dimensiones")
		ARRAY LONGINT:C221($al_ID_areaDestino;Records in selection:C76([MPA_DefinicionDimensiones:188]))
		AT_Populate (->$al_ID_areaDestino;->$l_ID_AreaDestino)
		$l_transaccionOK:=KRL_Array2Selection (->$al_ID_areaDestino;->[MPA_DefinicionDimensiones:188]ID_Area:2)
		If ((cb_AutoActualizaMatricesMPA=1) & ($l_transaccionOK=1))
			LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_RecNums;"")
			For ($i;1;Size of array:C274($al_RecNums))
				GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_RecNums{$i})
				MPAcfg_ActualizaMatrices ($l_recNum_AreaDestino;Dimension_Aprendizaje;[MPA_DefinicionDimensiones:188]DesdeGrado:6;[MPA_DefinicionDimensiones:188]HastaGrado:7;Record number:C243([MPA_DefinicionDimensiones:188]))
			End for 
		End if 
	End if 
	
	If ($l_transaccionOK=1)
		SET_UseSet ("Ejes")
		ARRAY LONGINT:C221($al_ID_areaDestino;Records in selection:C76([MPA_DefinicionEjes:185]))
		AT_Populate (->$al_ID_areaDestino;->$l_ID_AreaDestino)
		$l_transaccionOK:=KRL_Array2Selection (->$al_ID_areaDestino;->[MPA_DefinicionEjes:185]ID_Area:2)
		If ((cb_AutoActualizaMatricesMPA=1) & ($l_transaccionOK=1))
			LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$al_RecNums;"")
			For ($i;1;Size of array:C274($al_RecNums))
				GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_RecNums{$i})
				MPAcfg_ActualizaMatrices ($l_recNum_AreaDestino;Eje_Aprendizaje;[MPA_DefinicionEjes:185]DesdeGrado:4;[MPA_DefinicionEjes:185]HastaGrado:5;Record number:C243([MPA_DefinicionEjes:185]))
			End for 
		End if 
	End if 
	If ($l_transaccionOK=1)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
	End if 
End if 

SET_ClearSets ("Competencias";"Dimensiones";"Competencias";"$matricesModificadas")

If ($l_transaccionOK=0)
	$l_recNumObjeto:=-1
End if 

$0:=$l_recNumObjeto

