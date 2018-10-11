//%attributes = {}
  // Notificacion_retrollamado()
  // Por: Alberto Bachler: 22/10/13, 11:08:23
  //  ---------------------------------------------
  //  Este método es necesario para el llamado al plugin de notificaciones en MacOS
  //  No debiera ser necesario modificarlo ni utilizar otro método por razones de compatibilidad con Windows
  //  ---------------------------------------------

C_TEXT:C284($1;$2;$3;$4;$5;$6)
$t_titulo:=$1
$t_subtitulo:=$2
$t_mensaje:=$3
$t_nombreSonido:=$4
$t_informacionUsuario:=$5
$t_parametro:=$6

SET TEXT TO PASTEBOARD:C523($1+"\r"+$2+"\r"+$3+"\r"+$4+"\r"+$5+"\r"+$6)





