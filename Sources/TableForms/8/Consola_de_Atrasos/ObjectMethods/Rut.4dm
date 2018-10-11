C_TEXT:C284($vt_value)
C_LONGINT:C283($Ascii)
C_BOOLEAN:C305($b_filtraRetirados)
$Ascii:=Character code:C91(Keystroke:C390)
$vt_value:=Self:C308->

$b_filtraRetirados:=(b_filtraretirados=1)

Case of   //opciones para la búsqueda
	: (vl_OptSearch=1)
		IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]apellidos_y_nombres:40;True:C214;$b_filtraRetirados)
	: (vl_OptSearch=2)
		IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]RUT:5;True:C214;$b_filtraRetirados)
	: (vl_OptSearch=3)
		IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]NoPasaporte:87;True:C214;$b_filtraRetirados)
	: (vl_OptSearch=4)
		IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]Codigo_interno:6;True:C214;$b_filtraRetirados)
End case 

If (($ascii#Backspace key:K12:29) & ($ascii#DEL ASCII code:K15:34))
	If (Self:C308->="")
		Self:C308->:=$vt_value
	End if 
End if 
