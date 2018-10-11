//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:10:24
  // ----------------------------------------------------
  // Método: STWA2_OWC_webaccess2
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_BLOB:C604($blob)
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
If (Picture size:C356([Colegio:31]Logo:37)>0)
	STWA2_AdjustPicture (->[Colegio:31]Logo:37;59;68)
Else 
	$ref:=SVG_New 
	$ref2:=SVG_New_rect ($ref;0;0;59;68;0;0;"white";"white")
	[Colegio:31]Logo:37:=SVG_Export_to_picture ($ref)
End if 
PICTURE TO BLOB:C692([Colegio:31]Logo:37;$blob;"JPEG")
vt_STWASchoolLogo:=""
BASE64 ENCODE:C895($blob;vt_STWASchoolLogo)
vt_STWASchoolLogo:=Replace string:C233(vt_STWASchoolLogo;"\n";"")
vt_STWASchoolName:=[Colegio:31]Nombre_Colegio:1
WEB SEND FILE:C619("stwa/webaccess2_1.shtml")
