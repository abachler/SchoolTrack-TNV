//%attributes = {}
  // STWA2_AJAX_SendFotoAlumno()
  // Por: Alberto Bachler K.: 02-04-15, 18:51:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_recNumAlumno)
C_PICTURE:C286($p_imagen)
C_TEXT:C284($t_fotoBase64;$t_raizJson)


If (False:C215)
	C_TEXT:C284(STWA2_AJAX_SendFotoAlumno ;$0)
	C_LONGINT:C283(STWA2_AJAX_SendFotoAlumno ;$1)
End if 

$l_recNumAlumno:=$1

READ ONLY:C145([Alumnos:2])

$ob_objeto:=OB_Create 
If (KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215))
	$p_imagen:=[Alumnos:2]Fotografía:78
	PICT_ScalePicture (->$p_imagen;85;85)
	OB_SET ($ob_objeto;->$p_imagen;"foto";".jpg")
Else 
	$t_valor:="error"
	OB_SET ($ob_objeto;->$t_valor;"foto")
End if 
$t_json:=OB_Object2Json ($ob_objeto)

$0:=$t_json


