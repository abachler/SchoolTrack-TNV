//%attributes = {}
  // EV2_Puntos_a_Simbolo()
  // 
  //
  // creado por: Alberto Bachler Klein: 25-11-16, 14:37:38
  // -----------------------------------------------------------

C_TEXT:C284($0)
C_REAL:C285($1)

C_LONGINT:C283($i_simbolo;$l_posicion)
C_REAL:C285($r_evaluacion;$r_intervalo;$r_limiteInferior;$r_limiteSuperior;$r_mediana)


If (False:C215)
	C_TEXT:C284(EV2_Real_a_Simbolo ;$0)
	C_REAL:C285(EV2_Real_a_Simbolo ;$1)
End if 

$r_evaluacion:=Round:C94($1;11)

Case of 
	: ($r_evaluacion=-10)
		$0:=""
	: ($r_evaluacion=-5)
		$0:=">>>"
	: ($r_evaluacion=-4)
		$0:="*"
	: ($r_evaluacion=-2)
		$0:="P"
	: ($r_evaluacion=-3)
		$0:="X"
	: ($r_evaluacion>=rPointsFrom)
		
		If (Size of array:C274(aSymbPointsEqu)>0)
			If (viEVS_EquivalenciasAbsolutas=0)
				$l_posicion:=Find in array:C230(aSymbPointsEqu;$r_evaluacion)
				If ($l_posicion>0)
					$0:=aSymbol{$l_posicion}
				Else 
					For ($i_simbolo;1;Size of array:C274(aSymbol)-1)
						If (($r_evaluacion>=Round:C94(aSymbPointsFrom{$i_simbolo};11)) & ($r_evaluacion<=Round:C94(aSymbPointsTo{$i_simbolo};11)))
							$0:=aSymbol{$i_simbolo}
							$i_simbolo:=Size of array:C274(aSymbol)
						End if 
					End for 
					If ($0="")
						If (($r_evaluacion>=Round:C94(aSymbPointsFrom{Size of array:C274(aSymbol)};11)) & ($r_evaluacion<=100))
							$0:=aSymbol{Size of array:C274(aSymbol)}
						Else 
							$0:="S?"
						End if 
					End if 
				End if 
				
			Else 
				$l_posicion:=Find in array:C230(aSymbPointsEqu;$r_evaluacion)
				If ($l_posicion>0)
					$0:=aSymbol{$l_posicion}
				Else 
					
					For ($i_simbolo;1;Size of array:C274(aSymbol)-1)
						If (($r_evaluacion>=aSymbPointsEqu{$i_simbolo}) & ($r_evaluacion<=aSymbPointsEqu{$i_simbolo+1}))
							$r_limiteInferior:=Round:C94(aSymbPointsEqu{$i_simbolo};11)
							$r_limiteSuperior:=Round:C94(aSymbPointsEqu{$i_simbolo+1};11)
							$r_intervalo:=($r_limiteSuperior-$r_limiteInferior)/2
							$r_mediana:=$r_limiteInferior+$r_intervalo
							Case of 
								: ($r_evaluacion<$r_mediana)
									$0:=aSymbol{$i_simbolo}
								: ($r_evaluacion>=$r_mediana)
									$0:=aSymbol{$i_simbolo+1}
							End case 
							$i_simbolo:=Size of array:C274(aSymbol)
						End if 
					End for 
					
				End if 
			End if 
		Else 
			$0:="•"
		End if 
	Else 
		$0:=""
End case 
