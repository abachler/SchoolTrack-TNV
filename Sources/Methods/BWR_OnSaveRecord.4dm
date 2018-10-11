//%attributes = {}
  //BWR_OnSaveRecord

C_BOOLEAN:C305($trapped)


If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 

viBWR_RecordWasSaved:=0
$trapped:=dhBWR_OnSaveRecord ($tablePointer)

If (Not:C34($trapped))
	viBWR_RecordWasSaved:=KRL_SaveRecord ($tablePointer)
End if 

If ((vlBWR_BrowsingMethod=BWR Standard Browsing) & (vbXS_inBrowser))
	ADD TO SET:C119(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
End if 

$0:=viBWR_RecordWasSaved