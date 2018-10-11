C_LONGINT:C283($vCol;$vRow)
LISTBOX GET CELL POSITION:C971(*;"lb_IECV";$vCol;$vRow)
If ($vRow>0)
	ACTdte_OpcionesGeneralesIE ("EliminaElemento";->$vRow)
	ACTmnu_OpcionesGeneracionIECV ("ValidaDatos")
End if 