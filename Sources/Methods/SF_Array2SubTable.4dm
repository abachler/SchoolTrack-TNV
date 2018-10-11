//%attributes = {}
  //SF_Array2SubTable

  //$1:Subfile pointer
  //Next params are: Array 1;SubField 1;…;…;SubField N;Array N
_O_ALL SUBRECORDS:C109($1->)
_O_FIRST SUBRECORD:C61($1->)
For ($i;1;Size of array:C274($2->))
	If (_O_End subselection:C37($1->))
		_O_CREATE SUBRECORD:C72($1->)
	End if 
	For ($k;2;Count parameters:C259;2)
		${$k+1}->:=${$k}->{$i}
	End for 
	_O_NEXT SUBRECORD:C62($1->)
End for 