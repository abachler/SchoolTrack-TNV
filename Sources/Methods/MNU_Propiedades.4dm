//%attributes = {}
  // MNU_Popiedades()
  // Por: Alberto Bachler K.: 28-08-15, 13:28:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If (Application type:C494=4D Remote mode:K5:5)
	SYS_VerifyDataBaseProperties 
	$l_refVentana:=Open form window:C675("propiedadesBD";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
	DIALOG:C40("propiedadesBD")
	CLOSE WINDOW:C154
Else 
	$t_rutaPropiedadesXML:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"settings.4DSettings"
	If (Test path name:C476($t_rutaPropiedadesXML)=Is a document:K24:1)
		SYS_VerifyDataBaseProperties 
		$l_refVentana:=Open form window:C675("propiedadesBD";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("propiedadesBD")
		CLOSE WINDOW:C154
	Else 
		OPEN SETTINGS WINDOW:C903("/Database/Database/Memory and cpu";True:C214;User settings:K5:27)
	End if 
End if 
