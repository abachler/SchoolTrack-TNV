If (Form event:C388=On Display Detail:K2:22)
	If (([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6>0) & ([xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7>0))
		[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8:="["+Table name:C256([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6)+"]"+Field name:C257([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6;[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7)
	End if 
	If ([xxBBL_MarcRecordStructure:75]SubFieldCode:2="")
		OBJECT SET FONT STYLE:C166(*;"@";1)
	Else 
		OBJECT SET FONT STYLE:C166(*;"@";0)
	End if 
End if 