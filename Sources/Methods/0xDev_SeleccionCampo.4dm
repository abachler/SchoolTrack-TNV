//%attributes = {}
  // 0xDev_SeleccionCampo()
  // Por: Alberto Bachler K.: 20-12-13, 15:55:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($0)

C_LONGINT:C283($l_numeroCampo;$l_numeroTabla;$l_refVentana)
C_POINTER:C301($y_campo)


If (False:C215)
	C_POINTER:C301(0xDev_SeleccionCampo ;$0)
End if 

$l_refVentana:=Open form window:C675([xShell_Dialogs:114];"SeleccionCampo";Movable form dialog box:K39:8;Horizontally centered:K39:1;Vertically centered:K39:4)
DIALOG:C40([xShell_Dialogs:114];"SeleccionCampo")
CLOSE WINDOW:C154

If (OK=1)
	$l_numeroTabla:=aTableNumbers{aTableNames}
	$l_numeroCampo:=aFieldNumbers{aFieldNames}
	$y_campo:=Field:C253($l_numeroTabla;$l_numeroCampo)
	$0:=$y_campo
End if 

