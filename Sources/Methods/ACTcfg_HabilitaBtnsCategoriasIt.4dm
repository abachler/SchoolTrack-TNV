//%attributes = {}
  //ACTcfg_HabilitaBtnsCategoriasIt

C_BOOLEAN:C305($expanded)
C_LONGINT:C283($sublist)
IT_SetButtonState ((Count list items:C380(hl_Categorias)>0);->bDelCategoria;->bPrint)
If ((Selected list items:C379(hl_Categorias)>0) & (Count list items:C380(hl_Categorias)>0))
	If (Selected list items:C379(hl_Categorias)>Count list items:C380(hl_Categorias))
		SELECT LIST ITEMS BY POSITION:C381(hl_Categorias;Count list items:C380(hl_Categorias))
	Else 
		SELECT LIST ITEMS BY POSITION:C381(hl_Categorias;Selected list items:C379(hl_Categorias))
	End if 
	GET LIST ITEM:C378(hl_Categorias;Selected list items:C379(hl_Categorias);$ref;$text;$subList;$expanded)
	$parentRef:=List item parent:C633(hl_Categorias;$ref)
	If ($parentRef=0)
		$pos:=List item position:C629(hl_Categorias;$ref)
		$arriba:=False:C215
		$abajo:=False:C215
		For ($i;1;$pos-1)
			GET LIST ITEM:C378(hl_Categorias;$i;$ref;$text)
			$parentRef:=List item parent:C633(hl_Categorias;$ref)
			If ($parentRef=0)
				$i:=$pos
				$arriba:=True:C214
			End if 
		End for 
		For ($i;Count list items:C380(hl_Categorias);$pos+1;-1)
			GET LIST ITEM:C378(hl_Categorias;$i;$ref;$text)
			$parentRef:=List item parent:C633(hl_Categorias;$ref)
			If ($parentRef=0)
				$i:=$pos
				$abajo:=True:C214
			End if 
		End for 
		IT_SetButtonState ($arriba;->bSubir)
		IT_SetButtonState ($abajo;->bBajar)
	Else 
		IT_SetButtonState (False:C215;->bSubir;->bBajar)
	End if 
Else 
	IT_SetButtonState (False:C215;->bSubir;->bBajar)
End if 