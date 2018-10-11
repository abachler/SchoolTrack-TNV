//%attributes = {}
  //PP_OnActivate

If (Record number:C243([Personas:7])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo apoderado"))
Else 
	SET WINDOW TITLE:C213(__ ("Apoderados: ")+[Personas:7]Apellidos_y_nombres:30)
End if 
