//%attributes = {}
  // PICTLib_ImportFromFiles()
  //
  //
  // creado por: Alberto Bachler Klein: 02-09-16, 09:42:47
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_id)
C_PICTURE:C286($p_Picture)
C_TEXT:C284($t_fileName;$t_imageName;$t_ruta;$t_rutaDoc)

ARRAY LONGINT:C221($al_idImagenesLibreria;0)
ARRAY TEXT:C222($at_docs;0)
ARRAY TEXT:C222($at_nombreImagenesLibreria;0)
ARRAY TEXT:C222($at_PictureDocs;0)

$t_ruta:=Get 4D folder:C485(Database folder:K5:14)+"exportImagenes"+Folder separator:K24:12

PICTURE LIBRARY LIST:C564($al_idImagenesLibreria;$at_nombreImagenesLibreria)
For ($i;1;Size of array:C274($al_idImagenesLibreria))
	REMOVE PICTURE FROM LIBRARY:C567($al_idImagenesLibreria{$i})
End for 
PICTURE LIBRARY LIST:C564($al_idImagenesLibreria;$at_nombreImagenesLibreria)

DOCUMENT LIST:C474($t_ruta;$at_docs;Ignore invisible:K24:16)

For ($i;1;Size of array:C274($at_docs))
	$t_rutaDoc:=$t_ruta+$at_docs{$i}
	READ PICTURE FILE:C678($t_rutaDoc;$p_Picture)
	TRANSFORM PICTURE:C988($p_Picture;Transparency:K61:11;0x00FFFFFF)
	$l_id:=Num:C11(Substring:C12($at_docs{$i};1;Position:C15("_";$at_docs{$i})-1))
	$t_fileName:=Substring:C12($at_docs{$i};Position:C15("_";$at_docs{$i})+1)
	$t_fileName:=Replace string:C233($t_fileName;".PNG";"")
	SET PICTURE TO LIBRARY:C566($p_Picture;$l_id;$t_fileName)
End for 


