  // CIM_Principal.compactacionBD1()
  // Por: Alberto Bachler K.: 08-04-15, 12:58:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

OBJECT SET TITLE:C194(*;"resultadoVerificacion";"")
$l_refVentana:=Open form window:C675("CIM_Indices";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
DIALOG:C40("CIM_Indices")
CLOSE WINDOW:C154

KRL_UnloadAll 
$l_IdProcesoServidor:=Execute on server:C373("KRL_UnloadAll";Pila_256K;"LiberandoRegistros")

