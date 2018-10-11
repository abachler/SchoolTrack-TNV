//%attributes = {}
  //fStatistiques3

C_LONGINT:C283($i)
C_POINTER:C301($pNota)
C_REAL:C285($mean;$max;$min;$counter;$mean;$stddev;$variance;$range;$value)
ARRAY REAL:C219(<>aStatR;7)
$pNota:=$1
$type:=Type:C295($pNota)
icount:=Size of array:C274($pNota->)
  //$min:=1000000
ARRAY REAL:C219(ar_RealValues;0)
ARRAY REAL:C219(ar_RealValues;Size of array:C274($pNota->))
$minEnEscala:=NTA_PercentValue2StringValue (vrNTA_MinimoEscalaReferencia;iEvaluationMode)
If (iEvaluationMode=4)
	$minValue:=EV2_Simbolo_a_Real ($minEnEscala)
Else 
	$minValue:=Num:C11($minEnEscala)
End if 
If (iCount=0)
	ARRAY REAL:C219(<>aStatR;0)
	ARRAY REAL:C219(<>aStatR;8)
Else 
	$counter:=0
	For ($i;1;iCount)
		$stringValue:=NTA_PercentValue2StringValue ($pNota->{$i};iEvaluationMode)
		If (iEvaluationMode=4)
			$value:=EV2_Simbolo_a_Real ($stringValue)
		Else 
			$value:=Num:C11($stringValue)
		End if 
		If ($value>=$minValue)
			ar_RealValues{$i}:=$value
		End if 
	End for 
	
	For ($i;Size of array:C274(ar_RealValues);1;-1)
		If (ar_RealValues{$i}<$minValue)
			DELETE FROM ARRAY:C228(ar_RealValues;$i)
		End if 
	End for 
	$counter:=Size of array:C274(ar_RealValues)
	If ($counter>0)
		$mean:=AT_Mean (->ar_RealValues)  //media
		If ($counter>1)
			$stdDev:=AT_StandardDeviation (->ar_RealValues)  //desviación estandard
			$variance:=$stdDev*$stdDev  // varianza    
		End if 
		$min:=AT_Minimum (->ar_RealValues)  //minimo
		$max:=AT_Maximum (->ar_RealValues)  //máximo
		$range:=$max-$min  //rango  
	End if 
	<>aStatR{1}:=$mean
	<>aStatR{2}:=$stdDev
	<>aStatR{3}:=$variance
	<>aStatR{4}:=$min
	<>aStatR{5}:=$max
	<>aStatR{6}:=$range
	<>aStatR{7}:=$counter
End if 
