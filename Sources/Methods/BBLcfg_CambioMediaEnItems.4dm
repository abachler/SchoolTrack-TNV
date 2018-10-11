//%attributes = {}
  // BBLcfg_CambioMediaEnItems()
  // Por: Alberto Bachler: 17/09/13, 12:45:24
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_IDProgreso;$l_IdTipoDocumento_nuevo)
C_TEXT:C284($t_mensajeProgreso;$t_tipoDocumentoNuevo)

ARRAY LONGINT:C221($al_RecNums;0)

If (False:C215)
	C_LONGINT:C283(BBLcfg_CambioMediaEnItems ;$1)
	C_TEXT:C284(BBLcfg_CambioMediaEnItems ;$2)
End if 

_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_IDProgreso;$l_IdTipoDocumento_nuevo)
C_TEXT:C284($t_mensajeProgreso;$t_tipoDocumentoNuevo)

ARRAY LONGINT:C221($al_RecNums;0)
$l_IdTipoDocumento_nuevo:=$1
$t_tipoDocumentoNuevo:=$2
LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_RecNums;"")
$t_mensajeProgreso:=__ ("Cambiando tipo de documento...")
$l_IDProgreso:=IT_Progress (1;$l_IDProgreso;0;$t_mensajeProgreso)
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Items:61])
	GOTO RECORD:C242([BBL_Items:61];$al_RecNums{$i_registros})
	[BBL_Items:61]ID_Media:48:=$l_IdTipoDocumento_nuevo
	[BBL_Items:61]Media:15:=$t_tipoDocumentoNuevo
	SAVE RECORD:C53([BBL_Items:61])
	$l_IDProgreso:=IT_Progress (0;$l_IDProgreso;$i_registros/Size of array:C274($al_RecNums);$t_mensajeProgreso+"\r"+[BBL_Items:61]Primer_título:4)
End for 
$l_IDProgreso:=IT_Progress (-1;$l_IDProgreso)
KRL_UnloadReadOnly (->[BBL_Items:61])

