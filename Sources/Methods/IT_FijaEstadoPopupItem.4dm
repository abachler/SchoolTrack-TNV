//%attributes = {}
  // IT_FijaEstadoPopupItem()
  // Por: Alberto Bachler: 02/07/13, 18:13:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_ItemActivo)
C_LONGINT:C283($l_numeroItem)
C_TEXT:C284($t_ItemsPopupMenu;$t_textoItem)

ARRAY TEXT:C222($at_ItemsPopup;0)
If (False:C215)
	C_TEXT:C284(IT_FijaEstadoPopupItem ;$0)
	C_TEXT:C284(IT_FijaEstadoPopupItem ;$1)
	C_LONGINT:C283(IT_FijaEstadoPopupItem ;$2)
	C_BOOLEAN:C305(IT_FijaEstadoPopupItem ;$3)
End if 

$t_ItemsPopupMenu:=$1
$l_numeroItem:=$2
$b_ItemActivo:=$3

AT_Text2Array (->$at_ItemsPopup;$t_ItemsPopupMenu)

If (($l_numeroItem>=0) & ($l_numeroItem<=Size of array:C274($at_ItemsPopup)))
	$t_textoItem:=$at_ItemsPopup{$l_numeroItem}
	Case of 
		: (($t_textoItem="(@") & ($b_ItemActivo))
			$at_ItemsPopup{$l_numeroItem}:=Substring:C12($at_ItemsPopup{$l_numeroItem};2)
		: (($t_textoItem="(@") & (Not:C34($b_ItemActivo)))
			  // nada, ya está inactivo
		: (Not:C34($b_ItemActivo))
			$t_textoItem:="("+$t_textoItem
	End case 
	$at_ItemsPopup{$l_numeroItem}:=$t_textoItem
End if 

$0:=AT_array2text (->$at_ItemsPopup)

