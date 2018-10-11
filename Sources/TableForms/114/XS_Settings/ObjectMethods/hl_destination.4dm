  // Método: Método de Objeto: [xShell_Dialogs].XS_Settings.Lista jerárquica
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/07/10, 11:39:28
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
If (Selected list items:C379(Self:C308->)>0)
	If (List item parent:C633(Self:C308->;*)>0)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$fieldRef;$text)
		$stringFieldRef:=String:C10($fieldRef)
		$tableNum:=Num:C11(Substring:C12($stringFieldRef;1;Length:C16($stringFieldRef)-3))
		$fieldNum:=Num:C11(Substring:C12($stringFieldRef;Length:C16($stringFieldRef)-2))
		vy_RelationDestination:=Field:C253($tableNum;$fieldNum)
	End if 
End if 