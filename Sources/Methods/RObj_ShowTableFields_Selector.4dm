//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Alberto Bachler
  // Date and time: 03/01/11, 10:23:53
  // ----------------------------------------------------
  // Method: RObj_ShowTableFields_Selector
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------




C_POINTER:C301($nil;$2;vyTableNumber;$3;vyFieldNumber)
C_LONGINT:C283(hl_Tables;hl_Fields)
C_LONGINT:C283(vlVS_CurrentTableNum;$vlVS_FieldSelectorOptions)


$vlVS_FieldSelectorOptions:=$1
vyTableNumber:=$2
vyFieldNumber:=$3

If (Count parameters:C259=4)
	vlVS_CurrentTableNum:=$4
End if 

If (vlVS_CurrentTableNum=0)
	vlVS_CurrentTableNum:=vlBWR_SelectedTableRef
End if 

RObj_BuildTableFieldsLists ($vlVS_FieldSelectorOptions)

WDW_OpenFormWindow ($nil;"SR_Tables_and_Fields";-1;8)
DIALOG:C40("SR_Tables_and_Fields")
CLOSE WINDOW:C154

HL_ClearList (hl_Tables;hl_Fields)
