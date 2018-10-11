//%attributes = {}
  //ACTpagares_Delete

C_LONGINT:C283($r;$0;$vl_ok)
C_BOOLEAN:C305($vb_mostrarAlerta)

If ([ACT_Pagares:184]ID:12>0)
	If (USR_checkRights ("D";->[ACT_Pagares:184]))
		$vb_mostrarAlerta:=True:C214
		$vl_ok:=Num:C11(ACTcfg_OpcionesPagares ("ValidaEliminacion";->[ACT_Pagares:184]ID:12;->$vb_mostrarAlerta))
		If ($vl_ok=1)
			$r:=CD_Dlog (0;__ ("¿Desea realmente eliminar el pagaré?");__ ("");__ ("No");__ ("Eliminar"))
			If ($r=2)
				ACTcfg_OpcionesPagares ("EliminaPagare";->[ACT_Pagares:184]ID:12)
				$0:=1
			End if 
		End if 
	Else 
		USR_ALERT_UserHasNoRights (3)
	End if 
End if 