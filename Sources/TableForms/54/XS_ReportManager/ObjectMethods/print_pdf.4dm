  // [xShell_Reports].XS_ReportManager.Botón 3D()
  // Por: Alberto Bachler K.: 22-08-15, 10:44:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_refMenu)
C_TEXT:C284($t_destinoImpresion;$t_menuRef;$t_rutaCarpetaPDF)

$y_refMenu:=OBJECT Get pointer:C1124(Object named:K67:5;"menuImpresion")
If (Contextual click:C713)
	$t_menuRef:=$y_refMenu->
	MNU_Append ($t_menuRef;"(-")
	MNU_Append ($t_menuRef;"Mostrar documentos PDF…";"muestraCarpeta")
	$t_destinoImpresion:=Dynamic pop up menu:C1006($t_menuRef)
	DELETE MENU ITEM:C413($t_menuRef;-1)
	DELETE MENU ITEM:C413($t_menuRef;-1)
	
Else 
	$t_destinoImpresion:="pdf"
End if 

Case of 
	: ($t_destinoImpresion="muestraCarpeta")
		PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->$t_rutaCarpetaPDF)
		SHOW ON DISK:C922($t_rutaCarpetaPDF;*)
		
	: ($t_destinoImpresion="pdf")
		QR_ImprimeInforme (Record number:C243([xShell_Reports:54]);$t_destinoImpresion)
	Else 
		
End case 