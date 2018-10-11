//%attributes = {}
  //PICT_GetDefaultFormat

C_TEXT:C284($extension;$format;<>vs_PictureFormat;<>vs_PictureFileExtension)


<>vs_PictureFormat:=PREF_fGet (0;"FormatoFotografías";"")
If (<>vs_PictureFormat="")
	<>vs_PictureFormat:=PREF_fGet (0;"FormatoFotografías";"JPEG")
End if 
If (<>vs_PictureFormat="")
	PREF_Set (0;"FormatoFotografías";"JPEG")
	<>vs_PictureFormat:=PREF_fGet (0;"FormatoFotografías";"JPEG")
End if 
$0:=<>vs_PictureFormat

  //formato pict genera mal las imagenes en v11