//%attributes = {}
  //dhQF2_OpenFindDialog

  //xShell, Alberto Bachler
  //Metodo: dhQF_OpenFindDialog
  //Por abachler
  //Creada el 10/02/2004, 08:38:01
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  // utilizar para desviar ell llamado a al meto QF_OpenFindDialog
End if 
If (False:C215)
	<>xShellModificationDate:=!1903-05-22!
	  // 
End if 

  //****DECLARACIONES****
C_BOOLEAN:C305($trapped)

  //****INICIALIZACIONES****


  //****CUERPO****
Case of 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[BBL_Items:61]))
		BBL_SearchDocs 
		$trapped:=True:C214
End case 

  //****LIMPIEZA****
$0:=$trapped

