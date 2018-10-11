C_POINTER:C301($object)
OBJECT SET ENABLED:C1123(bDelEfemeride;(Find in array:C230(lb_Efemerides;True:C214)#-1))
LBX_HandleEvents ("lb_Efemerides";$object;"";"xLB_CB_EX_Efemerides")
Case of 
	: (Form event:C388=On Row Moved:K2:32)
		LISTBOX MOVED ROW NUMBER:C837(lb_Efemerides;$ant;$new)
		$temp1:=aIDs{$ant}
		$temp3:=aIndexMeta{$ant}
		AT_Delete ($ant;1;->aIDs;->aIndexMeta)
		AT_Insert ($new;1;->aIDs;->aIndexMeta)
		aIDs{$new}:=$temp1
		aIndexMeta{$new}:=$temp3
		For ($i;1;Size of array:C274(aIndexMeta))
			aIndexMeta{$i}:=$i
		End for 
		SORT ARRAY:C229(aIndexMeta;aRelMetaDef;aIDs;>)
End case 