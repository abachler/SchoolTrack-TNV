//%attributes = {}
  //NTA_stats

C_LONGINT:C283($i)
C_REAL:C285($mean;$max;$min;$total;$sqTotal;$product;$counter;$mean;$variance;$coeffVar;$range;$value)
ARRAY REAL:C219(<>aStatR;8)
$pNota:=$1
$type:=Type:C295($pNota)
icount:=Size of array:C274($pNota->)
$min:=1000000
If (iCount=0)
	ARRAY REAL:C219(<>aStatR;0)
	ARRAY REAL:C219(<>aStatR;8)
Else 
	$counter:=0
	For ($i;1;iCount)
		Case of 
			: (iEvaluationMode=Simbolos)
				$value:=$pNota->{$i}
			: (($type=14) | ($type=16) | ($type=15))
				$value:=$pNota->{$i}
			Else 
				$value:=$pNota->{$i}
		End case 
		If ($value>=vrNTA_MinimoEscalaReferencia)
			$counter:=$counter+1
			If ($Min>$value)
				$Min:=$value
			End if 
		End if 
		$Total:=$Total+$value
		$SqTotal:=$SqTotal+($value^2)
		$Product:=$Product*$value
		
		If ($Max<$value)
			$Max:=$value
		End if 
	End for 
	If ($min=1000000)
		$min:=0
	End if 
	$Mean:=Round:C94($total/$counter;2)
	$StdDev:=((($Counter*$SqTotal)-($Total^2))^0.5)/$Counter
	$Variance:=$StdDev*$StdDev
	$Range:=Round:C94($Max-$Min;0)
	$CoeffVar:=$StdDev/$Mean*100
	
	
	<>aStatR{1}:=$mean
	<>aStatR{2}:=$stdDev
	<>aStatR{3}:=$variance
	<>aStatR{4}:=$min
	<>aStatR{5}:=$max
	<>aStatR{6}:=$range
	<>aStatR{7}:=$coeffVar
	<>aStatR{8}:=$counter
	
End if 