//%attributes = {}
  // WEBarea_MuestraURL()
  // Por: Alberto Bachler: 17/09/13, 13:50:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_refVentana)
C_TEXT:C284($t_tituloVentana)

vt_URL:=$1

If (Count parameters:C259=2)
	$t_tituloVentana:=$2
End if 

$l_refVentana:=Open form window:C675("WebArea";Plain form window:K39:10;On the left:K39:2;At the top:K39:5)
SET WINDOW TITLE:C213($t_tituloVentana;$l_refVentana)
DIALOG:C40("WebArea")
CLOSE WINDOW:C154


