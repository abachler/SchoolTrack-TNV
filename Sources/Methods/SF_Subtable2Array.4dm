//%attributes = {}
  //SF_Subtable2Array

  //$1:Subfile pointer
  //Next params are: SubField 1;Array 1;…;…;SubField N;Array N
_O_FIRST SUBRECORD:C61($1->)
For ($i;1;_O_Records in subselection:C7($1->))
	For ($k;2;Count parameters:C259;2)
		INSERT IN ARRAY:C227(${$k+1}->;$i)
		${$k+1}->{$i}:=${$k}->
	End for 
	_O_NEXT SUBRECORD:C62($1->)
End for 