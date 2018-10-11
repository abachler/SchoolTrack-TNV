//%attributes = {"executedOnServer":true}
  // 0xDev_PictureLibrary2WebFile()
  //
  //
  // creado por: Alberto Bachler Klein: 01-11-16, 18:01:08
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_alto;$l_ancho)
C_TIME:C306($h_htmlDocRef)
C_PICTURE:C286($p_imagen;$picture2)
C_TEXT:C284($t_html;$t_htmlDocument;$t_nombreArchivo;$t_ruta;$t_rutaImagenes;$t_tamaño)

ARRAY LONGINT:C221($al_PictRefs;0)
ARRAY TEXT:C222($at_nombreImagenes;0)

PICTURE LIBRARY LIST:C564($al_PictRefs;$at_nombreImagenes)
$t_ruta:=Get 4D folder:C485(Database folder:K5:14)+"PictLibrary"+Folder separator:K24:12
$t_rutaImagenes:=$t_ruta+"PicturesLibrary"+Folder separator:K24:12
$t_htmlDocument:=$t_ruta+"PictureLibraryContents.html"
DELETE FOLDER:C693($t_rutaImagenes;Delete with contents:K24:24)
SYS_CreatePath ($t_rutaImagenes)


$h_htmlDocRef:=Create document:C266($t_htmlDocument;"HTML")
$t_html:="<HTML>\r<BODY>\r<TABLE Width=\"800\"><table align=\"CENTER\" border=\"1\" cellpadding=\"5\""+" c"+"ellspacing=\"2\" width=\"1000\" bgcolor=\"#FFFFFF\">"
SEND PACKET:C103($h_htmlDocRef;$t_html)
$t_html:="<TR><td width=\"50\">"+HTML_Style ("ID";1;"B")+"</td>\r"
$t_html:=$t_html+"<td width=\"150\">"+HTML_Style ("Nombre";1;"B")+"</td>\r"
$t_html:=$t_html+"<td width=\"80\">"+HTML_Style ("Dimensión";1;"B")+"</td>\r"
$t_html:=$t_html+"<td width=\"720\">"+HTML_Style ("Imagen";1;"B")+"</td>\r"
$t_html:=$t_html+"</TR>\r"
SEND PACKET:C103($h_htmlDocRef;$t_html)
For ($i;1;Size of array:C274($al_PictRefs))
	GET PICTURE FROM LIBRARY:C565($al_PictRefs{$i};$p_imagen)
	PICTURE PROPERTIES:C457($p_imagen;$l_ancho;$l_alto)
	$t_tamaño:=String:C10($l_ancho)+"*"+String:C10($l_alto)
	$at_nombreImagenes{$i}:=Replace string:C233($at_nombreImagenes{$i};Folder separator:K24:12;"_")
	If (Position:C15("/";$at_nombreImagenes{$i})>0)
		$at_nombreImagenes{$i}:=Substring:C12($at_nombreImagenes{$i};1;Position:C15("/";$at_nombreImagenes{$i})-1)
	End if 
	
	
	$t_html:="<TR>\r<td width=\"50\">"+HTML_Style (String:C10($al_PictRefs{$i});1;"B")+"</td>\r"
	$t_html:=$t_html+"<td width=\"150\">"+HTML_Style ($at_nombreImagenes{$i};1;"B")+"</td>\r"
	$t_html:=$t_html+"<td width=\"80\">"+HTML_Style ($t_tamaño;1;"B")+"</td>\r"
	$t_html:=$t_html+"<td width=\"720\"><IMG SRC =\"PicturesLibrary/"+_O_Mac to ISO:C519($at_nombreImagenes{$i})+".png"+"\" BORDER=0></td>\r"
	$t_html:=$t_html+"</TR>\r"
	SEND PACKET:C103($h_htmlDocRef;$t_html)
	
	$t_nombreArchivo:=$t_rutaImagenes+$at_nombreImagenes{$i}+".png"
	WRITE PICTURE FILE:C680($t_nombreArchivo;$p_imagen)
End for 
$t_html:="</table></body></html>"
SEND PACKET:C103($h_htmlDocRef;$t_html)
CLOSE DOCUMENT:C267($h_htmlDocRef)





