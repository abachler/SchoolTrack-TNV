ARRAY LONGINT:C221(alBBL_RecordStart;1)
alBBL_RecordStart{1}:=0
vhBBL_DocRef:=Open document:C264("";"TEXT";Read mode:K24:5)
If (document#"")
	vlBBL_CurrentRecordNum:=1
	RECEIVE PACKET:C104(vhBBL_DocRef;vtBBL_CurrentRecord;"`")
	$nextRecordStartAt:=alBBL_RecordStart{vlBBL_CurrentRecordNum}+Length:C16(vtBBL_CurrentRecord)+1
	SET DOCUMENT POSITION:C482(vhBBL_DocRef;$nextRecordStartAt)
	APPEND TO ARRAY:C911(alBBL_RecordStart;$nextRecordStartAt)
	POST KEY:C465(Character code:C91("'");256)
End if 