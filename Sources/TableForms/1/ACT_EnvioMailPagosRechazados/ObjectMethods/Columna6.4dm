C_BOOLEAN:C305(b_editado)
C_LONGINT:C283($l_col;$l_line)
b_Maileditado:=False:C215
If (Form event:C388=On Data Change:K2:15)
	LISTBOX GET CELL POSITION:C971(lb_ACTepr_Apoderados;$l_col;$l_line)
	b_Maileditado:=True:C214
	If ($l_line>0)
		If (MAIL_VerifyAddress (atACTepr_EmailApoderado{$l_line})#"")
			alACTepr_Colores{$l_line}:=0
			abACTepr_Enviar{$l_line}:=True:C214
			alACTepr_Colores{$l_line}:=0
		Else 
			alACTepr_Colores{$l_line}:=16711680
			abACTepr_Enviar{$l_line}:=False:C215
			atACTepr_EmailApoderado{$l_line}:=""
		End if 
	End if 
End if 