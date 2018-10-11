$row:=AL_GetLine (xALP_MetaDataValues)
If ($row>0)
	atADT_MetaDataValue{$row}:=""
	AL_UpdateArrays (xALP_MetaDataValues;-1)
End if 