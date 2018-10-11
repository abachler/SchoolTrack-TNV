//%attributes = {}
  // MPAcfg_Eje_EsValido <-Boolean
  // Determina si el noombre del eje actual es único en el mismo contenedor (dimension, eje, area)
  // y en las mismas etapas
  //
  // <-- ejeEsUnico
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 19/06/12, 22:11:35
  // ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_registroValido)
C_LONGINT:C283($l_elemento;$l_IdEstiloEvaluacionAnterior;$l_IdEstiloEvaluacionNuevo;$l_recNumEje)
C_POINTER:C301($y_objectPointer)
C_TEXT:C284($t_estiloNuevo;$t_estiloOriginal;$t_eventoLog;$t_mensaje)

If (False:C215)
	C_BOOLEAN:C305(MPA_Eje_EsValido;$0)
End if 

  // CÓDIGO
$b_registroValido:=True:C214

  // si falta el código o el nombre del eje
If ($b_registroValido & ([MPA_DefinicionEjes:185]Nombre:3=""))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Un Eje de aprendizaje debe tener un nombre o enunciado.")
	$y_objectPointer:=->[MPA_DefinicionEjes:185]Nombre:3
End if 

  // si existe un eje homónimo en la misma área
If ($b_registroValido & (Not:C34(MPAcfg_Eje_EsUnico )))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Ya existe un eje con el mismo nombre esta area.")
	$y_objectPointer:=->[MPA_DefinicionEjes:185]Nombre:3
	If (Is new record:C668([MPA_DefinicionEjes:185]))
		[MPA_DefinicionEjes:185]Nombre:3:=""
	End if 
End if 

  // si el modo de evaluación es 'Estilo de Evaluación'
If ($b_registroValido & ([MPA_DefinicionEjes:185]TipoEvaluación:12=1) & ([MPA_DefinicionEjes:185]EstiloEvaluación:13=0))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Por favor defina al menos la evaluación máxima de la escala.")
End if 

  // si el modo de evaluación es binario y no se han definido los indicadores para aprobación/reprobación
If ($b_registroValido & ([MPA_DefinicionEjes:185]TipoEvaluación:12=2) & (ST_CountWords ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;1;";")#2))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Por favor defina los indicadores simbólicos para Aprobado y Reprobado.")
End if 

  // si el modo de evaluación es 'Escala Independiente'
If ($b_registroValido & ([MPA_DefinicionEjes:185]TipoEvaluación:12=3) & ([MPA_DefinicionEjes:185]Escala_Maximo:18=0))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("Por favor defina al menos la evaluación máxima de la escala.")
End if 

If ($b_registroValido & ([MPA_DefinicionEjes:185]Escala_Minimo:17>[MPA_DefinicionEjes:185]Escala_Maximo:18))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("El mínimo de la escala no puede ser superior al máximo.")
	$y_objectPointer:=->[MPA_DefinicionEjes:185]Escala_Minimo:17
End if 

If ($b_registroValido & ([MPA_DefinicionEjes:185]Escala_Maximo:18<[MPA_DefinicionEjes:185]Escala_Minimo:17))
	$b_registroValido:=False:C215
	$t_mensaje:=__ ("El mínimo de la escala no puede ser superior al máximo.")
	$y_objectPointer:=->[MPA_DefinicionEjes:185]Escala_Maximo:18
End if 

If ($b_registroValido & ((Not:C34(Is new record:C668([MPA_DefinicionEjes:185]))) & (([MPA_DefinicionEjes:185]EstiloEvaluación:13#Old:C35([MPA_DefinicionEjes:185]EstiloEvaluación:13)) & ([MPA_DefinicionEjes:185]EstiloEvaluación:13#0))))
	OK:=1
	$l_IdEstiloEvaluacionAnterior:=Old:C35([MPA_DefinicionEjes:185]EstiloEvaluación:13)
	$l_IdEstiloEvaluacionNuevo:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
	SAVE RECORD:C53([MPA_DefinicionEjes:185])
	$l_recNumEje:=Record number:C243([MPA_DefinicionEjes:185])
	OK:=MPA_CambiaEstiloEvaluacion (Eje_Aprendizaje;[MPA_DefinicionEjes:185]ID:1;$l_IdEstiloEvaluacionAnterior;$l_IdEstiloEvaluacionNuevo)
	KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEje;True:C214)
	If (OK=0)
		[MPA_DefinicionEjes:185]EstiloEvaluación:13:=$l_IdEstiloEvaluacionAnterior
		SAVE RECORD:C53([MPA_DefinicionEjes:185])
		$b_registroValido:=False:C215
		$t_mensaje:=__ ("No fue posible aplicar el cambio en el estilo de evaluación en las evaluaciones de aprendizajes registradas.\r\rPor favor inténtelo nuevamente.")
	Else 
		$t_estiloOriginal:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluacionAnterior;->[xxSTR_EstilosEvaluacion:44]Name:2)
		$t_estiloNuevo:=KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluacionNuevo;->[xxSTR_EstilosEvaluacion:44]Name:2)
		$t_eventoLog:=__ ("Estilo de evaluación \"^0\" reemplazado en el Eje de Aprendizaje \"^1\" por el estilo de evaluación \"^2\".")
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_estiloOriginal)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";[MPA_DefinicionEjes:185]Nombre:3)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_estiloNuevo)
		LOG_RegisterEvt ($t_eventoLog)
	End if 
	
	$l_elemento:=Find in array:C230(aEvStyleId;[MPA_DefinicionEjes:185]EstiloEvaluación:13)
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