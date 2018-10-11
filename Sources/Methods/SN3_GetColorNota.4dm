//%attributes = {}
  //SN3_GetColorNota

  //B=Blanco
  //R=Rojo
  //A=Azul
  //V=Verde
  //N=Negro


$estilo:=$1
$real:=$2

If ($estilo=0)
	$0:="B"
Else 
	EVS_ReadStyleData ($estilo)
	Case of 
		: (iEvaluationMode=Simbolos)
			If ($real<rpctMinimum)
				$0:="R"
			Else 
				$0:="A"
			End if 
		: ($real=-1)
			$0:="M"
		: ($real=-2)
			$0:="V"
		: ($real=-4)
			$0:="N"
		: (($real>=vrNTA_MinimoEscalaReferencia) & ($real<rpctMinimum))
			$0:="R"
		Else 
			$0:="A"
	End case 
End if 