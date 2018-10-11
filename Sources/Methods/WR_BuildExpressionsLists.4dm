//%attributes = {}
  //WR_BuildExpressionsLists

C_LONGINT:C283(hl_TablesFields;hl_Methods;hl_Variables)
HL_ClearList (hl_TablesFields;hl_Methods;hl_Variables)
hl_TablesFields:=New list:C375
For ($i;1;Get last table number:C254)
	If (Is table number valid:C999($i))
		$tableName:=Table name:C256($i)
		$tableNameVirtual:=API Get Virtual Table Name ($i)
		If ($tableNameVirtual="")
			$tableNameVirtual:=$tableName
		End if 
		If (($tableName#"xShell@") & ($tableName#"xx@") & ($tableName#"zz@") & ($tableName#"REGEX@"))
			APPEND TO LIST:C376(hl_TablesFields;$tableNameVirtual;-$i;0;False:C215)
		End if 
	End if 
End for 
SORT LIST:C391(hl_TablesFields)

For ($i;1;Count list items:C380(hl_TablesFields))
	
	$fieldList:=New list:C375
	GET LIST ITEM:C378(hl_TablesFields;$i;$tableNumber;$tableNameVirtual)
	$tableNumber:=$tableNumber*-1
	For ($k;1;Get last field number:C255($tableNumber))
		If (Is field number valid:C1000($tableNumber;$k))
			$fieldNumber:=Num:C11(String:C10($tableNumber)+String:C10($k;"000"))
			$fieldName:=API Get Virtual Field Name ($tableNumber;$k)
			If ($fieldName="")
				$fieldName:=Field name:C257($tableNumber;$k)
			End if 
			APPEND TO LIST:C376($fieldList;$fieldName;$fieldNumber;0;False:C215)
		End if 
	End for 
	SORT LIST:C391($fieldList)
	SELECT LIST ITEMS BY POSITION:C381($fieldList;1)
	GET LIST ITEM:C378($fieldList;1;$ref;$text)
	SET LIST ITEM:C385(hl_TablesFields;$tableNumber*-1;$tableNameVirtual;$tableNumber*-1;$fieldList;False:C215)
	SET LIST PROPERTIES:C387(hl_TablesFields;_o_Ala Macintosh:K28:1;0;20;0;0;0)
End for 

hl_Methods:=New list:C375
WR_SetMethods 
SET LIST PROPERTIES:C387(hl_Methods;_o_Ala Macintosh:K28:1;0;20;0;0;0)
hl_Variables:=New list:C375
WR_SetVariables 
SET LIST PROPERTIES:C387(hl_Variables;_o_Ala Macintosh:K28:1;0;20;0;0;0)