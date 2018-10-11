$choice:=Pop up menu:C542(vt_MatrixMenu)

If ($choice>0)
	vsACT_Matriz:=atACT_Matrices{$choice}
	vlACT_IDMatriz:=<>alACT_MatrixID{$choice}
End if 