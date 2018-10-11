//%attributes = {}
  //BWR_ChangeCurrentRecord

C_LONGINT:C283($0)
$0:=0
Case of 
		  //: (Table(crtFile)=Table(->[my_table]))
		  //saved:=MT_dcSave 
End case 
If (viBWR_RecordWasSaved>=0)
	QUERY:C277(yBWR_currentTable->;<>brFldIDPtr->=$1)
	$0:=1
End if 