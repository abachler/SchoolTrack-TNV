//%attributes = {}
  //NIV_VerifyEnteredGrades

$stringValue:=$1
$field:=$2

Case of 
	: (iEValuationMode=Notas)
		$value:=Num:C11($stringValue->)
		Case of 
			: (($value<rGradesFrom) & ($value>0))
				$err:=CD_Dlog (0;__ ("La calificación no puede ser inferior a ")+String:C10(rGradesFrom))
				$stringValue->:=""
				$value:=0
				GOTO OBJECT:C206($stringValue->)
			: ($value>rGradesTo)
				$err:=CD_Dlog (0;__ ("La calificación no puede ser inferior a ")+String:C10(rGradesTo))
				$stringValue->:=""
				$value:=0
				GOTO OBJECT:C206($stringValue->)
			Else 
				$value:=EV2_Nota_a_Real ($value)
				$field->:=$value
				$stringValue->:=String:C10($field->)
		End case 
	: (iEValuationMode=Puntos)
		$value:=Num:C11($stringValue->)
		Case of 
			: (($value<rPointsFrom) & ($value>0))
				$err:=CD_Dlog (0;__ ("La calificación no puede ser inferior a ")+String:C10(rPointsFrom))
				$stringValue->:=""
				$value:=0
				GOTO OBJECT:C206($stringValue->)
			: ($value>rPointsTo)
				$err:=CD_Dlog (0;__ ("La calificación no puede ser inferior a ")+String:C10(rPointsTo))
				$stringValue->:=""
				$value:=0
				GOTO OBJECT:C206($stringValue->)
			Else 
				$value:=EV2_Puntos_a_Real ($value)
				$field->:=$value
				$stringValue->:=String:C10($field->)
		End case 
	: (iEValuationMode=Porcentaje)
		$value:=Num:C11($stringValue->)
		Case of 
			: (($value<1) & ($value>0))
				$err:=CD_Dlog (0;__ ("La calificación no puede ser inferior a 1."))
				$stringValue->:=""
				$value:=0
				GOTO OBJECT:C206($stringValue->)
			: ($value>100)
				$err:=CD_Dlog (0;__ ("La calificación no puede ser inferior a 100."))
				$stringValue->:=""
				$value:=0
				GOTO OBJECT:C206($stringValue->)
			Else 
				$field->:=Round:C94($value;6)
				$stringValue->:=String:C10($field->)
		End case 
	: (iEValuationMode=Simbolos)
		If (Find in array:C230(aSymbol;$stringValue->)=-1)
			$err:=CD_Dlog (0;__ ("El simbolo ingresado no está definido en en el estilo de evaluación.\rIngrese un símbolo existente o defínalo en el estilo de evaluación."))
			$stringValue->:=""
			GOTO OBJECT:C206($stringValue->)
		Else 
			$value:=NTA_SymbolValue2Percent ($stringValue->)
			$stringValue->:=EV2_Real_a_Simbolo ($value)
			$field->:=$value
		End if 
End case 

Case of 
	: (iEvaluationMode=Notas)
		vs_minimo0:=NTA_PercentValue2Grade ([xxSTR_Niveles:6]Minimo_0:25)
		vs_minimo1:=NTA_PercentValue2Grade ([xxSTR_Niveles:6]Minimo_1:26)
		vs_minimo2:=NTA_PercentValue2Grade ([xxSTR_Niveles:6]Minimo_2:27)
		vs_minimo3:=NTA_PercentValue2Grade ([xxSTR_Niveles:6]Minimo_3:31)
	: (iEvaluationMode=Puntos)
		vs_minimo0:=NTA_PercentValue2Points ([xxSTR_Niveles:6]Minimo_0:25)
		vs_minimo1:=NTA_PercentValue2Points ([xxSTR_Niveles:6]Minimo_1:26)
		vs_minimo2:=NTA_PercentValue2Points ([xxSTR_Niveles:6]Minimo_2:27)
		vs_minimo3:=NTA_PercentValue2Points ([xxSTR_Niveles:6]Minimo_3:31)
	: (iEvaluationMode=Porcentaje)
		vs_minimo0:=String:C10(Trunc:C95([xxSTR_Niveles:6]Minimo_0:25;1))
		vs_minimo1:=String:C10(Trunc:C95([xxSTR_Niveles:6]Minimo_1:26;1))
		vs_minimo2:=String:C10(Trunc:C95([xxSTR_Niveles:6]Minimo_2:27;1))
		vs_minimo3:=String:C10(Trunc:C95([xxSTR_Niveles:6]Minimo_3:31;1))
	: (iEvaluationMode=Simbolos)
		vs_minimo0:=EV2_Real_a_Simbolo ([xxSTR_Niveles:6]Minimo_0:25)
		vs_minimo1:=EV2_Real_a_Simbolo ([xxSTR_Niveles:6]Minimo_1:26)
		vs_minimo2:=EV2_Real_a_Simbolo ([xxSTR_Niveles:6]Minimo_2:27)
		vs_minimo3:=EV2_Real_a_Simbolo ([xxSTR_Niveles:6]Minimo_3:31)
End case 