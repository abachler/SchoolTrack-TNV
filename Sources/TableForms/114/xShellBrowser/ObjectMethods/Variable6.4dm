If (Self:C308->>0)
	If (Self:C308-><Size of array:C274(Self:C308->))
		$item:=Self:C308->{Self:C308->}
		yBWR_currentTable:=yBWR_currentTable
		vyQRY_TablePointer:=yBWR_currentTable
		$found:=QRY_ExecuteBuildQuery ($item)
		If (OK=1)
			If ($found#0)
				CREATE SET:C116(vyQRY_TablePointer->;"Selection"+Table name:C256(vyQRY_TablePointer))
				WDW_Title (vyQRY_TablePointer)
			Else 
				CD_Dlog (0;__ ("Ningún registro cumple con las condiciones especificadas.");__ (""))
				USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(vyQRY_TablePointer)))
			End if 
		Else 
			USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(vyQRY_TablePointer)))
		End if 
		If ((Macintosh option down:C545 & Macintosh command down:C546) | (Windows Alt down:C563 & Windows Ctrl down:C562))
			CREATE SET:C116(yBWR_currentTable->;"selection")
			ALL RECORDS:C47(yBWR_currentTable->)
			CREATE SET:C116(yBWR_currentTable->;"all")
			DIFFERENCE:C122("all";"Selection";"selection")
			USE SET:C118("selection")
			CLEAR SET:C117("selection")
			CLEAR SET:C117("all")
		End if 
		CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	Else 
		vyQRY_TablePointer:=yBWR_currentTable
		wSrchInSel:=False:C215
		QRY_QueryEditor 
		If (ok=1)
			CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
			BWR_SelectTableData 
		End if 
	End if 
End if 