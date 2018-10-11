//%attributes = {}
  // MPAcfg_Comp_CambiaDimension()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 27/06/12, 11:44:13
  // ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_cargadoEnEscritura)
C_LONGINT:C283($l_IdCompetencia;$l_IdDimensionDestino;$l_IdDimensionOrigen;$l_IdEjeDimensionDestino;$l_recNumCompetencia;$l_recNumDimensionDestino;$l_TransaccionOK)
C_TEXT:C284($t_textoEventoLog;$t_enunciadoDimensionDestino;$t_mensajeError)

If (False:C215)
	C_TEXT:C284(MPAcfg_Comp_CambiaDimension ;$0)
	C_LONGINT:C283(MPAcfg_Comp_CambiaDimension ;$1)
	C_LONGINT:C283(MPAcfg_Comp_CambiaDimension ;$2)
End if 

  // CÓDIGO
$l_recNumCompetencia:=$1
$l_recNumDimensionDestino:=$2

  // accedo al registro de competencia en lectura escritura para poder cambiarlo a la nueva dimensión
KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;True:C214)
$l_IdCompetencia:=[MPA_DefinicionCompetencias:187]ID:1
$l_IdDimensionOrigen:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
$b_cargadoEnEscritura:=(OK=1)

  // obtengo los IDs de dimensión y eje de la dimensión de destino (acceso en lectura sola) para asignarlos a la competencia si todo va bien
KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimensionDestino;False:C215)
$t_enunciadoDimensionDestino:=[MPA_DefinicionDimensiones:188]Dimensión:4
$l_IdDimensionDestino:=[MPA_DefinicionDimensiones:188]ID:1
$l_IdEjeDimensionDestino:=[MPA_DefinicionDimensiones:188]ID_Eje:3

  // asigno los ID correspondientes a la dimensión de destino para asegurarnos que la competencia no
  // exista en las mismas etapas/niveles
[MPA_DefinicionCompetencias:187]ID_Dimension:23:=$l_IdDimensionDestino
[MPA_DefinicionCompetencias:187]ID_Eje:2:=$l_IdEjeDimensionDestino

For ($i;1;24)
	If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $i) & (Not:C34([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $i)))
		$t_mensajeError:="La competencia está configurada para aplicar en niveles académicos no habilitados para la Dimensión de aprendizaje.\r\rNo es posible asociar la competencia a la Dimensión de aprendizaje"
	End if 
End for 

If ($t_mensajeError="")
	Case of 
		: (Not:C34($b_cargadoEnEscritura))
			  // si el registro pudo ser cargado en lectura y escritura
			$t_mensajeError:=__ ("No fue posible editar el registro de definición de la competencia.\r\rPor favor inténtelo nuevamente mas tarde.")
			
		: (Old:C35([MPA_DefinicionCompetencias:187]ID_Dimension:23)=[MPA_DefinicionCompetencias:187]ID_Dimension:23)
			  // si la competencia es arrastrada sobre la misma dimensión a la que está actualmente asignada, advertimos al usuario
			$t_mensajeError:=__ ("La competencia ya esta asignada a la Dimensión de aprendizaje ")+ST_Qte ($t_enunciadoDimensionDestino)+"."
			
		: (Not:C34(MPAcfg_Comp_EsUnica ))
			  // si ya existe una competencia con el mismo nombre y mismas etapas/niveles de aplicación,
			  // advertimos al usuario, rechazamos el arrastre y liberamos el registro
			$t_mensajeError:=__ ("Existe una competencia con el mismo nombre en la misma Dimensión de aprendizaje y con aplicación en las mismas etapas o niveles académicos.\r\rNo es posible desplazar la Competencia a la Dimensión de aprendizaje ")+ST_Qte ($t_enunciadoDimensionDestino)+"."
			
		: ((([MPA_DefinicionCompetencias:187]DesdeGrado:5#[MPA_DefinicionDimensiones:188]DesdeGrado:6) | ([MPA_DefinicionCompetencias:187]HastaGrado:13#[MPA_DefinicionDimensiones:188]HastaGrado:7)) & ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5>0))
			  // si las etapas /  niveles de la competencia y la dimensión no son compatibles
			$t_mensajeError:=__ ("La Dimensión y la Competencia están asignadas a diferentes etapas.\r\rNo es posible desplazar la Competencia a la Dimensión de aprendizaje ")+ST_Qte ($t_enunciadoDimensionDestino)+"."
			
	End case 
End if 



If ($t_mensajeError="")
	START TRANSACTION:C239
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$l_IdCompetencia)
	ARRAY LONGINT:C221($al_IDsEjes;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
	ARRAY LONGINT:C221($al_IDsDimensiones;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
	AT_Populate (->$al_IDsEjes;->$l_IdEjeDimensionDestino)
	AT_Populate (->$al_IDsDimensiones;->$l_IdDimensionDestino)
	$l_TransaccionOK:=KRL_Array2Selection (->$al_IDsEjes;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->$al_IDsDimensiones;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
	
	If ($l_TransaccionOK=1)
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$l_IdCompetencia)
		ARRAY LONGINT:C221($al_IDsEjes;Records in selection:C76([MPA_ObjetosMatriz:204]))
		ARRAY LONGINT:C221($al_IDsDimensiones;Records in selection:C76([MPA_ObjetosMatriz:204]))
		AT_Populate (->$al_IDsEjes;->$l_IdEjeDimensionDestino)
		AT_Populate (->$al_IDsDimensiones;->$l_IdDimensionDestino)
		$l_TransaccionOK:=KRL_Array2Selection (->$al_IDsEjes;->[MPA_ObjetosMatriz:204]ID_Eje:3;->$al_IDsDimensiones;->[MPA_ObjetosMatriz:204]ID_Dimension:4)
		KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10;>;0;*)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6;>;0)
		CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
	End if 
	
	If ($l_TransaccionOK=1)
		UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
		SET_ClearSets ("$matricesModificadas")
		$t_textoEventoLog:=__ ("Competencia \"^0\" asignada al Eje de aprendizaje \"^1\"")
		$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^0";[MPA_DefinicionCompetencias:187]Competencia:6)
		$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^1";$t_enunciadoDimensionDestino)
		LOG_RegisterEvt ($t_textoEventoLog)
		[MPA_DefinicionCompetencias:187]ID_Dimension:23:=$l_IdDimensionDestino
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		VALIDATE TRANSACTION:C240
		KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])
	Else 
		CANCEL TRANSACTION:C241
		$t_mensajeError:=__ ("No fue posible asignar esta Competencia a la Dimensión de aprendizaje seleccionada.\r\rPor favor inténtelo nuevamente más tarde.")
	End if 
End if 

KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])

$0:=$t_mensajeError