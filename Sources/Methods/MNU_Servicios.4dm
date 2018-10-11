//%attributes = {}
  // MNU_Servicios()
  // Por: Alberto Bachler K.: 31-08-15, 10:33:20
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284(vmref_submenu_AD)

  // STWA
$b_itemActivo:=(USR_GetMethodAcces ("STWA2_AdminStartProcess";0)) & LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access)
APPEND MENU ITEM:C411(6;"SchoolTrack Web Access…";Current process:C322)
SET MENU ITEM METHOD:C982(6;-1;"STWA2_AdminStartProcess")
MNU_SetMenuItemState ($b_itemActivo;6;1)
  //


  // Google Apps
$b_itemActivo:=LICENCIA_esModuloAutorizado (2;13)
APPEND MENU ITEM:C411(6;"-")
APPEND MENU ITEM:C411(6;"Google Apps…";Current process:C322)
SET MENU ITEM METHOD:C982(6;-1;"GAFE_OpenForm")
MNU_SetMenuItemState ($b_itemActivo;6;3)
  //


  //Schoolnet
SN3_BuildMenu 
  //


  // Actualizacion de datos
If (vmref_submenu_AD#"")
	RELEASE MENU:C978(vmref_submenu_AD)
End if 
vmref_submenu_AD:=Create menu:C408
APPEND MENU ITEM:C411(vmref_submenu_AD;__ ("Descargar datos");Current process:C322)
SET MENU ITEM METHOD:C982(vmref_submenu_AD;1;"SN3_ActuaDatos_Download")
APPEND MENU ITEM:C411(vmref_submenu_AD;__ ("Revisión y actualización");Current process:C322)
SET MENU ITEM METHOD:C982(vmref_submenu_AD;2;"SN3_ActuaDatos_OpenREV")
APPEND MENU ITEM:C411(vmref_submenu_AD;__ ("Información de actualizaciones");Current process:C322)
SET MENU ITEM METHOD:C982(vmref_submenu_AD;3;"SN3_ActuaDatos_OpenINFO")
APPEND MENU ITEM:C411(vmref_submenu_AD;__ ("Registro de actividades");Current process:C322)
SET MENU ITEM METHOD:C982(vmref_submenu_AD;4;"SN3_ActuaDatos_OpenLOG")

ARRAY TEXT:C222($at_timnu;0)
ARRAY TEXT:C222($at_refmnu;0)
GET MENU ITEMS:C977(vmref_submenu_AD;$at_timnu;$at_refmnu)

If (<>ACTUADATOS_ID_USR_REV=0)  //MONO 203046: ID del encargado de la actualzación de datos
	GET PROCESS VARIABLE:C371(-1;<>ACTUADATOS_ID_USR_REV;<>ACTUADATOS_ID_USR_REV)
End if 

If ((<>lUSR_CurrentUserID=<>ACTUADATOS_ID_USR_REV) | ((<>lUSR_CurrentUserID>-99) & (<>lUSR_CurrentUserID<0)))
	ENABLE MENU ITEM:C149(vmref_submenu_AD;Find in array:C230($at_timnu;__ ("Descargar datos"));Current process:C322)
	ENABLE MENU ITEM:C149(vmref_submenu_AD;Find in array:C230($at_timnu;__ ("Revisión y actualización"));Current process:C322)
Else 
	DISABLE MENU ITEM:C150(vmref_submenu_AD;Find in array:C230($at_timnu;__ ("Descargar datos"));Current process:C322)
	DISABLE MENU ITEM:C150(vmref_submenu_AD;Find in array:C230($at_timnu;__ ("Revisión y actualización"));Current process:C322)
End if 

  //$vb_per_SN:=USR_GetMethodAcces ("CFG_SchoolNetConfiguration";0)
$vb_per_SN:=USR_GetMethodAcces ("SN3_OpenConfig_ActuaDatos";0)  //20180425 RCH El proceso autorizado no era encontrado. Con este permiso se puede acceder desde el menú SN a la info.
If ($vb_per_SN)
	ENABLE MENU ITEM:C149(vmref_submenu_AD;Find in array:C230($at_timnu;__ ("Información de actualizaciones"));Current process:C322)
	ENABLE MENU ITEM:C149(vmref_submenu_AD;Find in array:C230($at_timnu;__ ("Registro de actividades"));Current process:C322)
Else 
	DISABLE MENU ITEM:C150(vmref_submenu_AD;Find in array:C230($at_timnu;__ ("Información de actualizaciones"));Current process:C322)
	DISABLE MENU ITEM:C150(vmref_submenu_AD;Find in array:C230($at_timnu;__ ("Registro de actividades"));Current process:C322)
End if 

APPEND MENU ITEM:C411(6;"(-";Current process:C322)
APPEND MENU ITEM:C411(6;__ ("Actualización de Datos");vmref_submenu_AD;Current process:C322)
  //