//%attributes = {}
  //BBLanl_OnActivation

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_dcActiveSub
	  //Autor: Alberto Bachler
	  //Creada el 1/9/96 a 9:50 AM
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
	SET WINDOW TITLE:C213(__ ("Nuevo Registro Analítico"))
Else 
	SET WINDOW TITLE:C213(Replace string:C233([BBL_RegistrosAnaliticos:74]Titulos:3;"\r";", "))
End if 

BWR_SetInputFormButtons (->[BBL_RegistrosAnaliticos:74];BWR Array Browsing;->aSubID)