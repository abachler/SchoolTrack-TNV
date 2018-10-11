//%attributes = {}
  // Método: Log_RegisterEvtSTW
  // código original de: RC, DL
  // modificado por Alberto Bachler Klein, 08/08/18, 09:24:18
  //  limpieza, normalización, declaración de variables
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($vl_idUsuario)
C_TEXT:C284($vt_actividad)


If (False:C215)
	C_TEXT:C284(Log_RegisterEvtSTW ;$1)
	C_LONGINT:C283(Log_RegisterEvtSTW ;$2)
End if 

$vt_actividad:=$1
$vl_idUsuario:=$2



LOG_RegisterEvt ($vt_actividad;0;0;$vl_idUsuario;"SchoolTrack Web Access")


