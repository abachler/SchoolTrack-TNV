//%attributes = {}
  //XS_SetApplicationInfo


  //`xShell, Alberto Bachler
  //Metodo: XS_SetApplicationInfo
  //Por Administrator
  //Creada el 23/12/2004, 07:44:19
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_TEXT:C284($0;$itemText)
C_LONGINT:C283($itemRef;$1;$selector;$hl_App;$sublist)
C_BOOLEAN:C305($expanded)

  //****INICIALIZACIONES****
$selector:=$1
$itemText:=$2
If (Count parameters:C259=3)
	$sublist:=$3
End if 


  //****CUERPO****
While (Semaphore:C143("Setting Application Info"))
	DELAY PROCESS:C323(Current process:C322;5)
End while 

$hl_app:=Load list:C383("XS_Application")
If (Is a list:C621($hl_app))
	If ($sublist>0)
		SET LIST ITEM:C385($hl_app;$selector;$itemText;$selector;$sublist;False:C215)
	Else 
		SET LIST ITEM:C385($hl_app;$selector;$itemText;$selector)
	End if 
	SAVE LIST:C384($hl_app;"XS_Application")
	$error:=0
Else 
	$error:=-1
End if 

  //****LIMPIEZA****
HL_ClearList ($hl_app)
CLEAR SEMAPHORE:C144("Setting Application Info")




