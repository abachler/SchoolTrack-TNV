//%attributes = {}
  //XCR_OnActivate


If (Record number:C243([Actividades:29])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva actividad"))
Else 
	SET WINDOW TITLE:C213(__ ("Actividades: ")+[Actividades:29]Nombre:2+", "+[Profesores:4]Nombre_comun:21)
End if 
