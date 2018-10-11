//%attributes = {}
  // MPAcfg_MinimoAdquisicion()
  // Por: Alberto Bachler K.: 03-03-15, 16:30:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($el;$i)
C_POINTER:C301($y_minimo)

ARRAY REAL:C219($ar_Porcentajes;0)

$y_minimo:=OBJECT Get pointer:C1124(Object named:K67:5;"minimoAdquisicion_var")
Case of 
	: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1)  // evaluacion por indicadores
		OBJECT SET ENTERABLE:C238(*;"minimoAdquisicion_Var";False:C215)
		OBJECT SET VISIBLE:C603(*;"minimoAdquisicion_btn";True:C214)
		If ([MPA_DefinicionCompetencias:187]PctParaAprobacion:22>0)
			BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
			For ($i;1;Size of array:C274(aiEVLG_Indicadores_Valor))
				APPEND TO ARRAY:C911($ar_Porcentajes;Round:C94(aiEVLG_Indicadores_Valor{$i}/[MPA_DefinicionCompetencias:187]Maximo_Indicadores:9*100;6))
			End for 
			SORT ARRAY:C229($ar_Porcentajes;atEVLG_Indicadores_Descripcion;aiEVLG_Indicadores_Valor;atEVLG_Indicadores_Concepto;>)
			For ($i;1;Size of array:C274($ar_Porcentajes))
				If ($ar_Porcentajes{$i}>=[MPA_DefinicionCompetencias:187]PctParaAprobacion:22)
					$y_minimo->:=atEVLG_Indicadores_Concepto{$i}
					$i:=Size of array:C274(aiEVLG_Indicadores_Valor)
				End if 
			End for 
		End if 
		
	: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2)  // evaluación binaria
		  // asignación de las variables para la definición de símbolos y descripción en evaluación binaria
		vsEVLG_Simbolo_True:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;1;";")
		vsEVLG_Simbolo_False:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;2;";")
		vsEVLG_DescSimbolo_True:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")
		vsEVLG_DescSimbolo_False:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")
		OBJECT SET ENTERABLE:C238(*;"minimoAdquisicion_Var";False:C215)
		OBJECT SET VISIBLE:C603(*;"minimoAdquisicion_btn";True:C214)
		Case of 
			: ([MPA_DefinicionCompetencias:187]PctParaAprobacion:22=100)
				$y_minimo->:=vsEVLG_Simbolo_True
			: ([MPA_DefinicionCompetencias:187]PctParaAprobacion:22=1)
				$y_minimo->:=vsEVLG_Simbolo_False
			Else 
				$y_minimo->:=""
				[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=0
		End case 
		
		
	: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)  //estilos de evaluacion
		$el:=Find in array:C230(aEvStyleId;[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
		If ($el>0)
			aEvStyleName:=$el
		End if 
		EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
		OBJECT SET ENTERABLE:C238(*;"minimoAdquisicion_Var";iEvaluationMode#Simbolos)
		OBJECT SET VISIBLE:C603(*;"minimoAdquisicion_btn";iEvaluationMode=Simbolos)
		Case of 
			: (iEvaluationMode=Simbolos)
				$y_minimo->:=EV2_Real_a_Simbolo ([MPA_DefinicionCompetencias:187]PctParaAprobacion:22)
			: (iEvaluationMode=Notas)
				  //MONO TICKET 183148
				$y_minimo->:=EV2_Real_a_Literal ([MPA_DefinicionCompetencias:187]PctParaAprobacion:22;Notas)
				  //$y_minimo->:=String(EV2_Real_a_Nota ([MPA_DefinicionCompetencias]PctParaAprobacion))
			: (iEvaluationMode=Puntos)
				  //MONO TICKET 183148
				$y_minimo->:=EV2_Real_a_Literal ([MPA_DefinicionCompetencias:187]PctParaAprobacion:22;Puntos)
				  //$y_minimo->:=String(EV2_Real_a_Puntos ([MPA_DefinicionCompetencias]PctParaAprobacion))
			: (iEvaluationMode=Porcentaje)
				$y_minimo->:=String:C10(Round:C94([MPA_DefinicionCompetencias:187]PctParaAprobacion:22;1))
		End case 
		
End case 