//%attributes = {}
  //SRal_NotasSubAsignaturas

C_LONGINT:C283($2;$line;$idAlumno;$3)
C_TEXT:C284($ref;$1)

$ref:=$1
$line:=$2
$idAlumno:=$3
READ WRITE:C146([xxSTR_Subasignaturas:83])
QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$ref)

If (Records in selection:C76([xxSTR_Subasignaturas:83])=1)
	ASsev_InitArrays 
	  //MONO TICKET 187315 
	  //BLOB_ExpandBlob_byPointer (->[xxSTR_Subasignaturas]Data)
	  //$offset:=0
	  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalID;"aSubEvalID")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStdNme;"aSubEvalStdNme")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalCurso;"aSubEvalCurso")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStatus;"aSubEvalStatus")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalOrden;"aSubEvalOrden")
	
	For ($j;1;Size of array:C274(aRealSubEvalArrPtr))
		  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
	End for 
	  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
	  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
	  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentacion)
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalP1;"aRealSubEvalP1")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalControles;"aRealSubEvalControles")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
	
	
	$punteroPromedio:=Get pointer:C304("vsPromedioSubEval_"+String:C10([xxSTR_Subasignaturas:83]Columna:13))
	If (vrNTA_MinimoEscalaReferencia=0)
		$promedio:=AT_Mean (->aRealSubEvalP1;3)
	Else 
		$promedio:=AT_Mean (->aRealSubEvalP1;1)
	End if 
	$punteroPromedio->:=NTA_PercentValue2StringValue ($promedio;iPrintMode)
	
	
	$el:=Find in array:C230(aSubEvalID;$idAlumno)
	If ($el>0)
		For ($i;1;12)
			$pct:=aRealSubEvalArrPtr{$i}->{$el}
			aSRpSub_EvalPointers{$i}->{$line}:=NTA_PercentValue2StringValue ($pct;iPrintMode)
			aSRpSub_NotasPointers{$i}->{$line}:=NTA_PercentValue2StringValue ($pct;Notas)
			aSRpSub_PuntosPointers{$i}->{$line}:=NTA_PercentValue2StringValue ($pct;Puntos)
			aSRpSub_PorcentajesPointers{$i}->{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
			aSRpSub_IndicadoresPointers{$i}->{$line}:=_Evaluacion_a_Indicador ($pct)
			aSRpSub_SimbolosPointers{$i}->{$line}:=NTA_PercentValue2StringValue ($pct;Simbolos)
			Case of 
				: ($pct=-2)
					aSRpSub_EvalColorPointers{$i}->{$line}:="Green"
				: ($pct<rPctMinimum)
					aSRpSub_EvalColorPointers{$i}->{$line}:="Red"
				: ($pct>=rPctMinimum)
					aSRpSub_EvalColorPointers{$i}->{$line}:="Blue"
				Else 
					aSRpSub_EvalColorPointers{$i}->{$line}:="Black"
			End case 
		End for 
		$pct:=aRealSubEvalControles{$el}
		atSRal_SubEvalEXP_Eval{$line}:=NTA_PercentValue2StringValue ($pct;iPrintMode)
		atSRal_SubEvalEXP_Nota{$line}:=NTA_PercentValue2StringValue ($pct;Notas)
		atSRal_SubEvalEXP_Puntos{$line}:=NTA_PercentValue2StringValue ($pct;Puntos)
		atSRal_SubEvalEXP_Simbolos{$line}:=NTA_PercentValue2StringValue ($pct;Simbolos)
		atSRal_SubEvalEXP_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
		atSRal_SubEvalEXP_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
		Case of 
			: ($pct=-2)
				atSRal_SubEvalEXP_Color{$line}:="Green"
			: ($pct<rPctMinimum)
				atSRal_SubEvalEXP_Color{$line}:="Red"
			: ($pct>=rPctMinimum)
				atSRal_SubEvalEXP_Color{$line}:="Blue"
			Else 
				atSRal_SubEvalEXP_Color{$line}:="Black"
		End case 
		
		$pct:=aRealSubEvalPresentacion{$el}
		atSRal_SubEvalPRES_Eval{$line}:=NTA_PercentValue2StringValue ($pct;iPrintMode)
		atSRal_SubEvalPRES_Nota{$line}:=NTA_PercentValue2StringValue ($pct;Notas)
		atSRal_SubEvalPRES_Puntos{$line}:=NTA_PercentValue2StringValue ($pct;Puntos)
		atSRal_SubEvalPRES_Simbolos{$line}:=NTA_PercentValue2StringValue ($pct;Simbolos)
		atSRal_SubEvalPRES_Indicadores{$line}:=_Evaluacion_a_Indicador ($pct)
		atSRal_SubEvalPRES_Porcentajes{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
		Case of 
			: ($pct=-2)
				atSRal_SubEvalPRES_Color{$line}:="Green"
			: ($pct<rPctMinimum)
				atSRal_SubEvalPRES_Color{$line}:="Red"
			: ($pct>=rPctMinimum)
				atSRal_SubEvalPRES_Color{$line}:="Blue"
			Else 
				atSRal_SubEvalPRES_Color{$line}:="Black"
		End case 
		
		$pct:=aRealSubEvalP1{$el}
		atSRal_SubEvalPeriodo_Eval{$line}:=NTA_PercentValue2StringValue ($pct;iPrintMode)
		atSRal_SubEvalPeriodo_Nota{$line}:=NTA_PercentValue2StringValue ($pct;Notas)
		atSRal_SubEvalPeriodo_Puntos{$line}:=NTA_PercentValue2StringValue ($pct;Puntos)
		atSRal_SubEvalPeriodo_Simbolos{$line}:=NTA_PercentValue2StringValue ($pct;Simbolos)
		atSRal_SubEvalPeriodo_Indicador{$line}:=_Evaluacion_a_Indicador ($pct)
		atSRal_SubEvalPeriodo_Porcentaj{$line}:=NTA_PercentValue2StringValue ($pct;Porcentaje)
		Case of 
			: ($pct=-2)
				atSRal_SubEvalPeriodo_Color{$line}:="Green"
			: ($pct<rPctMinimum)
				atSRal_SubEvalPeriodo_Color{$line}:="Red"
			: ($pct>=rPctMinimum)
				atSRal_SubEvalPeriodo_Color{$line}:="Blue"
			Else 
				atSRal_SubEvalPeriodo_Color{$line}:="Black"
		End case 
	End if 
End if 
