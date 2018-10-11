//%attributes = {}
  // ACTabc_CreaRutaCarpetas()
  // 
  //
  // creado por: Alberto Bachler Klein: 09-01-17, 20:01:31
  // -----------------------------------------------------------

$t_ruta:=$1

$t_ruta:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+$t_ruta
  //20170214 RCH Cuando, por ejemplo, se intentaba crear una carpeta en un directorio inexistente, aparecía un error.
  //CREATE FOLDER($t_ruta)
SYS_CreateFolder ($t_ruta)
$0:=$t_ruta



