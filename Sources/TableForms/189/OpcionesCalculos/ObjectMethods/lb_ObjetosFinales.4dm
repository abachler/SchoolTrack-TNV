  //[MPA_AsignaturasMatrices].OpcionesCalculos.lb_ObjetosFinales

C_POINTER:C301($y_objectEdited)
C_LONGINT:C283($l_rowEdited)


$l_rowEdited:=LBX_HandleEvents ("lb_ObjetosFinales";->$y_objectEdited)

If ($l_RowEdited>0)
	vb_CalculoResultadoFinal:=True:C214
End if 
