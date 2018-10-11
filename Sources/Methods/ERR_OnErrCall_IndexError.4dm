//%attributes = {}
  //ERR_OnErrCall_IndexError

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : z_dtectBadIdx
	  //Autor: Alberto Bachler
	  //Creada el 24/6/96 a 8:29 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
If ((error=-10001) | (error=-10004))
	<>badIdx:=True:C214
End if 