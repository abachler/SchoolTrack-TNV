//%attributes = {}
  //AL_PromedioPonderadoPorFactor

C_POINTER:C301($arrayHoras;$2;$arrayReales;$1)
C_REAL:C285($sum;$div)
$arrayReales:=$1
$arrayFactores:=$2


$sumaFactores:=0
For ($i;1;Size of array:C274($arrayReales->))
	If (($arrayReales->{$i}>=vrNTA_MinimoEscalaReferencia) & ($arrayFactores->{$i}>0))
		$sumaFactores:=$sumaFactores+$arrayFactores->{$i}
		$sum:=$sum+Round:C94($arrayReales->{$i}*$arrayFactores->{$i}/100;11)
	End if 
End for 

If ($sumaFactores#100)
	$0:=Round:C94(($sum/$sumaFactores)*100;11)
Else 
	$0:=Round:C94($sum;11)
End if 
