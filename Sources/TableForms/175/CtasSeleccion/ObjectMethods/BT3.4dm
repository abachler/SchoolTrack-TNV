ARRAY LONGINT:C221(al_NumAlumnos;0)
For ($i;1;Size of array:C274(abACT_PrintItem))
	If (abACT_PrintItem{$i})
		APPEND TO ARRAY:C911(al_NumAlumnos;al_NumAlumno{$i})
	End if 
End for 

vb_continue:=True:C214

