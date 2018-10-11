//%attributes = {}
  //XS_GetApplicationInfo

  //`xShell, Alberto Bachler
  //Metodo: XS_GetApplicationInfo
  //Por Administrator
  //Creada el 23/12/2004, 07:41:56
  //Modificaciones:
If ("DESCRIPCION"="")
	  //Retorna información de la lista XS_Application de acuerdo al selector pasado en $1
	
	  //SELECTORES:
	  //  1: application name
End if 

  //****DECLARACIONES****
C_TEXT:C284($0;$itemText)
C_LONGINT:C283($itemRef;$1;$selector;$hl_App;$sublist)
C_BOOLEAN:C305($expanded)

  //****INICIALIZACIONES****
$selector:=$1

  //****CUERPO****
$hl_app:=Load list:C383("XS_Application")
If (Is a list:C621($hl_app))
	HL_ExpandAll ($hl_app)
	SELECT LIST ITEMS BY REFERENCE:C630($hl_app;$selector)
	GET LIST ITEM:C378($hl_app;Selected list items:C379($hl_app);$itemRef;$itemText;$sublist;$expanded)
End if 
$0:=$itemText

  //****LIMPIEZA****

CLEAR LIST:C377($hl_app)






