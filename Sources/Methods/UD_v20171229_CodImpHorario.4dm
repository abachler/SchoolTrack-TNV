//%attributes = {}
  //UD_v20171229_CodImpHorario 
  //MONO: Agrego una nueva propiedad al objeto opciones de asignatura, para registrar un codigo de importación para horarios y así relacionarlos con las asignaturas.

ARRAY LONGINT:C221($al_recnumAsig;0)
C_LONGINT:C283($i;$l_idTermometro)

$l_idTermometro:=IT_Progress (1;0;0;"Inicializando Código de Importación de Horario:")

READ ONLY:C145([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recnumAsig;"")
<>vb_AvoidTriggerExecution:=True:C214
For ($i;1;Size of array:C274($al_recnumAsig))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$al_recnumAsig{$i})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recnumAsig))
	OB SET:C1220([Asignaturas:18]Opciones:57;"impHorarioCode";"")
	If (<>gRolBD="89796") | (<>gRolBD="112233QA8")  //Colegio Alemán de Santiago y Rol utilizado en pruebas.
		OB SET:C1220([Asignaturas:18]Opciones:57;"impHorarioCode";[Asignaturas:18]Codigo_interno:48)
		[Asignaturas:18]Codigo_interno:48:=""
	End if 
	SAVE RECORD:C53([Asignaturas:18])
	KRL_UnloadReadOnly (->[Asignaturas:18])
End for 
<>vb_AvoidTriggerExecution:=False:C215
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)