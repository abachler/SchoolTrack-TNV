//%attributes = {"executedOnServer":true}
  // XS_EstableceServidorOficial()
  // Por: Alberto Bachler: 01/04/13, 10:50:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)
If (False:C215)
	C_BOOLEAN:C305(XS_EstableceServidorOficial ;$1)
End if 


If (<>bXS_esServidorOficial)
	  // reinicio los servicios web que estaban detenidos
	dhXS_IniciaProcWeb_enServidor 
End if 

