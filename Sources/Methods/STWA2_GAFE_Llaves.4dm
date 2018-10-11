//%attributes = {}
C_LONGINT:C283($1;$idprof)
C_TEXT:C284($cp;$rol)

$idprof:=$1

$cp:=Lowercase:C14(<>vtXS_CountryCode)
$rol:=<>gRolBD

  //$cp:="cl"
  //$rol:="101010"

  //$string2Hash:=$rol
  //$err:=PHP Execute("";"hash";$res;"md5";$string2Hash)
  //$string2Hash:=$res+$cp
  //$err:=PHP Execute("";"hash";$res;"sha1";$string2Hash)
  //$string2Hash:=$res+String($idprof)
  //$err:=PHP Execute("";"hash";$llave;"sha1";$string2Hash)
  //$0:=$llave

C_BLOB:C604($blob)
CONVERT FROM TEXT:C1011($rol;"utf-8";$blob)
$res:=MD5 ($blob;Crypto HEX)
CONVERT FROM TEXT:C1011($res+$cp;"utf-8";$blob)
$res:=SHA1 ($blob;Crypto HEX)
CONVERT FROM TEXT:C1011($res+String:C10($idprof);"utf-8";$blob)
$llave:=SHA1 ($blob;Crypto HEX)

$0:=$llave