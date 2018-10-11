  //Siempre despliego el formulario.
If (Form event:C388=On Clicked:K2:4)
	WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"AsignaColor";0;-Palette form window:K39:9;__ ("Asignar color a competencias, dimensiones y ejes"))
	DIALOG:C40([MPA_DefinicionAreas:186];"AsignaColor")
	CLOSE WINDOW:C154
End if 