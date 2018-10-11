//%attributes = {}
  // MÉTODO: xDOC_Picture_IsCodecAvailable
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/11, 10:52:41
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // xDOC_Picture_IsCodecAvailable()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1;$codec)
_O_ARRAY STRING:C218(4;$aCodecNames;0)
$codec:=$1


  // CODIGO PRINCIPAL
PICTURE CODEC LIST:C992($aCodecNames)
$0:=(Find in array:C230($aCodecNames;$codec)>0)


