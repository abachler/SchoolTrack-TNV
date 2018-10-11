//%attributes = {"executedOnServer":true}
  // Método: SYS_GetServerDocumentIcon
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 01/09/10, 08:26:46
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_PICTURE:C286($vp_Icon;$0)
C_TEXT:C284($path;$1)
C_LONGINT:C283($iconSize;$2)


  // Código principal
$path:=$1
If (Count parameters:C259=2)
	$iconSize:=$2
End if 

GET DOCUMENT ICON:C700($path;$vp_Icon;$iconSize)
$0:=$vp_Icon





