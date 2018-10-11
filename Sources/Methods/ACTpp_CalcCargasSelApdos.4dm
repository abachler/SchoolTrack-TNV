//%attributes = {}
  //ACTpp_CalcCargasSelApdos

C_BOOLEAN:C305($1;$display)

If (Count parameters:C259=1)
	$display:=$1
Else 
	$display:=True:C214
End if 

$set:="$RecordSet_Table"+String:C10(Table:C252(->[Personas:7]))
USE SET:C118($set)
BWR_SearchRecords 
ARRAY LONGINT:C221($aIDs;0)
ARRAY TEXT:C222($aNombre;0)
SELECTION TO ARRAY:C260([Personas:7]No:1;$aIDs;[Personas:7]Apellidos_y_nombres:30;$aNombres)
If ($display)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando cargas para: "))
End if 
For ($i;1;Size of array:C274($aIDs))
	If ($display)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aIDs);__ ("Calculando cargas para: ")+$aNombres{$i})
	End if 
	$locked:=Not:C34(ACTpp_CalculaNoCargas ($aIDs{$i}))
	If ($locked)
		BM_CreateRequest ("ACT_RecalculaCargas";String:C10($aIDs{$i}))
	End if 
End for 
If ($display)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
BWR_PanelSettings 
BWR_SelectTableData 

