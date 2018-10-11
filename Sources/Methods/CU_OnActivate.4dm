//%attributes = {}
  //CU_OnActivate

If (Record number:C243([Cursos:3])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo curso"))
Else 
	SET WINDOW TITLE:C213(__ ("Cursos: ")+[Cursos:3]Nivel_Nombre:10+", "+[Cursos:3]Curso:1+", "+[Profesores:4]Nombre_comun:21)
End if 

  //MONO: TICKET 112576
If ((<>vtXS_CountryCode="ar") & ((<>gRegion="Capital Federal") | (<>gRegion="Distrito Federal")) & ([Cursos:3]Nivel_Numero:7=12))
	OBJECT SET VISIBLE:C603(*;"ar_bachillerato_mod";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"ar_bachillerato_mod";False:C215)
End if 