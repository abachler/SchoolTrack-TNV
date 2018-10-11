//%attributes = {}
  //ACTbol_GetDocTribFromTercero

C_LONGINT:C283($idTer;$1)
$idTer:=$1
READ WRITE:C146([ACT_Terceros:138])
QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=$idTer)
$DocCat:=[ACT_Terceros:138]id_CatDocTrib:55
$ExisteCat:=Find in array:C230(alACT_IDsCats;$DocCat)
If (($DocCat=0) | ($ExisteCat=-1))
	$CatPorDefecto:=Find in array:C230(abACT_PorDefecto;True:C214)
	If ($CatPorDefecto#-1)
		$DocCat:=alACT_IDsCats{$CatPorDefecto}
		[ACT_Terceros:138]id_CatDocTrib:55:=$DocCat
		SAVE RECORD:C53([ACT_Terceros:138])
		$0:=$DocCat
	Else 
		$0:=-1
	End if 
Else 
	$0:=$DocCat
End if 