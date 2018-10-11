//%attributes = {}
  // MPAcfg_Dim_EsValida()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 24/06/12, 17:39:30
  // ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_registroValido)
C_LONGINT:C283($l_elemento;$l_IdEstiloEvaluacionAnterior;$l_IdEstiloEvaluacionNuevo;$l_recNumDimension)
C_POINTER:C301($y_objectPointer)
C_TEXT:C284($t_estiloNuevo;$t_estiloOriginal;$t_eventoLog;$t_mensaje)

If (False:C215)
	C_BOOLEAN:C305(MPAcfg_Dim_EsValida ;$0)
End if 

  // CÓDIGO
$b_registroValido:=True:C214

  // si falta el código o el nombre de LA DIMENSION
If ($b_registroValido & ([MPA_DefinicionDimensiones:188]Dimensión:4=""))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Un Dimension de aprendizaje debe tener un nombre o enunciado.\r\rPor favor defina el nombre de la dimensión")
	$y_objectPointer:=->[MPA_DefinicionDimensiones:188]Dimensión:4
End if 

  // si existe una dimension homónima en la misma área y etapa/niveles
If ($b_registroValido & (Not:C34(MPAcfg_Dim_EsUnica )))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Ya existe una dimensión con el mismo nombre en esta area y etapas/niveles.")
	$y_objectPointer:=->[MPA_DefinicionDimensiones:188]Dimensión:4
	If (Is new record:C668([MPA_DefinicionDimensiones:188]))
		[MPA_DefinicionDimensiones:188]Dimensión:4:=""
	End if 
End if 

  // si el modo de evaluación es 'Estilo de Evaluacióm'
If ($b_registroValido & ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=1) & ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=0))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Por favor defina al menos la evaluación máxima de la escala.")
End if 

  // si el modo de evaluación es binario y no se han definido los indicadores para aprobación/reprobación
If ($b_registroValido & ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=2) & (ST_CountWords ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;1;";")#2))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Por favor defina los indicadores simbólicos para Aprobado y Reprobado.")
End if 

  // si el modo de evaluación es 'Escala Independiente'
If ($b_registroValido & ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=3) & ([MPA_DefinicionDimensiones:188]Escala_Maximo:13=0))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Por favor defina al menos la evaluación máxima de la escala.")
End if 

If ($b_registroValido & ([MPA_DefinicionDimensiones:188]Escala_Minimo:12>[MPA_DefinicionDimensiones:188]Escala_Maximo:13))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("El mínimo de la escala no puede ser superior al máximo.")
	$y_objectPointer:=->[MPA_DefinicionDimensiones:188]Escala_Minimo:12
End if 

If ($b_registroValido & ([MPA_DefinicionDimensiones:188]Escala_Maximo:13<[MPA_DefinicionDimensiones:188]Escala_Minimo:12))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("El mínimo de la escala no puede ser superior al máximo.")
	$y_objectPointer:=->[MPA_DefinicionDimensiones:188]Escala_Maximo:13
End if 

If ($b_registroValido & ((Not:C34(Is new record:C668([MPA_DefinicionDimensiones:188]))) & (([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11#Old:C35([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)) & ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11#0))))
	OK:=1
	$l_IdEstiloEvaluacionAnterior:=Old:C35([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
	$l_IdEstiloEvaluacionNuevo:=[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11
	SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
	$l_recNumDimension:=Record number:C243([MPA_DefinicionDimensiones:188])
	OK:=MPA_CambiaEstiloEvaluacion (Dimension_Aprendizaje;[MPA_DefinicionDimensiones:188]ID:1;$l_IdEstiloEvaluacionAnterior;$l_IdEstiloEvaluacionNuevo)
	KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)
	If (OK=0)
		[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=$l_IdEstiloEvaluacionAnterior
		SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
		$b_registroValido:=False:C215
		$t_mensaje:=__ ("No fue posible aplicar el cambio en el estilo de evaluación en las evaluaciones de aprendizajes registradas.\r\rPor favor inténtelo nuevamente.")
	Else 
		$t_estiloOriginal:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluacionAnterior;->[xxSTR_EstilosEvaluacion:44]Name:2)
		$t_estiloNuevo:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluacionNuevo;->[xxSTR_EstilosEvaluacion:44]Name:2)
		$t_eventoLog:=__ ("Estilo de evaluación \"^0\" reemplazado en la Dimensión de Aprendizaje \"^1\" por el estilo de evaluación \"^2\".")
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_estiloOriginal)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";[MPA_DefinicionDimensiones:188]Dimensión:4)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_estiloNuevo)
		LOG_RegisterEvt ($t_eventoLog)
	End if 
	
	$l_elemento:=Find in array:C230(aEvStyleId;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
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