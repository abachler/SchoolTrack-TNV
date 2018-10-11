//%attributes = {}
  //ACTat_LLenaArregloPict

$ptr1:=$1
$ptr2:=$2

AT_Initialize ($ptr2)
For ($i;1;Size of array:C274($ptr1->))
	AT_Insert ($i;1;$ptr2)
	If ($ptr1->{$i})
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";$ptr2->{$i})
	Else 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";$ptr2->{$i})
	End if 
End for 