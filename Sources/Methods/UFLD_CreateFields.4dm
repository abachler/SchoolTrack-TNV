//%attributes = {}
  //UFLD_CreateFields

C_POINTER:C301($1;$2;$3)


ARRAY TEXT:C222(aUFItmName;0)
ARRAY TEXT:C222(aUFItmVal;0)
For ($i;1;Size of array:C274(aUFID))
	$Code:=String:C10(aUFID{$i};"00000")+"/"
	$ptr:=$3  //pongo $3 en $ptr, ya que 4D arroja un error al pasar la 2a vez por la linea sig.
	_O_QUERY SUBRECORDS:C108($2->;$ptr->=$code)
	If (_O_Records in subselection:C7($2->)=0)
		_O_CREATE SUBRECORD:C72($2->)
		$ptr->:=$code
	End if 
End for 
_O_ALL SUBRECORDS:C109($2->)