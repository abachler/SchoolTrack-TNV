AT_Initialize (->al_idsItemsForList;->at_nombreItemsForList)
AT_Difference (->al_idsItems;->al_idsItemsIFC;->al_idsItemsForList)
For ($i;1;Size of array:C274(al_idsItemsForList))
	AT_Insert ($i;1;->at_nombreItemsForList)
	$pos:=Find in array:C230(al_idsItems;al_idsItemsForList{$i})
	at_nombreItemsForList{$i}:=at_nombreItems{$pos}
End for 

ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;2)
<>aChoicePtrs{1}:=->at_nombreItemsForList
<>aChoicePtrs{2}:=->al_idsItemsForList
TBL_ShowChoiceList (1;"Seleccione los ítems";1;->vt_ItemsIE;True:C214)
If (ok=1)
	AT_Initialize (->at_element2Var;->al_element2Var)
	For ($i;1;Size of array:C274(aLinesSelected))
		AT_Insert ($i;1;->at_element2Var;->al_element2Var)
		$pos:=Find in array:C230(al_idsItems;al_idsItemsForList{aLinesSelected{$i}})
		at_element2Var{$i}:="- "+at_nombreItems{$pos}
		al_element2Var{$i}:=al_idsItems{$pos}
	End for 
	vt_ItemsIE:=""
	vt_ItemsIE:=AT_array2text (->at_element2Var;"\r")
	COPY ARRAY:C226(al_element2Var;al_idsItemsIE)
End if 
REDRAW WINDOW:C456