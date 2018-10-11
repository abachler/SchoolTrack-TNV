ARRAY TEXT:C222(aListElements;0)
COPY ARRAY:C226(sElements;aListElements)
ARRAY TEXT:C222(sElements;0)
AL_UpdateArrays (xALP_Tables;0)
TBL_Rebuild 
COPY ARRAY:C226(aListElements;sElements)
AL_UpdateArrays (xALP_Tables;Size of array:C274(sElements))
ARRAY INTEGER:C220(aLines;0)
AL_SetSelect (xALP_Tables;aLines)
ARRAY TEXT:C222(aListElements;0)

TBL_SetListApparence 