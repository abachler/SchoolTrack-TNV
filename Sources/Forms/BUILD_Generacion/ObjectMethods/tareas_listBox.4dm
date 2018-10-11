  // GeneracionAplicacion.tareas_listBox()
  //
  //
  // creado por: Alberto Bachler Klein: 18-08-16, 17:32:57
  // -----------------------------------------------------------
C_LONGINT:C283($l_columna;$l_fila;$l_seleccion)

If (Contextual click:C713)
	$l_seleccion:=Pop up menu:C542("Ejecutar tarea")
	If ($l_seleccion=1)
		LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila)
		BUILD_ExecuteTask ($l_fila)
	End if 
End if 