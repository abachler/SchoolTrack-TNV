//%attributes = {}
  // MPAcfg_Comp_CambiaEje()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 20/07/12, 14:05:23
  // ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_cargadoEnEscritura)
C_LONGINT:C283($l_IdCompetencia;$l_IdEjeDestino;$l_IdEjeOrigen;$l_recNumCompetencia;$l_recNumEjeDestino;$l_TransaccionOK)
C_TEXT:C284($t_enunciadoDimensionDestino;$t_enunciadoEjeDestino;$t_mensajeError;$t_TextoEventoLog)

If (False:C215)
	C_TEXT:C284(MPAcfg_Comp_CambiaEje ;$0)
	C_LONGINT:C283(MPAcfg_Comp_CambiaEje ;$1)
	C_LONGINT:C283(MPAcfg_Comp_CambiaEje ;$2)
End if 

  // CÓDIGO
$l_recNumCompetencia:=$1
$l_recNumEjeDestino:=$2

  // accedo al registro de competencia en lectura escritura para poder cambiarlo a la nueva dimensión
KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;True:C214)
$l_IdCompetencia:=[MPA_DefinicionCompetencias:187]ID:1
$l_IdEjeOrigen:=[MPA_DefinicionCompetencias:187]ID_Eje:2
$b_cargadoEnEscritura:=(OK=1)


  // obtengo el ID del eje de destino (acceso en lectura sola) para asignarlos a la competencia si todo va bien
KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEjeDestino;False:C215)
$t_enunciadoEjeDestino:=[MPA_DefinicionEjes:185]Nombre:3
$l_IdEjeDestino:=[MPA_DefinicionEjes:185]ID:1

  // asigno los ID correspondientes al eje de destino para asegurarnos que la competencia no
  // exista en las mismas etapas/niveles
[MPA_DefinicionCompetencias:187]ID_Eje:2:=$l_IdEjeDestino

For ($i;1;24)
	If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $i) & (Not:C34([MPA_DefinicionEjes:185]BitsNiveles:20 ?? $i)))
		$t_mensajeError:="La competencia está configurada para aplicar en niveles académicos no habilitados para el eje de destino.\r\rNo es posible asociar la competencia al eje de aprendizaje"
	End if 
End for 


If ($t_mensajeError="")
	Case of 
		: (Not:C34($b_cargadoEnEscritura))
			  // si el registro pudo ser cargado en lectura y escritura
			$t_mensajeError:=__ ("No fue posible editar el registro de definición de la competencia.\r\rPor favor inténtelo nuevamente mas tarde.")
			
		: ((Old:C35([MPA_DefinicionCompetencias:187]ID_Eje:2)=[MPA_DefinicionCompetencias:187]ID_Eje:2) & ([MPA_DefinicionCompetencias:187]ID_Dimension:23=0))
			  // si la competencia es arrastrada sobre la misma dimensión a la que está actualmente asignada, advertimos al usuario
			$t_mensajeError:=__ ("La competencia ya esta asignada a el Eje de aprendizaje ")+ST_Qte ($t_enunciadoEjeDestino)+"."
			
		: (Not:C34(MPAcfg_Comp_EsUnica ))
			  // si ya existe una competencia con el mismo nombre y mismas etapas/niveles de aplicación,
			  // advertimos al usuario, rechazamos el arrastre y liberamos el registro
			$t_mensajeError:=__ ("Existe una competencia con el mismo nombre en el mismo Eje de aprendizaje y con aplicación en las mismas etapas o niveles académicos.\r\rNo es posible desplazar la Competencia al Eje de aprendizaje ")+ST_Qte ($t_enunciadoDimensionDestino)+"."
			
		: ((([MPA_DefinicionCompetencias:187]DesdeGrado:5#[MPA_DefinicionEjes:185]DesdeGrado:4) | ([MPA_DefinicionCompetencias:187]HastaGrado:13#[MPA_DefinicionEjes:185]HastaGrado:5)) & ([MPA_DefinicionEjes:185]Asignado_a_Etapa:19>0))
			  // si las etapas /  niveles de la competencia y la dimensión no son compatibles
			$t_mensajeError:=__ ("El eje de aprendizaje y la Competencia están asignadas a diferentes etapas.\r\rNo es posible asociar la Competencia al Eje de aprendizaje ")+ST_Qte ($t_enunciadoEjeDestino)+"."
			
	End case 
End if 



If ($t_mensajeError="")
	START TRANSACTION:C239
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$l_IdCompetencia)
	ARRAY LONGINT:C221($al_IDsEjes;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
	ARRAY LONGINT:C221($al_Zero;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
	AT_Populate (->$al_IDsEjes;->$l_IdEjeDestino)
	$l_TransaccionOK:=KRL_Array2Selection (->$al_IDsEjes;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->$al_Zero;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
	
	If ($l_TransaccionOK=1)
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$l_IdCompetencia)
		ARRAY LONGINT:C221($al_IDsEjes;Records in selection:C76([MPA_ObjetosMatriz:204]))
		AT_Populate (->$al_IDsEjes;->$l_IdEjeDestino)
		ARRAY LONGINT:C221($al_Zero;Records in selection:C76([MPA_ObjetosMatriz:204]))
		$l_TransaccionOK:=KRL_Array2Selection (->$al_IDsEjes;->[MPA_ObjetosMatriz:204]ID_Eje:3;->$al_Zero;->[MPA_ObjetosMatriz:204]ID_Dimension:4)
		KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1)
		CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
	End if 
	
	If ($l_TransaccionOK=1)
		UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
		SET_ClearSets ("$matricesModificadas")
		$t_TextoEventoLog:=__ ("Competencia \"^0\" asignada al Eje de aprendizaje \"^1\"")
		$t_TextoEventoLog:=Replace string:C233($t_TextoEventoLog;"^0";[MPA_DefinicionCompetencias:187]Competencia:6)
		$t_TextoEventoLog:=Replace string:C233($t_TextoEventoLog;"^1";$t_enunciadoEjeDestino)
		LOG_RegisterEvt ($t_TextoEventoLog)
		[MPA_DefinicionCompetencias:187]ID_Eje:2:=$l_IdEjeDestino
		[MPA_DefinicionCompetencias:187]ID_Dimension:23:=0
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		VALIDATE TRANSACTION:C240
		KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])
	Else 
		CANCEL TRANSACTION:C241
		$t_mensajeError:=__ ("No fue posible asignar esta Competencia al Eje de aprendizaje seleccionada.\r\rPor favor inténtelo nuevamente más tarde.")
	End if 
End if 

KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])

$0:=$t_mensajeError

