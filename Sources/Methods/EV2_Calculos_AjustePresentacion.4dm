//%attributes = {}
  // EV2_Calculos_AjustePresentacion()
  //
  //
  // creado por: Alberto Bachler Klein: 21-11-16, 18:09:13
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)

C_POINTER:C301($y_FinalNoAproximado;$y_Presentacion_Literal;$y_Presentacion_Nota;$y_Presentacion_Puntos;$y_Presentacion_Real;$y_Presentacion_Simbolo)
C_REAL:C285($r_nota;$r_Puntos)


If (False:C215)
	C_POINTER:C301(EV2_Calculos_AjustePresentacion ;$1)
	C_POINTER:C301(EV2_Calculos_AjustePresentacion ;$2)
	C_POINTER:C301(EV2_Calculos_AjustePresentacion ;$3)
	C_POINTER:C301(EV2_Calculos_AjustePresentacion ;$4)
	C_POINTER:C301(EV2_Calculos_AjustePresentacion ;$5)
	C_POINTER:C301(EV2_Calculos_AjustePresentacion ;$6)
End if 

$y_Presentacion_Real:=$1
$y_Presentacion_Nota:=$2
$y_Presentacion_Puntos:=$3
$y_Presentacion_Simbolo:=$4
$y_Presentacion_Literal:=$5
$y_FinalNoAproximado:=$6

If ((vi_TruncarInferiorRequerido=1) & ($y_Presentacion_Real-><rPctMinimum))
	Case of 
		: (iEvaluationMode=Notas)
			$r_nota:=EV2_Real_a_Nota ($y_Presentacion_Real->;vi_TruncarInferiorRequerido;iGradesDecPP)
			$y_Presentacion_Real->:=EV2_Nota_a_Real ($r_nota)
			
		: (iEvaluationMode=Puntos)
			$r_Puntos:=EV2_Real_a_Puntos ($y_Presentacion_Real->;vi_TruncarInferiorRequerido;iPointsDecPP)
			$y_Presentacion_Real->:=EV2_Puntos_a_Real ($r_Puntos)
			
		: (iEvaluationMode=Porcentaje)
			$y_Presentacion_Real->:=Trunc:C95($y_Presentacion_Real->;1)
			
	End case 
End if 

If ($y_Presentacion_Real->>=vrNTA_MinimoEscalaReferencia)
	$y_Presentacion_Nota->:=EV2_Real_a_Nota ($y_Presentacion_Real->;vi_gTrPAvg;iGradesDecPP)
	$y_Presentacion_Puntos->:=EV2_Real_a_Puntos ($y_Presentacion_Real->;vi_gTrPAvg;iPointsDecPP)
	$y_Presentacion_Simbolo->:=EV2_Real_a_Simbolo ($y_Presentacion_Real->)
	$y_Presentacion_Literal->:=EV2_Real_a_Literal ($y_Presentacion_Real->;iPrintMode;vlNTA_DecimalesPP)
Else 
	$y_Presentacion_Nota->:=$y_Presentacion_Real->
	$y_Presentacion_Puntos->:=$y_Presentacion_Real->
	$y_Presentacion_Simbolo->:=""
	$y_Presentacion_Literal->:=EV2_Real_a_Literal ($y_Presentacion_Real->;iPrintMode;vlNTA_DecimalesPP)
End if 
$y_FinalNoAproximado->:=$y_Presentacion_Real->