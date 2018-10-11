//%attributes = {"executedOnServer":true}
  // Método: SYS_GetServerVolumeAttributes
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 01/09/10, 12:19:07
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BLOB:C604($blob)
C_TEXT:C284($volumeName;$1)
C_REAL:C285($size;$used;$free)

$volumeName:=$1
  // Código principal

If (Test path name:C476($volumeName)=Is a folder:K24:2)
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
End if 
$0:=$blob

