  //[MPA_AsignaturasMatrices].OpcionesCalculos.lb_ObjetosEje

C_POINTER:C301($y_objectEdited)
C_LONGINT:C283($l_rowEdited)


$l_rowEdited:=LBX_HandleEvents ("lb_ObjetosEje";->$y_objectEdited)

If ($l_RowEdited>0)
	vb_CalculoEjes:=True:C214
End if 
