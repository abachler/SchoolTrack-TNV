//%attributes = {"publishedWeb":true}
  //BBLw_Thesaurus

C_BLOB:C604(vx_HtmlBlob)


$4DCGI_prefix:="HTTP://"+vtWEB_Host
vT_palette:="|"
For ($i;65;78)
	vT_palette:=vT_palette+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/BBLw_GetWords/"+Char:C90($i)+"?estilo="+String:C10(1))+HTML_mseOver ("Encabezamientos comenzando con "+Char:C90($i)+"...")+">"+" "+Char:C90($i)+"</A> |"+"\r"
End for 
  //vT_palette:=vT_palette+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/BBLw_GetWords/"+Char(132)+"?estilo="+String(1))+HTML_mseOver ("Encabezamientos comenzando con "+$t_eñe+"...")+">"+$t_eñe+"</A> |"+<>cr
For ($i;79;90)
	vT_palette:=vT_palette+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/BBLw_GetWords/"+Char:C90($i)+"?estilo="+String:C10(1))+HTML_mseOver ("Encabezamientos comenzando con "+Char:C90($i)+"...")+">"+" "+Char:C90($i)+"</A> |"+"\r"
End for 
vT_palette:=vT_palette+"<BR>| "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/BBLw_GetWords/Otros?estilo="+String:C10(1))+HTML_mseOver ("Encabezamientos comenzando con cifras ")+">Cifras y otros signos</A> |"+"\r"
vT_palette:=vT_palette+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/BBLw_GetWords/Todos?estilo="+String:C10(1))+HTML_mseOver ("Todos los encabezamientos")+">"+"Todos"+"</A> |"+"\r"
vt_Thesaurus:=""
WEB_SendHtmlFile ("thesaurus_1.shtml")