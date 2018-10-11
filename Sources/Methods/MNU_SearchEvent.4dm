//%attributes = {}
  //MNU_SearchEvent

vyQRY_TablePointer:=yBWR_currentTable
wSrchInSel:=False:C215
QRY_QueryEditor 
If (ok=1)
	  //BWRcust_SpecialSearch 
	CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	BWR_SelectTableData 
End if 