  // Método: Método de Objeto: [xShell_Dialogs].ChoiceWindow.Botón
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/10, 10:58:14
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
$selected:=Selected list items:C379(hl_ChoiceList)
If ($selected=0)
	SELECT LIST ITEMS BY POSITION:C381(hl_ChoiceList;1)
Else 
	SET LIST ITEM PROPERTIES:C386(hl_choiceList;*;False:C215;0;0)
	If (($selected)<Count list items:C380(hl_ChoiceList))
		SELECT LIST ITEMS BY POSITION:C381(hl_ChoiceList;$selected+1)
		OBJECT SET SCROLL POSITION:C906(hl_ChoiceList;$selected+1)
		SET LIST ITEM PROPERTIES:C386(hl_choiceList;*;False:C215;1;0)
		vl_SelectedListItem:=$selected+1
	End if 
End if 


