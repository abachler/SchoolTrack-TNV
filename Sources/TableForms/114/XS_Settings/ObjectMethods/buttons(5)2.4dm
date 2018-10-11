$codigo:=CD_Request (__ ("Por favor ingrese el código ISO del nuevo idioma (por ejemplo, es para Español):");__ ("Aceptar");__ ("Cancelar"))
If (ok=1)
	$codigo:=Lowercase:C14($codigo)
	$nombre:=CD_Request (__ ("Por favor ingrese el nombre del nuevo idioma:");__ ("Aceptar");__ ("Cancelar"))
	If (ok=1)
		$nombre:=ST_Uppercase ($nombre[[1]])+ST_Lowercase (Substring:C12($nombre;2))
		$itemText:=$codigo+": "+$nombre
		$r:=CD_Dlog (0;__ ("xShell generará ahora la configuración y recursos para ")+$itemText+__ (". Esta operación pueder resultar larga. ¿Desea continuar?");__ ("");__ ("Si, continuar");__ ("Cancelar"))
		If ($r=1)
			$itemRef:=HL_GetNextItemRefNumber (hl_LangSistema)
			APPEND TO LIST:C376(hl_LangSistema;$itemText;$itemRef)
			APPEND TO LIST:C376(hl_langages;$itemText;$itemRef)
			SELECT LIST ITEMS BY POSITION:C381(hl_LangSistema;Count list items:C380(hl_LangSistema))
			SET LIST ITEM PROPERTIES:C386(hl_LangSistema;*;False:C215;0;Use PicRef:K28:4+2078)
			_O_REDRAW LIST:C382(hl_LangSistema)
			$p:=IT_UThermometer (1;0;__ ("Copiando configuración completa de cl - es  a "))
			For ($i;1;Count list items:C380(hl_Paises))
				GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
				$country:=ST_GetWord ($text;1;":")
				IT_UThermometer (0;$p;__ ("Copiando configuración completa de cl - es  a ")+$country+__ (" - ")+$codigo+__ ("..."))
				XS_CopyXShellConfig ("all";$country;$codigo;"cl";"es")
			End for 
			IT_UThermometer (-2;$p)
		End if 
	End if 
End if 