//%attributes = {}
  //ACTcc_BuscaCuentasXSede

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")