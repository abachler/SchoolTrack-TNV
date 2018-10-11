//%attributes = {}
  //ALrc_GeneralAverages

C_POINTER:C301($2;$3)
C_LONGINT:C283($ViewAs;$4;$convert2Style;$decimales;$truncate)
C_BOOLEAN:C305($inAverage)
$evStyleIDArray:=$3
$convert2Style:=$4
Case of 
	: (Count parameters:C259=7)
		$truncate:=$7
		$viewAs:=$5
		$decimales:=$6
	: (Count parameters:C259=6)
		$viewAs:=$5
		$decimales:=$6
	: (Count parameters:C259=5)
		$viewAs:=$5
End case 
EVS_ReadStyleData ($convert2Style)
$gradeEvaluationMode:=iEvaluationMode

If ($viewAs=0)
	$viewAs:=iPrintMode
End if 
If ($decimales=0)
	Case of 
		: (iEvaluationMode=Notas)
			$decimales:=iGradesDec
		: (iEvaluationMode=Puntos)
			$decimales:=iPointsDec
	End case 
End if 

$sum:=0
$div:=0


For ($i;1;Size of array:C274($1->))
	$inAverage:=$2->{$i}
	If (($convert2Style=$evStyleIDArray->{$i}) | ($convert2Style=0))
		$num:=$1->{$i}
	Else 
		vlEVS_CurrentEvStyleID:=0
		EVS_ReadStyleData ($evStyleIDArray->{$i})
		$gradeEvaluationMode:=iEvaluationMode
		Case of 
			: (iEvaluationMode=Notas)
				$rFromSource:=rGradesFrom
				$rToSource:=rGradesTo
				$rMinSource:=rGradesMinimum
			: (iEvaluationMode=Puntos)
				$rFromSource:=rPointsFrom
				$rToSource:=rPointsTo
				$rMinSource:=rPointsMinimum
			: (iEvaluationMode=Porcentaje)
				$rFromSource:=1
				$rToSource:=100
				$rMinSource:=rPctMinimum
			: (iEvaluationMode=Simbolos)
				$rFromSource:=1
				$rToSource:=100
				$rMinSource:=rPctMinimum
		End case 
		$string:=NTA_PercentValue2StringValue ($1->{$i};$gradeEvaluationMode;$evStyleIDArray->{$i})
		vlEVS_CurrentEvStyleID:=0
		EVS_ReadStyleData ($convert2Style)
		Case of 
			: ($viewAs=Notas)
				$rFromDestination:=rGradesFrom
				$rToDestination:=rGradesTo
				$rMinDestination:=rGradesMinimum
			: ($viewAs=Puntos)
				$rFromDestination:=rPointsFrom
				$rToDestination:=rPointsTo
				$rMinDestination:=rPointsMinimum
			: ($viewAs=Porcentaje)
				$rFromDestination:=0
				$rToDestination:=100
				$rMinDestination:=rPctMinimum
			: ($viewAs=Simbolos)
				$rFromDestination:=0
				$rToDestination:=100
				$rMinDestination:=rPctMinimum
		End case 
		If (($rFromSource=$rFromDestination) & ($rToSource=$rToDestination) & ($rMinSource=$rMinDestination))
			$num:=NTA_StringValue2Percent ($string;$convert2Style;$gradeEvaluationMode)
		Else 
			$num:=$1->{$i}
		End if 
	End if 
	If (($inAverage) & ($num>=vrNTA_MinimoEscalaReferencia))
		$pct:=Round:C94($Num;12)
		$sum:=$sum+$pct
		$div:=$div+1
	End if 
End for 

If ($sum>=vrNTA_MinimoEscalaReferencia)
	$r:=Round:C94($sum/$div;12)
	Case of 
		: ($viewAs=Notas)
			$0:=NTA_PercentValue2Grade ($r;$truncate;$decimales)
		: ($viewAs=Puntos)
			$0:=NTA_PercentValue2Points ($r;$truncate;$decimales)
		: ($viewAs=Porcentaje)
			If ($decimales=1)
				If ($truncate=1)
					$0:=String:C10(Trunc:C95($r;1);vs_percentFormat)
				Else 
					$0:=String:C10(Round:C94($r;1);vs_percentFormat)
				End if 
			Else 
				If ($truncate=1)
					$0:=String:C10(Trunc:C95($r;1);vs_percentFormat)
				Else 
					$0:=String:C10(Round:C94($r;$decimales))
				End if 
			End if 
		: ($viewAs=Simbolos)
			Case of 
				: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
					$grade:=NTA_PercentValue2Grade ($r;$truncate;$decimales)
					$r:=NTA_GradeValue2Percent ($grade)
					$0:=EV2_Real_a_Simbolo ($r)
				: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
					$grade:=NTA_PercentValue2Points ($r;$truncate;$decimales)
					$r:=NTA_PointValue2Percent ($grade)
					$0:=EV2_Real_a_Simbolo ($r)
				Else 
					$0:=EV2_Real_a_Simbolo (Round:C94($r;11))
			End case 
	End case 
Else 
	$0:=""
End if 
