
$l_linea:=LISTBOX Get rows height:C836(lb_reemplazo;lk lines:K53:23)
If ($l_linea>1)
	LISTBOX SET ROWS HEIGHT:C835(lb_reemplazo;$l_linea-1;lk lines:K53:23)
End if 