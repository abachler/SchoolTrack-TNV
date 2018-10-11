ARRAY LONGINT:C221($selected;0)
LB_GetSelectedRows (->lb_AlumnosABS;->$selected)
If (Size of array:C274($selected)>0)
	For ($i;Size of array:C274($selected);1;-1)
		AT_Delete ($selected{$i};1;->atABS_Alumnos;->alABS_AlumnosID)
	End for 
End if 
LISTBOX SELECT ROW:C912(lb_AlumnosABS;0;lk remove from selection:K53:3)
OBJECT SET ENABLED:C1123(bDelLines;False:C215)
OBJECT SET ENABLED:C1123(bOK;(Size of array:C274(atABS_Alumnos)>0))