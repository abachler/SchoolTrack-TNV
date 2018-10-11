//%attributes = {}
  //ACTmnu_RecalculaSaldoApdo

C_TEXT:C284($set)
C_BOOLEAN:C305($display)
C_REAL:C285($saldo)
C_LONGINT:C283($i)
ARRAY LONGINT:C221($aI_recNums;0)
ARRAY LONGINT:C221($aI_idsPersonas;0)
ARRAY TEXT:C222($at_nombres;0)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])

$set:="$RecordSet_Table"+String:C10(Table:C252(->[Personas:7]))
USE SET:C118($set)
BWR_SearchRecords 
SELECTION TO ARRAY:C260([Personas:7];$aI_recNums;[Personas:7]Apellidos_y_nombres:30;$at_nombres;[Personas:7]No:1;$aI_idsPersonas)
$display:=Size of array:C274($aI_recNums)>10
If ($display)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando cuenta: "))
End if 
For ($i;1;Size of array:C274($aI_recNums))
	$done:=ACTpp_RecalculaSaldoApdo ($aI_recNums{$i})
	If (Not:C34($done))
		BM_CreateRequest ("ACTpp_Calcula_Montos_Ejercicio";String:C10($aI_recNums{$i}))
	End if 
	If ($display)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aI_recNums);__ ("Recalculando saldo apoderado: ")+$at_nombres{$i})
	End if 
End for 
If ($display)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
ACTter_RecalculaSaldo (->$aI_idsPersonas)

POST KEY:C465(-96)

