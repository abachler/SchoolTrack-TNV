//%attributes = {}
  //ACTcc_OnActivate

If (Record number:C243([ACT_CuentasCorrientes:175])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva Cuenta Corriente"))
Else 
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	SET WINDOW TITLE:C213(__ ("Cuentas Corrientes: ")+[Alumnos:2]apellidos_y_nombres:40)
End if 
