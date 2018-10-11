//%attributes = {}
  //BBLmarc_OpenInputer

C_POINTER:C301($1;$fieldPtr)

$fieldPtr:=$1
vpBBL_MTField4MARC:=$fieldPtr

ARRAY TEXT:C222(atBBL_MARCCode;0)
ARRAY TEXT:C222(atBBL_SubFieldCode;0)
ARRAY TEXT:C222(atBBL_SubFieldName;0)
ARRAY TEXT:C222(atBBL_MARCValue;0)
ARRAY LONGINT:C221(alBBL_MarcValueRecNum;0)
ARRAY BOOLEAN:C223(abBBL_EquivPrincipal;0)

$tableNum:=Table:C252($fieldPtr)
$fieldNum:=Field:C253($fieldPtr)

START TRANSACTION:C239

READ ONLY:C145([xxBBL_MarcRecordStructure:75])
READ ONLY:C145([BBL_ItemMarcFields:205])
$key:=String:C10($tableNum)+"."+String:C10($fieldNum)+"."+String:C10([BBL_Items:61]Numero:1)+"@"
QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]LLaveItem:10=$key)

If ($tableNum=66)
	QUERY SELECTION:C341([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Copia:9=[BBL_Registros:66]ID:3)
End if 

For ($i;1;Records in selection:C76([BBL_ItemMarcFields:205]))
	QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8=[BBL_ItemMarcFields:205]SubFieldRef:3)
	APPEND TO ARRAY:C911(atBBL_MARCCode;[xxBBL_MarcRecordStructure:75]FieldNumber:1)
	APPEND TO ARRAY:C911(atBBL_SubFieldCode;[xxBBL_MarcRecordStructure:75]SubFieldCode:2)
	APPEND TO ARRAY:C911(atBBL_SubFieldName;[xxBBL_MarcRecordStructure:75]Name_en:3)
	APPEND TO ARRAY:C911(atBBL_MARCValue;[BBL_ItemMarcFields:205]Dato:6)
	APPEND TO ARRAY:C911(alBBL_MarcValueRecNum;Record number:C243([BBL_ItemMarcFields:205]))
	APPEND TO ARRAY:C911(abBBL_EquivPrincipal;[xxBBL_MarcRecordStructure:75]Equivalencia_Principal:10)
	NEXT RECORD:C51([BBL_ItemMarcFields:205])
End for 

WDW_OpenFormWindow (->[BBL_Items:61];"InputMARC";0;Movable form dialog box:K39:8;__ ("Campos MARC"))
DIALOG:C40([BBL_Items:61];"InputMARC")
CLOSE WINDOW:C154
If (ok=1)
	For ($i;1;Size of array:C274(alBBL_MarcValueRecNum))
		If (atBBL_MARCValue{$i}#"")
			If (alBBL_MarcValueRecNum{$i}#-1)
				KRL_GotoRecord (->[BBL_ItemMarcFields:205];alBBL_MarcValueRecNum{$i};True:C214)
			Else 
				CREATE RECORD:C68([BBL_ItemMarcFields:205])
			End if 
			[BBL_ItemMarcFields:205]Dato:6:=atBBL_MARCValue{$i}
			[BBL_ItemMarcFields:205]ID_Item:1:=[BBL_Items:61]Numero:1
			[BBL_ItemMarcFields:205]FieldRef:2:=Num:C11(atBBL_MARCCode{$i})
			[BBL_ItemMarcFields:205]SubFieldRef:3:=atBBL_MARCCode{$i}+atBBL_SubFieldCode{$i}
			[BBL_ItemMarcFields:205]TableNum:7:=$tableNum
			[BBL_ItemMarcFields:205]FieldNum:8:=$fieldNum
			Case of 
				: ($tableNum=61)
					[BBL_ItemMarcFields:205]ID_Copia:9:=0
				: ($tableNum=66)
					[BBL_ItemMarcFields:205]ID_Copia:9:=[BBL_Registros:66]ID:3
			End case 
			SAVE RECORD:C53([BBL_ItemMarcFields:205])
		Else 
			If (alBBL_MarcValueRecNum{$i}#-1)
				KRL_GotoRecord (->[BBL_ItemMarcFields:205];alBBL_MarcValueRecNum{$i};True:C214)
				DELETE RECORD:C58([BBL_ItemMarcFields:205])
			End if 
		End if 
		$fieldPtr->:=atBBL_MARCValue{$i}
		SAVE RECORD:C53(Table:C252($tableNum)->)
	End for 
	KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 