//%attributes = {}
  // MPAcfg_MuestraCompetencias()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/07/12, 13:22:29
  // ---------------------------------------------
_O_C_INTEGER:C282($i_columnas;$i_filas)
C_LONGINT:C283($l_columna;$l_columnaCompetencias;$l_error;$l_estilo;$l_estiloActual;$l_fila;$l_filaAreas;$l_filaCompetencias;$l_filaDimensiones;$l_filaEjes)
C_LONGINT:C283($l_recNumArea;$l_recNumCompetencia;$l_recNumComptenciaSeleccionada;$l_recNumDimension;$l_recNumEje;$recNum)

ARRAY LONGINT:C221($al_dummy;0)

C_LONGINT:C283(vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension;vlMPA_recNumCompetencia)

  // CÓDIGO 

$l_recNumArea:=-1
$l_recNumEje:=-1
$l_recNumDimension:=-1
$l_recNumCompetencia:=-1

  // recibo en variables los parametros que permitirán eventualmente forzar la selección de enunciados
  // en el universo correspondiente a Area/Ejes/Dimensiones (normalmente debiera usarse solo al acrear nuevos enunciados)
  // un valor de -1 en los parametros conserva la selección actual de ennunciados correspondiente al enunciado de nivel superior
Case of 
	: (Count parameters:C259=4)
		$l_recNumArea:=$1
		$l_recNumEje:=$2
		$l_recNumDimension:=$3
		$l_recNumCompetencia:=$4
		
	: (Count parameters:C259=3)
		$l_recNumArea:=$1
		$l_recNumEje:=$2
		$l_recNumDimension:=$3
		
	: (Count parameters:C259=2)
		$l_recNumArea:=$1
		$l_recNumEje:=$2
		
	: (Count parameters:C259=1)
		$l_recNumArea:=$1
End case 


vt_Competencia:=""
vl_competenciasEvaluados:=0
vl_competenciasEnMatrices:=0
vt_Eje:=""
vl_ejeEvaluados:=0
vl_ejeEvaluados_asociados:=0
vl_ejeEnMatrices:=0
vl_ejeEnMatrices_asociados:=0
vt_Dimension:=""
vl_dimEvaluados:=0
vl_dimEvaluados_Asociados:=0
vl_dimEnMatrices:=0
vl_dimEnMatrices_Asociados:=0
OBJECT SET VISIBLE:C603(bselectEje;False:C215)
OBJECT SET VISIBLE:C603(bselectDim;False:C215)
OBJECT SET VISIBLE:C603(bCompetencia;False:C215)
OBJECT SET VISIBLE:C603(bInfoEvalEje;False:C215)
OBJECT SET VISIBLE:C603(bInfoMatrizEje;False:C215)
OBJECT SET VISIBLE:C603(bInfoEvalDim;False:C215)
OBJECT SET VISIBLE:C603(bInfoMatrizDim;False:C215)
OBJECT SET VISIBLE:C603(bInfoEvalComp;False:C215)
OBJECT SET VISIBLE:C603(bInfoMatrizComp;False:C215)
OBJECT SET TITLE:C194(bselectEje;"")
OBJECT SET TITLE:C194(bselectDim;"")
OBJECT SET TITLE:C194(bCompetencia;"")
OBJECT SET TITLE:C194(bInfoEvalEje;"")
OBJECT SET TITLE:C194(bInfoMatrizEje;"")
OBJECT SET TITLE:C194(bInfoEvalDim;"")
OBJECT SET TITLE:C194(bInfoMatrizDim;"")
OBJECT SET TITLE:C194(bInfoEvalComp;"")
OBJECT SET TITLE:C194(bInfoMatrizComp;"")





If (($l_recNumEje<0) & (Count parameters:C259>=2))
	vlMPA_recNumEje:=-1
	vlEVLG_IDEje:=0
	vlMPA_TipoEvaluacionEje:=0
	vlMPA_EstiloEvaluacionEje:=0
	vlMPA_recNumDimension:=-1
	vlEVLG_IDDimension:=0
	vlEVLG_IDCompetencia:=0
	vlMPA_TipoEvaluacionDimension:=0
	vlMPA_EstiloEvaluacionDimension:=0
	vlMPA_TipoEvaluacionComp:=0
	vlMPA_EstiloEvaluacionComp:=0
	$l_filaEjes:=0
	$l_filaDimensiones:=0
	$l_columnaCompetencias:=0
	$l_filaCompetencias:=0
	AL_SetLine (xALP_Ejes;0)
	AL_SetLine (xALP_Dimensiones;0)
	AL_SetCellSel (xALP_Competencias;0;0)
End if 

If (($l_recNumDimension<0) & (Count parameters:C259>=3))
	vlMPA_recNumEje:=-1
	vlEVLG_IDEje:=0
	vlMPA_TipoEvaluacionEje:=0
	vlMPA_EstiloEvaluacionEje:=0
	vlMPA_recNumDimension:=-1
	vlEVLG_IDDimension:=0
	vlEVLG_IDCompetencia:=0
	vlMPA_TipoEvaluacionDimension:=0
	vlMPA_EstiloEvaluacionDimension:=0
	vlMPA_TipoEvaluacionComp:=0
	vlMPA_EstiloEvaluacionComp:=0
	$l_filaEjes:=0
	$l_filaDimensiones:=0
	$l_columnaCompetencias:=0
	$l_filaCompetencias:=0
	AL_SetLine (xALP_Dimensiones;0)
	AL_SetCellSel (xALP_Competencias;0;0)
End if 

If (($l_recNumCompetencia<0) & (Count parameters:C259=4))
	vlMPA_recNumEje:=-1
	vlEVLG_IDEje:=0
	vlMPA_TipoEvaluacionEje:=0
	vlMPA_EstiloEvaluacionEje:=0
	vlMPA_recNumDimension:=-1
	vlEVLG_IDDimension:=0
	vlEVLG_IDCompetencia:=0
	vlMPA_recNumCompetencia:=-1
	vlMPA_TipoEvaluacionDimension:=0
	vlMPA_EstiloEvaluacionDimension:=0
	vlMPA_TipoEvaluacionComp:=0
	vlMPA_EstiloEvaluacionComp:=0
	$l_filaEjes:=0
	$l_filaDimensiones:=0
	$l_columnaCompetencias:=0
	$l_filaCompetencias:=0
	AL_SetCellSel (xALP_Competencias;0;0)
End if 

If ($l_recNumArea>=0)
	  // el metodo fue llamado con un record number válido para el Area de aprendizaje
	  // fuerzo la selección del área
	$l_filaAreas:=Find in array:C230(alEVLG_Marcos_RecNums;$l_recNumArea)
	AL_SetLine (xALP_AreasMPA;$l_filaAreas)
End if 

  // determino cuales son los enunciados actualmente seleccionados
$l_filaAreas:=AL_GetLine (xALP_AreasMPA)
$l_filaEjes:=AL_GetLine (xALP_Ejes)
$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
$l_error:=AL_GetCellSel (xALP_Competencias;$l_columnaCompetencias;$l_filaCompetencias)



If ($l_filaEjes=0)
	vlMPA_recNumEje:=-1
	vlMPA_recNumDimension:=-1
	vlEVLG_IDEje:=0
	vlEVLG_IDDimension:=0
End if 

If ($l_filaDimensiones=0)
	vlMPA_recNumDimension:=-1
	vlEVLG_IDDimension:=0
End if 

If ($l_recNumCompetencia>=0)
	vlMPA_recNumCompetencia:=$l_recNumCompetencia
End if 

  // siempre hay una hay una fila seleccionada en el area Areas de Aprendizaje
  // no es necesario hacer el test

If (Size of array:C274(alEVLG_Marcos_RecNums)=0)
	OBJECT SET VISIBLE:C603(*;"@_Competencias_@";False:C215)
Else 
	If ($l_filaAreas=0)
		OBJECT SET VISIBLE:C603(*;"@_Competencias_@";True:C214)
		  // si hay areas de aprendizajes definidas debe haberv una seleccionada
		alEVLG_Marcos_RecNums:=1
		$recNum:=alEVLG_Marcos_RecNums{1}
		AL_SetLine (xALP_AreasMPA;1)
	End if 
	
	Case of 
		: (vlMPA_recNumArea#alEVLG_Marcos_RecNums{$l_filaAreas})
			  // si la fila seleccionada corresponde a un Area de aprendizaje distinta de la que está actualmente en memoria
			  // cargo el registro correspondiente a la nueva selección e
			  // inicializo variables que se utilizan durante la configuración
			vlMPA_recNumArea:=alEVLG_Marcos_RecNums{$l_filaAreas}
			KRL_GotoRecord (->[MPA_DefinicionAreas:186];vlMPA_recNumArea;False:C215)
			vlEVLG_IDArea:=[MPA_DefinicionAreas:186]ID:1
			vlMPA_recNumEje:=-1
			vlMPA_recNumDimension:=-1
			vlMPA_recNumCompetencia:=-1
			vlEVLG_IDEje:=0
			vlEVLG_IDDimension:=0
			vlEVLG_IDCompetencia:=0
			vlMPA_EtapasAplicacion:=0
			vlMPA_NivelesAplicacion:=0
			vlMPA_TipoEvaluacionEje:=0
			vlMPA_EstiloEvaluacionEje:=0
			vlMPA_TipoEvaluacionDimension:=0
			vlMPA_EstiloEvaluacionDimension:=0
			vlMPA_TipoEvaluacionComp:=0
			vlMPA_EstiloEvaluacionComp:=0
			$l_filaEjes:=0
			$l_filaDimensiones:=0
			$l_columnaCompetencias:=0
			$l_filaCompetencias:=0
	End case 
	
	Case of 
		: (($l_filaEjes>0) & ($l_recNumEje=-1))
			  // si hay una fila seleccionada en el areaEjes y el parametro para forzar la selección fue omitido o tiene valor -1
			If (vlMPA_recNumEje#alEVLG_Ejes_RecNums{$l_filaEjes})
				  // si la fila seleccionada corresponde a un Eje distinto del actualmente en memoria
				  // cargo el registro correspondiente a la nueva selección e
				  // inicializo variables que se utilizan durante la configuración
				vlMPA_recNumEje:=alEVLG_Ejes_RecNums{$l_filaEjes}
				KRL_GotoRecord (->[MPA_DefinicionEjes:185];vlMPA_recNumEje;False:C215)
				vlEVLG_IDEje:=[MPA_DefinicionEjes:185]ID:1
				vlMPA_TipoEvaluacionEje:=[MPA_DefinicionEjes:185]TipoEvaluación:12
				vlMPA_EstiloEvaluacionEje:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
				vlMPA_recNumDimension:=-1
				vlMPA_recNumCompetencia:=-1
				vlEVLG_IDDimension:=0
				vlEVLG_IDCompetencia:=0
				vlMPA_TipoEvaluacionDimension:=0
				vlMPA_EstiloEvaluacionDimension:=0
				vlMPA_TipoEvaluacionComp:=0
				vlMPA_EstiloEvaluacionComp:=0
				$l_filaDimensiones:=0
				$l_columnaCompetencias:=0
				$l_filaCompetencias:=0
			End if 
		: ($l_recNumEje>=0)
			vlMPA_recNumEje:=$l_recNumEje
			KRL_GotoRecord (->[MPA_DefinicionEjes:185];vlMPA_recNumEje;False:C215)
			vlEVLG_IDEje:=[MPA_DefinicionEjes:185]ID:1
			vlMPA_TipoEvaluacionEje:=[MPA_DefinicionEjes:185]TipoEvaluación:12
			vlMPA_EstiloEvaluacionEje:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
			vlMPA_recNumDimension:=-1
			vlEVLG_IDDimension:=0
			vlEVLG_IDCompetencia:=0
			vlMPA_TipoEvaluacionDimension:=0
			vlMPA_EstiloEvaluacionDimension:=0
			vlMPA_TipoEvaluacionComp:=0
			vlMPA_EstiloEvaluacionComp:=0
			$l_filaDimensiones:=0
			$l_columnaCompetencias:=0
			$l_filaCompetencias:=0
	End case 
	
	Case of 
		: (($l_filaDimensiones>0) & ($l_recNumDimension=-1))
			If (vlMPA_recNumDimension#alEVLG_Dimensiones_RecNums{$l_filaDimensiones})
				vlMPA_recNumDimension:=alEVLG_Dimensiones_RecNums{$l_filaDimensiones}
				KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];vlMPA_recNumDimension;False:C215)
				vlEVLG_IDDimension:=[MPA_DefinicionDimensiones:188]ID:1
				vlEVLG_IDEje:=[MPA_DefinicionDimensiones:188]ID_Eje:3
				vlMPA_TipoEvaluacionDimension:=[MPA_DefinicionDimensiones:188]TipoEvaluacion:15
				vlMPA_EstiloEvaluacionDimension:=[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11
				vlMPA_TipoEvaluacionComp:=0
				vlMPA_EstiloEvaluacionComp:=0
				vlEVLG_IDCompetencia:=0
				$l_columnaCompetencias:=0
				$l_filaCompetencias:=0
			End if 
		: ($l_recNumDimension>=0)
			vlMPA_recNumDimension:=$l_recNumDimension
			KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];vlMPA_recNumDimension;False:C215)
			vlEVLG_IDDimension:=[MPA_DefinicionDimensiones:188]ID:1
			vlEVLG_IDEje:=[MPA_DefinicionDimensiones:188]ID_Eje:3
			vlMPA_TipoEvaluacionDimension:=[MPA_DefinicionDimensiones:188]TipoEvaluacion:15
			vlMPA_EstiloEvaluacionDimension:=[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11
			vlMPA_TipoEvaluacionComp:=0
			vlMPA_EstiloEvaluacionComp:=0
			vlEVLG_IDCompetencia:=0
			$l_columnaCompetencias:=0
			$l_filaCompetencias:=0
	End case 
	
	If ($l_filaAreas>0)  // no es posible que ningún área esté seleccionada
		MPAcfg_ListaEjes 
		If ($l_recNumEje>=0)
			  // si se recibió un record number valido de eje fuerzo la selección del eje
			$l_filaEjes:=Find in array:C230(alEVLG_Ejes_RecNums;$l_recNumEje)
			AL_SetLine (xALP_Ejes;$l_filaEjes)
		End if 
		
		If ($l_filaDimensiones=0)
			If ($l_filaEjes=0)
				MPAcfg_ListaDimensiones (0)
			Else 
				MPAcfg_ListaDimensiones (Eje_Aprendizaje)
			End if 
			If ($l_recNumDimension>=0)
				  // si se recibió un record number valido de dimensión fuerzo la selección de la dimension
				$l_filaDimensiones:=Find in array:C230(alEVLG_Dimensiones_RecNums;$l_recNumDimension)
				AL_SetLine (xALP_Dimensiones;$l_filaDimensiones)
			End if 
		End if 
		
		If ($l_recNumCompetencia>=0)
			  // si se recibió un record number de competencia lo asigno a la variable vlMPA_recNumCompetencia
			  // que será utilizada para seleccionar la celda correspondiente a la competencia, si existe en el universo area/eje/dimensión
			vlMPA_recNumCompetencia:=$l_recNumCompetencia
		End if 
		
		ALP_RemoveAllArrays (xALP_Competencias)
		Case of 
			: ($l_filaDimensiones>0)
				  // hay una dimensión seleccionada, se  listan las competencias de la dimensión
				KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];vlMPA_recNumDimension)
				MPAcfg_ListaCompetencias (Dimension_Aprendizaje)
				  // si hay una dimensión seleccionada el eje al que pertenece debe estar seleccionado y el registro en memoria
				vlMPA_recNumEje:=KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->vlEVLG_IDEje;False:C215)
				$l_filaEjes:=Find in array:C230(alEVLG_Ejes_RecNums;vlMPA_recNumEje)
				AL_SetLine (xALP_Ejes;$l_filaEjes)
				MPAcfg_InfoUsoEnunciado (Dimension_Aprendizaje;vlMPA_recNumDimension)
				vtEVLG_labelCompetencias:="Competencias en: "+atEVLG_Marcos_Nombres{$l_filaAreas}+" > "+atEVLG_Ejes_Nombres{$l_filaEjes}+" > "+atEVLG_Dimensiones_Nombres{$l_filaDimensiones}
				
				
			: ($l_filaEjes>0)
				MPAcfg_ListaDimensiones (Eje_Aprendizaje)
				MPAcfg_ListaCompetencias (Eje_Aprendizaje)
				AL_SetLine (xALP_Dimensiones;$l_filaDimensiones)
				MPAcfg_InfoUsoEnunciado (Eje_Aprendizaje;vlMPA_recNumEje)
				vtEVLG_labelCompetencias:="Competencias en: "+atEVLG_Marcos_Nombres{$l_filaAreas}+" > "+atEVLG_Ejes_Nombres{$l_filaEjes}
				
				
			: ($l_filaAreas>0)
				MPAcfg_ListaCompetencias (0)
				vtEVLG_labelCompetencias:="Competencias en: "+atEVLG_Marcos_Nombres{$l_filaAreas}
				
			Else 
				ALP_RemoveAllArrays (xALP_Competencias)
				AT_Initialize (->atEVLG_Competencias_E1;->atEVLG_Competencias_E2;->atEVLG_Competencias_E3;->atEVLG_Competencias_E4;->atEVLG_Competencias_E5;->atEVLG_Competencias_E6;->atEVLG_Competencias_E7;->atEVLG_Competencias_E8;->atEVLG_Competencias_E9;->atEVLG_Competencias_E10;->atEVLG_Competencias_E11;->atEVLG_Competencias_E12;->atEVLG_Competencias_E13;->atEVLG_Competencias_E14;->atEVLG_Competencias_E15;->atEVLG_Competencias_E16;->atEVLG_Competencias_E17;->atEVLG_Competencias_E18;->atEVLG_Competencias_E19;->atEVLG_Competencias_E20;->atEVLG_Competencias_E21;->atEVLG_Competencias_E22;->atEVLG_Competencias_E23;->atEVLG_Competencias_E24)
		End case 
		MPAcfg_ConfigAreaCompetencias 
		OBJECT SET VISIBLE:C603(xALP_Competencias;True:C214)
		
		AL_SetLine (xALP_AreasMPA;$l_filaAreas)
		AL_SetLine (xALP_Ejes;$l_filaEjes)
		AL_SetLine (xALP_Dimensiones;$l_filaDimensiones)
		
		If (Size of array:C274(atEVLG_Marcos_Nombres)>0)
			OBJECT SET TITLE:C194(bArea;atEVLG_Marcos_Nombres{$l_filaAreas})
			OBJECT SET VISIBLE:C603(bArea;True:C214)
		Else 
			OBJECT SET VISIBLE:C603(bArea;False:C215)
		End if 
		vt_area:=atEVLG_Marcos_Nombres{$l_filaAreas}
		
		$l_recNumComptenciaSeleccionada:=-1
		If (vlMPA_recNumCompetencia>=0)
			For ($i_filas;1;Size of array:C274(alEVLG_Competencias_RecNums))
				For ($i_columnas;1;Size of array:C274(alEVLG_Competencias_RecNums{1}))
					If (alEVLG_Competencias_RecNums{$i_filas}{$i_columnas}=vlMPA_recNumCompetencia)
						AL_SetCellSel (xALP_Competencias;$i_columnas;$i_filas;$i_columnas;$i_filas)
						AL_SetScroll (xALP_Competencias;-2;-2)
						AL_SetScroll (xALP_Competencias;$i_filas;$i_columnas-1)
						$l_recNumComptenciaSeleccionada:=alEVLG_Competencias_RecNums{$i_filas}{$i_columnas}
						$i_filas:=Size of array:C274(alEVLG_Competencias_RecNums)
						$i_columnas:=Size of array:C274(alEVLG_Competencias_RecNums{1})
					End if 
				End for 
			End for 
			
			$err:=AL_GetCellSel (xALP_Competencias;$l_columna;$l_fila)
			If (($l_columna>0) & ($l_fila>0))
				$l_recNum:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
				$y_arregloEtapa:=Get pointer:C304("atEVLG_Competencias_E"+String:C10($l_columna))
				vt_Competencia:=$y_arregloEtapa->{$l_fila}
				OBJECT SET TITLE:C194(bCompetencia;vt_Competencia)
				For ($i_columnas;1;Size of array:C274(alEVLG_Competencias_RecNums{$l_fila}))
					For ($i_filas;1;Size of array:C274(alEVLG_Competencias_RecNums))
						If (alEVLG_Competencias_RecNums{$i_filas}{$i_columnas}=$l_recNum)
							AL_SetCellBorder (xALP_Competencias;$i_columnas;$i_filas;1;1;1;1;0;2;187;187;187)
						Else 
							AL_SetCellBorder (xALP_Competencias;$i_columnas;$i_filas;0;0;0;0;0;0;0;0;0)
						End if 
					End for 
				End for 
			End if 
			
			
			vlMPA_recNumCompetencia:=$l_recNumComptenciaSeleccionada
			MPAcfg_InfoUsoEnunciado (Logro_Aprendizaje;vlMPA_recNumCompetencia)
		Else 
			
		End if 
	End if 
End if 

IT_SetButtonState ($l_filaAreas>0;->bDeleteArea;->bAddCompetencia;->bAddEje;->bAddCompetencia)
IT_SetButtonState ($l_filaEjes>0;->bDeleteEje;->bAddDimension)
IT_SetButtonState ($l_filaDimensiones>0;->bDeleteDimension)
IT_SetButtonState (vlMPA_recNumCompetencia>=0;->bDeleteCompetencia)

