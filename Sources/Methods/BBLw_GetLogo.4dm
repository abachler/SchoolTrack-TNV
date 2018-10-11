//%attributes = {}
  //BBLw_GetLogo

C_PICTURE:C286($pict)
C_BLOB:C604($xBlob)
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
If (Picture size:C356([Colegio:31]Logo:37)=0)
	GET PICTURE FROM LIBRARY:C565("Module MTWebServer";$pict)
Else 
	$pict:=[Colegio:31]Logo:37
End if 
PICTURE TO BLOB:C692($pict;$xBlob;".jpg")
  //SEND HTML BLOB($xBlob;"image/jpeg")
  //WEB SEND RAW DATA($xBlob;*)  //20130513 ASM, JHB, RCH para mostrar el logo
WEB SEND RAW DATA:C815($xBlob)  //20150715 JVP por ticket 146925 se quita del envio 
  //"*" que es el chunked de datos, por x motivos se perdia la visualizacion 
  //de la imagen, por lo cual se quita el chunked para evitar envio en partes

