$item:=Selected list items:C379(hl_Estados)
If ($item>0)
	GET LIST ITEM:C378(hl_Estados;$item;$ref;$text;$sublist;$expanded)
	$menu:="Agregar estado;Agregar situación final"
Else 
	$menu:="Agregar estado"
End if 
$choice:=Pop up menu:C542($menu)
Case of 
	: ($choice=1)
		$id:=Num:C11(PREF_fGet (0;"LastEstadoID";"0"))
		$id:=$id+1
		PREF_Set (0;"LastEstadoID";String:C10($id))
		APPEND TO LIST:C376(hl_Estados;"Nuevo Estado";$id)
		_O_REDRAW LIST:C382(hl_Estados)
		EDIT ITEM:C870(hl_Estados;Count list items:C380(hl_Estados))
	: ($choice=2)
		$id:=Num:C11(PREF_fGet (0;"LastEstadoID";"0"))
		$id:=$id+1
		PREF_Set (0;"LastEstadoID";String:C10($id))
		If ($sublist>0)
			APPEND TO LIST:C376($sublist;"Nuevo situación final";$id*-100)
			_O_REDRAW LIST:C382(hl_Estados)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_Estados;$id*-100)
			EDIT ITEM:C870(hl_Estados;Selected list items:C379(hl_Estados))
		Else 
			If ($ref<-100)
				$parent:=List item parent:C633(hl_Estados;$ref)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Estados;$parent)
				GET LIST ITEM:C378(hl_Estados;*;$ref;$text;$sublist;$expanded)
				APPEND TO LIST:C376($sublist;"Nueva situación final";$id*-100)
				_O_REDRAW LIST:C382(hl_Estados)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Estados;$id*-100)
				EDIT ITEM:C870(hl_Estados;Selected list items:C379(hl_Estados))
			Else 
				$sublist:=New list:C375
				APPEND TO LIST:C376($sublist;"Nueva situación final";$id*-100)
				SET LIST ITEM:C385(hl_Estados;$ref;$text;$ref;$sublist;True:C214)
				_O_REDRAW LIST:C382(hl_Estados)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Estados;$id*-100)
				EDIT ITEM:C870(hl_Estados;Selected list items:C379(hl_Estados))
			End if 
		End if 
		_O_REDRAW LIST:C382(hl_Estados)
End case 