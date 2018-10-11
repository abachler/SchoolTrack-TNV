FORM NEXT PAGE:C248

  // Modificado por: Alexis Bustamante (11-04-2017)
  //TICKET 176934 
If (Test path name:C476(vt_g1)#1)
	OBJECT SET ENABLED:C1123(bImport;False:C215)
	  //_o_DISABLE BUTTON(bImport)
Else 
	  //_o_ENABLE BUTTON(bImport)
	OBJECT SET ENABLED:C1123(bImport;True:C214)
End if 