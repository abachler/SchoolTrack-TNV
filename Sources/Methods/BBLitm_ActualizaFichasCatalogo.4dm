//%attributes = {"invisible":true}
  // BBLitm_ActualizaFichasCatalogo()
  // Por: Alberto Bachler: 17/09/13, 13:21:35
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_elementos;$l_tamaño)
C_TEXT:C284($t_clasificacion;$t_detalleCopias;$t_encabezado;$t_indentacion;$t_Materias;$t_textoEnTarjeta;$t_textoFicha;$t_titulo;$t_tituloTarjeta)
C_OBJECT:C1216($ob_Materias)

ARRAY LONGINT:C221($al_IdItem;0)
ARRAY INTEGER:C220($al_numeroCopia;0)
ARRAY LONGINT:C221($al_numeroRegistros;0)
ARRAY TEXT:C222($at_clasificacion;0)
ARRAY TEXT:C222($at_Encabezado;0)
ARRAY TEXT:C222($at_materias;0)
ARRAY TEXT:C222($at_numeroVolumen;0)
ARRAY TEXT:C222($at_texto;0)
ARRAY TEXT:C222($at_TextoFicha;0)
ARRAY TEXT:C222($at_TipoItem;0)

$l_tamaño:=0
$t_textoEnTarjeta:=""
$t_indentacion:=" "*4


  // Construccion del texto de la tarjeta
If (Position:C15("\r";[BBL_Items:61]Titulos:5)>0)
	$t_titulo:=Substring:C12([BBL_Items:61]Titulos:5;1;Position:C15("\r";[BBL_Items:61]Titulos:5)-1)
Else 
	$t_titulo:=[BBL_Items:61]Titulos:5
End if 

If ([BBL_Items:61]Autores:7#"")
	$t_textoEnTarjeta:=$t_indentacion+$t_titulo
Else 
	$t_textoEnTarjeta:="\r"+$t_indentacion+$t_titulo
End if 

If ([BBL_Items:61]Autor_Texto_libre:22#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+" / "+[BBL_Items:61]Autor_Texto_libre:22
End if 

$t_textoEnTarjeta:=$t_textoEnTarjeta+".-- "

If ([BBL_Items:61]Edicion:11#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+[BBL_Items:61]Edicion:11+".--"
End if 

If ([BBL_Items:61]Lugar_de_edicion:12#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+""+[BBL_Items:61]Lugar_de_edicion:12+": "
End if 

If ([BBL_Items:61]Editores:9#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+[BBL_Items:61]Editores:9+", "+[BBL_Items:61]Fecha_de_edicion:10
End if 

If ([BBL_Items:61]Descripción:14#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+"\r"+$t_indentacion+[BBL_Items:61]Descripción:14
End if 

If ([BBL_Items:61]Serie_Nombre:26#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+" -- ("+[BBL_Items:61]Serie_Nombre:26
	
	If ([BBL_Items:61]Serie_ISSN:31#"")
		$t_textoEnTarjeta:=$t_textoEnTarjeta+"\r"+", ISSN: "+[BBL_Items:61]Serie_ISSN:31
	End if 
	If ([BBL_Items:61]Serie_No:27#"")
		$t_textoEnTarjeta:=$t_textoEnTarjeta+"; "+[BBL_Items:61]Serie_No:27+"."
	End if 
	$t_textoEnTarjeta:=$t_textoEnTarjeta+")"
End if 

If ([BBL_Items:61]Notas:16#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+"\r"+$t_indentacion+[BBL_Items:61]Notas:16
End if 

If ([BBL_Items:61]ISBN:3#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+"\r"+$t_indentacion+"ISBN: "+[BBL_Items:61]ISBN:3
End if 
If ([BBL_Items:61]LCCN:23#"")
	$t_textoEnTarjeta:=$t_textoEnTarjeta+"\r"+$t_indentacion+"LCCN: "+[BBL_Items:61]LCCN:23
End if 
  //

  //detalle de las copias
$t_detalleCopias:=""
QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
SELECTION TO ARRAY:C260([BBL_Registros:66]No_Registro:25;$al_numeroRegistros;[BBL_Registros:66]Número_de_copia:2;$al_numeroCopia;[BBL_Registros:66]Número_de_volumen:19;$at_numeroVolumen)
SORT ARRAY:C229($al_numeroCopia;$al_numeroRegistros;$at_numeroVolumen;>)
For ($i_elementos;1;Size of array:C274($al_numeroRegistros))
	$t_detalleCopias:=$t_detalleCopias+"R."+String:C10($al_numeroRegistros{$i_elementos})+" c"+String:C10($al_numeroCopia{$i_elementos})+((" v"+$at_numeroVolumen{$i_elementos})*Num:C11($at_numeroVolumen{$i_elementos}#""))+"; "
End for 
$t_detalleCopias:=Substring:C12($t_detalleCopias;1;Length:C16($t_detalleCopias)-2)


  //$t_refjSon:=JSON Parse text ([BBL_Items]Materias_json)
  //JSON_ExtraeValorElemento ($t_refjSon;->$at_Materias;"materiasCatalogacion_KW")
  //JSON CLOSE ($t_refjSon)
$ob_Materias:=OB_JsonToObject ([BBL_Items:61]Materias_json:53)
OB_GET ($ob_Materias;->$at_materias;"materiasCatalogacion_KW")

$t_Materias:=""
For ($i_elementos;1;Size of array:C274($at_Materias))
	$at_Materias{$i_elementos}:=ST_GetCleanString ($at_Materias{$i_elementos})
	If ($at_Materias{$i_elementos}#"")
		$t_Materias:=$t_Materias+$t_indentacion+String:C10($i_elementos)+". "+$at_Materias{$i_elementos}+"\r"
	End if 
End for 
$t_Materias:=Substring:C12($t_Materias;1;Length:C16($t_Materias)-1)
$t_clasificacion:=Replace string:C233([BBL_Items:61]Clasificacion:2;" ";"\r")
  //

  //tarjeta principal
If ([BBL_Items:61]Autores:7#"")
	$t_textoFicha:=ST_ClearExtraCR ([BBL_Items:61]Autores:7)
	If (Position:C15("\r";$t_tituloTarjeta)>0)
		$t_tituloTarjeta:=Substring:C12([BBL_Items:61]Autores:7;1;Position:C15("\r";$t_tituloTarjeta)-1)
	End if 
	If (Position:C15("/";$t_tituloTarjeta)>0)
		$t_tituloTarjeta:=Substring:C12($t_tituloTarjeta;1;Position:C15("/";$t_tituloTarjeta)-1)
	End if 
	$t_tituloTarjeta:=ST_ClearSpaces ($t_tituloTarjeta)
Else 
	$t_tituloTarjeta:=""
End if 
If ($t_tituloTarjeta#"")
	$t_textoFicha:=$t_tituloTarjeta+"\r"+$t_textoEnTarjeta
Else 
	$t_textoFicha:=$t_textoEnTarjeta
End if 
$l_tamaño:=$l_tamaño+1
INSERT IN ARRAY:C227($al_IdItem;$l_tamaño)
INSERT IN ARRAY:C227($at_TipoItem;$l_tamaño)
INSERT IN ARRAY:C227($at_Encabezado;$l_tamaño)
INSERT IN ARRAY:C227($at_clasificacion;$l_tamaño)
INSERT IN ARRAY:C227($at_TextoFicha;$l_tamaño)
$al_IdItem{$l_tamaño}:=[BBL_Items:61]Numero:1
$at_TipoItem{$l_tamaño}:=""
$at_Encabezado{$l_tamaño}:=$t_encabezado
$at_clasificacion{$l_tamaño}:=$t_clasificacion
$at_TextoFicha{$l_tamaño}:=$t_textoFicha+"\r\r"+$t_detalleCopias+"\r\r"+$t_Materias

  //tarjetas por título
$t_tituloTarjeta:=""
If ([BBL_Items:61]Titulos:5#"")
	$t_encabezado:=""
	AT_Text2Array (->$at_texto;[BBL_Items:61]Titulos:5;"\r")
	For ($i_elementos;1;Size of array:C274($at_texto))
		If ($at_texto{$i_elementos}#"")
			$t_tituloTarjeta:=ST_ClearSpaces ($at_texto{$i_elementos})
			$t_textoFicha:=$t_tituloTarjeta+"\r"+$t_textoEnTarjeta
			$l_tamaño:=$l_tamaño+1
			INSERT IN ARRAY:C227($al_IdItem;$l_tamaño)
			INSERT IN ARRAY:C227($at_TipoItem;$l_tamaño)
			INSERT IN ARRAY:C227($at_Encabezado;$l_tamaño)
			INSERT IN ARRAY:C227($at_clasificacion;$l_tamaño)
			INSERT IN ARRAY:C227($at_TextoFicha;$l_tamaño)
			$al_IdItem{$l_tamaño}:=[BBL_Items:61]Numero:1
			$at_TipoItem{$l_tamaño}:="T"
			$at_Encabezado{$l_tamaño}:=$t_encabezado
			$at_clasificacion{$l_tamaño}:=$t_clasificacion
			$at_TextoFicha{$l_tamaño}:=$t_textoFicha+"\r\r"+$t_Materias
		End if 
	End for 
End if 

  // tarjetas para cada autor
If ([BBL_Items:61]Autores:7#"")
	$t_tituloTarjeta:=ST_ClearExtraCR ([BBL_Items:61]Autores:7)
	If (Position:C15("\r";$t_tituloTarjeta)>0)
		$t_tituloTarjeta:=Substring:C12([BBL_Items:61]Autores:7;1;Position:C15("\r";$t_tituloTarjeta)-1)
	End if 
	If (Position:C15("/";$t_tituloTarjeta)>0)
		$t_tituloTarjeta:=Substring:C12($t_tituloTarjeta;1;Position:C15("/";$t_tituloTarjeta)-1)
	End if 
	$t_tituloTarjeta:=ST_ClearSpaces ($t_tituloTarjeta)
Else 
	$t_tituloTarjeta:=""
End if 
AT_Text2Array (->$at_texto;[BBL_Items:61]Autores:7;"\r")
For ($i_elementos;1;Size of array:C274($at_texto))
	If ($at_texto{$i_elementos}#"")
		$t_encabezado:=$at_texto{$i_elementos}
		$t_textoFicha:=$t_tituloTarjeta+"\r"+$t_textoEnTarjeta
		$l_tamaño:=$l_tamaño+1
		INSERT IN ARRAY:C227($al_IdItem;$l_tamaño)
		INSERT IN ARRAY:C227($at_TipoItem;$l_tamaño)
		INSERT IN ARRAY:C227($at_Encabezado;$l_tamaño)
		INSERT IN ARRAY:C227($at_clasificacion;$l_tamaño)
		INSERT IN ARRAY:C227($at_TextoFicha;$l_tamaño)
		$al_IdItem{$l_tamaño}:=[BBL_Items:61]Numero:1
		$at_TipoItem{$l_tamaño}:="A"
		$at_Encabezado{$l_tamaño}:=$t_encabezado
		$at_clasificacion{$l_tamaño}:=$t_clasificacion
		$at_TextoFicha{$l_tamaño}:=$t_textoFicha+"\r\r"+$t_Materias
	End if 
End for 



  // tarjetas por materias
If ([BBL_Items:61]Autores:7#"")
	$t_tituloTarjeta:=ST_ClearExtraCR ([BBL_Items:61]Autores:7)
	If (Position:C15("\r";$t_tituloTarjeta)>0)
		$t_tituloTarjeta:=Substring:C12([BBL_Items:61]Autores:7;1;Position:C15("\r";$t_tituloTarjeta)-1)
	End if 
	If (Position:C15("/";$t_tituloTarjeta)>0)
		$t_tituloTarjeta:=Substring:C12($t_tituloTarjeta;1;Position:C15("/";$t_tituloTarjeta)-1)
	End if 
	$t_tituloTarjeta:=ST_ClearSpaces ($t_tituloTarjeta)
Else 
	$t_tituloTarjeta:=""
End if 
For ($i_elementos;1;Size of array:C274($at_Materias))
	If ($at_Materias{$i_elementos}#"")
		$t_encabezado:=String:C10($i_elementos)+"."+$at_Materias{$i_elementos}
		$t_textoFicha:=$t_tituloTarjeta+"\r"+$t_textoEnTarjeta
		$l_tamaño:=$l_tamaño+1
		INSERT IN ARRAY:C227($al_IdItem;$l_tamaño)
		INSERT IN ARRAY:C227($at_TipoItem;$l_tamaño)
		INSERT IN ARRAY:C227($at_Encabezado;$l_tamaño)
		INSERT IN ARRAY:C227($at_clasificacion;$l_tamaño)
		INSERT IN ARRAY:C227($at_TextoFicha;$l_tamaño)
		$al_IdItem{$l_tamaño}:=[BBL_Items:61]Numero:1
		$at_TipoItem{$l_tamaño}:="M"
		$at_Encabezado{$l_tamaño}:=$t_encabezado
		$at_clasificacion{$l_tamaño}:=$t_clasificacion
		$at_TextoFicha{$l_tamaño}:=$t_textoFicha+"\r\r"+$t_Materias
	End if 
End for 


  // tarjeta topográfica
$t_tituloTarjeta:=""
If (Size of array:C274($al_numeroRegistros)>0)
	For ($i_elementos;1;Size of array:C274($al_numeroRegistros))
		$t_textoFicha:=$t_tituloTarjeta+"\r"+$t_textoEnTarjeta
		$l_tamaño:=$l_tamaño+1
		INSERT IN ARRAY:C227($al_IdItem;$l_tamaño)
		INSERT IN ARRAY:C227($at_TipoItem;$l_tamaño)
		INSERT IN ARRAY:C227($at_Encabezado;$l_tamaño)
		INSERT IN ARRAY:C227($at_clasificacion;$l_tamaño)
		INSERT IN ARRAY:C227($at_TextoFicha;$l_tamaño)
		$al_IdItem{$l_tamaño}:=[BBL_Items:61]Numero:1
		$at_TipoItem{$l_tamaño}:="G"
		$at_Encabezado{$l_tamaño}:=String:C10($al_numeroRegistros{$i_elementos})
		$at_clasificacion{$l_tamaño}:=$t_clasificacion
		$at_TextoFicha{$l_tamaño}:=$t_textoFicha+"\r\r"+$t_Materias
	End for 
End if 


  // actualizando registros de tarjetas bibliográficas
READ WRITE:C146([BBL_FichasCatalograficas:81])
QUERY:C277([BBL_FichasCatalograficas:81];[BBL_FichasCatalograficas:81]Nº de item:5=[BBL_Items:61]Numero:1)
If ($l_tamaño<Records in selection:C76([BBL_FichasCatalograficas:81]))
	DELETE SELECTION:C66([BBL_FichasCatalograficas:81])
End if 
ARRAY TO SELECTION:C261($al_IdItem;[BBL_FichasCatalograficas:81]Nº de item:5;$at_TipoItem;[BBL_FichasCatalograficas:81]Tipo:1;$at_Encabezado;[BBL_FichasCatalograficas:81]Encabezado:2;$at_clasificacion;[BBL_FichasCatalograficas:81]Clasificación:3;$at_TextoFicha;[BBL_FichasCatalograficas:81]Texto Ficha:4)
READ ONLY:C145([BBL_FichasCatalograficas:81])


