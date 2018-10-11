//%attributes = {}
  // QRY_BusquedaPorPalabrasClave()
  // Por: Alberto Bachler: 01/10/13, 10:50:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_BOOLEAN:C305($b_busquedaTerminada;$b_PalabraCompleta)
_O_C_INTEGER:C282($i_palabras)
C_LONGINT:C283($l_numeroDePalabras)
C_POINTER:C301($y_campo;$y_tabla;$y_tablaRelacionada)
C_TEXT:C284($t_palabra;$t_palabras)

If (False:C215)
	C_POINTER:C301(QRY_BusquedaPorPalabrasClave ;$1)
	C_POINTER:C301(QRY_BusquedaPorPalabrasClave ;$2)
	C_TEXT:C284(QRY_BusquedaPorPalabrasClave ;$3)
	C_LONGINT:C283(QRY_BusquedaPorPalabrasClave ;$4)
	C_LONGINT:C283(QRY_BusquedaPorPalabrasClave ;$5)
End if 

$y_tabla:=$1
$y_campo:=$2
$t_palabras:=$3

$l_tipoComparacion:=Contiene alguna de las palabras
$l_buscarPalabrasCompletas:=0

Case of 
	: (Count parameters:C259=4)
		$l_tipoComparacion:=$4
	: (Count parameters:C259=5)
		$l_tipoComparacion:=$4
		$l_buscarPalabrasCompletas:=$5
End case 

If (Table:C252($y_tabla)#(Table:C252($y_campo)))
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
End if 



$t_palabras:=Replace string:C233($t_palabras;"|";" | ")
$t_palabras:=Replace string:C233($t_palabras;"&";" & ")
$t_palabras:=Replace string:C233($t_palabras;"#";" # ")
$t_palabras:=Replace string:C233($t_palabras;"-";" ")
$t_palabras:=ST_ClearSpaces ($t_palabras)

CREATE EMPTY SET:C140($y_tabla->;"resultado")

If ($t_palabras#"")
	
	Case of 
		: ($l_tipoComparacion=Comienza con)
			QUERY:C277($y_tabla->;$y_campo->;=;$t_palabras+"@")
			
		: ($l_tipoComparacion=Es exactamente)
			QUERY:C277($y_tabla->;$y_campo->;=;$t_palabras)
			
		: ($l_tipoComparacion=Contiene alguna de las palabras)
			$l_numeroDePalabras:=ST_CountWords ($t_palabras)
			
			$t_palabra:=ST_GetWord ($t_palabras;1)
			If ($l_buscarPalabrasCompletas=0)
				$t_palabra:="@"+$t_palabra+"@"
			End if 
			QUERY:C277($y_tabla->;$y_campo->;%;$t_Palabra)
			CREATE SET:C116($y_tabla->;"resultado")
			
			For ($i_palabras;2;$l_numeroDePalabras)
				$t_palabra:=ST_GetWord ($t_palabras;$i_palabras)
				If ($l_buscarPalabrasCompletas=0)
					If (($t_palabra#"&") & ($t_palabra#"|") & ($t_palabra#"#"))
						$t_palabra:="@"+$t_palabra+"@"
					End if 
				End if 
				
				Case of 
					: ($t_palabra="&")
						$i_palabras:=$i_palabras+1
						$t_palabra:=ST_GetWord ($t_palabras;$i_palabras)
						If ($l_buscarPalabrasCompletas=0)
							$t_palabra:="@"+$t_palabra+"@"
						End if 
						QUERY:C277($y_tabla->;$y_campo->;%;$t_Palabra)
						CREATE SET:C116($y_tabla->;"ultimaBusqueda")
						INTERSECTION:C121("resultado";"ultimaBusqueda";"resultado")
						
						
					: ($t_palabra="|")
						$i_palabras:=$i_palabras+1
						$t_palabra:=ST_GetWord ($t_palabras;$i_palabras)
						If ($l_buscarPalabrasCompletas=0)
							$t_palabra:="@"+$t_palabra+"@"
						End if 
						QUERY:C277($y_tabla->;$y_campo->;%;$t_Palabra)
						CREATE SET:C116($y_tabla->;"ultimaBusqueda")
						UNION:C120("resultado";"ultimaBusqueda";"resultado")
						
						
					: ($t_palabra="#")
						$i_palabras:=$i_palabras+1
						$t_palabra:=ST_GetWord ($t_palabras;$i_palabras)
						If ($l_buscarPalabrasCompletas=0)
							$t_palabra:="@"+$t_palabra+"@"
						End if 
						QUERY:C277($y_tabla->;$y_campo->;%;$t_Palabra)
						CREATE SET:C116($y_tabla->;"ultimaBusqueda")
						DIFFERENCE:C122("resultado";"ultimaBusqueda";"resultado")
					Else 
						QUERY:C277($y_tabla->;$y_campo->;%;$t_Palabra)
						CREATE SET:C116($y_tabla->;"ultimaBusqueda")
						UNION:C120("resultado";"ultimaBusqueda";"resultado")
				End case 
			End for 
			USE SET:C118("resultado")
			CLEAR SET:C117("resultado")
			CLEAR SET:C117("ultimaBusqueda")
			
		: ($l_tipoComparacion=Contiene todas las palabras)
			$t_palabras:=Replace string:C233($t_palabras;"|";"")
			$t_palabras:=Replace string:C233($t_palabras;"&";"")
			$t_palabras:=Replace string:C233($t_palabras;"#";"")
			$t_palabras:=ST_ClearSpaces ($t_palabras)
			$l_numeroDePalabras:=ST_CountWords ($t_palabras)
			$t_palabra:=ST_GetWord ($t_palabras;1)
			QUERY:C277($y_tabla->;$y_campo->;%;$t_Palabra;*)
			For ($i_palabras;2;$l_numeroDePalabras)
				$t_palabra:=ST_GetWord ($t_palabras;$i_palabras)
				If ($l_buscarPalabrasCompletas=0)
					$t_palabra:="@"+$t_palabra+"@"
				End if 
				QUERY:C277($y_tabla->; & ;$y_campo->;%;$t_Palabra;*)
			End for 
			QUERY:C277($y_tabla->)
	End case 
End if 



If (Table:C252($y_tabla)#(Table:C252($y_campo)))
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
End if 