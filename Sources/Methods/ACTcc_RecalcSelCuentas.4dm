//%attributes = {}
  //ACTcc_RecalcSelCuentas

C_BOOLEAN:C305($1;$display)

If (Count parameters:C259=1)
	$display:=$1
Else 
	$display:=True:C214
End if 


$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_CuentasCorrientes:175]))
USE SET:C118($set)
BWR_SearchRecords 
ARRAY LONGINT:C221($aIDs;0)
ARRAY TEXT:C222($aNombre;0)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$aIDs;[Alumnos:2]apellidos_y_nombres:40;$aNombres)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
If ($display)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando cuenta: "))
End if 
For ($i;1;Size of array:C274($aIDs))
	If ($display)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aIDs);__ ("Recalculando cuenta: ")+$aNombres{$i})
	End if 
	ACTcc_CalculaMontos ($aIDs{$i})
End for 
If ($display)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
POST KEY:C465(-96)