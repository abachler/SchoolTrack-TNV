//%attributes = {}
  // ST_CleanMenuMetaCharacters()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 26/07/12, 16:56:47
  // ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($t_contenidoPopup)

If (False:C215)
	C_TEXT:C284(ST_CleanMenuMetaCharacters ;$0)
	C_TEXT:C284(ST_CleanMenuMetaCharacters ;$1)
End if 


  // CÓDIGO
$t_contenidoPopup:=$1
$t_contenidoPopup:=Replace string:C233($t_contenidoPopup;"/";".")
$t_contenidoPopup:=Replace string:C233($t_contenidoPopup;"-";"–")
$t_contenidoPopup:=Replace string:C233($t_contenidoPopup;"!";"")
$t_contenidoPopup:=Replace string:C233($t_contenidoPopup;"<";"")
$t_contenidoPopup:=Replace string:C233($t_contenidoPopup;"(";"[")
$t_contenidoPopup:=Replace string:C233($t_contenidoPopup;")";"]")

$0:=$t_contenidoPopup