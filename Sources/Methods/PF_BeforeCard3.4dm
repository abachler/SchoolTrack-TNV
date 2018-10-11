//%attributes = {}
  //PF_BeforeCard3

xALP_Set_StudTutorias 

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_Conducta:8])
READ ONLY:C145([Alumnos_Calificaciones:208])

QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=[Profesores:4]Numero:1)
CREATE SET:C116([Alumnos:2];"tutorias")
SELECTION TO ARRAY:C260([Alumnos:2]curso:20;aStdClass;[Alumnos:2]apellidos_y_nombres:40;aStdName;[Alumnos:2];aStdRecNo)
AL_UpdateArrays (xALP_Students;-2)
If (Size of array:C274(aStdRecNo)>0)
	AL_SetLine (xALP_Students;1)
	GOTO RECORD:C242([Alumnos:2];aStdRecNo{1})
	PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	  //PF_SetTutoriasPages 
	QUERY:C277([Alumnos_Conducta:8];[Alumnos_Conducta:8]Número_de_Alumno:1=[Alumnos:2]numero:1)
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Asignatura:3;>)
End if 
SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_Tutorias;1)
vs_NewStudent:=""
vl_NewStudent:=0

PF_TutoriasTabBrowser 