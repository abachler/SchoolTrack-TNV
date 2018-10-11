//%attributes = {}
  // BBLitm_NormalizaAutores()
  // Por: Alberto Bachler: 16/11/13, 17:30:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_posicionComa;$i_indice)
C_TEXT:C284($t_apellidosAutor;$t_nombreCompleto;$t_nombresAutor;$t_prefijoAutores)

ARRAY TEXT:C222($at_autores;0)

If ([BBL_Items:61]Autores:7#"")
	If (Position:C15("\r";[BBL_Items:61]Autores:7)>0)
		[BBL_Items:61]Primer_autor:6:=Substring:C12([BBL_Items:61]Autores:7;1;Position:C15("\r";[BBL_Items:61]Autores:7)-1)
	Else 
		[BBL_Items:61]Primer_autor:6:=[BBL_Items:61]Autores:7
	End if 
	If (Position:C15("\r";[BBL_Items:61]Autores:7)>0)
		$t_prefijoAutores:="por "
		AT_Text2Array (->$at_autores;[BBL_Items:61]Autores:7;"\r")
		For ($i_indice;1;Size of array:C274($at_autores))
			$t_nombreCompleto:=$at_autores{$i_indice}
			$l_posicionComa:=Position:C15(",";$t_nombreCompleto)
			If ($l_posicionComa>0)
				$t_nombresAutor:=Substring:C12($t_nombreCompleto;$l_posicionComa+1)
				$t_apellidosAutor:=Substring:C12($t_nombreCompleto;1;$l_posicionComa-1)
			Else 
				$t_nombresAutor:=""
				$t_apellidosAutor:=$t_nombreCompleto
			End if 
			Case of 
				: ($i_indice=Size of array:C274($at_autores))
					$t_prefijoAutores:=$t_prefijoAutores+$t_nombresAutor+" "+$t_apellidosAutor+"."
				: ($i_indice=(Size of array:C274($at_autores)-1))
					$t_prefijoAutores:=$t_prefijoAutores+$t_nombresAutor+" "+$t_apellidosAutor+" y "
				Else 
					$t_prefijoAutores:=$t_prefijoAutores+$t_nombresAutor+" "+$t_apellidosAutor+", "
			End case 
		End for 
	Else 
		$t_nombreCompleto:=[BBL_Items:61]Autores:7
		[BBL_Items:61]Primer_autor:6:=$t_nombreCompleto
		$l_posicionComa:=Position:C15(",";$t_nombreCompleto)
		If ($l_posicionComa>0)
			$t_nombresAutor:=Substring:C12($t_nombreCompleto;$l_posicionComa+1)
			$t_apellidosAutor:=Substring:C12($t_nombreCompleto;1;$l_posicionComa-1)
		Else 
			$t_nombresAutor:=""
			$t_apellidosAutor:=$t_nombreCompleto
		End if 
		$t_prefijoAutores:="por "+$t_nombresAutor+" "+$t_apellidosAutor
	End if 
	[BBL_Items:61]Autor_Texto_libre:22:=ST_ClearSpaces ($t_prefijoAutores)
End if 