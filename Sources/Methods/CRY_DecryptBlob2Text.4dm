//%attributes = {}
  // Método: CRY_DecryptBlob2Text
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/07/10, 10:33:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BLOB:C604($llavePrivada;$llavePublica;$xCifrado;$xKeys;$1;$2)
C_LONGINT:C283($objectRef)
C_TEXT:C284($0;$decrypted)

  // Código principal
$xCifrado:=$1
If (Count parameters:C259=2)
	$llavePublica:=$2
Else 
	$blob:=$xCifrado
	$docPath:=Get 4D folder:C485(Current resources folder:K5:16)+"Files"+Folder separator:K24:12+"kinfo.txt"
	DOCUMENT TO BLOB:C525($docPath;$xKeys)
	EXPAND BLOB:C535($xKeys)
	$objectRef:=OT BLOBToObject ($xKeys)
	OT GetBLOB ($objectRef;"pub";$llavePublica)
	OT Clear ($objectRef)
End if 
DECRYPT BLOB:C690($xCifrado;$llavePublica)
$decrypted:=BLOB to text:C555($xCifrado;UTF8 text without length:K22:17)
$0:=$decrypted



