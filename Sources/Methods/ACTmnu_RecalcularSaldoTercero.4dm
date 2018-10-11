//%attributes = {}
  //ACTmnu_RecalcularSaldoTercero

C_TEXT:C284($set)
C_BOOLEAN:C305($display)
C_REAL:C285($saldo)
C_LONGINT:C283($i)
ARRAY LONGINT:C221($al_idsTerceros;0)
ARRAY TEXT:C222($at_nombres;0)

READ ONLY:C145([ACT_Terceros:138])
$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_Terceros:138]))
USE SET:C118($set)

BWR_SearchRecords 
SELECTION TO ARRAY:C260([ACT_Terceros:138]Id:1;$al_idsTerceros;[ACT_Terceros:138]Nombre_Completo:9;$at_nombres)

$display:=Size of array:C274($al_idsTerceros)>10
If ($display)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando cuenta: "))
End if 

For ($i;1;Size of array:C274($al_idsTerceros))
	$done:=ACTter_ActualizaValores ($al_idsTerceros{$i})
	If (Not:C34($done))
		BM_CreateRequest ("ACTter_ActualizaValores";String:C10($al_idsTerceros{$i});String:C10($al_idsTerceros{$i}))
	End if 
	If ($display)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_idsTerceros);__ ("Recalculando saldo apoderado: ")+$at_nombres{$i})
	End if 
End for 

If ($display)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
POST KEY:C465(-96)