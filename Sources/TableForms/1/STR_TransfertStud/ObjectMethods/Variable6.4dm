C_LONGINT:C283($i)

$r:=AL_GetSelect (xALP_Trans1;alLines)
ARRAY LONGINT:C221($aIdAlumnos;Size of array:C274(alLines))
For ($i;1;Size of array:C274(alLines))
	$aIdAlumnos{$i}:=<>aStdID{alLines{$i}}
End for 
AL_TransfiereSeleccion (->$aIdAlumnos)
