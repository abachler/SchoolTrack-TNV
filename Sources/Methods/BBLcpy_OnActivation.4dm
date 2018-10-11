//%attributes = {}
  //BBLcpy_OnActivation

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_cpActivation
	  //Autor: Alberto Bachler
	  //Creada el 30/5/96 a 04:39
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

If (Record number:C243([BBL_Registros:66])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva copia")+", "+[BBL_Items:61]Primer_título:4)
Else 
	SET WINDOW TITLE:C213(__ ("Copia #")+String:C10([BBL_Registros:66]Número_de_copia:2)+", "+[BBL_Items:61]Primer_título:4)
End if 
BWR_SetInputFormButtons (->[BBL_Registros:66];BWR Array Browsing;->aCpyBCode)




