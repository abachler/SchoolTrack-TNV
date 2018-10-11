//%attributes = {}
  // Listas_Popup()
  // Por: Alberto Bachler K.: 26-03-14, 17:12:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1;$0)
C_POINTER:C301($2)

C_LONGINT:C283($l_itemSeleccionado;$l_posicionItemPorDefecto)
C_POINTER:C301($y_valorActual)
C_TEXT:C284($t_nombreLista;$t_valorSeleccionado)

ARRAY TEXT:C222($at_elementosLista;0)
ARRAY TEXT:C222($at_valoresPorDefecto;0)

If (False:C215)
	C_TEXT:C284(Listas_Popup ;$0)
	C_TEXT:C284(Listas_Popup ;$1)
	C_POINTER:C301(Listas_Popup ;$2)
End if 
$t_nombreLista:=$1

If (Count parameters:C259=2)
	$y_valorActual:=$2
End if 

KRL_FindAndLoadRecordByIndex (->[xShell_List:39]Listname:1;->$t_nombreLista)

If (BLOB size:C605([xShell_List:39]Contents:9)>0)
	BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_elementosLista)
End if 
SORT ARRAY:C229($at_elementosLista;>)

AT_Text2Array (->$at_valoresPorDefecto;[xShell_List:39]DefaultValues:10)
SORT ARRAY:C229($at_valoresPorDefecto;>)
For ($i;1;Size of array:C274($at_valoresPorDefecto))
	$l_posicionItemPorDefecto:=Find in array:C230($at_elementosLista;$at_valoresPorDefecto{$i})
	If ($l_posicionItemPorDefecto>0)
		DELETE FROM ARRAY:C228($at_elementosLista;$l_posicionItemPorDefecto)
	End if 
End for 

If (Size of array:C274($at_elementosLista)>0)
	If (Size of array:C274($at_elementosLista)>0)
		APPEND TO ARRAY:C911($at_elementosLista;"(-")
		For ($i;1;Size of array:C274($at_valoresPorDefecto))
			APPEND TO ARRAY:C911($at_elementosLista;$at_valoresPorDefecto{$i})
		End for 
	End if 
	
End if 

If (Size of array:C274($at_elementosLista)>0)
	$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_elementosLista;$y_valorActual)
	If ($l_itemSeleccionado>0)
		$t_valorSeleccionado:=$at_elementosLista{$l_itemSeleccionado}
	End if 
End if 


$0:=$t_valorSeleccionado
