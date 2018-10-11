//%attributes = {}
  // MNU_CreaMenu_arreglo()
  // Por: Alberto Bachler: 13/11/13, 09:14:12
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_TEXT:C284($0)
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
$y_arregloItems:=$1
$b_utilizarIndice:=False:C215

If (Count parameters:C259=2)
	$b_utilizarIndice:=$2
End if 

$t_referenciaMenu:=Create menu:C408
For ($i;1;Size of array:C274($y_arregloItems->))
	Case of 
		: ($y_arregloItems->{$i}="(@")
			APPEND MENU ITEM:C411($t_referenciaMenu;$y_arregloItems->{$i};"";0)
		: ($y_arregloItems->{$i}="(-")
			APPEND MENU ITEM:C411($t_referenciaMenu;$y_arregloItems->{$i};"";0)
		Else 
			APPEND MENU ITEM:C411($t_referenciaMenu;$y_arregloItems->{$i};"";0;*)
	End case 
	If ($b_utilizarIndice)
		SET MENU ITEM PARAMETER:C1004($t_referenciaMenu;$i;String:C10($i))
	Else 
		SET MENU ITEM PARAMETER:C1004($t_referenciaMenu;$i;$y_arregloItems->{$i})
	End if 
End for 

$0:=$t_referenciaMenu