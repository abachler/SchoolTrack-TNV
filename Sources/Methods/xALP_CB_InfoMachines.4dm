//%attributes = {}
  //xALP_CB_InfoMachines

C_BOOLEAN:C305($0)
C_LONGINT:C283($area;$1;$column;$2;$dataType;$3;$first;$5;$last;$6)
C_POINTER:C301($arrayPointer;$4)
$area:=$1
$column:=$2
$dataType:=$3
$first:=$5
$last:=$6
$arrayPointer:=$4

If ($column=7)
	SELECTION RANGE TO ARRAY:C368($first;$first+$last-1;[xShell_InfoMachines:151]AppDisk_FreeSpace_Gb:15;$free;[xShell_InfoMachines:151]AppDisk_Capacity_Gb:14;$capacity)
	For ($i;1;$last)
		$arrayPointer->{$i}:=String:C10($free{$i})+" / "+String:C10($capacity{$i})
	End for 
End if 