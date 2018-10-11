FORM NEXT PAGE:C248
  // Modificado por: Alexis Bustamante (11-04-2017)
  //TICKET 176934 
If ((vt_g1="") | (Test path name:C476(vt_g1)#1))
	  //_o_DISABLE BUTTON(bImport)
	OBJECT SET ENABLED:C1123(bImport;False:C215)
Else 
	  //_o_ENABLE BUTTON(bImport)
	OBJECT SET ENABLED:C1123(bImport;True:C214)
End if 