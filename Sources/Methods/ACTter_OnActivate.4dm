//%attributes = {}
  //ACTter_OnActivate

If (Record number:C243([ACT_Terceros:138])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo Registro"))
Else 
	SET WINDOW TITLE:C213(__ ("Tercero: ")+[ACT_Terceros:138]Nombre_Completo:9)
End if 