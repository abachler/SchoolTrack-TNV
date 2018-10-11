//%attributes = {}
  //AS_fMinimum


ARRAY REAL:C219($aReal;0)
COPY ARRAY:C226($1->;$aReal)
For ($i;Size of array:C274($aReal);1;-1)
	If ($aReal{$i}<=vrNTA_MinimoEscalaReferencia)
		DELETE FROM ARRAY:C228($aREal;$i;1)
	End if 
End for 
SORT ARRAY:C229($aReal;>)

If (Size of array:C274($aReal)>0)
	$nvalue:=$aReal{1}
	$0:=Round:C94($nValue;11)
Else 
	$0:=-10
End if 