If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script bOK
	  //Autor: Alberto Bachler
	  //Creada el 24/6/96 a 8:11 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
If ((at_TablaPop>0) & (at_CamposPop>0))
	ACCEPT:C269
Else 
	BEEP:C151
	ok:=0
End if 