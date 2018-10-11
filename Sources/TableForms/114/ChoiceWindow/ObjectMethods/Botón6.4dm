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
SET LIST ITEM PROPERTIES:C386(hl_choiceList;*;False:C215;0;0)
SELECT LIST ITEMS BY POSITION:C381(hl_ChoiceList;Count list items:C380(hl_ChoiceList))
OBJECT SET SCROLL POSITION:C906(hl_ChoiceList;Count list items:C380(hl_ChoiceList))
SET LIST ITEM PROPERTIES:C386(hl_choiceList;*;False:C215;1;0)
vl_SelectedListItem:=Count list items:C380(hl_ChoiceList)

