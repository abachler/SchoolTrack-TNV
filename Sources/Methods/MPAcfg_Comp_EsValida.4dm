//%attributes = {}
  // MPAcfg_Competencia_EsValida()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 21/06/12, 10:33:17
  // ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_registroValido)
C_LONGINT:C283($l_elemento;$l_IdEstiloEvaluacionAnterior;$l_IdEstiloEvaluacionNuevo;$l_reNumCompetencia)
C_POINTER:C301($y_objectPointer)
C_TEXT:C284($t_estiloNuevo;$t_estiloOriginal;$t_eventoLog;$t_mensaje)

If (False:C215)
	C_BOOLEAN:C305(MPAcfg_Comp_EsValida ;$0)
End if 

  // CÓDIGO
$b_registroValido:=True:C214

If ($b_registroValido & ([MPA_DefinicionCompetencias:187]Competencia:6=""))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Una competencia debe tener un nombre o enunciado.")
	$y_objectPointer:=->[MPA_DefinicionCompetencias:187]Competencia:6
End if 

If ($b_registroValido & Not:C34(MPAcfg_Comp_EsUnica ))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Existe una competencia con el mismo nombre en el mismo contenedor (Area, Eje o Dimensión) que aplica en las mismas etapas o niveles académicos.\r\rPor favor elija otro nombre para la competencia.")
	$y_objectPointer:=->[MPA_DefinicionCompetencias:187]Competencia:6
	If (Is new record:C668([MPA_DefinicionCompetencias:187]))
		[MPA_DefinicionCompetencias:187]Competencia:6:=""
	End if 
End if 

If ($b_registroValido & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1) & ((Size of array:C274(aiEVLG_Indicadores_Valor)=0) | (Size of array:C274(atEVLG_Indicadores_Descripcion)=0) | (Size of array:C274(atEVLG_Indicadores_Concepto)=0))))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Los indicadores de logros no han sido correctamente definidos.\r\rDebe registrar el valor numérico, simbólico y la descripción para cada indicador.")
End if 

If ($b_registroValido & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1) & (Find in array:C230(atEVLG_Indicadores_Descripcion;"")>0)))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Hay una o más descripción de niveles de logro sin el texto de descripción.\r\rPor favor registre todas las descripciones de los niveles de logro")
End if 

If ($b_registroValido & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1) & (Find in array:C230(atEVLG_Indicadores_Concepto;"")>0)))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Hay uno o más indicadores de niveles de logro sin equivalencia simbólica especificada.\r\rPor favor defina todas las equivalencias de indicadores de niveles de logro.")
End if 

If ($b_registroValido & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2) & ((ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;1;";")="") | (ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;2;";")=""))))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Hay al menos un indicador binario no definido.\r\rPor favor defina ambos símbolos.")
End if 

If ($b_registroValido & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2) & ((ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")="") | (ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")=""))))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Hay al menos una descripción de indicador binario no definida.\r\rPor favor defina ambos descripciones.")
End if 

If ($b_registroValido & (([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7#Old:C35([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)) & ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7#0) & (Not:C34(Is new record:C668([MPA_DefinicionCompetencias:187])))))
	$l_IdEstiloEvaluacionAnterior:=Old:C35([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
	$l_IdEstiloEvaluacionNuevo:=[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7
	SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
	$l_reNumCompetencia:=Record number:C243([MPA_DefinicionCompetencias:187])
	OK:=MPA_CambiaEstiloEvaluacion (Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]ID:1;$l_IdEstiloEvaluacionAnterior;$l_IdEstiloEvaluacionNuevo)
	KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_reNumCompetencia;True:C214)
	If (OK=0)
		[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=$l_IdEstiloEvaluacionAnterior
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])
		$b_registroValido:=False:C215
		$t_mensaje:=__ ("No fue posible aplicar el cambio en el estilo de evaluación en las evaluaciones de aprendizajes registradas.\r\rPor favor inténtelo nuevamente.")
	Else 
		$t_estiloOriginal:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluacionAnterior;->[xxSTR_EstilosEvaluacion:44]Name:2)
		$t_estiloNuevo:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluacionNuevo;->[xxSTR_EstilosEvaluacion:44]Name:2)
		$t_eventoLog:=__ ("Estilo de evaluación \"^0\" reemplazado en la Competencia \"^1\" por el estilo de evaluación \"^2\".")
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_estiloOriginal)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";[MPA_DefinicionCompetencias:187]Competencia:6)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_estiloNuevo)
		LOG_RegisterEvt ($t_eventoLog)
	End if 
	
	$l_elemento:=Find in array:C230(aEvStyleId;[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
	If ($l_elemento>0)
		aEvStyleName:=$l_elemento
	End if 
End if 

If ((Not:C34($b_registroValido)) & ($t_mensaje#""))
	CD_Dlog (0;$t_mensaje)
	If (Not:C34(Is nil pointer:C315($y_objectPointer)))
		GOTO OBJECT:C206($y_objectPointer->)
		If ((Type:C295($y_objectPointer->)=Is text:K8:3) | (Type:C295($y_objectPointer->)=Is alpha field:K8:1))
			HIGHLIGHT TEXT:C210($y_objectPointer->;1;Length:C16($y_objectPointer->)+1)
		End if 
	End if 
End if 

$0:=$b_registroValido