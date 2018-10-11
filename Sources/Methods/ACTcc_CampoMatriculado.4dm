//%attributes = {}
  //ACTcc_CampoMatriculado

If (Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))=1)
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
	OBJECT SET VISIBLE:C603(*;"ACT_Matriculado@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"ACT_Matriculado@";False:C215)
End if 