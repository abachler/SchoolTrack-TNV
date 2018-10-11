  // VC4D_Config.List Box()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 17:02:41
  // -----------------------------------------------------------
C_POINTER:C301($y_alias;$y_namespace;$y_password;$y_url;$y_userName;$y_webserviceName)

$y_alias:=OBJECT Get pointer:C1124(Object named:K67:5;"aliasServidor")
$y_url:=OBJECT Get pointer:C1124(Object named:K67:5;"url")
$y_webserviceName:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
$y_namespace:=OBJECT Get pointer:C1124(Object named:K67:5;"namespace")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"username")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password")

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		
		
		If ($y_alias->>0)
			(OBJECT Get pointer:C1124(Object named:K67:5;"in_aliasServidor"))->:=$y_alias->{$y_alias->}
			(OBJECT Get pointer:C1124(Object named:K67:5;"in_url"))->:=$y_url->{$y_alias->}
			(OBJECT Get pointer:C1124(Object named:K67:5;"in_webServiceName"))->:=$y_webserviceName->{$y_alias->}
			(OBJECT Get pointer:C1124(Object named:K67:5;"in_namespace"))->:=$y_namespace->{$y_alias->}
			(OBJECT Get pointer:C1124(Object named:K67:5;"in_username"))->:=$y_userName->{$y_alias->}
			(OBJECT Get pointer:C1124(Object named:K67:5;"in_password"))->:=$y_password->{$y_alias->}
			FORM GOTO PAGE:C247(2)
		Else 
			POST KEY:C465(Character code:C91("+");Command key mask:K16:1)
		End if 
		
	: (Form event:C388=On Selection Change:K2:29)
		OBJECT SET ENABLED:C1123(*;"remove";$y_alias->>0)
End case 