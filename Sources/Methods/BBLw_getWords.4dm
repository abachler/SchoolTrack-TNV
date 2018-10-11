//%attributes = {"publishedWeb":true}
  //BBLw_getWords

C_TEXT:C284($parameter;$word;$submit;vtWEB_parameters;vt_Word;vt_Submit)
C_BLOB:C604(vx_HTMLBlob)
ARRAY TEXT:C222($at_Names;0)
ARRAY TEXT:C222($at_Values;0)


$parameter:=$1
$4DCGI_prefix:="HTTP://"+vtWEB_Host

vT_palette:="|"
For ($i;65;78)
	vT_palette:=vT_palette+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/BBLw_GetWords/"+Char:C90($i)+"?estilo="+String:C10(1))+HTML_mseOver ("Encabezamientos comenzando con "+Char:C90($i)+"...")+">"+" "+Char:C90($i)+"</A> |"+"\r"
End for 
For ($i;79;90)
	vT_palette:=vT_palette+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/BBLw_GetWords/"+Char:C90($i)+"?estilo="+String:C10(1))+HTML_mseOver ("Encabezamientos comenzando con "+Char:C90($i)+"...")+">"+" "+Char:C90($i)+"</A> |"+"\r"
End for 
vT_palette:=vT_palette+"<BR>| "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_GetWords/Otros?estilo="+String:C10(1))+HTML_mseOver ("Encabezamientos comenzando con cifras")+">Cifras y otros signos</A> |"+"\r"
vT_palette:=vT_palette+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_getWords/Todos?estilo="+String:C10(1))+HTML_mseOver ("Todos los encabezamientos")+">"+_O_Mac to ISO:C519("Todos")+"</A> |"+"\r"
vt_Thesaurus:=""

Case of 
	: ((vt_Word="Otros") | ($parameter="@/Otros") | ($parameter="Otros"))
		ARRAY TEXT:C222($at_caracteres;0)
		For ($i;33;47)
			APPEND TO ARRAY:C911($at_caracteres;Char:C90($i)+"@")
		End for 
		For ($i;48;57)
			APPEND TO ARRAY:C911($at_caracteres;Char:C90($i)+"@")
		End for 
		For ($i;58;63)
			APPEND TO ARRAY:C911($at_caracteres;Char:C90($i)+"@")
		End for 
		For ($i;91;96)
			APPEND TO ARRAY:C911($at_caracteres;Char:C90($i)+"@")
		End for 
		QUERY WITH ARRAY:C644([BBL_Thesaurus:68]Materia:13;$at_caracteres)
		CREATE SET:C116([BBL_Thesaurus:68];"$resultado")
		QUERY BY FORMULA:C48([BBL_Thesaurus:68];Character code:C91([BBL_Thesaurus:68]Materia:13[[1]])=64)
		ADD TO SET:C119([BBL_Thesaurus:68];"$resultado")
		USE SET:C118("$resultado")
		CLEAR SET:C117("$resultado")
		
	: ((vt_Word="Todos") | ($parameter="@/Todos") | ($parameter="Todos"))
		ALL RECORDS:C47([BBL_Thesaurus:68])
		
	: (($parameter#"") & (vt_Submit#"Buscar"))
		QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13=($parameter+"@"))
		
	: ($parameter#"")
		QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13=($parameter+"@"))
		
End case 


If (Records in selection:C76([BBL_Thesaurus:68])>0)
	ARRAY TEXT:C222($aText;0)
	SELECTION TO ARRAY:C260([BBL_Thesaurus:68]Materia:13;$aText)
	ARRAY TEXT:C222(at_Html;Size of array:C274($aText))
	SORT ARRAY:C229($aText;>)
	SET BLOB SIZE:C606(vx_HTMLBlob;0)
	$HdrTAG:="<tr>"
	$rowTAG:="<tr>"
	$tableTAG:="<table align="+ST_Qte ("Center")+" border="+ST_Qte ("0")+" cellpadding="+ST_Qte ("5")+" cellspacing="+ST_Qte ("2")+" width="+ST_Qte ("75%")+">"
	
	$htmlText:=$tableTag+"\r"
	$htmlText:=$htmlText+$hdrTAG+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+"><div align="+ST_Qte ("center")+">Materias Encontradas</div></td></tr>"
	TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	For ($i;1;Size of array:C274($aText))
		at_Html{$i}:=$rowTag+"\r"+"<td class="+ST_Qte ("mt_tabla_cuerpo")+"><A HREF="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_QuerybySubject/[K]"+_O_Mac to ISO:C519($aText{$i})+"?estilo="+String:C10(1))+HTML_mseOver (_O_Mac to ISO:C519($aText{$i}))+">"+" "+_O_Mac to ISO:C519($aText{$i})+"</A> <BR></td></tr>"+"\r"
		TEXT TO BLOB:C554(at_Html{$i};vx_HTMLBlob;Mac text without length:K22:10;*)
	End for 
	TEXT TO BLOB:C554("</Table>";vx_HTMLBlob;Mac text without length:K22:10;*)
	WEB_SendHtmlFile ("thesaurus_1.shtml")
Else 
	$vt_Thesaurus:=_O_Mac to ISO:C519("La materia especificada no existe en el thesaurus.<BR>"+"Por favor haz la búsqueda con otra materia o utiliza el índice.")
	TEXT TO BLOB:C554($vt_Thesaurus;vx_HTMLBlob;Mac text without length:K22:10;*)
	WEB_SendHtmlFile ("thesaurus_1.shtml")
End if 