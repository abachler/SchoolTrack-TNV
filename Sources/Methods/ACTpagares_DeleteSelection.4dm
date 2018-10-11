//%attributes = {}
  //ACTpgs_DeleteSelection
C_LONGINT:C283($0;$r;$i)
C_BOOLEAN:C305($vb_mostrarAlerta;$vb_mensajeNoNulo;$vb_mensajeLocked)

If (USR_checkRights ("D";->[ACT_Pagares:184]))
	If (Records in selection:C76([ACT_Pagares:184])>0)
		$r:=CD_Dlog (0;__ ("Los registros serán eliminados definitivamente sin ninguna verificación adicional.\r¿Desea realmente eliminar los registros seleccionados?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			ARRAY LONGINT:C221($alACT_recNums;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagares:184];$alACT_recNums;"")
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Eliminando Pagarés..."))
			ARRAY LONGINT:C221($al_idsCtasTotal;0)
			For ($i;1;Size of array:C274($alACT_recNums))
				READ WRITE:C146([ACT_Pagares:184])
				GOTO RECORD:C242([ACT_Pagares:184];$alACT_recNums{$i})
				$vl_ok:=Num:C11(ACTcfg_OpcionesPagares ("ValidaEliminacion";->[ACT_Pagares:184]ID:12;->$vb_mostrarAlerta))
				If ($vl_ok=1)
					ACTcfg_OpcionesPagares ("EliminaPagare";->[ACT_Pagares:184]ID:12)
				Else 
					Case of 
						: ($vl_ok=2)
							$vb_mensajeNoNulo:=True:C214
						: ($vl_ok=3)
							$vb_mensajeLocked:=True:C214
					End case 
				End if 
				KRL_UnloadReadOnly (->[ACT_Pagares:184])
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNums))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			Case of 
				: ($vb_mensajeNoNulo)
					CD_Dlog (0;__ ("Algunos registros no pueden ser eliminados debido a que no tienen el estado Nulo."))
					
				: ($vb_mensajeLocked)
					CD_Dlog (0;__ ("Algunos registros no pueden ser eliminados debido a que están siendo utilizados por otros procesos."))
					
			End case 
			
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 