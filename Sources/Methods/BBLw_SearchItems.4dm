//%attributes = {"publishedWeb":true}
  //BBLw_SearchItems

C_TEXT:C284($1)
C_TEXT:C284(vt_Keywords;vt_CallNumber;vt_Place;vt_wholeWord;vt_Synonims;vt_search;vt_search2;vtWEB_Connector)


$estilo:=1

$ChronoStart:=Milliseconds:C459

If (vt_Place="")
	vt_Place:="2"
End if 

$class:=vt_CallNumber
$words:=vt_Keywords
$place:=Num:C11(vt_Place)
b1:=Num:C11(vt_wholeWord#"")
bXREfs:=Num:C11(vt_Synonims#"")

vt_words:=$words

If ($class#"")
	QUERY:C277([BBL_Items:61];[BBL_Items:61]Clasificacion:2=($class+"@"))
	CREATE SET:C116([BBL_Items:61];"Clasificacion")
	vt_Place:="Clasificación"
	vt_words:=$class
Else 
	CREATE EMPTY SET:C140([BBL_Items:61];"Clasificacion")
End if 

If ($words#"")
	tSearch:=Replace string:C233($words;Char:C90(10);"")
	ARRAY TEXT:C222(aSrchOpts;9)
	Case of 
		: ($place=2)  //materias
			aSrchOpts:=3
			$t_campoBusqueda:="_F01_encabezado"
			
		: ($place=3)  //titulo
			aSrchOpts:=4
			$t_campoBusqueda:="_F02_titulo"
			
		: ($place=4)  //autor
			aSrchOpts:=5
			$t_campoBusqueda:="_F03_autor"
			
		: ($place=5)  //editor
			aSrchOpts:=6
			$t_campoBusqueda:="_F04_editor"
			vt_place:="Editor"
			
		: ($place=6)  //resumen
			aSrchOpts:=7
			$t_campoBusqueda:="_F06_resumen"
			vt_place:="Resumen"
			
		: ($place=7)  //contenido
			aSrchOpts:=8
			$t_campoBusqueda:=""
			vt_place:="Contenido"
			
		: ($place=8)  //serie
			aSrchOpts:=9
			$t_campoBusqueda:="_F05_serie"
			vt_place:="Serie"
		Else 
			aSrchOpts:=1  //cualquier parte
			$t_campoBusqueda:=""
			
	End case 
	
	Case of 
		: (vtWEB_Connector="allwords")
			$l_modoComparacion:=Contiene todas las palabras
		: (vtWEB_Connector="")
			$l_modoComparacion:=Contiene alguna de las palabras
	End case 
	
	If (($class#"") & (Records in set:C195("Clasificacion")>0))
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

vt_Words:=_O_Mac to ISO:C519(vt_Words)
vt_place:=_O_Mac to ISO:C519(vt_place)
$documentosTotales:=String:C10(Records in selection:C76([BBL_Items:61]))
If (Records in selection:C76([BBL_Items:61])>10)
	$words:=Replace string:C233($words;"\r";";")
	
	  // Modificado por: Alexis Bustamante (10/08/2017)
	  //186999 
	vt_SearchString:="&vt_keywords="+_O_Mac to ISO:C519($words)+"&vt_place="+vt_place+"&vt_wholeword="+((vtWEB_Connector))+"&vt_synonims="+("ON"*(bXREfs)+"&vt_callNumber="+_O_Mac to ISO:C519($class))
	  //vt_SearchString:="&vt_keywords="+_o_Mac to ISO($words)+"&vt_place="+vt_place+"&vt_wholeword="+("ON"*(b1))+"&vt_synonims="+("ON"*(bXREfs)+"&vt_callNumber="+_o_Mac to ISO($class))
	BBLw_BuildQueryResults (1)
	$secs:=Round:C94((Milliseconds:C459-$chronoStart)/1000;2)
	sChrono:=$documentosTotales+" documentos en "+String:C10($secs)+" segundos"
	WEB_SendHtmlFile ("itemlist_1.shtml")
	vt_table:=""
Else 
	vt_SearchString:=""
	BBLw_BuildQueryResults (1)
	$secs:=Round:C94((Milliseconds:C459-$chronoStart)/1000;2)
	sChrono:=$documentosTotales+" documentos en "+String:C10($secs)+" segundos"
	WEB_SendHtmlFile ("itemlist_1.shtml")
End if 