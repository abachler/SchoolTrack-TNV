//%attributes = {}
  //AL_MuestraListamedidas
  //jvp se crea una lista para mostrar la informacion correspondiente a las medidas
  //ticket 149034  27-08-2015


STR_LeePreferenciasConducta2 

SORT ARRAY:C229(<>atSTRal_MotivosCastigo)

$hl_Anotaciones:=New list:C375
$itemID:=0
For ($i;1;Size of array:C274(atSTRal_MotivosCastigo))
	  //$idMatriz:=Abs(aiSTR_IDCategoria{$i})
	$idMatriz:=atSTRal_MotivosCastigo{$i}
	$startAt:=Find in array:C230(<>atSTRal_MotivosCastigo;$idMatriz)
	$sublist:=0
	If ($startAt>0)
		$subList:=New list:C375
		$index:=$startAt
		For ($index;$startAt;Size of array:C274(<>atSTRal_MotivosCastigo))
			If (<>atSTRal_MotivosCastigo{$index}#$idMatriz)
				$index:=Size of array:C274(<>atSTRal_MotivosCastigo)+1
			Else 
				$itemID:=$itemID+1
				APPEND TO LIST:C376($subList;<>atSTRal_MotivosCastigo{$index};$itemID)
			End if 
		End for 
		SORT LIST:C391($sublist)
	End if 
	APPEND TO LIST:C376($hl_Anotaciones;atSTRal_MotivosCastigo{$i};aiSTR_IDCategoria{$i}*-1)
End for 
SORT LIST:C391($hl_Anotaciones;>)
$choice:=HL_ShowHListPopWindow ($hl_Anotaciones;"Selección del Motivo de Medida...")
CLEAR LIST:C377($hl_Anotaciones;*)

SORT ARRAY:C229(<>atSTRal_MotivosCastigo;>)

$0:=$choice





