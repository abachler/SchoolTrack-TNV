//%attributes = {}
  // Método: USR_DecryptPassword
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/07/10, 12:43:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($password;$text;$0)
C_BLOB:C604($encryptedPW;$llavePrivada;$llavePublica;$blob;$1)

  // Código principal
$blob:=$1
If (BLOB size:C605($blob)>0)
	$objectRef:=OT BLOBToObject ($blob)
	OT GetBLOB ($objectRef;"pvt";$llavePrivada)
	OT GetBLOB ($objectRef;"pub";$llavePublica)
	OT GetBLOB ($objectRef;"pass";$encryptedPW)
	OT Clear ($objectRef)  //2015/08/13
	$0:=CRY_DecryptBlob2Text ($encryptedPW;$llavePublica)
End if 


