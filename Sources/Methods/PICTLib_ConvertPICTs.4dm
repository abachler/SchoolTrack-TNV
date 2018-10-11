//%attributes = {}
  // PICTLib_ConvertPICTs()
  //
  //
  // creado por: Alberto Bachler Klein: 02-09-16, 09:49:20
  // -----------------------------------------------------------
C_LONGINT:C283($i_index;$l_IdImagen;$l_imagenesLibreria)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_imagen)
C_TEXT:C284($t_nombreImagen)
C_BOOLEAN:C305($b_is_jpg;$b_is_Pict;$b_is_png;$b_is_svg)

ARRAY LONGINT:C221($al_IdImagenes;0)
ARRAY TEXT:C222($at_codecs;0)
ARRAY TEXT:C222($at_nombreImagenes;0)

PICTURE LIBRARY LIST:C564($al_IdImagenes;$at_nombreImagenes)
$l_imagenesLibreria:=Size of array:C274($al_IdImagenes)


If ($l_imagenesLibreria>0)
	For ($i_index;1;$l_imagenesLibreria)
		$l_IdImagen:=$al_IdImagenes{$i_index}
		$t_nombreImagen:=$at_nombreImagenes{$i_index}
		
		If ($t_nombreImagen="sin@")
			
		End if 
		GET PICTURE FROM LIBRARY:C565($al_IdImagenes{$i_index};$p_imagen)
		GET PICTURE FORMATS:C1406($p_imagen;$at_codecs)
		$b_is_png:=(Find in array:C230($at_codecs;".png")>0)
		$b_is_jpg:=(Find in array:C230($at_codecs;".jpg")>0)
		$b_is_svg:=(Find in array:C230($at_codecs;".svg")>0)
		$b_is_Pict:=(Find in array:C230($at_codecs;".pict")>0)
		
		If ($b_is_Pict)
			CONVERT PICTURE:C1002($p_imagen;".PNG")
			TRANSFORM PICTURE:C988($p_imagen;Transparency:K61:11;0x00FFFFFF)
			If (Application type:C494#4D Server:K5:6)
				SET PICTURE TO LIBRARY:C566($p_imagen;$l_IdImagen;$t_nombreImagen)
			End if 
		End if 
		
	End for 
Else 
	TRACE:C157
	  //ALERT("No hay imagenes en la librería.")
End if 