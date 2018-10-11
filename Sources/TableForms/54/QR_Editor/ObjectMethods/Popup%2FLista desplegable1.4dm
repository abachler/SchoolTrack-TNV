
Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283(viQR_TableFieldSelector)
		ARRAY TEXT:C222(atQR_TableFieldSelector;5)
		  //$tableName:=API Get Virtual Table Name (Table(vyQR_tablePointer))
		  //atQR_TableFieldSelector{1}:="Campos para "+$tableName
		  //atQR_TableFieldSelector{2}:="Campos de tablas relacionadas"
		  //atQR_TableFieldSelector{3}:="Campos de todas las tablas"
		  //atQR_TableFieldSelector{4}:="-"
		  //atQR_TableFieldSelector{5}:="Columnas del Informe"
		
		$tableName:=API Get Virtual Table Name (vlQR_MainTable)
		atQR_TableFieldSelector{1}:="Campos para "+$tableName
		atQR_TableFieldSelector{2}:="Campos de tablas relacionadas"
		atQR_TableFieldSelector{3}:="Campos de todas las tablas"
		atQR_TableFieldSelector{4}:="-"
		atQR_TableFieldSelector{5}:="Columnas del Informe"
		
		atQR_TableFieldSelector:=1
		QR_BuildTableList (->hlQR_FieldList;vlQR_MainTable;Self:C308->)
		viQR_TableFieldSelector:=1
	: (Form event:C388=On Clicked:K2:4)
		QR_BuildTableList (->hlQR_FieldList;vlQR_MainTable;Self:C308->)
	: (Form event:C388=On Unload:K2:2)
		If (Self:C308->#viQR_TableFieldSelector)
			QR_BuildTableList (->hlQR_FieldList;Table:C252(vyQR_tablePointer);Self:C308->)
			viQR_TableFieldSelector:=Self:C308->
		End if 
End case 

