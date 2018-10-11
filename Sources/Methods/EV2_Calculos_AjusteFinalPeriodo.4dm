//%attributes = {}
  // EV2_Calculos_AjusteFinalPeriodo()
  //
  //
  // creado por: Alberto Bachler Klein: 21-11-16, 17:33:39
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($6)


C_LONGINT:C283($l_itemEncontrado)
C_POINTER:C301($y_FinalNoAproximado;$y_FinalLiteral;$y_FinalNota;$y_FinalPuntos;$y_FinalReal;$y_FinalSimbolo)
C_REAL:C285($r_Nota;$r_Puntos)
C_TEXT:C284($t_simbolo)


If (False:C215)
	C_POINTER:C301(EV2_Calculos_AjusteFinalPeriodo ;$1)
	C_POINTER:C301(EV2_Calculos_AjusteFinalPeriodo ;$2)
	C_POINTER:C301(EV2_Calculos_AjusteFinalPeriodo ;$3)
	C_POINTER:C301(EV2_Calculos_AjusteFinalPeriodo ;$4)
	C_POINTER:C301(EV2_Calculos_AjusteFinalPeriodo ;$6)
End if 

$y_FinalNoAproximado:=$1
$y_FinalReal:=$2
$y_FinalNota:=$3
$y_FinalPuntos:=$4
$y_FinalSimbolo:=$5
$y_FinalLiteral:=$6

Case of 
	: ($y_FinalNoAproximado->=-2)
		$y_FinalNota->:=-2
		$y_FinalPuntos->:=-2
		$y_FinalSimbolo->:="P"
		$y_FinalLiteral->:="P"
		$y_FinalReal->:=-2
		$y_FinalNoAproximado->:=-2
	: ($y_FinalNoAproximado->=-3)
		$y_FinalNota->:=-3
		$y_FinalPuntos->:=-3
		$y_FinalSimbolo->:="X"
		$y_FinalLiteral->:="X"
		$y_FinalReal->:=-3
		$y_FinalNoAproximado->:=-3
		
	: (iEvaluationMode=Notas)
		$r_Nota:=EV2_Real_a_Nota ($y_FinalNoAproximado->;vi_gTrPAvg;iGradesDecPP)
		$y_FinalReal->:=EV2_Nota_a_Real ($r_Nota;vi_gTrPAvg)
		If ((vi_BonificarPromedioPeriodo=1) & ($y_FinalReal->>=vrNTA_MinimoEscalaReferencia))
			$l_itemEncontrado:=Find in array:C230(arEVS_ConvGradesPercent;$y_FinalReal->)
			If ($l_itemEncontrado>0)
				$r_Nota:=$r_Nota+arEVS_ConvGradesOfficial{$l_itemEncontrado}
				$y_FinalReal->:=EV2_Nota_a_Real ($r_Nota;vi_gTrPAvg)
			End if 
		End if 
		$y_FinalSimbolo->:=EV2_Nota_a_Simbolo ($r_Nota)
		
		
	: (iEvaluationMode=Puntos)
		$r_Puntos:=EV2_Real_a_Puntos ($y_FinalNoAproximado->;vi_gTrPAvg;iPointsDecPP)
		$y_FinalReal->:=EV2_Puntos_a_Real ($r_Puntos;vi_gTrPAvg)
		If ((vi_BonificarPromedioPeriodo=1) & ($y_FinalReal->>=vrNTA_MinimoEscalaReferencia))
			$l_itemEncontrado:=Find in array:C230(arEVS_ConvPointsPercent;$y_FinalReal->)
			If ($l_itemEncontrado>0)
				$r_Puntos:=$r_Puntos+arEVS_ConvGradesOfficial{$l_itemEncontrado}
				$y_FinalReal->:=EV2_Puntos_a_Real ($r_Puntos;vi_gTrPAvg)
			End if 
		End if 
		$y_FinalSimbolo->:=EV2_Puntos_a_Simbolo ($r_Puntos)
		
	: (iEvaluationMode=Porcentaje)
		$y_FinalReal->:=Round:C94($y_FinalNoAproximado->;1)
		$y_FinalSimbolo->:=EV2_Real_a_Simbolo ($y_FinalNoAproximado->)  //ABC190473
		  //al recalcular estilos con ingreso en porcentaje se pierde el literal.
		
	: (iEvaluationMode=Simbolos)
		$y_FinalSimbolo->:=EV2_Real_a_Simbolo ($y_FinalNoAproximado->)
		If ((vi_ConvertSymbolicAverage=1) | ((iPrintMode=Simbolos) & (iPrintActa=Simbolos)))
			$y_FinalReal->:=EV2_Simbolo_a_Real ($y_FinalSimbolo->)
		Else 
			$y_FinalReal->:=$y_FinalNoAproximado->
		End if 
		
End case 

If ($y_FinalReal->>=vrNTA_MinimoEscalaReferencia)
	$y_FinalNota->:=EV2_Real_a_Nota ($y_FinalReal->;vi_gTrPAvg;iGradesDecPP)
	$y_FinalPuntos->:=EV2_Real_a_Puntos ($y_FinalReal->;vi_gTrPAvg;iPointsDecPP)
Else 
	$y_FinalNota->:=$y_FinalReal->
	$y_FinalPuntos->:=$y_FinalReal->
End if 

If (iPrintMode=Simbolos)
	$y_FinalLiteral->:=$y_FinalSimbolo->
Else 
	$y_FinalLiteral->:=EV2_Real_a_Literal ($y_FinalReal->;iPrintMode;vlNTA_DecimalesPP)
End if 

If ((vi_TruncarInferiorRequerido=1) & ($y_FinalNoAproximado-><rPctMinimum))
	Case of 
		: (iEvaluationMode=Notas)
			$r_nota:=EV2_Real_a_Nota ($y_FinalNoAproximado->;vi_TruncarInferiorRequerido;iGradesDecPP)
			$y_FinalNoAproximado->:=EV2_Nota_a_Real ($r_nota)
			
		: (iEvaluationMode=Puntos)
			$r_Puntos:=EV2_Real_a_Puntos ($y_FinalNoAproximado->;vi_TruncarInferiorRequerido;iPointsDecPP)
			$y_FinalNoAproximado->:=EV2_Puntos_a_Real ($r_Puntos)
			
		: (iEvaluationMode=Porcentaje)
			$y_FinalNoAproximado->:=Trunc:C95($y_FinalNoAproximado->;1)
			
	End case 
End if 


If (iGradesDecPP#iGradesDec)
	If (vi_gTrPAvg=1)
		$y_FinalNota->:=Trunc:C95($y_FinalNota->;iGradesDecPP)
	Else 
		$y_FinalNota->:=Round:C94($y_FinalNota->;iGradesDecPP)
	End if 
	
	If (iEvaluationMode=Notas)  //si el modo de evaluaci—n es NOTAS vuelvo a convertir para ajustar las equivalencias a otros modos
		$y_FinalReal->:=EV2_Nota_a_Real ($y_FinalNota->)
		$y_FinalPuntos->:=EV2_Real_a_Puntos ($y_FinalReal->;vi_gTrPAvg;iPointsDecPP)
		$y_FinalSimbolo->:=EV2_Nota_a_Simbolo ($y_FinalNota->)
		$y_FinalLiteral->:=EV2_Real_a_Literal ($y_FinalReal->;iPrintMode;vlNTA_DecimalesPP)
	End if 
End if 


If (iPointsDecPP#iPointsDec)
	If (vi_gTrPAvg=1)
		$y_FinalPuntos->:=Trunc:C95($y_FinalPuntos->;iPointsDecPP)
	Else 
		$y_FinalPuntos->:=Round:C94($y_FinalPuntos->;iPointsDecPP)
	End if 
	
	If (iEvaluationMode=Puntos)  //si el modo de evaluaci—n es Puntos vuelvo a convertir para ajustar las equivalencias a otros modos
		$y_FinalReal->:=EV2_Puntos_a_Real ($y_FinalPuntos->)
		$y_FinalNota->:=EV2_Real_a_Nota ($y_FinalReal->;vi_gTrPAvg;iGradesDecPP)
		$y_FinalSimbolo->:=EV2_Real_a_Simbolo ($y_FinalReal->)
		$y_FinalLiteral->:=EV2_Real_a_Literal ($y_FinalReal->;iPrintMode;vlNTA_DecimalesPP)
	End if 
End if 