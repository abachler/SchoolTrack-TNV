//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 03-10-18, 11:35:18
  // ----------------------------------------------------
  // Método: UD_v20181003_ControlAobjeto
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_BLOB:C604($x_blob)
C_LONGINT:C283($l_otRef;$l_progress;$l_indice)
C_OBJECT:C1216($o_nuevoObjeto;$o_temporal)

ARRAY LONGINT:C221($al_recNumAsignaturas;0)
ARRAY LONGINT:C221($al_tipoItems;0)
ARRAY TEXT:C222($at_NombreItems;0)

READ WRITE:C146([Asignaturas:18])

ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18];$al_recNumAsignaturas)

$l_progress:=IT_Progress (1;0;0;"Exportando configuración de controles y exámenes")
For ($l_indice;1;Size of array:C274($al_recNumAsignaturas))
	GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$l_indice})
	$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($al_recNumAsignaturas);"Exportando configuración de controles y exámenes asignatura: "+[Asignaturas:18]Asignatura:3)
	$x_blob:=[Asignaturas:18]OpcionesControles_y_Examenes:106
	If (BLOB size:C605($x_blob)>0)
		$l_otRef:=OT BLOBToObject ($x_blob)
		$o_temporal:=UD_CreaObjetoDesdeOT ($l_otRef)
		OB SET:C1220([Asignaturas:18]Opciones:57;"controles_y_examenes";$o_temporal)
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	CLEAR VARIABLE:C89($o_temporal)
	
End for 
$l_progress:=IT_Progress (-1;$l_progress)
KRL_UnloadReadOnly (->[Asignaturas:18])


