//%attributes = {}
  //ACTter_ActualizaNombreCompleto

If ([ACT_Terceros:138]Es_empresa:2)
	[ACT_Terceros:138]Nombre_Completo:9:=ST_Format (->[ACT_Terceros:138]Razon_Social:3)
Else 
	[ACT_Terceros:138]Nombre_Completo:9:=[ACT_Terceros:138]Apellido_Paterno:16+" "+[ACT_Terceros:138]Apellido_Materno:17+" "+[ACT_Terceros:138]Nombres:18
	[ACT_Terceros:138]Nombre_Completo:9:=ST_Format (->[ACT_Terceros:138]Nombre_Completo:9)
End if 