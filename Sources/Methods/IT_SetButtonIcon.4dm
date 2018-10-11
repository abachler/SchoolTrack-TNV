//%attributes = {"shared":true}
  // IT_SetButtonIcon()
  // 
  //
  // creado por: Alberto Bachler Klein: 18-02-16, 16:36:12
  // -----------------------------------------------------------


C_TEXT:C284($t_estilo;$t_fondo;$t_format;$t_format2;$t_icono;$t_iconovisible;$t_imagen;$t_margenH;$t_margenV;$t_objectName)
C_TEXT:C284($t_offsetIcono;$t_popup;$t_titulo;$t_tituloPosicion;$t_tituloVisible)

$t_objectName:=$1
$t_icono:=$2
$t_format:=OBJECT Get format:C894(*;$t_objectName)
$t_titulo:=ST_GetWord ($t_format;1;";")
$t_imagen:=ST_GetWord ($t_format;2;";")
$t_fondo:=ST_GetWord ($t_format;3;";")
$t_tituloPosicion:=ST_GetWord ($t_format;4;";")
$t_tituloVisible:=ST_GetWord ($t_format;5;";")
$t_iconovisible:=ST_GetWord ($t_format;6;";")
$t_estilo:=ST_GetWord ($t_format;7;";")
$t_margenH:=ST_GetWord ($t_format;8;";")
$t_margenV:=ST_GetWord ($t_format;9;";")
$t_offsetIcono:=ST_GetWord ($t_format;10;";")
$t_popup:=ST_GetWord ($t_format;11;";")
$t_format2:=ST_Concatenate (";";->$t_titulo;->$t_imagen;->$t_fondo;->$t_tituloPosicion;->$t_tituloVisible;->$t_iconovisible;->$t_estilo;->$t_margenH;->$t_margenV;->$t_offsetIcono;->$t_popup)
OBJECT SET FORMAT:C236(*;$t_objectName;$t_format2)