//%attributes = {}
  //BWR_SetDataPointers

C_LONGINT:C283(vLBWR_HideCol)
_O_C_STRING:C293(35;vsBWR_defaultInputForm)


vlBWR_SelectedTableRef:=Table:C252(yBWR_currentTable)  //copyng IP var into global var

BWR_GetPanelSettings (vlBWR_CurrentModuleRef;vlBWR_SelectedTableRef)


$countText:=0
$countString:=0
$countDate:=0
$countReal:=0
$countInteger:=0
$countLongint:=0
$countBoolean:=0
$columns:=Size of array:C274(alVS_FieldNumber)+1
ARRAY POINTER:C280(ayBWR_FieldPointers;$columns)
ARRAY POINTER:C280(ayBWR_ArrayPointers;$columns)
ARRAY TEXT:C222(atBWR_ArrayNames;$columns)
For ($i;1;Size of array:C274(alVS_FieldNumber))
	ayBWR_FieldPointers{$i}:=Field:C253(alVS_TableNumber{$i};alVS_FieldNumber{$i})
	Case of 
		: (Type:C295(ayBWR_FieldPointers{$i}->)=Is alpha field:K8:1)
			$countString:=$countString+1
			atBWR_ArrayNames{$i}:="asBWR_array"+String:C10($countString)
			ayBWR_ArrayPointers{$i}:=Get pointer:C304(atBWR_ArrayNames{$i})
		: (Type:C295(ayBWR_FieldPointers{$i}->)=Is text:K8:3)
			$countText:=$countText+1
			atBWR_ArrayNames{$i}:="atBWR_array"+String:C10($countText)
			ayBWR_ArrayPointers{$i}:=Get pointer:C304(atBWR_ArrayNames{$i})
		: (Type:C295(ayBWR_FieldPointers{$i}->)=Is integer:K8:5)
			$countInteger:=$countInteger+1
			atBWR_ArrayNames{$i}:="aiBWR_array"+String:C10($countInteger)
			ayBWR_ArrayPointers{$i}:=Get pointer:C304(atBWR_ArrayNames{$i})
		: (Type:C295(ayBWR_FieldPointers{$i}->)=Is longint:K8:6)
			$countLongint:=$countLongint+1
			atBWR_ArrayNames{$i}:="alBWR_array"+String:C10($countLongint)
			ayBWR_ArrayPointers{$i}:=Get pointer:C304(atBWR_ArrayNames{$i})
		: (Type:C295(ayBWR_FieldPointers{$i}->)=Is real:K8:4)
			$countReal:=$countReal+1
			atBWR_ArrayNames{$i}:="arBWR_array"+String:C10($countReal)
			ayBWR_ArrayPointers{$i}:=Get pointer:C304(atBWR_ArrayNames{$i})
		: (Type:C295(ayBWR_FieldPointers{$i}->)=Is date:K8:7)
			$countDate:=$countDate+1
			atBWR_ArrayNames{$i}:="adBWR_array"+String:C10($countDate)
			ayBWR_ArrayPointers{$i}:=Get pointer:C304(atBWR_ArrayNames{$i})
		: (Type:C295(ayBWR_FieldPointers{$i}->)=Is boolean:K8:9)
			$countBoolean:=$countBoolean+1
			atBWR_ArrayNames{$i}:="abBWR_array"+String:C10($countBoolean)
			ayBWR_ArrayPointers{$i}:=Get pointer:C304(atBWR_ArrayNames{$i})
	End case 
	AT_Initialize (ayBWR_ArrayPointers{$i})  //23/08
End for 
ayBWR_FieldPointers{$columns}:=yBWR_currentTable
atBWR_ArrayNames{$columns}:="alBWR_recordNumber"
ayBWR_ArrayPointers{$columns}:=->alBWR_recordNumber