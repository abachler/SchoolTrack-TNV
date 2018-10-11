//%attributes = {}
  //ACTter_ProcesaBusquedaCtas

AL_UpdateArrays (xALP_List;0)

ACTter_Datos_ALP ("DeclaraArraysAreaInscAlumnos")
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aIDsAlumnos;[Alumnos:2]apellidos_y_nombres:40;atACT_CCAlumno;[Alumnos:2]curso:20;atACT_CCCurso)

READ ONLY:C145([ACT_Terceros_Pactado:139])
QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1)
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_idsAlumnosYaInscritos)
For ($i;Size of array:C274(aIDsAlumnos);1;-1)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=aIDsAlumnos{$i})
	If ((Find in array:C230($al_idsAlumnosYaInscritos;aIDsAlumnos{$i})>0) | (Records in selection:C76([ACT_CuentasCorrientes:175])=0))
		AT_Delete ($i;1;->aIDsAlumnos;->atACT_CCAlumno;->atACT_CCCurso)
	End if 
End for 

AL_UpdateArrays (xALP_List;-2)
AL_SetSort (xALP_List;1)
ARRAY INTEGER:C220(aSelect;0)
AL_SetSelect (xALP_List;aSelect)