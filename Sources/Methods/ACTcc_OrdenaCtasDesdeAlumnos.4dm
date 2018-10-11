//%attributes = {}
  //ACTcc_OrdenaCtasDesdeAlumnos

ARRAY LONGINT:C221($al_idsAlumnos;0)
ARRAY LONGINT:C221($al_recNumsCtas;0)
ARRAY LONGINT:C221($al_idsAlumnosCtas;0)

SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];$al_recNumsCtas;[ACT_CuentasCorrientes:175]ID_Alumno:3;$al_idsAlumnosCtas)
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_idsAlumnos)

AT_OrderArraysByArray (MAXLONG:K35:2;->$al_idsAlumnos;->$al_idsAlumnosCtas;->$al_recNumsCtas)

CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];$al_recNumsCtas;"")

FIRST RECORD:C50([Alumnos:2])
FIRST RECORD:C50([ACT_CuentasCorrientes:175])