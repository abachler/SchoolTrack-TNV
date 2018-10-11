//%attributes = {}
  // SN3_BuildMenu()
  // Por: Alberto Bachler K.: 31-08-15, 10:07:37
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_itemActivo)
C_TEXT:C284($t_menuItems)

C_TEXT:C284(vmref_SN3SubMenuRef)

  //ARRAY TEXT($at_itemsMenu;8)
  //If (USR_GetUserID <0)
  //ARRAY TEXT($at_itemsMenu;9)
  //End if 
  //20180925 RCH Textos en componente de xshell en IN. Si se cambia o agrega alguno, modificar IN.
  //$at_itemsMenu{1}:=__ ("Opciones Generales")
  //$at_itemsMenu{2}:=__ ("Opciones de Publicación")
  //$at_itemsMenu{3}:=__ ("Plantillas de Publicación")
  //$at_itemsMenu{4}:=__ ("Usuarios y Contraseñas")
  //$at_itemsMenu{5}:=__ ("Opciones de Envío")
  //$at_itemsMenu{6}:=__ ("Consulta de Usuarios")
  //$at_itemsMenu{7}:=__ ("Registro de Actividades")
  //$at_itemsMenu{8}:=__ ("Actualización de Datos")

  //20180925 RCH Textos en componente de xshell en IN. Si se cambia o agrega alguno, modificar IN.
C_OBJECT:C1216($o_datosFuncion)
ARRAY TEXT:C222($at_itemsMenu;0)
OB SET:C1220($o_datosFuncion;"modulo";41)
OB SET:C1220($o_datosFuncion;"accion";"obtienemenu")
$o_datosFuncion:=STC_ObtieneDatos ($o_datosFuncion)
OB GET ARRAY:C1229($o_datosFuncion;"items";$at_itemsMenu)

If (vmref_SN3SubMenuRef#"")
	RELEASE MENU:C978(vmref_SN3SubMenuRef)
End if 

vmref_SN3SubMenuRef:=Create menu:C408

$t_menuItems:=AT_array2text (->$at_itemsMenu)
APPEND MENU ITEM:C411(vmref_SN3SubMenuRef;$t_menuItems;Current process:C322)
APPEND MENU ITEM:C411(6;"(-";Current process:C322)
APPEND MENU ITEM:C411(6;"SchoolNet";vmref_SN3SubMenuRef;Current process:C322)
  //20152010 JVP se cambia validacion debido a que existen procesos autorizados que no tienen validacion
  //$b_itemActivo:=(USR_GetMethodAcces ("CFG_SchoolNetConfiguration";0)) & LICENCIA_esModuloAutorizado (1;SchoolNet)
$b_itemActivo:=LICENCIA_esModuloAutorizado (1;SchoolNet)
MNU_SetMenuItemState ($b_itemActivo;6;5)

