//%attributes = {}
  // Método: KRL_LoadTableAndFieldPointers
  // Load table and field names and pointer in two objects
  //
  // por Alberto Bachler Klein
  // creación 25/08/17, 15:52:38
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($i_fields;$i_tables)
C_POINTER:C301($y_tablePointer)
C_TEXT:C284($t_fieldName;$t_tableName)
C_OBJECT:C1216(<>ob_Tables;<>ob_fields)



$l_ms:=Milliseconds:C459

<>ob_Tables:=OB_Create 
<>ob_fields:=OB_Create 
For ($i_tables;1;Get last table number:C254)
	If (Is table number valid:C999($i_tables))
		$t_tableName:=Lowercase:C14(Table name:C256($i_tables))
		$y_tablePointer:=Table:C252($i_tables)
		OB SET:C1220(<>ob_Tables;$t_tableName;$y_tablePointer)
		For ($i_fields;1;Get last field number:C255($i_tables))
			If (Is field number valid:C1000($i_tables;$i_fields))
				$t_fieldName:=Lowercase:C14(Field name:C257($i_tables;$i_fields))
				OB SET:C1220(<>ob_fields;$t_tableName+"$"+$t_fieldName;Field:C253($i_tables;$i_fields))
			End if 
		End for 
	End if 
End for 
$l_ms1:=Milliseconds:C459-$l_ms


