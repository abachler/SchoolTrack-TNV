//%attributes = {}
  //ACTter_RecalculaSaldo

C_BOOLEAN:C305($display;$vb_recalcularBash;$done)
C_LONGINT:C283($vl_idPersona)
C_POINTER:C301($ptr_idsApdos)
ARRAY LONGINT:C221($al_idsTerceros;0)
ARRAY LONGINT:C221($al_idTercero;0)
ARRAY LONGINT:C221($al_idsPersonas;0)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Terceros_Pactado:139])

$ptr_idsApdos:=$1
If (Count parameters:C259>=2)
	$vb_recalcularBash:=$2
End if 

If (Records in table:C83([ACT_Terceros:138])>0)
	For ($i;1;Size of array:C274($ptr_idsApdos->))
		$vl_idPersona:=$ptr_idsApdos->{$i}
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$vl_idPersona)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->[ACT_CuentasCorrientes:175]ID:1;"")
		AT_DistinctsFieldValues (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->$al_idTercero)
		For ($j;1;Size of array:C274($al_idTercero))
			If (Find in array:C230($al_idsTerceros;$al_idTercero{$j})=-1)
				APPEND TO ARRAY:C911($al_idsTerceros;$al_idTercero{$j})
			End if 
		End for 
	End for 
	
	
	$display:=Size of array:C274($al_idsTerceros)>10
	If ($display)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando saldos tercero..."))
	End if 
	For ($i;1;Size of array:C274($al_idsTerceros))
		If (Not:C34($vb_recalcularBash))
			$done:=ACTter_ActualizaValores ($al_idsTerceros{$i})
		End if 
		If (Not:C34($done))
			BM_CreateRequest ("ACTter_ActualizaValores";String:C10($al_idsTerceros{$i});String:C10($al_idsTerceros{$i}))
		End if 
		If ($display)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_idsTerceros);__ ("Recalculando saldos tercero..."))
		End if 
	End for 
	If ($display)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
End if 