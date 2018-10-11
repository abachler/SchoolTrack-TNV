//%attributes = {}
  //WDW_ModifyRecordInDrawer

  //`xShell, Alberto Bachler
  //Metodo: WDW_OpenDialogInDrawer
  //Por abachler
  //Creada el 04/02/2004, 09:15:35
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$table)
C_TEXT:C284($2;$3;$form;$drawerTitle)
C_LONGINT:C283($step)

  //****INICIALIZACIONES****
$table:=$1
$form:=$2
If (Count parameters:C259=3)
	$drawerTitle:=$3
End if 
vtXS_DrawerTitle:=$drawerTitle


If (SYS_IsWindows )
	$step:=10
Else 
	$step:=20
End if 

  //****CUERPO****
GET WINDOW RECT:C443($left;$top;$right;$bottom;Frontmost window:C447)
If ((Undefined:C82($left)) & (Undefined:C82($top)) & (Undefined:C82($right)) & (Undefined:C82($bottom)))
	$left:=50
	$right:=539
	$top:=44
	$Bottom:=233
Else 
	If (($left=0) & ($right=0) & ($top=0) & ($Bottom=0))
		$left:=50
		$right:=539
		$top:=44
		$Bottom:=233
	End if 
End if 
FORM GET PROPERTIES:C674($table->;$form;$width;$height)
$mainWindowWidth:=$right-$left
$hCenter:=$left+Int:C8($mainWindowWidth/2)
$left:=$hCenter-Int:C8($width/2)
If ($left<=0)
	$left:=2
End if 
If ($top<=0)
	$top:=46
End if 
$ref:=Open window:C153($left;$top;$left+$width;$top+2;1)
WDW_SetWindowIcon ($ref)
KRL_ModifyRecord ($table;$form)
GET WINDOW RECT:C443($left;$top;$right;$bottom;$ref)
For ($i;$bottom;$top+$step;-$step)
	SET WINDOW RECT:C444($left;$top;$right;$i)
End for 
CLOSE WINDOW:C154


  //****LIMPIEZA****