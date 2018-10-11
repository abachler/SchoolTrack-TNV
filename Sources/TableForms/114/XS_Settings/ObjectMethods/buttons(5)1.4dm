$codigo:=CD_Request (__ ("Por favor ingrese el código ISO del nuevo país (por ejemplo, mx para México):");__ ("Aceptar");__ ("Cancelar"))
If (ok=1)
	$codigo:=Lowercase:C14($codigo)
	$nombre:=CD_Request (__ ("Por favor ingrese el nombre del nuevo país:");__ ("Aceptar");__ ("Cancelar"))
	If (ok=1)
		$nombre:=ST_Uppercase ($nombre[[1]])+ST_Lowercase (Substring:C12($nombre;2))
		$itemText:=$codigo+": "+$nombre
		$r:=CD_Dlog (0;__ ("xShell generará ahora la configuración y recursos para ")+$itemText+__ (". Esta operación pueder resultar larga. ¿Desea continuar?");__ ("");__ ("Si, continuar");__ ("Cancelar"))
		If ($r=1)
			$itemRef:=HL_GetNextItemRefNumber (hl_PaisesSistema)
			APPEND TO LIST:C376(hl_PaisesSistema;$itemText;$itemRef)
			APPEND TO LIST:C376(hl_Paises;$itemText;$itemRef)
			SELECT LIST ITEMS BY POSITION:C381(hl_PaisesSistema;Count list items:C380(hl_PaisesSistema))
			SET LIST ITEM PROPERTIES:C386(hl_PaisesSistema;*;False:C215;0;Use PicRef:K28:4+2078)
			_O_REDRAW LIST:C382(hl_PaisesSistema)
			$p:=IT_UThermometer (1;0;__ ("Copiando configuración completa de cl - es  a "))
			For ($i;1;Count list items:C380(hl_Langages))
				GET LIST ITEM:C378(hl_Langages;$i;$ref;$text)
				$langage:=ST_GetWord ($text;1;":")
				IT_UThermometer (0;$p;__ ("Copiando configuración completa de cl - es  a ")+$codigo+__ (" - ")+$langage+__ ("..."))
				XS_CopyXShellConfig ("all";$codigo;$langage;"cl";"es")
			End for 
			IT_UThermometer (-2;$p)
		End if 
	End if 
End if 