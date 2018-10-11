//%attributes = {}
  //BBL_drSave

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_drSave
	  //Autor: Alberto Bachler
	  //Creada el 17/5/96 a 09:53
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
If (KRL_RegistroFueModificado (->[xxBBL_ReglasParaItems:69]))
	SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
	UNLOAD RECORD:C212([xxBBL_ReglasParaItems:69])
	ALL RECORDS:C47([xxBBL_ReglasParaItems:69])
	SELECTION TO ARRAY:C260([xxBBL_ReglasParaItems:69]Codigo_regla:1;<>aPrefDoc)
	SORT ARRAY:C229(<>aPrefDoc;>)
End if 