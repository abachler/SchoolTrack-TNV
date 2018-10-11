//%attributes = {}
  //KRL_SortOnExternalTableField

  //KRNL_SortOnExternalTableField(->[Invoices];->[Customers]CustomerName)

  // Method SORT_SortOnExternalTableField(Pointer;Pointer) 

C_POINTER:C301($1;$SortBaseTable_ptr;$2;$SortColumnField_ptr)
C_LONGINT:C283($3;$Direction_l;$FieldType_l)
C_BOOLEAN:C305($MakeSelection_b)

ARRAY LONGINT:C221($RecNums_al;0)
ARRAY TEXT:C222($ToSort_at;0)
ARRAY LONGINT:C221($ToSort_al;0)
ARRAY INTEGER:C220($ToSort_ai;0)
ARRAY REAL:C219($ToSort_ar;0)
ARRAY DATE:C224($ToSort_ad;0)
ARRAY BOOLEAN:C223($ToSort_ab;0)

$SortBaseTable_ptr:=$1
$SortColumnField_ptr:=$2
If (Count parameters:C259>2)
	$Direction_l:=$3
Else 
	$Direction_l:=0
End if 

$FieldType_l:=Type:C295($SortColumnField_ptr->)
$MakeSelection_b:=True:C214

Case of 
	: ($FieldType_l=Is integer:K8:5)
		SELECTION TO ARRAY:C260($SortBaseTable_ptr->;$RecNums_al;$SortColumnField_ptr->;$ToSort_ai)
		If ($Direction_l=0)
			SORT ARRAY:C229($ToSort_ai;$RecNums_al;>)
		Else 
			SORT ARRAY:C229($ToSort_ai;$RecNums_al;<)
		End if 
		
	: ($FieldType_l=Is longint:K8:6) | ($FieldType_l=Is time:K8:8)
		SELECTION TO ARRAY:C260($SortBaseTable_ptr->;$RecNums_al;$SortColumnField_ptr->;$ToSort_al)
		If ($Direction_l=0)
			SORT ARRAY:C229($ToSort_al;$RecNums_al;>)
		Else 
			SORT ARRAY:C229($ToSort_al;$RecNums_al;<)
		End if 
		
	: ($FieldType_l=Is alpha field:K8:1) | ($FieldType_l=Is text:K8:3)
		SELECTION TO ARRAY:C260($SortBaseTable_ptr->;$RecNums_al;$SortColumnField_ptr->;$ToSort_at)
		If ($Direction_l=0)
			SORT ARRAY:C229($ToSort_at;$RecNums_al;>)
		Else 
			SORT ARRAY:C229($ToSort_at;$RecNums_al;<)
		End if 
		
	: ($FieldType_l=Is real:K8:4)
		SELECTION TO ARRAY:C260($SortBaseTable_ptr->;$RecNums_al;$SortColumnField_ptr->;$ToSort_ar)
		If ($Direction_l=0)
			SORT ARRAY:C229($ToSort_ar;$RecNums_al;>)
		Else 
			SORT ARRAY:C229($ToSort_ar;$RecNums_al;<)
		End if 
		
	: ($FieldType_l=Is date:K8:7)
		SELECTION TO ARRAY:C260($SortBaseTable_ptr->;$RecNums_al;$SortColumnField_ptr->;$ToSort_ad)
		If ($Direction_l=0)
			SORT ARRAY:C229($ToSort_ad;$RecNums_al;>)
		Else 
			SORT ARRAY:C229($ToSort_ad;$RecNums_al;<)
		End if 
		
	: ($FieldType_l=Is boolean:K8:9)
		SELECTION TO ARRAY:C260($SortBaseTable_ptr->;$RecNums_al;$SortColumnField_ptr->;$ToSort_ab)
		If ($Direction_l=0)
			SORT ARRAY:C229($ToSort_ab;$RecNums_al;>)
		Else 
			SORT ARRAY:C229($ToSort_ab;$RecNums_al;<)
		End if 
		
	Else 
		$MakeSelection_b:=False:C215
End case 

If ($MakeSelection_b)
	CREATE SELECTION FROM ARRAY:C640($SortBaseTable_ptr->;$RecNums_al)
End if 