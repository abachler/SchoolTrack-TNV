Case of 
	: (Self:C308->=4)
		REDUCE SELECTION:C351(yBWR_currentTable->;0)
		vtQR_SelectionType:=__ ("Selección a imprimir: Búsqueda previa")
		vyQRY_TablePointer:=vyQR_TablePointer
		wSrchInSel:=False:C215
		QRY_QueryEditor 
		If (Records in selection:C76(vyQR_TablePointer->)=0)
			o4:=0
		End if 
	: (Self:C308->=3)
		vtQR_SelectionType:=__ ("Selección a imprimir: Todos los registros")
		vyQRY_TablePointer:=vyQR_TablePointer
		wSrchInSel:=False:C215
		ALL RECORDS:C47(vyQR_TablePointer->)
	: (Self:C308->=2)
		vtQR_SelectionType:=__ ("Selección a imprimir: Los registros de la lista")
		USE SET:C118("recordsInList")
	: (Self:C308->=1)
		vtQR_SelectionType:=__ ("Selección a imprimir: Registros seleccionados en la lista")
		$records:=BWR_SearchRecords 
		If ($records=-1)
			REDUCE SELECTION:C351(vyQR_TablePointer->;0)
		End if 
End case 
vtQR_Records:=String:C10(Records in selection:C76(vyQR_TablePointer->))+__ (" entre ")+String:C10(Records in table:C83(vyQR_TablePointer->))+" "+vt_QRtableVName
QR_AjustesMenu 