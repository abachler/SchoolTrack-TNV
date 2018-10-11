//%attributes = {}
  //BBL_urBefore

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_urBefore
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 17:59
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 


If (Old:C35([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)="GEN")
	OBJECT SET ENTERABLE:C238([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;False:C215)
	OBJECT SET COLOR:C271([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;-62479)
Else 
	OBJECT SET ENTERABLE:C238([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;True:C214)
	OBJECT SET COLOR:C271([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;-15)
End if 
If (<>aPrefUsr=0)
	<>aPrefUsr:=Find in array:C230(<>aPrefUsr;"GEN")
	QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1="GEN")
End if 
If (<>aPrefUsr{<>aPrefUsr}="GEN")
	_O_DISABLE BUTTON:C193(bDelDR)
Else 
	_O_ENABLE BUTTON:C192(bDelDR)
End if 
