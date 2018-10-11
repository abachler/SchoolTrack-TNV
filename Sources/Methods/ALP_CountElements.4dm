//%attributes = {}
  //ALP_CountElements

  //ALP_IsAreaEmpty


C_LONGINT:C283($0)


$areaRef:=$1

ARRAY TEXT:C222($aArrayNames;0)
$err:=AL_GetArrayNames ($areaRef;$aArrayNames)
If ($err=0)
	If (Size of array:C274($aArrayNames)>0)
		$arrayPointer:=Get pointer:C304($aArrayNames{1})
		$0:=Size of array:C274($arrayPointer->)
	End if 
End if 
