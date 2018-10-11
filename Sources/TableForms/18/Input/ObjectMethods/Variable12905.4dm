Case of 
	: (Form event:C388=On Data Change:K2:15)
		vb_NoLimpiarCadena:=True:C214
End case 


C_POINTER:C301($ptr)
READ WRITE:C146([Asignaturas_PlanesDeClases:169])
LOAD RECORD:C52([Asignaturas_PlanesDeClases:169])
$page:=Selected list items:C379(vTab_Programas)
Case of 
	: ($page=1)
		$ptr:=->[Asignaturas_PlanesDeClases:169]Nota_al_Alumno:6
	: ($page=2)
		$ptr:=->[Asignaturas_PlanesDeClases:169]Objetivos:7
	: ($page=3)
		$ptr:=->[Asignaturas_PlanesDeClases:169]Contenidos:8
	: ($page=4)
		$ptr:=->[Asignaturas_PlanesDeClases:169]Actividades:9
	: ($page=6)
		$ptr:=->[Asignaturas_PlanesDeClases:169]Tareas:12
	: ($page=7)
		$ptr:=->[Asignaturas_PlanesDeClases:169]Intrumentos_evaluacion:11
End case 
Spell_CheckSpelling 
vbSpell_StopChecking:=True:C214
If (ST_ExactlyEqual ($ptr->;vtSTK_TextoPlanesDeClases)=0)
	$ptr->:=vtSTK_TextoPlanesDeClases
	SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
	  //MONO 193174
	$t_logmsj:="Planes de Clases: Modificación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
	$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
	$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
	LOG_RegisterEvt ($t_logmsj)
	KRL_ReloadAsReadOnly (->[Asignaturas_PlanesDeClases:169])
End if 