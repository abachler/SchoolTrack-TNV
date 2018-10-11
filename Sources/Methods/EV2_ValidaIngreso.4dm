//%attributes = {}
  //EV2_ValidaIngreso


C_REAL:C285($minEscala;$maxEscala;$decEscala;$nValue;$intervaloEscala)
C_TEXT:C284($value)
C_LONGINT:C283($modo;$length;vi_lastGradeView)

$value:=EV2_Literal_Sistema ($1)
$modo:=iEvaluationMode

If (vi_lastGradeView=0)
	vi_lastGradeView:=iEvaluationMode
End if 

If (Count parameters:C259=2)
	$modo:=$2
End if 

If (iEvaluationMode=4)  //símbolos
	Case of 
		: ($value="")
			$nValue:=-10
		: ($value="*")
			$nValue:=-4
		: ($value="P")
			$nValue:=-2
		: ($value="X")
			$nValue:=-3
			
		Else 
			$el:=Find in array:C230(aSymbol;$value)
			If ($el<0)
				$nValue:=-10
				CD_Dlog (0;__ ("Símbolo no definido. No puede ser aceptado como indicador."))
			Else 
				$nValue:=aSymbPctEqu{$el}
				$nValue:=Round:C94($nValue;12)
				If ($nValue<vrNTA_MinimoEscalaReferencia)
					CD_Dlog (0;__ ("No se ha definido la equivalencia numérica para el símbolo ingresado en el estilo de evaluación utilizado por la comptencia.\r\rEl símbolo ingresado no puede ser acepatado."))
				End if 
			End if 
	End case 
	
Else 
	Case of 
		: ($modo=Notas)
			$minEscala:=rGradesFrom
			$maxEscala:=rGradesTo
			$decEscala:=iGradesDec
			$intervaloEscala:=rGradesInterval
		: ($modo=Puntos)
			$minEscala:=rPointsFrom
			$maxEscala:=rPointsTo
			$decEscala:=iPointsDec
			$intervaloEscala:=rPointsInterval
		: ($modo=Porcentaje)
			$minEscala:=1
			$maxEscala:=100
			$decEscala:=1
			$intervaloEscala:=0.1
		: ($modo=Simbolos)
			$minEscala:=0
			$maxEscala:=100
			$decEscala:=1
			$intervaloEscala:=0.1
	End case 
	
	Case of 
		: ($value="")
			$nValue:=-10
		: ($value="*")
			$nValue:=-4
		: ($value="P")
			$nValue:=-2
		: ($value="X")
			$nValue:=-3
			
		Else 
			
			
			If (($minEscala>=1) & ($value="0@"))
				$value:=String:C10(Num:C11($value))  //elimino eventuales 0 previos
			End if 
			
			Case of 
				: ((Position:C15(<>tXS_RS_DecimalSeparator;$value)=0) & ($decEscala>0) & (Num:C11($value)<$maxEscala))
					$nValue:=Num:C11($value)
					
				: ((Position:C15(<>tXS_RS_DecimalSeparator;$value)=0) & ($decEscala>0))
					$length:=Length:C16(String:C10(Int:C8($maxEscala)))+$decEscala
					$value:=Substring:C12($value;1;$length)
					If (Length:C16($value)<$length)
						If ((Position:C15($value;String:C10($maxEscala))#0) | (Num:C11($value)=$minEscala))
							$value:=$value
							$nvalue:=Num:C11($value)
						Else 
							$value:=Substring:C12($value+("0"*5);1;$length)
						End if 
						$value:=Insert string:C231($value;<>tXS_RS_DecimalSeparator;$length-$decEscala+1)
					Else 
						$value:=Insert string:C231($value;<>tXS_RS_DecimalSeparator;$length-$decEscala+1)
					End if 
					
					Case of 
						: (Position:C15(String:C10($maxEscala);$value)=1)
							$nValue:=$maxEscala
							
						: (Length:C16($value)=$length)
							$i:=0
							While ($nValue>$maxEscala)
								$nValue:=Num:C11($value)/(10^($decEscala+$i))
								$i:=$i+1
							End while 
						Else 
							$nValue:=Num:C11($value)
							$i:=0
							While ($nValue>$maxEscala)
								$nValue:=Num:C11($value)/(10^$i)
								$i:=$i+1
							End while 
					End case 
				: (Length:C16($value)=Length:C16(String:C10($minEscala)))
					$nValue:=Num:C11($value)
				Else 
					$nValue:=Num:C11($value)
			End case 
			$nValue:=Trunc:C95($nValue;$decEscala)
			
			$interval:=Num:C11(Substring:C12($value;Position:C15(<>tXS_RS_DecimalSeparator;$value)+$decEscala))/(10^$decEscala)
			If (($interval<rGradesInterval) & ($interval>0))
				$nValue:=NTA_adjustInterval ($nValue;$decEscala;$intervaloEscala)
			End if 
			
			
			Case of 
				: ($nValue<$minEscala)
					CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10($minEscala)+__ (" a ")+String:C10($maxEscala))
					$nValue:=-10
				: ($nValue>$maxEscala)
					CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10($minEscala)+__ (" a ")+String:C10($maxEscala))
					$nValue:=-10
				Else 
					$iConversionTable:=iConversionTable
					Case of 
						: ($modo=Notas)
							If (vi_lastGradeView=Puntos)  //grades to points
								If ($iConversionTable=1)
									iConversionTable:=$iConversionTable
									$nValue:=NTA_GetPctValueFromConvTable ($nValue;Notas)
									If ($nValue=-10)
										CD_Dlog (0;__ ("La nota ingresada no está definida en la tabla de conversión de evaluaciones."))
									End if 
								End if 
							Else 
								$nValue:=EV2_Nota_a_Real ($nValue)
							End if 
							
						: ($modo=Puntos)
							If (vi_lastGradeView=Notas)  //grades to points
								If ($iConversionTable=1)
									iConversionTable:=$iConversionTable
									$nValue:=NTA_GetPctValueFromConvTable ($nValue;Puntos)
									If ($nValue=-10)
										CD_Dlog (0;__ ("La nota ingresada no está definida en la tabla de conversión de evaluaciones."))
									End if 
								End if 
							Else 
								$nValue:=EV2_Puntos_a_Real ($nValue)
							End if 
							
							
							
						: ($modo=Porcentaje)
							$nValue:=Round:C94($nValue;1)
							
					End case 
					iConversionTable:=$iConversionTable
			End case 
			
	End case 
	
	
	
End if 




$0:=$nValue