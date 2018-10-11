//%attributes = {}
  //NTA_GetValueFromPctConvTable

$pct:=$1
$to:=$2
$el:=0
SET REAL COMPARISON LEVEL:C623(10^-11)

If ($pct>=vrNTA_MinimoEscalaReferencia)
	
	If (Size of array:C274(arEVS_ConvPointsPercent)>0)
		Case of 
			: (iEValuationMode=Puntos)
				$el:=Find in array:C230(arEVS_ConvPointsPercent;$pct)
				If ($el=-1)
					Case of 
						: ($pct<arEVS_ConvPointsPercent{1})
							$el:=1
						: ($pct>=arEVS_ConvPointsPercent{Size of array:C274(arEVS_ConvPointsPercent)})
							$el:=Size of array:C274(arEVS_ConvPointsPercent)
						Else 
							For ($i;1;Size of array:C274(arEVS_ConvPointsPercent)-1)
								If (($pct>=arEVS_ConvPointsPercent{$i}) & ($pct<arEVS_ConvPointsPercent{$i+1}))
									$d1:=Abs:C99($pct-arEVS_ConvPointsPercent{$i+1})
									$d2:=Abs:C99(arEVS_ConvPointsPercent{$i}-$pct)
									If ($d1<=$d2)
										$el:=$i+1
									Else 
										$el:=$i
									End if 
									$i:=Size of array:C274(arEVS_ConvPointsPercent)+1
								End if 
							End for 
					End case 
				End if 
				
			: (iEValuationMode=Notas)
				$el:=Find in array:C230(arEVS_ConvGradesPercent;$pct)
				If ($el=-1)
					Case of 
						: ($pct<arEVS_ConvGradesPercent{1})
							$el:=1
						: ($pct>=arEVS_ConvGradesPercent{Size of array:C274(arEVS_ConvGradesPercent)})
							$el:=Size of array:C274(arEVS_ConvGradesPercent)
						Else 
							For ($i;1;Size of array:C274(arEVS_ConvGradesPercent)-1)
								If (($pct>=arEVS_ConvGradesPercent{$i}) & ($pct<arEVS_ConvGradesPercent{$i+1}))
									$d1:=Abs:C99($pct-arEVS_ConvGradesPercent{$i+1})
									$d2:=Abs:C99(arEVS_ConvGradesPercent{$i}-$pct)
									If ($d1<=$d2)
										$el:=$i+1
									Else 
										$el:=$i
									End if 
									$i:=Size of array:C274(arEVS_ConvGradesPercent)+1
								End if 
							End for 
					End case 
				End if 
				
		End case 
	Else 
		$el:=-1
	End if 
	
	If ($el>0)
		Case of 
			: ($to=Puntos)
				  //$0:=String(arEVS_ConvPoints{$el};vs_pointsFormat)
				$0:=EV2_Literal_Aplicacion (String:C10(arEVS_ConvPoints{$el}))
			: ($to=Notas)
				  //$0:=String(arEVS_ConvGrades{$el};vs_gradesFormat)
				$0:=EV2_Literal_Aplicacion (String:C10(arEVS_ConvGrades{$el}))
		End case 
	Else 
		$0:="ERR"
	End if 
Else 
	$0:=""
End if 
