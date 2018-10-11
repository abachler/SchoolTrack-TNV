//%attributes = {}
  //ACTpagares_AnularPagares
C_LONGINT:C283($err;$i;$r;$rslt)

If (USR_GetMethodAcces (Current method name:C684))
	If (Size of array:C274(abrSelect)>0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		$err:=BWR_SearchRecords 
	Else 
		CD_Dlog (0;__ ("Seleccione previamente los registros que desea anular."))
		USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	End if 
	
	
	
	If (USR_checkRights ("D";->[ACT_Pagares:184]))
		If (Records in selection:C76([ACT_Pagares:184])>0)
			$r:=CD_Dlog (0;__ ("¿Desea realmente anular los registros seleccionados? Esta operación es irreversible.");__ ("");__ ("No");__ ("Si"))
			If ($r=2)
				ARRAY LONGINT:C221($aRecNumPagares;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Pagares:184];$aRecNumPagares;"")
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Anulando Pagarés..."))
				For ($i;1;Size of array:C274($aRecNumPagares))
					READ WRITE:C146([ACT_Pagares:184])
					GOTO RECORD:C242([ACT_Pagares:184];$aRecNumPagares{$i})
					ACTcfg_OpcionesPagares ("AnulaPagare";->[ACT_Pagares:184]ID:12)
					KRL_UnloadReadOnly (->[ACT_Pagares:184])
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNumPagares))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
				BWR_PanelSettings 
				BWR_SelectTableData 
			End if 
		End if 
	Else 
		USR_ALERT_UserHasNoRights (3)
	End if 
End if 