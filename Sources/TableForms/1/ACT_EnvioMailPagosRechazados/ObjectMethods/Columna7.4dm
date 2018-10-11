C_LONGINT:C283($l_col;$l_line)
If (Form event:C388=On Data Change:K2:15)
	LISTBOX GET CELL POSITION:C971(lb_ACTepr_Apoderados;$l_col;$l_line)
	If ($l_line>0)
		If (abACTepr_Enviar{$l_line})
			If (alACTepr_Colores{$l_line}#0)
				abACTepr_Enviar{$l_line}:=False:C215
				BEEP:C151
			End if 
		End if 
	End if 
End if 