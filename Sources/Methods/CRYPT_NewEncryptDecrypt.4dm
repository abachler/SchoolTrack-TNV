//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 27-07-17, 10:15:46
  // ----------------------------------------------------
  // Método: CRYPT_NewEncryptDecrypt
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($t_accion;$1;$t_textoIn;$t_keyType;$2;$3;$0;$t_textoOut;$t_key)
C_BOOLEAN:C305($4;$b_base64)
C_LONGINT:C283($l_HL_CryptNew)
C_BLOB:C604($x_textoIn;$x_key)

$t_accion:=$1  //encrypt, decrypt4d, decryptNo4d
$t_keyType:=$2  //public, private
$t_textoIn:=$3

If (Count parameters:C259=4)
	$b_base64:=$4
End if 

$l_HL_CryptNew:=Load list:C383("CryptNew")
Case of 
	: ($t_keyType="private")
		GET LIST ITEM PARAMETER:C985($l_HL_CryptNew;1;"priv";$t_key)
	: ($t_keyType="public")
		GET LIST ITEM PARAMETER:C985($l_HL_CryptNew;2;"pub";$t_key)
End case 
HL_ClearList ($l_HL_CryptNew)
TEXT TO BLOB:C554($t_key;$x_key;UTF8 text without length:K22:17)

Case of 
	: ($t_accion="encrypt")
		TEXT TO BLOB:C554($t_textoIn;$x_textoIn;UTF8 text without length:K22:17)
		SET BLOB SIZE:C606($x_textoIn;BLOB size:C605($x_textoIn)-1)
		ENCRYPT BLOB:C689($x_textoIn;$x_key)
		
		If ($b_base64)
			BASE64 ENCODE:C895($x_textoIn;$t_textoOut)
		Else 
			$t_textoOut:=BLOB to text:C555($x_textoIn;UTF8 text without length:K22:17)
		End if 
		
	: ($t_accion="decrypt4d")
		If ($b_base64)
			BASE64 DECODE:C896($t_textoIn;$x_textoIn)
		Else 
			TEXT TO BLOB:C554($t_textoIn;$x_textoIn;UTF8 text without length:K22:17)
		End if 
		
		DECRYPT BLOB:C690($x_textoIn;$x_key)
		$t_textoOut:=Convert to text:C1012($x_textoIn;"UTF-8")
		
	: ($t_accion="decryptNo4d")
		
		If ($b_base64)
			BASE64 DECODE:C896($t_textoIn;$x_textoIn)
		Else 
			TEXT TO BLOB:C554($t_textoIn;$x_textoIn;UTF8 text without length:K22:17)
		End if 
		
		INSERT IN BLOB:C559($x_textoIn;0;3)
		$x_textoIn{0}:=1
		$x_textoIn{1}:=2
		$x_textoIn{2}:=0
		DECRYPT BLOB:C690($x_textoIn;$x_key)
		$t_textoOut:=Convert to text:C1012($x_textoIn;"UTF-8")
		
End case 

$0:=$t_textoOut