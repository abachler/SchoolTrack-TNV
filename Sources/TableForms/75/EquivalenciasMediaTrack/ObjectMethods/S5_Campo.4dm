If (([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6>0) & ([xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7>0))
	[xxBBL_MarcRecordStructure:75]MediaTrack_FieldName:9:="["+Table name:C256([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6)+"]"+Field name:C257([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6;[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7)
End if 