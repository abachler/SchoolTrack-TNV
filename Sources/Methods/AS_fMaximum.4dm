//%attributes = {}
  //AS_fMaximum
ARRAY REAL:C219($aReal;0)
COPY ARRAY:C226($1->;$aReal)
SORT ARRAY:C229($aReal;<)
If (Size of array:C274($aReal)>0)
	$nvalue:=$aReal{1}
	If ($nvalue>=vrNTA_MinimoEscalaReferencia)
		$0:=Round:C94($nValue;11)
	Else 
		$0:=-10
	End if 
End if 