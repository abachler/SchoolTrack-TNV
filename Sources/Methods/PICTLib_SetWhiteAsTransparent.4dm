//%attributes = {}
  // PICTLib_SetWhiteAsTransparent()
  //
  //
  // creado por: Alberto Bachler Klein: 02-09-16, 09:48:05
  // -----------------------------------------------------------
C_LONGINT:C283($i_index;$l_IdImagen;$l_imagenesLibreria;$RIS)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_imagen)
C_TEXT:C284($t_nombreImagen)

ARRAY LONGINT:C221($al_IdImagenes;0)
ARRAY TEXT:C222($at_nombreImagenes;0)

PICTURE LIBRARY LIST:C564($al_IdImagenes;$at_nombreImagenes)
$l_imagenesLibreria:=Size of array:C274($al_IdImagenes)


If ($l_imagenesLibreria>0)
	For ($i_index;1;$l_imagenesLibreria)
		$l_IdImagen:=$al_IdImagenes{$i_index}
		$t_nombreImagen:=$at_nombreImagenes{$i_index}
		GET PICTURE FROM LIBRARY:C565($al_IdImagenes{$i_index};$p_imagen)
		TRANSFORM PICTURE:C988($p_imagen;Transparency:K61:11;0x00FFFFFF)
		SET PICTURE TO LIBRARY:C566($p_imagen;$l_IdImagen;$t_nombreImagen)
	End for 
Else 
	ALERT:C41("No hay imagenes en la librería.")
End if 