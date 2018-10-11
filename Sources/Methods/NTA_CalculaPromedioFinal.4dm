//%attributes = {}
  //NTA_CalculaPromedioFinal

C_LONGINT:C283($1;$row)
C_REAL:C285($sum;$div;$totalPonderaciones;$ponderacionesAcumuladas;$sumPonderados;$nValue)
C_POINTER:C301($pointerPonderacion)

$row:=$1
$div:=0
$sum:=0
$evaluaciones:=0

Case of 
	: (viSTR_Periodos_NumeroPeriodos=4)
		$totalPonderaciones:=vrEVS_PonderacionB1+vrEVS_PonderacionB2+vrEVS_PonderacionB3+vrEVS_PonderacionB4
		
	: (viSTR_Periodos_NumeroPeriodos=3)
		$totalPonderaciones:=vrEVS_PonderacionT1+vrEVS_PonderacionT2+vrEVS_PonderacionT3
		
	: (viSTR_Periodos_NumeroPeriodos=2)
		$totalPonderaciones:=vrEVS_PonderacionS1+vrEVS_PonderacionS2
End case 
If ($totalPonderaciones=100)
	$periodosPonderados:=True:C214
Else 
	$periodosPonderados:=False:C215
End if 

Case of 
	: ($periodosPonderados=True:C214)
		$ponderacionesAcumuladas:=0
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			Case of 
				: (viSTR_Periodos_NumeroPeriodos=2)
					$pointerPonderacion:=Get pointer:C304("vrEVS_PonderacionS"+String:C10($i))
				: (viSTR_Periodos_NumeroPeriodos=3)
					$pointerPonderacion:=Get pointer:C304("vrEVS_PonderacionT"+String:C10($i))
				: (viSTR_Periodos_NumeroPeriodos=4)
					$pointerPonderacion:=Get pointer:C304("vrEVS_PonderacionB"+String:C10($i))
			End case 
			$array:=Get pointer:C304("aRealNtaP"+String:C10($i))
			$nValue:=$array->{$row}
			If (($nValue>=vrNTA_MinimoEscalaReferencia) | ($nValue=-3))
				
			Else   //si hay algun pendiente no calculo nada más
				$sum:=$nValue
				$i:=Size of array:C274(atSTR_Periodos_Nombre)+1
			End if 
			If ($nValue>=vrNTA_MinimoEscalaReferencia)
				$ponderacionesAcumuladas:=$ponderacionesAcumuladas+$pointerPonderacion->
				$sumPonderados:=$sumPonderados+Round:C94($nValue*($pointerPonderacion->/100);11)
				$evaluaciones:=$evaluaciones+1
			End if 
		End for 
		If ($evaluaciones>0)
			If ($ponderacionesAcumuladas<=100)
				If ($sumPonderados>0)
					$sumPonderados:=Round:C94(Round:C94($sumPonderados/$ponderacionesAcumuladas;11)*100;11)
					aRealNtaPF{$row}:=$sumPonderados
				Else 
					aRealNtaPF{$row}:=0
				End if 
			End if 
		Else 
			If (($sum=-1) | ($sum=-2) | ($sum=-3))
				aRealNtaPF{$row}:=$sum
			Else 
				aRealNtaPF{$row}:=-10
			End if 
		End if 
		
		
	: ($periodosPonderados=False:C215)
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			$array:=Get pointer:C304("aRealNtaP"+String:C10($i))
			$nValue:=$array->{$row}
			If (($nValue>=vrNTA_MinimoEscalaReferencia) | ($nValue=-3) | ($nValue=-10))
				If ($nValue>=vrNTA_MinimoEscalaReferencia)
					$sum:=$Sum+$nValue
					$div:=$div+1
					$evaluaciones:=$evaluaciones+1
				End if 
			Else 
				$sum:=$nValue
				$i:=Size of array:C274(atSTR_Periodos_Nombre)+1
			End if 
		End for 
		If ($evaluaciones>0)
			If (($sum>=vrNTA_MinimoEscalaReferencia) & ($div>0))
				aRealNtaPF{$row}:=Round:C94($sum/$div;11)
			Else 
				aRealNtaPF{$row}:=$sum
			End if 
		Else 
			If (($sum=-1) | ($sum=-2) | ($sum=-3))
				aRealNtaPF{$row}:=$sum
			Else 
				aRealNtaPF{$row}:=-10
			End if 
		End if 
End case 

