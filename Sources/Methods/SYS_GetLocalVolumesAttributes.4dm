//%attributes = {}
  // Método: SYS_GetLocalVolumesAttributes
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/09/10, 15:56:09
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BLOB:C604($blob;$2)
C_TEXT:C284($volumeName;$1)
C_REAL:C285($size;$used;$free)

$volumeName:=$1
  // Código principal
VOLUME ATTRIBUTES:C472($volumeName;$size;$used;$free)

If (SYS_IsWindows )
	$size:=Trunc:C95($size/1024/1024/1024;1)
	$used:=Trunc:C95($used/1024/1024/1024;1)
	$free:=Trunc:C95($free/1024/1024/1024;1)
Else 
	$size:=Trunc:C95($size/1000/1000/1000;1)
	$used:=Trunc:C95($used/1000/1000/1000;1)
	$free:=Trunc:C95($free/1000/1000/1000;1)
End if 

BLOB_Variables2Blob (->$blob;0;->$size;->$used;->$free)

$0:=$blob


