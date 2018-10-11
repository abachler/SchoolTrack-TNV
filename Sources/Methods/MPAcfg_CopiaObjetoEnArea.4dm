//%attributes = {}
  // MPAcfg_CopiaObjetoEnArea()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 20/07/12, 13:08:32
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_copiarObjeto)
C_LONGINT:C283($i;$iCompetencias;$l_IdDimension;$l_asignado_a_etapa;$l_desdeNivel;$l_hastaNivel;$l_IdAreaDestino;$l_IdDimensionCopiada;$l_IdEje_a_copiar;$l_IdEjeCopiado)
C_LONGINT:C283($l_recNumAreaDestino;$l_recNumEnunciadoCopiado;$l_recNumObjeto;$l_tipoObjecto)

ARRAY LONGINT:C221($aRecNums;0)
ARRAY LONGINT:C221($aRecNumsCompetencias;0)
ARRAY LONGINT:C221($DA_Return;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_CopiaObjetoEnArea ;$0)
	C_LONGINT:C283(MPAcfg_CopiaObjetoEnArea ;$1)
	C_LONGINT:C283(MPAcfg_CopiaObjetoEnArea ;$2)
	C_LONGINT:C283(MPAcfg_CopiaObjetoEnArea ;$3)
End if 

  // CÓDIGO

$l_tipoObjecto:=$1
$l_recNumObjeto:=$2
$l_recNumAreaDestino:=$3

$b_copiarObjeto:=True:C214

KRL_GotoRecord (->[MPA_DefinicionAreas:186];$l_recNumAreaDestino)
$l_IdAreaDestino:=[MPA_DefinicionAreas:186]ID:1

$l_recNumEnunciadoCopiado:=-1
Case of 
	: ($l_tipoObjecto=Dimension_Aprendizaje)
		CD_Dlog (0;__ ("Las dimensiones de aprendizajes no pueden ser desplazadas o copiadas individualmente (dependen siempre de un Eje de Aprendizaje."))
		  //las dimensiones de aprendizajes no se pueden copiar sin copiar el eje (no puede haber dimensiones no asignadas a un eje)
		$l_recNumEnunciadoCopiado:=-1
		
	: ($l_tipoObjecto=Eje_Aprendizaje)
		KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumObjeto;False:C215)
		If (OK=1)
			[MPA_DefinicionEjes:185]ID_Area:2:=$l_IdAreaDestino  // cambio el ID del area para asegurarme que en área de destino no exista un eje homónimo
			If (Not:C34(MPAcfg_Eje_EsUnico ))
				CD_Dlog (0;"Ya existe un Eje de aprendizaje con el mismo nombre en el area de destino.\r\rEl eje no puede ser desplazado ni copiado")
				$b_copiarObjeto:=False:C215
			End if 
		Else 
			$b_copiarObjeto:=False:C215
			CD_Dlog (0;__ ("No fue posible accedera la información del eje a copiar."))
		End if 
		
		If ($b_copiarObjeto)
			  // leo las etapas del área de destino
			MPAcfg_LeeEtapasDelArea ($l_recNumAreaDestino)
			
			  //verifico que las etapas o niveles en los que aplica el eje sean compatibles con las etapas en el área de destino
			If ([MPA_DefinicionEjes:185]Asignado_a_Etapa:19=1)
				  //si está asignado a una etapa verifico que la etapa exista en el área de destino
				alMPA_NivelDesde{0}:=[MPA_DefinicionEjes:185]DesdeGrado:4
				alMPA_NivelHasta{0}:=[MPA_DefinicionEjes:185]HastaGrado:5
				AT_MultiArraySearch (True:C214;->$DA_Return;->alMPA_NivelDesde;->alMPA_NivelHasta)
				If (Size of array:C274($DA_Return)=1)
					  //si existe mantengo la asignación a etapa
					$b_copiarObjeto:=True:C214
					$l_asignado_a_etapa:=1
					$l_desdeNivel:=[MPA_DefinicionEjes:185]DesdeGrado:4
					$l_hastaNivel:=[MPA_DefinicionEjes:185]HastaGrado:5
				Else 
					  //si no existe pregunto al usuario si desea copiar el eje dejándolo disponible para toda etapa
					OK:=CD_Dlog (0;__ ("La etapa a la que esta asignado este Eje en el área de origen no tiene correspondencia exacta con una etapa en el área de destino.\r\r¿Desea copiarlo al área de destino y dejarlo disponible para todas las etapas? ");__ ("");__ ("Si. Copiar");__ ("Cancelar"))
					If (OK=1)  //si el usuario acepta asigno los valores que utilizaré para las etapas al duplicar el eje
						$b_copiarObjeto:=True:C214
						$l_asignado_a_etapa:=0
						$l_desdeNivel:=-100
						$l_hastaNivel:=-100
					Else 
						$b_copiarObjeto:=False:C215
					End if 
				End if 
			Else 
				  //si no está asignado a ninguna etapa asigno los valores que utilizaré para las etapas al duplicar el eje
				$b_copiarObjeto:=True:C214
				$l_asignado_a_etapa:=0
				$l_desdeNivel:=-100
				$l_hastaNivel:=-100
			End if 
		End if 
		
		If ($b_copiarObjeto)
			$l_IdEje_a_copiar:=[MPA_DefinicionEjes:185]ID:1
			  // las dimensiones del eje deben ser copiadas conjuntamente con el eje
			  //     busco las dimensiones asignadas al eje
			QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_IdEje_a_copiar)
			CREATE SET:C116([MPA_DefinicionDimensiones:188];"dimensiones")
			
			  // las competencias asociadas al eje y no asociadas a ninguna dimensión deben ser copiadas
			  //     busco las competencias asignadas al eje no asignadas a ninguna dimensión
			QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_IdEje_a_copiar;*)
			QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]ID_Dimension:23=0)
			CREATE SET:C116([MPA_DefinicionCompetencias:187];"competenciasEnEje")
			
			  //cargo el eje a transferir y lo duplico y le asigno el ID del área de destino
			KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumObjeto;False:C215)
			DUPLICATE RECORD:C225([MPA_DefinicionEjes:185])
			[MPA_DefinicionEjes:185]ID:1:=SQ_SeqNumber (->[MPA_DefinicionEjes:185]ID:1)  //genero un nuevo id
			[MPA_DefinicionEjes:185]ID_Area:2:=$l_IdAreaDestino  //asigno el eje al área de destino
			[MPA_DefinicionEjes:185]Asignado_a_Etapa:19:=$l_asignado_a_etapa  //asigno las variables relativas a las etapas
			[MPA_DefinicionEjes:185]DesdeGrado:4:=$l_desdeNivel
			[MPA_DefinicionEjes:185]HastaGrado:5:=$l_hastaNivel
			$l_IdEjeCopiado:=[MPA_DefinicionEjes:185]ID:1  //conservo el id de la copia del eje para asignarlo a las copias de dimensiones y competencias dependientes
			[MPA_DefinicionEjes:185]Auto_UUID:23:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
			MPAcfg_Eje_AlGuardar 
			SAVE RECORD:C53([MPA_DefinicionEjes:185])
			$l_recNumEnunciadoCopiado:=Record number:C243([MPA_DefinicionEjes:185])
			If (cb_AutoActualizaMatricesMPA=1)
				MPAcfg_ActualizaMatrices ($l_recNumAreaDestino;Eje_Aprendizaje;$l_desdeNivel;$l_hastaNivel;$l_recNumEnunciadoCopiado)
			End if 
			
			  // si el eje copiado tenía dimensiones asociadas y el usuario optó por copiar el eje con sus dependencias
			  // copio las dimensiones y las competencias asociadas a ellas
			If (Records in set:C195("dimensiones")>0)
				USE SET:C118("dimensiones")
				LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$aRecNums;"")
				For ($i;1;Size of array:C274($aRecNums))
					GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$aRecNums{$i})
					$l_IdDimension:=[MPA_DefinicionDimensiones:188]ID:1  //conservo el id de la dimension para buscar las competencias que dependen de ella
					If ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5=1)  //verifico asignación a etapas, conservo en variables la asignación a etapas 
						alMPA_NivelDesde{0}:=[MPA_DefinicionDimensiones:188]DesdeGrado:6
						alMPA_NivelHasta{0}:=[MPA_DefinicionDimensiones:188]HastaGrado:7
						AT_MultiArraySearch (True:C214;->$DA_Return;->alMPA_NivelDesde;->alMPA_NivelHasta)
						If (Size of array:C274($DA_Return)=1)
							$l_asignado_a_etapa:=1
							$l_desdeNivel:=[MPA_DefinicionDimensiones:188]DesdeGrado:6
							$l_hastaNivel:=[MPA_DefinicionDimensiones:188]HastaGrado:7
						Else 
							$l_asignado_a_etapa:=0
							$l_desdeNivel:=-100
							$l_hastaNivel:=-100
						End if 
					Else 
						$l_asignado_a_etapa:=0
						$l_desdeNivel:=-100
						$l_hastaNivel:=-100
					End if 
					DUPLICATE RECORD:C225([MPA_DefinicionDimensiones:188])  //duplico el registro
					[MPA_DefinicionDimensiones:188]ID:1:=SQ_SeqNumber (->[MPA_DefinicionDimensiones:188]ID:1)
					[MPA_DefinicionDimensiones:188]ID_Area:2:=$l_IdAreaDestino
					[MPA_DefinicionDimensiones:188]ID_Eje:3:=$l_IdEjeCopiado
					[MPA_DefinicionDimensiones:188]Auto_UUID:23:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					If (($l_asignado_a_etapa=0) & ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5=1))
						[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5:=$l_asignado_a_etapa
						[MPA_DefinicionDimensiones:188]DesdeGrado:6:=$l_desdeNivel
						[MPA_DefinicionDimensiones:188]HastaGrado:7:=$l_hastaNivel
					End if 
					MPAcfg_Dim_AlGuardar 
					SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
					$l_IdDimensionCopiada:=[MPA_DefinicionDimensiones:188]ID:1
					If ((cb_AutoActualizaMatricesMPA=1) & (Record number:C243([MPA_DefinicionDimensiones:188])>=0))
						MPAcfg_ActualizaMatrices ($l_recNumAreaDestino;Dimension_Aprendizaje;$l_desdeNivel;$l_hastaNivel;Record number:C243([MPA_DefinicionDimensiones:188]))
					End if 
					
					  //busco las competencias asociadas a la dimensión a copiar y las creo asociándolas a la dimensión copiada
					QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$l_IdDimension)
					LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$aRecNumsCompetencias;"")
					For ($iCompetencias;1;Size of array:C274($aRecNumsCompetencias))
						GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$aRecNumsCompetencias{$iCompetencias})
						If ([MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4=1)
							alMPA_NivelDesde{0}:=[MPA_DefinicionCompetencias:187]DesdeGrado:5
							alMPA_NivelHasta{0}:=[MPA_DefinicionCompetencias:187]HastaGrado:13
							AT_MultiArraySearch (True:C214;->$DA_Return;->alMPA_NivelDesde;->alMPA_NivelHasta)
							If (Size of array:C274($DA_Return)=1)
								$l_asignado_a_etapa:=1
								$l_desdeNivel:=[MPA_DefinicionCompetencias:187]DesdeGrado:5
								$l_hastaNivel:=[MPA_DefinicionCompetencias:187]HastaGrado:13
							Else 
								$l_asignado_a_etapa:=0
								$l_desdeNivel:=-100
								$l_hastaNivel:=-100
							End if 
						Else 
							$l_asignado_a_etapa:=0
							$l_desdeNivel:=-100
							$l_hastaNivel:=-100
						End if 
						DUPLICATE RECORD:C225([MPA_DefinicionCompetencias:187])  //duplico el registro
						[MPA_DefinicionCompetencias:187]ID:1:=SQ_SeqNumber (->[MPA_DefinicionCompetencias:187]ID:1)  //genero un nuevo id para la competencia
						[MPA_DefinicionCompetencias:187]ID_Eje:2:=$l_IdEjeCopiado  //asigno el id del eje copiado
						[MPA_DefinicionCompetencias:187]ID_Dimension:23:=$l_IdDimensionCopiada  //asigno el id de la dimension copiada
						[MPA_DefinicionCompetencias:187]ID_Area:11:=$l_IdAreaDestino  //asigno la dimensión al área de destino
						[MPA_DefinicionCompetencias:187]Auto_UUID:30:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
						If (($l_asignado_a_etapa=0) & ([MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4=1))  //si hay cambio en las etapas reasigno las variables correspondientes al área de de  `  `stino 
							[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=$l_asignado_a_etapa
							[MPA_DefinicionCompetencias:187]DesdeGrado:5:=$l_desdeNivel
							[MPA_DefinicionCompetencias:187]HastaGrado:13:=$l_hastaNivel
						End if 
						MPAcfg_Comp_AlGuardar 
						SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
						If ((cb_AutoActualizaMatricesMPA=1) & (Record number:C243([MPA_DefinicionCompetencias:187])>=0))
							MPAcfg_ActualizaMatrices ($l_recNumAreaDestino;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;Record number:C243([MPA_DefinicionCompetencias:187]))
						End if 
					End for 
				End for 
				
			End if 
			
			  // si el eje copiado tenía competencias asociadas al eje directamente y el usuario optó por copiar el eje con sus dependencias
			  // copio las cas competencias asociadas a al eje
			If (Records in set:C195("competenciasEnEje")>0)
				USE SET:C118("competenciasEnEje")
				LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$aRecNums;"")
				For ($i;1;Size of array:C274($aRecNums))
					GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$aRecNums{$i})
					If ([MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4=1)
						alMPA_NivelDesde{0}:=[MPA_DefinicionCompetencias:187]DesdeGrado:5
						alMPA_NivelHasta{0}:=[MPA_DefinicionCompetencias:187]HastaGrado:13
						AT_MultiArraySearch (True:C214;->$DA_Return;->alMPA_NivelDesde;->alMPA_NivelHasta)
						If (Size of array:C274($DA_Return)=1)
							$l_asignado_a_etapa:=1
							$l_desdeNivel:=[MPA_DefinicionCompetencias:187]DesdeGrado:5
							$l_hastaNivel:=[MPA_DefinicionCompetencias:187]HastaGrado:13
						Else 
							$l_asignado_a_etapa:=0
							$l_desdeNivel:=-100
							$l_hastaNivel:=-100
						End if 
					Else 
						$l_asignado_a_etapa:=0
						$l_desdeNivel:=-100
						$l_hastaNivel:=-100
					End if 
					DUPLICATE RECORD:C225([MPA_DefinicionCompetencias:187])
					[MPA_DefinicionCompetencias:187]ID:1:=SQ_SeqNumber (->[MPA_DefinicionCompetencias:187]ID:1)
					[MPA_DefinicionCompetencias:187]ID_Eje:2:=$l_IdEjeCopiado  //asigno el id del eje copiado
					[MPA_DefinicionCompetencias:187]ID_Area:11:=$l_IdAreaDestino
					[MPA_DefinicionCompetencias:187]Auto_UUID:30:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					If (($l_asignado_a_etapa=0) & ([MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4=1))
						[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=$l_asignado_a_etapa
						[MPA_DefinicionCompetencias:187]DesdeGrado:5:=$l_desdeNivel
						[MPA_DefinicionCompetencias:187]HastaGrado:13:=$l_hastaNivel
					End if 
					MPAcfg_Comp_AlGuardar 
					SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
					If ((cb_AutoActualizaMatricesMPA=1) & (Record number:C243([MPA_DefinicionCompetencias:187])>=0))
						MPAcfg_ActualizaMatrices ($l_recNumAreaDestino;Logro_Aprendizaje;$l_desdeNivel;$l_hastaNivel;Record number:C243([MPA_DefinicionCompetencias:187]))
					End if 
				End for 
			End if 
			
		End if 
		
	: ($l_tipoObjecto=Logro_Aprendizaje)
		
		KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumObjeto;True:C214)
		  // asigno en memoria, sin guardar, el ID del área e inicializo los ID de Eje y dimensión para asegurarme de que no exista una competencia con el mismo nombre
		  // asignada directamente al área
		[MPA_DefinicionCompetencias:187]ID_Area:11:=$l_IdAreaDestino
		[MPA_DefinicionCompetencias:187]ID_Eje:2:=0
		[MPA_DefinicionCompetencias:187]ID_Dimension:23:=0
		If (Not:C34(MPAcfg_Comp_EsUnica ))
			CD_Dlog (0;__ ("Ya existe una Competencia con el mismo nombre en el área de destino.\r\rLa Dimensión no puede ser desplazada ni copiada."))
			$b_copiarObjeto:=False:C215
		End if 
		
		If ($b_copiarObjeto)
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumObjeto;True:C214)
			If ([MPA_DefinicionCompetencias:187]ID_Eje:2>0)
				OK:=CD_Dlog (0;__ ("Esta Competencia está asociada a un Eje de aprendizaje.\rSi desea mantener esa relación debe copiar el Eje.\rSi la copia aisladamente no dependerá de ningún eje.\r\r¿Copiar sin la dependencia del Eje?");__ ("");__ ("Si. Copiar");__ ("Cancelar"))
			Else 
				OK:=1
			End if 
			If (OK=1)
				$b_copiarObjeto:=True:C214
			Else 
				$b_copiarObjeto:=False:C215
			End if 
		End if 
		
		If ($b_copiarObjeto)
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumObjeto;True:C214)
			MPAcfg_LeeEtapasDelArea ($l_recNumAreaDestino)
			If ([MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4=1)
				alMPA_NivelDesde{0}:=[MPA_DefinicionCompetencias:187]DesdeGrado:5
				alMPA_NivelHasta{0}:=[MPA_DefinicionCompetencias:187]HastaGrado:13
				AT_MultiArraySearch (True:C214;->$DA_Return;->alMPA_NivelDesde;->alMPA_NivelHasta)
				If (Size of array:C274($DA_Return)=1)
					$b_copiarObjeto:=True:C214
					$l_asignado_a_etapa:=1
					$l_desdeNivel:=[MPA_DefinicionCompetencias:187]DesdeGrado:5
					$l_hastaNivel:=[MPA_DefinicionCompetencias:187]HastaGrado:13
				Else 
					OK:=CD_Dlog (0;__ ("La etapa a la que está asignada esta Competencia en el área de origen no tiene correspondencia exacta con una etapa en el área de destino.\r\r¿Desea copiarla al área de destino y dejarla disponible para todas las etapas? ");__ ("");__ ("Si. Copiar");__ ("Cancelar"))
					If (OK=1)
						$b_copiarObjeto:=True:C214
						$l_asignado_a_etapa:=0
						$l_desdeNivel:=-100
						$l_hastaNivel:=-100
					Else 
						$b_copiarObjeto:=False:C215
					End if 
				End if 
			Else 
				$b_copiarObjeto:=True:C214
				$l_asignado_a_etapa:=0
				$l_desdeNivel:=-100
				$l_hastaNivel:=-100
			End if 
			
			If ($b_copiarObjeto)
				DUPLICATE RECORD:C225([MPA_DefinicionCompetencias:187])
				[MPA_DefinicionCompetencias:187]ID:1:=SQ_SeqNumber (->[MPA_DefinicionCompetencias:187]ID:1)
				[MPA_DefinicionCompetencias:187]ID_Area:11:=$l_IdAreaDestino
				[MPA_DefinicionCompetencias:187]ID_Eje:2:=0
				[MPA_DefinicionCompetencias:187]ID_Dimension:23:=0
				[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=$l_asignado_a_etapa
				[MPA_DefinicionCompetencias:187]DesdeGrado:5:=$l_desdeNivel
				[MPA_DefinicionCompetencias:187]HastaGrado:13:=$l_hastaNivel
				[MPA_DefinicionCompetencias:187]Auto_UUID:30:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
				MPAcfg_Comp_AlGuardar 
				SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
				$l_recNumEnunciadoCopiado:=Record number:C243([MPA_DefinicionCompetencias:187])
				If (cb_AutoActualizaMatricesMPA=1)
					MPAcfg_ActualizaMatrices ($l_recNumAreaDestino;Logro_Aprendizaje;$l_desdeNivel;$l_hastaNivel;$l_recNumEnunciadoCopiado)
				End if 
			End if 
		End if 
		
End case 

$0:=$l_recNumEnunciadoCopiado