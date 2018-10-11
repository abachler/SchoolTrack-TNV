//%attributes = {}
  //`KRL_RewriteIndexedFields

C_LONGINT:C283($iTable;$iField;$fieldType;$fieldLength;$errorCount;$records;$tableNumber)
C_BOOLEAN:C305($indexed)
C_TIME:C306($time)
C_POINTER:C301($1)
ARRAY REAL:C219($aRealValues;0)
ARRAY INTEGER:C220($aIntegerValues;0)
ARRAY TEXT:C222($aTextValues;0)
ARRAY DATE:C224($aDateValues;0)
ARRAY LONGINT:C221($aLongintValues;0)
ARRAY BOOLEAN:C223($aBooleanValues;0)
ARRAY REAL:C219($aRealValues2;0)
ARRAY INTEGER:C220($aIntegerValues2;0)
ARRAY TEXT:C222($aTextValues2;0)
ARRAY DATE:C224($aDateValues2;0)
ARRAY LONGINT:C221($aLongintValues2;0)
ARRAY BOOLEAN:C223($aBooleanValues2;0)
C_BOOLEAN:C305($showResults)
ARRAY POINTER:C280($aTablePointers;0)

$fieldPointer:=$1
$fieldName:=Field name:C257($fieldPointer)
$tablePointer:=Table:C252(Table:C252($fieldPointer))




EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
$pId:=IT_UThermometer (1;0;__ ("Reconstruyendo Index ")+$fieldName)


GET FIELD PROPERTIES:C258($fieldPointer;$fieldType;$fieldLength;$indexed)


If ($indexed)
	0xDev_AvoidTriggerExecution (True:C214)
	
	$pId:=IT_UThermometer (0;$pID;__ ("Verificando Index...  \r[")+$tableName+__ ("]")+$fieldName)
	ALL RECORDS:C47($tablePointer->)
	Case of 
		: ($fieldType=Is longint:K8:6)
			ARRAY LONGINT:C221($aLongintValues2;Records in selection:C76($tablePointer->))
			SELECTION TO ARRAY:C260($fieldPointer->;$aLongintValues)
			KRL_Array2Selection (->$aLongintValues2;$fieldPointer)
			KRL_Array2Selection (->$aLongintValues;$fieldPointer)
			
			
		: ($fieldType=Is integer:K8:5)
			SELECTION TO ARRAY:C260($fieldPointer->;$aIntegerValues)
			ARRAY INTEGER:C220($aIntegerValues2;Records in selection:C76($tablePointer->))
			KRL_Array2Selection (->$aIntegerValues2;$fieldPointer)
			KRL_Array2Selection (->$aIntegerValues;$fieldPointer)
			
		: ($fieldType=Is real:K8:4)
			SELECTION TO ARRAY:C260($fieldPointer->;$aRealValues)
			ARRAY REAL:C219($aRealValues2;Records in selection:C76($tablePointer->))
			KRL_Array2Selection (->$aRealValues2;$fieldPointer)
			KRL_Array2Selection (->$aRealValues;$fieldPointer)
			
		: ($fieldType=Is alpha field:K8:1)
			SELECTION TO ARRAY:C260($fieldPointer->;$aTextValues)
			ARRAY TEXT:C222($aTextValues2;Records in selection:C76($tablePointer->))
			KRL_Array2Selection (->$aTextValues2;$fieldPointer)
			KRL_Array2Selection (->$aTextValues;$fieldPointer)
			
		: ($fieldType=Is date:K8:7)
			SELECTION TO ARRAY:C260($fieldPointer->;$aDateValues)
			ARRAY DATE:C224($aDateValues2;Records in selection:C76($tablePointer->))
			KRL_Array2Selection (->$aDateValues2;$fieldPointer)
			KRL_Array2Selection (->$aDateValues;$fieldPointer)
			
		: ($fieldType=Is time:K8:8)
			ARRAY LONGINT:C221($aLongintValues2;Records in selection:C76($tablePointer->))
			SELECTION TO ARRAY:C260($fieldPointer->;$aLongintValues)
			KRL_Array2Selection (->$aLongintValues2;$fieldPointer)
			KRL_Array2Selection (->$aLongintValues;$fieldPointer)
			
		: ($fieldType=Is boolean:K8:9)
			ARRAY BOOLEAN:C223($aBooleanValues2;Records in selection:C76($tablePointer->))
			SELECTION TO ARRAY:C260($fieldPointer->;$aBooleanValues)
			KRL_Array2Selection (->$aBooleanValues2;$fieldPointer)
			KRL_Array2Selection (->$aBooleanValues;$fieldPointer)
			
		Else 
			TRACE:C157
	End case 
	
	0xDev_AvoidTriggerExecution (False:C215)
End if 

