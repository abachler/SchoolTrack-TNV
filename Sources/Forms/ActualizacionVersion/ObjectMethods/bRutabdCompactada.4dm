ARRAY TEXT:C222($at_MenuItems;0)

$t_ruta:=OBJECT Get title:C1068(*;"rutabdCompactada")
SYS_PathToArray ($t_ruta;->$at_MenuItems)
  //DELETE FROM ARRAY($at_MenuItems;1)
APPEND TO ARRAY:C911($at_MenuItems;"(-")
APPEND TO ARRAY:C911($at_MenuItems;__ ("Copiar la ruta"))


$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_MenuItems)

Case of 
	: ($l_itemSeleccionado>Size of array:C274($at_MenuItems))
		$text:=""
		For ($i;Size of array:C274($at_MenuItems);1;-1)
			$text:=$text+$at_MenuItems{$i}+Folder separator:K24:12
		End for 
		$text:=Substring:C12($text;1;Length:C16($text)-1)
		SET TEXT TO PASTEBOARD:C523($text)
		
		
	: ($l_itemSeleccionado>0)
		$path:=$at_MenuItems{Size of array:C274($at_MenuItems)}
		$path:=""
		For ($i;Size of array:C274($at_MenuItems)-2;$l_itemSeleccionado;-1)
			If ($path#"")
				$path:=$path+Folder separator:K24:12+$at_MenuItems{$i}
			Else 
				$path:=$at_MenuItems{$i}
			End if 
		End for 
		SHOW ON DISK:C922($path;*)
		
End case 

