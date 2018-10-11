//%attributes = {}
  // Método: USR_EncryptPassWord
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/07/10, 12:10:11
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

C_TEXT:C284($1;$password)
C_BLOB:C604($xKeys;$encryptedPW;$xPass)


$password:=$1
If ($password#"")
	$encryptedPW:=CRY_EncryptText2Blob ($password;->$xKeys)
	$objectRef:=OT BLOBToObject ($xKeys)
	OT GetBLOB ($objectRef;"pvt";$llavePrivada)
	OT GetBLOB ($objectRef;"pub";$llavePublica)
	OT Clear ($objectRef)
	
	$objectRef:=OT New 
	OT PutBLOB ($objectRef;"pvt";$llavePrivada)
	OT PutBLOB ($objectRef;"pub";$llavePublica)
	OT PutBLOB ($objectRef;"pass";$encryptedPW)
	$xPass:=OT ObjectToNewBLOB ($objectRef)
	OT Clear ($objectRef)
End if 

$0:=$xPass







