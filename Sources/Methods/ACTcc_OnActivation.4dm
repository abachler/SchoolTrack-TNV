//%attributes = {}
  //ACTcc_OnActivation

If (Record number:C243([ACT_CuentasCorrientes:175])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo alumno"))
Else 
	SET WINDOW TITLE:C213(__ ("Cuentas corrientes: ")+[Alumnos:2]Nombre_Común:30+", "+[Alumnos:2]curso:20)
End if 
BWR_SetInputFormButtons 