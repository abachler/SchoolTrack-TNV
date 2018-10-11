  // VC4D_Config.add()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 10:44:32
  // -----------------------------------------------------------
C_POINTER:C301($y_alias;$y_namespace;$y_password;$y_url;$y_userName;$y_webserviceName)

$y_alias:=OBJECT Get pointer:C1124(Object named:K67:5;"aliasServidor")
$y_url:=OBJECT Get pointer:C1124(Object named:K67:5;"url")
$y_webserviceName:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
$y_namespace:=OBJECT Get pointer:C1124(Object named:K67:5;"namespace")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"username")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password")

(OBJECT Get pointer:C1124(Object named:K67:5;"in_aliasServidor"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"in_url"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"in_webServiceName"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"in_namespace"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"in_username"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"in_password"))->:=""

FORM GOTO PAGE:C247(2)
