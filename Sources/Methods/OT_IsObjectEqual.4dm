//%attributes = {}
  //OT_IsObjectEqual

C_LONGINT:C283($objet1;$1;$object2;$2)
C_BOOLEAN:C305($objectIsEqual;$0)
$object1:=$1
$object2:=$2
$objectIsEqual:=True:C214

If ((OT IsObject ($object1)=1) & (OT IsObject ($object2)=1))
	
	ARRAY TEXT:C222($aObject1_ItemNames;0)
	ARRAY TEXT:C222($aObject2_ItemNames;0)
	ARRAY LONGINT:C221($aObject1_ItemTypes;0)
	ARRAY LONGINT:C221($aObject2_ItemTypes;0)
	ARRAY LONGINT:C221($aObject1_ItemSizes;0)
	ARRAY LONGINT:C221($aObject2_ItemSizes;0)
	ARRAY LONGINT:C221($aObject1_ItemDataSizes;0)
	ARRAY LONGINT:C221($aObject2_ItemDataSizes;0)
	
	OT GetAllProperties ($object1;$aObject1_ItemNames;$aObject1_ItemTypes;$aObject1_ItemSizes;$aObject1_ItemDataSizes)
	SORT ARRAY:C229($aObject1_ItemNames;$aObject1_ItemTypes;$aObject1_ItemSizes;$aObject1_ItemDataSizes;>)
	OT GetAllProperties ($object2;$aObject2_ItemNames;$aObject2_ItemTypes;$aObject2_ItemSizes;$aObject2_ItemDataSizes)
	SORT ARRAY:C229($aObject2_ItemNames;$aObject2_ItemTypes;$aObject2_ItemSizes;$aObject2_ItemDataSizes;>)
	
	If (AT_IsEqual (->$aObject1_ItemNames;->$aObject2_ItemNames)=1)
		For ($i;1;Size of array:C274($aObject1_ItemNames))
			$tag1:=$aObject1_ItemNames{$i}
			$tag2:=$aObject2_ItemNames{$i}
			$itemsAreEqual:=OT CompareItems ($object1;$tag1;$object2;$tag2)
			If ($itemsAreEqual<1)
				$objectIsEqual:=False:C215
				$i:=Size of array:C274($aObject1_ItemNames)
			End if 
		End for 
	Else 
		$objectIsEqual:=False:C215
	End if 
	
Else 
	$objectIsEqual:=False:C215
End if 
