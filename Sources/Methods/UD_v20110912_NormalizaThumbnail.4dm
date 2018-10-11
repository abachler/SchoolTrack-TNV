//%attributes = {}
  // MÉTODO: UD_v20110912_NormalizaThumbnail
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/09/11, 11:32:59
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // UD_v20110912_NormalizaThumbnail()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_PICTURE:C286($thumbnail)
ARRAY LONGINT:C221($aRecNums;0)
C_LONGINT:C283($l_proc)


  // CODIGO PRINCIPAL

  //20130715 RCH Se agrega mensaje
MESSAGES OFF:C175
$l_proc:=IT_UThermometer (1;0;__ ("Normalizando imágenes de alumnos..."))

ALL RECORDS:C47([Alumnos:2])
QUERY SELECTION BY FORMULA:C207([Alumnos:2];Picture size:C356([Alumnos:2]Fotografía:78)>20000)
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	CREATE THUMBNAIL:C679([Alumnos:2]Fotografía:78;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
	[Alumnos:2]Fotografía:78:=$thumbnail
	SAVE RECORD:C53([Alumnos:2])
End for 
KRL_UnloadReadOnly (->[Alumnos:2])

IT_UThermometer (0;$l_proc;__ ("Normalizando imágenes de apoderados..."))
ALL RECORDS:C47([Personas:7])
QUERY SELECTION BY FORMULA:C207([Personas:7];Picture size:C356([Personas:7]Fotografia:43)>20000)
ARRAY LONGINT:C221($aRecNums;0)
  //LONGINT ARRAY FROM SELECTION([Alumnos];$aRecNums;"")
LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aRecNums;"")  //20130715 RCH
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Personas:7])
	GOTO RECORD:C242([Personas:7];$aRecNums{$i})
	CREATE THUMBNAIL:C679([Personas:7]Fotografia:43;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
	[Personas:7]Fotografia:43:=$thumbnail
	SAVE RECORD:C53([Personas:7])
End for 
KRL_UnloadReadOnly (->[Personas:7])

IT_UThermometer (0;$l_proc;__ ("Normalizando imágenes de profesores..."))
ALL RECORDS:C47([Profesores:4])
QUERY SELECTION BY FORMULA:C207([Profesores:4];Picture size:C356([Profesores:4]Fotografia:59)>20000)
ARRAY LONGINT:C221($aRecNums;0)
  //LONGINT ARRAY FROM SELECTION([Alumnos];$aRecNums;"")
LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$aRecNums;"")  //20130715 RCH
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Profesores:4])
	GOTO RECORD:C242([Profesores:4];$aRecNums{$i})
	CREATE THUMBNAIL:C679([Profesores:4]Fotografia:59;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
	[Profesores:4]Fotografia:59:=$thumbnail
	SAVE RECORD:C53([Profesores:4])
End for 
KRL_UnloadReadOnly (->[Profesores:4])

IT_UThermometer (0;$l_proc;__ ("Normalizando imágenes de lectores..."))
ALL RECORDS:C47([BBL_Lectores:72])
QUERY SELECTION BY FORMULA:C207([BBL_Lectores:72];Picture size:C356([BBL_Lectores:72]Fotografia:32)>20000)
ARRAY LONGINT:C221($aRecNums;0)
  //LONGINT ARRAY FROM SELECTION([Alumnos];$aRecNums;"")
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$aRecNums;"")  //20130715 RCH
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([BBL_Lectores:72])
	GOTO RECORD:C242([BBL_Lectores:72];$aRecNums{$i})
	CREATE THUMBNAIL:C679([BBL_Lectores:72]Fotografia:32;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
	[BBL_Lectores:72]Fotografia:32:=$thumbnail
	SAVE RECORD:C53([BBL_Lectores:72])
End for 
KRL_UnloadReadOnly (->[BBL_Lectores:72])

IT_UThermometer (-2;$l_proc)