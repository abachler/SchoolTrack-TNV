//%attributes = {}
  //BWR_AfterDeleteOnLoading

AL_UpdateArrays (xALP_Browser;0)
For ($i;1;Size of array:C274(ayBWR_ArrayPointers))
	If (lBWR_recordNumber>0)
		DELETE FROM ARRAY:C228(ayBWR_ArrayPointers{$i}->;lBWR_recordNumber)
	End if 
End for 

Case of 
	: (lBWR_recordNumber>Size of array:C274(alBWR_recordNumber))  //20080908 RCH caso nuevo. Cuando se eliminaba un registro desde la ficha, a la variable alBWR_recordNumber se le sumaba 1
		lBWR_recordNumber:=Size of array:C274(alBWR_recordNumber)
	: (lBWR_recordNumber=Size of array:C274(alBWR_recordNumber))
		lBWR_recordNumber:=lBWR_recordNumber-1
	: (Size of array:C274(alBWR_recordNumber)=0)
		lBWR_recordNumber:=0
	Else 
		lBWR_recordNumber:=lBWR_recordNumber+1
End case 
CANCEL:C270
AL_UpdateArrays (xALP_Browser;-2)


