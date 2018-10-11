//%attributes = {}
  // Método: `CRY_EncryptText2Blob
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/07/10, 10:30:31
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($text;$1)
C_BLOB:C604($llavePrivada;$llavePublica;$xCifrado;$xKeys;$0)
C_POINTER:C301($keys;$2)
C_LONGINT:C283($objectRef)

  // Código principal
$text:=$1



$docPath:=Get 4D folder:C485(Current resources folder:K5:16)+"Files"+Folder separator:K24:12+"kinfo.txt"
DOCUMENT TO BLOB:C525($docPath;$xKeys)
EXPAND BLOB:C535($xKeys)
$objectRef:=OT BLOBToObject ($xKeys)
OT GetBLOB ($objectRef;"pvt";$llavePrivada)
OT GetBLOB ($objectRef;"pub";$llavePublica)
If (Count parameters:C259=2)
	$2->:=$xKeys
End if 

OT Clear ($objectRef)
TEXT TO BLOB:C554($text;$xCifrado;UTF8 text without length:K22:17)
ENCRYPT BLOB:C689($xCifrado;$llavePrivada)
$0:=$xCifrado

