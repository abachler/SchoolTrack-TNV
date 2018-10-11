//%attributes = {}
  //BBL_urSave

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : M_urSave
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
If (KRL_RegistroFueModificado (->[xxBBL_ReglasParaUsuarios:64]))
	SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
	UNLOAD RECORD:C212([xxBBL_ReglasParaUsuarios:64])
	ALL RECORDS:C47([xxBBL_ReglasParaUsuarios:64])
	SELECTION TO ARRAY:C260([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;<>aPrefUsr)
	SORT ARRAY:C229(<>aPrefUsr;>)
End if 