//%attributes = {}
  //ACTbol_GetDocTribFromPersona

C_LONGINT:C283($idApdo;$1)
$idApdo:=$1
ACTcfg_LoadConfigData (8)
READ WRITE:C146([Personas:7])
QUERY:C277([Personas:7];[Personas:7]No:1=$idApdo)
$DocCat:=[Personas:7]ACT_DocumentoTributario:45
$ExisteCat:=Find in array:C230(alACT_IDsCats;$DocCat)
If (($DocCat=0) | ($ExisteCat=-1))
	$CatPorDefecto:=Find in array:C230(abACT_PorDefecto;True:C214)
	If ($CatPorDefecto#-1)
		$DocCat:=alACT_IDsCats{$CatPorDefecto}
		[Personas:7]ACT_DocumentoTributario:45:=$DocCat
		SAVE RECORD:C53([Personas:7])
		$0:=$DocCat
	Else 
		$0:=-1
	End if 
Else 
	$0:=$DocCat
End if 