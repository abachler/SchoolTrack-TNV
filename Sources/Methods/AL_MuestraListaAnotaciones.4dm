//%attributes = {}
  //AL_MuestraListaAnotaciones

STR_LeePreferenciasConducta2 

SORT ARRAY:C229(<>aiID_Matriz;<>atSTR_Anotaciones_categorias;<>atSTR_Anotaciones_motivo;<>aiSTR_Anotaciones_puntaje;<>aiSTR_Anotaciones_motivo_puntaj)
$hl_Anotaciones:=New list:C375
$itemID:=0
For ($i;1;Size of array:C274(aiSTR_IDCategoria))
	  //$idMatriz:=Abs(aiSTR_IDCategoria{$i})
	$idMatriz:=aiSTR_IDCategoria{$i}
	$startAt:=Find in array:C230(<>aiID_Matriz;$idMatriz)
	$sublist:=0
	If ($startAt>0)
		$subList:=New list:C375
		$index:=$startAt
		For ($index;$startAt;Size of array:C274(<>aiID_Matriz))
			If (<>aiID_Matriz{$index}#$idMatriz)
				$index:=Size of array:C274(<>aiID_Matriz)+1
			Else 
				$itemID:=$itemID+1
				APPEND TO LIST:C376($subList;<>atSTR_Anotaciones_motivo{$index};$itemID)
			End if 
		End for 
		SORT LIST:C391($sublist)
	End if 
	APPEND TO LIST:C376($hl_Anotaciones;at_STR_CategoriasAnot_Nombres{$i};aiSTR_IDCategoria{$i}*-1;$subList;True:C214)
End for 
SORT LIST:C391($hl_Anotaciones;>)
$choice:=HL_ShowHListPopWindow ($hl_Anotaciones;"Selección del Motivo de Anotación...")
CLEAR LIST:C377($hl_Anotaciones;*)

SORT ARRAY:C229(<>atSTR_Anotaciones_motivo;<>aiID_Matriz;<>atSTR_Anotaciones_categorias;<>aiSTR_Anotaciones_puntaje;<>aiSTR_Anotaciones_motivo_puntaj;>)

$0:=$choice