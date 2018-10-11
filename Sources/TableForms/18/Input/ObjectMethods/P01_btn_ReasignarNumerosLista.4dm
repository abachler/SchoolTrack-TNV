AL_RemoveArrays (xALP_StdList;1;5)

$mode:=CD_Dlog (0;__ ("¿Desea Ud. reasignar el Nº de orden ordenando sólo por nombres o por curso y nombres?");"";__ ("Por curso y nombres");__ ("Sólo nombres");__ ("Cancelar"))

If ($mode#3)
	$recNum:=Record number:C243([Asignaturas:18])
	KRL_ReloadAsReadOnly (->[Asignaturas:18])
	$lastNumber:=AS_fmNosOrden ($mode)
	KRL_GotoRecord (->[Asignaturas:18];$recNum;True:C214)
	[Asignaturas:18]Numero_de_alumnos:49:=$lastNumber
	[Asignaturas:18]LastNumber:54:=$lastNumber
	SAVE RECORD:C53([Asignaturas:18])
End if 

AS_LoadStudentList 