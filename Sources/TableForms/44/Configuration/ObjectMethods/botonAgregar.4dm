  // [xxSTR_EstilosEvaluacion].Configuration.botonAgregar()
  // Por: Alberto Bachler K.: 02-01-15, 12:46:51
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



$t_menu:=Create menu:C408
APPEND MENU ITEM:C411($t_menu;__ ("Nuevo estilo"))
SET MENU ITEM PARAMETER:C1004($t_menu;-1;"nuevo")
If (aEvStyleName>0)
	APPEND MENU ITEM:C411($t_menu;__ ("Duplicar ")+"\""+aEvStyleName{aEvStyleName}+"\"")
	SET MENU ITEM PARAMETER:C1004($t_menu;-1;"duplicar")
Else 
	APPEND MENU ITEM:C411($t_menu;"("+__ ("Duplicar ")+"\""+aEvStyleName{aEvStyleName}+"\"")
	SET MENU ITEM PARAMETER:C1004($t_menu;-1;"duplicar")
End if 

$t_accion:=Dynamic pop up menu:C1006($t_menu)
RELEASE MENU:C978($t_menu)

EVS_EjecutaAccion ($t_accion)