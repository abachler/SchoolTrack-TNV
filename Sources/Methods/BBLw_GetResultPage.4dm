//%attributes = {"publishedWeb":true}
  // BBLw_GetResultPage()
  // Por: Alberto Bachler K.: 20-02-15, 18:30:39
  //  ---------------------------------------------
  // creado por Alberto Bachler on 23/6/98
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_modoComparacion;$l_ms;$l_pagina;$l_lugar)
C_TEXT:C284($t_campoBusqueda;$t_clasificacion;$t_palabras;$t_parametros;$t_referenciasCruzadas;$t_todasLasPalabras)


If (False:C215)
	C_TEXT:C284(BBLw_GetResultPage ;$1)
End if 

$t_parametros:=$1


$l_ms:=Milliseconds:C459

$l_pagina:=Num:C11(Substring:C12($t_parametros;1;Position:C15("&";$t_parametros)-1))
$t_parametros:=Substring:C12($t_parametros;Position:C15("&";$t_parametros)+1)

ARRAY TEXT:C222(aValues;0)
AT_Text2Array (->aValues;$t_parametros;"&")
$t_palabras:=NV_GetValueFromTextArray (->aValues;"vt_Keywords")
$l_lugar:=Num:C11(NV_GetValueFromTextArray (->aValues;"vt_Place"))
$t_clasificacion:=NV_GetValueFromTextArray (->aValues;"vt_CallNumber")
$t_todasLasPalabras:=NV_GetValueFromTextArray (->aValues;"vt_wholeword")
$t_referenciasCruzadas:=NV_GetValueFromTextArray (->aValues;"vt_synonims")
ARRAY TEXT:C222(aValues;0)

$t_palabras:=Replace string:C233($t_palabras;";";"\r")
vt_words:=_O_Mac to ISO:C519($t_palabras)
vt_Place:=_O_Mac to ISO:C519(NV_GetValueFromTextArray (->aValues;"vt_Place"))
b1:=Num:C11($t_todasLasPalabras#"")
bXREfs:=Num:C11($t_referenciasCruzadas#"")

Case of 
	: ($t_todasLasPalabras#"")
		$l_modoComparacion:=Contiene todas las palabras
	Else 
		$l_modoComparacion:=Contiene alguna de las palabras
End case 

If ($t_clasificacion#"")
	QUERY:C277([BBL_Items:61];[BBL_Items:61]Clasificacion:2=($t_clasificacion+"@"))
	CREATE SET:C116([BBL_Items:61];"Clasificacion")
Else 
	CREATE EMPTY SET:C140([BBL_Items:61];"Clasificacion")
End if 


  //vt_words:=$t_palabras
If (vt_words#"")
	tSearch:=Replace string:C233(vt_words;Char:C90(10);"")
	Case of 
		: ($l_lugar=2)  //materias
			$t_campoBusqueda:="_F01_encabezado"
			
		: ($l_lugar=3)  //titulo
			$t_campoBusqueda:="_F02_titulo"
			
		: ($l_lugar=4)  //autor
			$t_campoBusqueda:="_F03_autor"
			
		: ($l_lugar=5)  //editor
			$t_campoBusqueda:="_F04_editor"
			vt_place:="Editor"
			
		: ($l_lugar=6)  //resumen
			$t_campoBusqueda:="_F06_resumen"
			vt_place:="Resumen"
			
		: ($l_lugar=7)  //contenido
			$t_campoBusqueda:=""
			vt_place:="Contenido"
			
		: ($l_lugar=8)  //serie
			$t_campoBusqueda:="_F05_serie"
			vt_place:="Serie"
			
	End case 
	
	If (($t_clasificacion#"") & (Records in set:C195("Clasificacion")>0))
		BBL_BusquedaItems (vt_words;$t_campoBusqueda;$l_modoComparacion)
		CREATE SET:C116([BBL_Items:61];"keywords")
		INTERSECTION:C121("Clasificacion";"keywords";"Clasificacion")
		USE SET:C118("Clasificacion")
		CLEAR SET:C117("Clasificacion")
		CLEAR SET:C117("keywords")
	Else 
		CLEAR SET:C117("Clasificacion")
		BBL_BusquedaItems (vt_words;$t_campoBusqueda;$l_modoComparacion)
	End if 
End if 

If (Records in selection:C76([BBL_Items:61])>10)
	$t_palabras:=Replace string:C233($t_palabras;"\r";";")
	vt_SearchString:="&vt_keywords="+vt_words+"&vt_place="+vt_Place+"&vt_wholeword="+("ON"*(b1))+"&vt_synonims="+("ON"*(bXREfs)+"&vt_callNumber="+_O_Mac to ISO:C519($t_clasificacion))
	BBLw_BuildQueryResults ($l_pagina)
	sChrono:=String:C10(Records in selection:C76([BBL_Items:61]))+" documentos en "+String:C10(Round:C94((Milliseconds:C459-$l_ms)/1000;2))+" segundos"
	WEB_SendHtmlFile ("itemlist_1.shtml")
	vt_table:=""
Else 
	vt_SearchString:=""
	WEB_SendHtmlFile ("search_1.shtml")
End if 