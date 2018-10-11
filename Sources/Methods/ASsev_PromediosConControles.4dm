//%attributes = {}
  //ASsev_PromediosConControles

$rowIndex:=$1
$sum:=$2
$div:=$3


$pp:=Round:C94($sum/$div;11)

If ($pp>=vrNTA_MinimoEscalaReferencia)
	If (vi_RoundCPpresent=1)
		Case of 
			: (vi_lastGradeView=Notas)
				$stringValue:=EV2_Real_a_Nota ($pp)
				$pp:=EV2_Real_a_Nota ($stringValue)
			: (vi_lastGradeView=Puntos)
				$temp:=EV2_Real_a_Puntos ($pp)
				$pp:=EV2_Puntos_a_Real ($temp)
			: (vi_lastGradeView=Porcentaje)
				$pp:=Round:C94($pp;1)
			: (vi_lastGradeView=Simbolos)
				$symbol:=EV2_Real_a_Simbolo ($pp)
				$pp:=EV2_Simbolo_a_Real ($symbol)
		End case 
	End if 
	aREalSubEvalPresentacion{$rowIndex}:=$pp
	$pondera:=False:C215
	Case of 
		: ([xxSTR_Subasignaturas:83]ModoControles:5=0)
			aRealNtaF{$rowIndex}:=aREalSubEvalPresentacion{$rowIndex}
		: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 1)
			$fExP:=[xxSTR_Subasignaturas:83]PonderacionControlInferior:8/100
			$fPP:=(100-[xxSTR_Subasignaturas:83]PonderacionControlInferior:8)/100
			$pondera:=True:C214
			  //: (([xxSTR_Subasignaturas]ModoControles ?? 11) & ([xxSTR_Subasignaturas]ValorControlSiInferior>0) & (aREalSubEvalControles{$rowIndex}<aREalSubEvalPresentacion{$rowIndex}))  // ponderación si examen inferior a Promedio final
		: (([xxSTR_Subasignaturas:83]ModoControles:5 ?? 11) & (aREalSubEvalControles{$rowIndex}<aREalSubEvalPresentacion{$rowIndex}))  // ponderación si examen inferior a Promedio final
			$fExP:=[xxSTR_Subasignaturas:83]PonderacionControlInferior:8/100
			$fPP:=(100-[xxSTR_Subasignaturas:83]PonderacionControlInferior:8)/100
			$pondera:=True:C214
			  //: (([xxSTR_Subasignaturas]ModoControles ?? 21) & ([xxSTR_Subasignaturas]ValorControlSiSuperior>0) & (aREalSubEvalControles{$rowIndex}>aREalSubEvalPresentacion{$rowIndex}))  // ponderación si examen superior a Promedio final
		: (([xxSTR_Subasignaturas:83]ModoControles:5 ?? 21) & (aREalSubEvalControles{$rowIndex}>aREalSubEvalPresentacion{$rowIndex}))  // ponderación si examen superior a Promedio final
			$fExP:=[xxSTR_Subasignaturas:83]PonderacionControlSuperior:15/100
			$fPP:=(100-[xxSTR_Subasignaturas:83]PonderacionControlSuperior:15)/100
			$pondera:=True:C214
		: (([xxSTR_Subasignaturas:83]ModoControles:5 ?? 12) & (aREalSubEvalControles{$rowIndex}<aREalSubEvalPresentacion{$rowIndex}))  // si examen inferior a Promedio final, Nota final=Promedio
			aRealSubEvalP1{$rowIndex}:=aREalSubEvalPresentacion{$rowIndex}
		: (([xxSTR_Subasignaturas:83]ModoControles:5 ?? 13) & (aREalSubEvalControles{$rowIndex}<aREalSubEvalPresentacion{$rowIndex}))  // si examen inferior a Promedio final, Nota final=Examen
			aRealSubEvalP1{$rowIndex}:=aREalSubEvalControles{$rowIndex}
		: (([xxSTR_Subasignaturas:83]ModoControles:5 ?? 14) & (aREalSubEvalControles{$rowIndex}<aREalSubEvalPresentacion{$rowIndex}))  // si examen inferior a Promedio final, Nota final=Valor Prefijado
			aRealSubEvalP1{$rowIndex}:=[xxSTR_Subasignaturas:83]ValorControlSiInferior:9
		: (([xxSTR_Subasignaturas:83]ModoControles:5 ?? 22) & (aREalSubEvalControles{$rowIndex}>aREalSubEvalPresentacion{$rowIndex}))  // si examen superior a Promedio final, Nota final=Promedio
			aRealSubEvalP1{$rowIndex}:=aREalSubEvalPresentacion{$rowIndex}
		: (([xxSTR_Subasignaturas:83]ModoControles:5 ?? 23) & (aREalSubEvalControles{$rowIndex}>aREalSubEvalPresentacion{$rowIndex}))  // si examen superior a Promedio final, Nota final=Examen
			aRealSubEvalP1{$rowIndex}:=aREalSubEvalControles{$rowIndex}
		: (([xxSTR_Subasignaturas:83]ModoControles:5 ?? 24) & (aREalSubEvalControles{$rowIndex}>aREalSubEvalPresentacion{$rowIndex}))  // si examen superior a Promedio final, Nota final=Valor Prefijado
			aRealSubEvalP1{$rowIndex}:=[xxSTR_Subasignaturas:83]ValorControlSiSuperior:10
	End case 
	
	If ($pondera)
		$ctrl:=Round:C94(aREalSubEvalControles{$rowIndex}*$fExP;11)
		$pp:=Round:C94($pp*$fPP;11)
		$fp:=$pp+$ctrl
		If (vi_gTrPAvg=1)
			aRealSubEvalP1{$rowIndex}:=Trunc:C95($fp;11)
		Else 
			aRealSubEvalP1{$rowIndex}:=Round:C94($fp;11)
		End if 
	End if 
Else 
	aRealSubEvalP1{$rowIndex}:=-10
End if 
