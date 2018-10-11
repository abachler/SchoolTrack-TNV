//%attributes = {}
  //BBLss_OnActivate


If (Record number:C243([BBL_Subscripciones:117])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva suscripción"))
Else 
	SET WINDOW TITLE:C213(__ ("Suscripciones: ")+[BBL_Subscripciones:117]Titulo:2)
End if 
