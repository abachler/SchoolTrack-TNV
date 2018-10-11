//%attributes = {}
  //BBLitm_OnActivate

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_dcActivation
	  //Autor: Alberto Bachler
	  //Creada el 20/5/96 a 12:19
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 


If (Record number:C243([BBL_Items:61])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo item"))
Else 
	SET WINDOW TITLE:C213(__ ("Item: ")+[BBL_Items:61]Primer_título:4)
End if 

