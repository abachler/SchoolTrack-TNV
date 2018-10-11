//%attributes = {}
  // XSnota_AgregaAnotacion()
  // Por: Alberto Bachler K.: 19-03-15, 10:46:24
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_tabla:=$1
$t_uuidRegistro:=$2
$t_referenciaAdicional:=$3
$t_descripcionEvento:=$4
$t_usuario:=$5
$t_anotacion:=$6

CREATE RECORD:C68([xShell_RecordNotes:283])
[xShell_RecordNotes:283]ID_Tabla:1:=$l_tabla
[xShell_RecordNotes:283]UUID_Registro:2:=$t_uuidRegistro
[xShell_RecordNotes:283]Referencia:3:=$t_referenciaAdicional
[xShell_RecordNotes:283]Usuario:5:=$t_usuario
[xShell_RecordNotes:283]DescripcionEvento:9:=$t_descripcionEvento
[xShell_RecordNotes:283]Anotacion:8:=$t_anotacion
SAVE RECORD:C53([xShell_RecordNotes:283])
