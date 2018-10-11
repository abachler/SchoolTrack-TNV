//%attributes = {}
  //AL_PromedioPonderadoPorHoras


C_POINTER:C301($arrayHoras;$2;$arrayReales;$1)
C_REAL:C285($sum;$div)
$arrayReales:=$1
$arrayHoras:=$2


$totalHoras:=0
For ($i;1;Size of array:C274($arrayReales->))
	If (($arrayReales->{$i}>=vrNTA_MinimoEscalaReferencia) & ($arrayHoras->{$i}>0))
		$totalHoras:=$totalHoras+$arrayHoras->{$i}
		$sum:=$sum+Round:C94($arrayReales->{$i}*$arrayHoras->{$i};11)
	End if 
End for 

$0:=Round:C94($sum/$totalHoras;11)


