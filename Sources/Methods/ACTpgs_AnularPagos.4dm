//%attributes = {}
  //ACTpgs_AnularPagos

If (USR_GetMethodAcces (Current method name:C684))
	
	If (Size of array:C274(abrSelect)>0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		$err:=BWR_SearchRecords 
	Else 
		CD_Dlog (0;__ ("Seleccione previamente los pagos que desea anular."))
		USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
		
		
		  //20110123 RCH. Podian haber pagos en seleccion...
		REDUCE SELECTION:C351([ACT_Pagos:172];0)
		
	End if 
	
	If (USR_checkRights ("D";->[ACT_Pagos:172]))
		If (Records in selection:C76([ACT_Pagos:172])>0)
			$r:=CD_Dlog (0;__ ("¿Desea realmente anular los pagos seleccionados? Esta operación es irreversible.\r\rRecuerde que los pagos realizados con documentos que ya han sido depositados no serán anulados.");__ ("");__ ("No");__ ("Si"))
			If ($r=2)
				ARRAY LONGINT:C221($aRecNumPagos;0)
				SELECTION TO ARRAY:C260([ACT_Pagos:172];$aRecNumPagos)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Anulando Pagos..."))
				For ($i;1;Size of array:C274($aRecNumPagos))
					$ok:=ACTpgs_AnulaPago ($aRecNumPagos{$i})
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNumPagos);__ ("Anulando Pagos..."))
					If ($ok=0)
						$i:=Size of array:C274($aRecNumPagos)
					End if 
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				If ($ok=1)
					USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
					BWR_PanelSettings 
					BWR_SelectTableData 
				End if 
			End if 
		End if 
	Else 
		USR_ALERT_UserHasNoRights (3)
	End if 
End if 