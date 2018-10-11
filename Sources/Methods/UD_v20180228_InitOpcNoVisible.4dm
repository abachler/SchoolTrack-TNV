//%attributes = {}

ARRAY LONGINT:C221($al_recNumAsignaturas;0)
C_OBJECT:C1216($o_Opciones)
C_LONGINT:C283($l_progres;$l_indice)
READ WRITE:C146([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18];$al_recNumAsignaturas)
$l_progres:=IT_Progress (1;0;0;__ ("Aplicando configuración..."))
For ($l_indice;1;Size of array:C274($al_recNumAsignaturas))
	GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$l_indice})
	$l_progres:=IT_Progress (0;$l_progres;$l_indice/Size of array:C274($al_recNumAsignaturas);__ ("Aplicando configuración en: ")+[Asignaturas:18]Asignatura:3)
	$o_Opciones:=[Asignaturas:18]Opciones:57
	OB SET:C1220($o_Opciones;"NoMostrarEnSTWA";False:C215)
	[Asignaturas:18]Opciones:57:=$o_Opciones
	SAVE RECORD:C53([Asignaturas:18])
End for 
$l_progres:=IT_Progress (-1;$l_progres)
KRL_UnloadReadOnly (->[Asignaturas:18])