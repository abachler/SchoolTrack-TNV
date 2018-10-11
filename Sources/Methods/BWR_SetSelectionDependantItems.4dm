//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Jaime Herreros
  // Date and time: 10/08/10, 08:55:16
  // ----------------------------------------------------
  // Method: BWR_SetSelectionDependantItems
  // Description
  // Establece los botones y items de menu de subseleccion, excluir subseleccion, borrar y abrir
  //Llamado principalmente desde el arealist del browser como reaccion a los clic en las lineas... y desde BWR_SetMenuBar

  // Parameters
  // ----------------------------------------------------

C_BOOLEAN:C305(vb_RecordInInputForm)

ARRAY LONGINT:C221(abrSelect;0)
If (Not:C34(vb_RecordInInputForm))
	$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
End if 
MNU_SetMenuItemState ((Size of array:C274(abrSelect)>0);3;6;3;7;1;2)
If (Size of array:C274(abrSelect)>0)
	If (USR_checkRights ("D";yBWR_currentTable))
		ENABLE MENU ITEM:C149(2;18;Current process:C322)
	Else 
		DISABLE MENU ITEM:C150(2;18;Current process:C322)
	End if 
Else 
	DISABLE MENU ITEM:C150(2;18;Current process:C322)
End if 
IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_OpenRecord)
IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_ExcludeSelection)
IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_SubSelection)