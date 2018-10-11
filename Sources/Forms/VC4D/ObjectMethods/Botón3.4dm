  // VC4D.Botón3()
  //
  //
  // creado por: Alberto Bachler Klein: 08-02-16, 13:13:06
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_windowRef)
C_POINTER:C301($y_alias;$y_namespace;$y_password;$y_status;$y_url_lista;$y_userName;$y_webserviceName)
C_TEXT:C284($t_alias;$t_item;$t_itemSeleccionado;$t_menuRef;$t_namespace;$t_password;$t_url;$t_username;$t_webserviceName)
C_OBJECT:C1216($ob_config)

ARRAY OBJECT:C1221($ao_servers;0)

$y_alias:=OBJECT Get pointer:C1124(Object named:K67:5;"aliasServidor_lista")
$y_url_lista:=OBJECT Get pointer:C1124(Object named:K67:5;"url_lista")
$y_webserviceName:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName_lista")
$y_namespace:=OBJECT Get pointer:C1124(Object named:K67:5;"namespace_lista")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"username_lista")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password_lista")
$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer_lista")
$y_servidorSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"servidorSeleccionado")


$t_menuRef:=Create menu:C408
For ($i;1;Size of array:C274($y_alias->))
	APPEND MENU ITEM:C411($t_menuRef;$y_alias->{$i})
	SET MENU ITEM PARAMETER:C1004($t_menuRef;-1;$y_alias->{$i})
End for 


APPEND MENU ITEM:C411($t_menuRef;"(-;Editar lista de servidores…")
SET MENU ITEM PARAMETER:C1004($t_menuRef;-1;"editar")

$t_itemSeleccionado:=Dynamic pop up menu:C1006($t_menuRef)

Case of 
	: ($t_itemSeleccionado="editar")
		VC4D_Setup 
		
	Else 
		$l_elemento:=Find in array:C230($y_alias->;$t_itemSeleccionado)
		If ($l_elemento>0)
			(OBJECT Get pointer:C1124(Object named:K67:5;"url"))->:=$y_url_lista->{$l_elemento}
			(OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName"))->:=$y_webserviceName->{$l_elemento}
			(OBJECT Get pointer:C1124(Object named:K67:5;"namespace"))->:=$y_namespace->{$l_elemento}
			(OBJECT Get pointer:C1124(Object named:K67:5;"userName"))->:=$y_userName->{$l_elemento}
			(OBJECT Get pointer:C1124(Object named:K67:5;"password"))->:=$y_password->{$l_elemento}
			AT_Initialize ($y_servidorSeleccionado)
			APPEND TO ARRAY:C911($y_servidorSeleccionado->;$y_alias->{$l_elemento})
			$y_servidorSeleccionado->:=1
		End if 
End case 

