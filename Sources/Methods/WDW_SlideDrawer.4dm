//%attributes = {}
  //WDW_SlideDrawer

  //
  //xShell, Alberto Bachler
  //Metodo: WDW_SlideDrawer
  //Por abachler
  //Creada el 04/02/2004, 09:22:23
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

C_POINTER:C301($1;$table)
C_TEXT:C284($2;$form)
C_LONGINT:C283($step;$width;$height)

  //****INICIALIZACIONES****
$table:=$1
$form:=$2

If (Count parameters:C259>2)
	$width:=$3
	$height:=$4
Else 
	FORM GET PROPERTIES:C674($table->;$form;$width;$height)
End if 

If (SYS_IsWindows )
	$step:=5
Else 
	$step:=20
End if 

  //****CUERPO****
GET WINDOW RECT:C443($left;$top;$right;$bottom)
For ($i;$top;$height+$top;$step)
	SET WINDOW RECT:C444($left;$top;$left+$width;$i)
End for 
SET WINDOW RECT:C444($left;$top;$left+$width;$top+$height)

  //****LIMPIEZA****
