//%attributes = {}
  //FM_OnActivate

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : FM_Activation
	  //Autor: Alberto Bachler
	  //Creada el 30/6/96 a 6:15 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
If (Record number:C243([Familia:78])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva familia"))
Else 
	SET WINDOW TITLE:C213(__ ("Familias: ")+[Familia:78]Nombre_de_la_familia:3)
End if 
