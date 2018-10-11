//%attributes = {}
  //0xdev_SelectTable

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : z_SelectFile
	  //Autor: Alberto Bachler
	  //Creada el 24/6/96 a 8:16 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283($0)
WDW_OpenFormWindow (->[xShell_Dialogs:114];"SelectTable";0;5)
DIALOG:C40([xShell_Dialogs:114];"SelectTable")
CLOSE WINDOW:C154
$0:=vi_TableNumber