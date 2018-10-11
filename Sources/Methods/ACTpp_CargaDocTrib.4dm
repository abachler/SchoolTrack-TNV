//%attributes = {}
  //ACTpp_CargaDocTrib

ACTcfg_LoadConfigData (8)
ARRAY LONGINT:C221($aCats2Delete;0)
For ($i;1;Size of array:C274(atACT_Categorias))
	$keep:=ACTcfg_SearchCatDocs (alACT_IDsCats{$i})
	If (Not:C34($keep))
		INSERT IN ARRAY:C227($aCats2Delete;1;1)
		$aCats2Delete{1}:=$i
	End if 
End for 
For ($r;1;Size of array:C274($aCats2Delete))
	AT_Delete ($aCats2Delete{$r};1;->atACT_Categorias;->alACT_IDsCats;->abACT_PorDefecto;->abACT_ReqDatos;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
End for 
IT_SetButtonState ((Size of array:C274(atACT_Categorias)>0);->bFactData)
If ((Size of array:C274(atACT_Categorias)=0) & ([Personas:7]ACT_DocumentoTributario:45#0))
	[Personas:7]ACT_DocumentoTributario:45:=0
End if 
