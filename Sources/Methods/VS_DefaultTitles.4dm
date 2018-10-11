//%attributes = {}
  //VS_DefaultTitles

If (False:C215)
	  //Method: vs_DefaultTitles
	  //Written by  Alberto Bachler on 30/1/98
	  //Purpose: change table and fields titles according to virtual structure
	  //Parameters:
	  // `$1: Table pointer
	  //Syntax:  vs_DefaultTitles(->[table])
	  //Copyright 1998 Transeo Chile
	<>ST_v4508:=False:C215
End if 
If (False:C215)
	  //Method: vs_SetTitles
	  //Written by  Administrateur on 16/03/99
	  //Module: 
	  //Purpose: 
	  //Syntax:  vs_SetTitles()
	  //Parameters:
	  //Copyright 1999 Transeo Chile
	<>ST_v50033:=False:C215
End if 


  //DECLARATIONS
_O_C_STRING:C293(63;$1)
C_LONGINT:C283(vl_table;$vlNbTable;$vlField;$vlNbField)
C_BLOB:C604(vx_StructureTitles)


  //INITIALIZATION
$vlNbTable:=Get last table number:C254  // Get the number of tables present in the database
_O_ARRAY STRING:C218(80;as_tableNames;$vlNbTable)  // Initialize the arrays to be passed to SET TABLE TITLE
ARRAY INTEGER:C220(ai_tableNumbers;$vlNbTable)


  //MAIN CODE
For (vl_table;1;$vlNbTable)  // Loop through the tables  
	If (Is table number valid:C999(vl_table))
		as_tableNames{vl_table}:=Table name:C256(vl_table)  // Get the name of the table
		ai_tableNumbers{vl_table}:=vl_table  // Store the actual table number  
	End if 
End for 
SORT ARRAY:C229(ai_tableNumbers;as_tableNames;>)
SET TABLE TITLES:C601(as_tableNames;ai_tableNumbers)

$vlNbTable:=Get last table number:C254  // Get the number of tables present in the database
For (vl_Table;1;$vlNbTable)  // Loop through the tables  
	If (Is table number valid:C999(vl_Table))
		$vlNbField:=Get last field number:C255(vl_Table)  // Get the number of fields for that table
		_O_ARRAY STRING:C218(80;as_fieldsNames;$vlNbField)  // Initialize the arrays to be passed to SET FIELD TITLES
		ARRAY INTEGER:C220(ai_fieldNumbers;$vlNbField)
		For ($vlField;1;$vlNbField)  // Loop through the fields
			  //20130321 RCH
			If (Is field number valid:C1000(vl_Table;$vlField))
				as_fieldsNames{$vlField}:=Field name:C257(vl_Table;$vlField)  // Get the name of the field
				ai_fieldNumbers{$vlField}:=$vlField  // Store the actual field number
			End if 
		End for 
		SORT ARRAY:C229(ai_fieldNumbers;as_fieldsNames;>)
		SET FIELD TITLES:C602(Table:C252(vl_Table)->;as_fieldsNames;ai_fieldNumbers)
	End if 
End for 
  //END OF MAIN CODE 


  //CLEANING
_O_ARRAY STRING:C218(80;as_fieldsNames;0)
ARRAY INTEGER:C220(ai_fieldNumbers;0)
_O_ARRAY STRING:C218(80;as_TableNames;0)
ARRAY INTEGER:C220(ai_TableNumbers;0)
  //END OF METHOD 

