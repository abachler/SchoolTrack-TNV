//%attributes = {}
  // BBLitm_NormalizaTitulos()
  // Por: Alberto Bachler: 17/09/13, 13:24:00
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($el;$i;$l_PosicionExcepcion;$l_PosicionDelimitador)
C_TEXT:C284($t_articulo;$t_expresion;$t_Palabra)

ARRAY TEXT:C222($at_palabrasTitulo;0)

If ([BBL_Items:61]Titulos:5#"")
	[BBL_Items:61]Titulos:5:=ST_Format (->[BBL_Items:61]Titulos:5)
	[BBL_Items:61]Titulos:5:=ST_ClearSpaces ([BBL_Items:61]Titulos:5)
	If (Position:C15("\r";[BBL_Items:61]Titulos:5)>0)
		$t_expresion:=Substring:C12([BBL_Items:61]Titulos:5;1;Position:C15("\r";[BBL_Items:61]Titulos:5)-1)
	Else 
		$t_expresion:=[BBL_Items:61]Titulos:5
	End if 
	$t_expresion:=ST_ClearSpaces (Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233($t_expresion;"?";"");"¿";"");"!";"");"¡";""))
	$t_Palabra:=ST_ClearPonct (ST_GetWord ($t_expresion;1))
	$t_articulo:=""
	
	ARRAY TEXT:C222($at_palabrasTitulo;0)
	AT_Text2Array (->$at_palabrasTitulo;[BBL_Items:61]Titulos:5;" ")
	$l_PosicionExcepcion:=0
	For ($i;1;Size of array:C274($at_palabrasTitulo))
		$el:=Find in array:C230(<>aExAuto;$at_palabrasTitulo{$i})
		If ($el>0)
			$l_PosicionExcepcion:=$l_PosicionExcepcion+1
		End if 
	End for 
	
	
	If ($l_PosicionExcepcion<Size of array:C274($at_palabrasTitulo))
		If (Find in array:C230(<>aExAuto;$t_Palabra)>0)
			$t_articulo:=$t_Palabra
			$l_PosicionDelimitador:=Position:C15(" ";$t_expresion)
			While ((Find in array:C230(<>aExAuto;$t_Palabra)>0) & ($l_PosicionDelimitador>0))
				If ($l_PosicionDelimitador>0)
					$t_expresion:=Substring:C12($t_expresion;Position:C15(" ";$t_expresion)+1)
					$t_Palabra:=ST_ClearPonct (ST_GetWord ($t_expresion;1))
					If (Find in array:C230(<>aExAuto;$t_Palabra)>0)
						$t_articulo:=$t_articulo+" "+$t_Palabra
					End if 
				End if 
				$l_PosicionDelimitador:=Position:C15(" ";$t_expresion)
			End while 
			$t_articulo:=", "+$t_articulo
			[BBL_Items:61]Primer_título:4:=$t_expresion+$t_articulo
		Else 
			[BBL_Items:61]Primer_título:4:=$t_expresion
		End if 
	Else 
		[BBL_Items:61]Primer_título:4:=$t_expresion
	End if 
End if 