//%attributes = {}
  //ACTcfg_ArregloDocsTribs

C_TEXT:C284(vtACT_DocTrib)
C_POINTER:C301($1;$ptr2Field)
C_LONGINT:C283($pos;$i)
C_BOOLEAN:C305($vb_eliminar)
ARRAY LONGINT:C221($al_idsAllowed;0)

APPEND TO ARRAY:C911($al_idsAllowed;-1)  //boleta
APPEND TO ARRAY:C911($al_idsAllowed;-3)  //factura

$ptr2Field:=$1

ACTcfg_LoadConfigData (8)

If (($ptr2Field->=0) & (Size of array:C274(alACT_IDsCats)>0))
	$Pdefecto:=Num:C11(ACTbol_validaInfo ("buscaCatPorDefecto"))
	If (($Pdefecto#-1) & (ACTcfg_SearchCatDocs (alACT_IDsCats{$Pdefecto})))
		$ptr2Field->:=alACT_IDsCats{$Pdefecto}
	End if 
End if 

$pos:=Find in array:C230(alACT_IDsCats;$ptr2Field->)
If ($pos=-1)
	vtACT_DocTrib:=""
Else 
	vtACT_DocTrib:=atACT_Categorias{$pos}
End if 

For ($i;Size of array:C274(alACT_IDsCats);1;-1)
	$vb_eliminar:=False:C215
	If (ACTcfg_SearchCatDocs (alACT_IDsCats{$i}))
		If (Find in array:C230($al_idsAllowed;alACT_IDsCats{$i})=-1)
			If (alACT_IDsCats{$i}<0)
				$vb_eliminar:=True:C214
			End if 
		End if 
	Else 
		$vb_eliminar:=True:C214
	End if 
	If ($vb_eliminar)
		AT_Delete ($i;1;->atACT_Categorias;->alACT_IDsCats)
	End if 
End for 