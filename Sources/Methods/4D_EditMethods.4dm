//%attributes = {}
  // Método: 4D_EditMethods
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 19/01/10, 17:24:12
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
ARRAY LONGINT:C221($aListItems;0)
C_LONGINT:C283($id)
C_TEXT:C284($object)

  // Código principal

$pos:=Selected list items:C379(hl_changes;$aListItems)

For ($i;1;Size of array:C274($aListItems))
	GET LIST ITEM:C378(hl_changes;$aListItems{$i};$id;$object)
	If ($id>0)
		$idParent:=List item parent:C633(hl_changes;$id)
		Case of 
			: (($idParent=-1) | ($idParent=-3))
				$l_error:=4D_openMethodEditor ($id)
			Else 
				  //
		End case 
	End if 
End for 


