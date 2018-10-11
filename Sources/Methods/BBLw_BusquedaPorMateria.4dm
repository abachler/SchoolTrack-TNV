//%attributes = {}
  // BBLw_BusquedaPorMateria()
  // Por: Alberto Bachler K.: 20-02-15, 17:27:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_ms:=Milliseconds:C459
$t_materia:=ST_GetWord ($1;2;"/")
$t_materia:=Replace string:C233($t_materia;"[K]";"")

QRY_BusquedaTextosIndexados ($t_materia;->[BBL_Items:61]Materias_json:53;Contiene todas las palabras)
BBL_BuscaMateriaEnItems ($t_materia)

vt_Words:=$t_materia
vt_place:="Materias"
If (Records in selection:C76([BBL_Items:61])>10)
	vt_SearchString:="&vt_keywords="+_O_Mac to ISO:C519(vt_words)+"&vt_place="+_O_Mac to ISO:C519(vt_place)+"&wholeword=&synonims="
Else 
	vt_SearchString:=""
End if 
BBLw_BuildQueryResults (1)

$secs:=Round:C94((Milliseconds:C459-$l_ms)/1000;2)
sChrono:=String:C10(Records in selection:C76([BBL_Items:61]))+" documentos en "+String:C10($secs)+" segundos"

vt_Words:=_O_Mac to ISO:C519(Substring:C12($1;4))
vt_Place:=_O_Mac to ISO:C519("Materias")

WEB_SendHtmlFile ("itemlist_1.shtml")
vt_table:=""

