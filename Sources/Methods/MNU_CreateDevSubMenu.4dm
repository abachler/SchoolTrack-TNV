//%attributes = {}
  //MNU_CreateDevSubMenu
  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 02/10/09, 09:09:52
  // ----------------------------------------------------
  // Método: MNU_ModuleRefMenus_Create
  // Descripción
  // Parámetros
  // ----------------------------------------------------
C_TEXT:C284(vtMNU_DevelopperMenu)
C_LONGINT:C283(vlMNU_ModuleReferencedMenus)
If ((<>lUSR_CurrentUserID<0) & (<>lUSR_CurrentUserID>=-101))
	ARRAY TEXT:C222($at_usuariosAutorizados;0)
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Alberto Bachler")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Luisa Aravena")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Andrea Barrios")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Eduardo Rojas")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Angel Ocaranza")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Constanza Valentina Osorio Escudero")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Javier Fonseca")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Katherine Figueroa Andrades")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Patricio Aliaga")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Ruben Giraldo")
	APPEND TO ARRAY:C911($at_usuariosAutorizados;"Saul Ponce")
	$b_usuarioQA_Informes:=(Find in array:C230($at_usuariosAutorizados;<>tUSR_CurrentUser)>0)
	$b_itemActivo:=Not:C34(Is compiled mode:C492)
	If (Macintosh option down:C545 | Windows Alt down:C563)
		RELEASE MENU:C978(vtMNU_DevelopperMenu)
		vtMNU_DevelopperMenu:=""
		$l_elemento:=Find in array:C230(atMNU_ModuleReferencesMenus;vtMNU_DevelopperMenu)
		If ($l_elemento>0)
			DELETE FROM ARRAY:C228(atMNU_ModuleReferencesMenus;$l_elemento)
		End if 
	End if 
	If (vtMNU_DevelopperMenu="")
		vtMNU_DevelopperMenu:=Create menu:C408
		APPEND TO ARRAY:C911(atMNU_ModuleReferencesMenus;vtMNU_DevelopperMenu)
		MNU_Append (vtMNU_DevelopperMenu;"Generar aplicaciones…";"";($b_itemActivo & (Application type:C494=4D Local mode:K5:1));"";"BUILD_Start";"G";Option key mask:K16:7+Command key mask:K16:1;"";True:C214)
		APPEND MENU ITEM:C411(vtMNU_DevelopperMenu;"(-")
		MNU_Append (vtMNU_DevelopperMenu;"Editor de metadatos…";"";$b_itemActivo;"";"MDATA_Configuracion";"";0;"";True:C214)
		APPEND MENU ITEM:C411(vtMNU_DevelopperMenu;"(-")
		MNU_Append (vtMNU_DevelopperMenu;"Selector RGB";"";$b_itemActivo;"";"0xDEV_RGBColorSelector")
		APPEND MENU ITEM:C411(vtMNU_DevelopperMenu;"(-")
		MNU_Append (vtMNU_DevelopperMenu;"VC4D";"";$b_itemActivo;"";"VC4D_FindModifiedObjects";"F";Option key mask:K16:7+Command key mask:K16:1;"";True:C214)
		MNU_Append (vtMNU_DevelopperMenu;"Index";"";<>lUSR_CurrentUserID=-1;"";"DEV_Indexacion";"";0;"";True:C214)
		MNU_Append (vtMNU_DevelopperMenu;"Revisar métodos no utilizados";"";$b_itemActivo;"";"4D_ObjetosInutilizados";"";0;"";True:C214)
		APPEND MENU ITEM:C411(vtMNU_DevelopperMenu;"(-")
		MNU_Append (vtMNU_DevelopperMenu;"Buscar código en informes";"";$b_usuarioQA_Informes;"";"0xDev_BuscaScriptEnInformeSR";"";0;"";True:C214)
		If (Folder separator:K24:12=":")
			APPEND MENU ITEM:C411(vtMNU_DevelopperMenu;"(-")
			$b_itemActivo:=$b_itemActivo & (Application type:C494=4D Local mode:K5:1)
			MNU_Append (vtMNU_DevelopperMenu;"Explorador 4D";"";$b_itemActivo;"";"MNU_4DExplorer";"E";Option key mask:K16:7+Command key mask:K16:1)
			MNU_Append (vtMNU_DevelopperMenu;"Métodos";"";$b_itemActivo;"";"MNU_4DMethods";"K";Option key mask:K16:7+Command key mask:K16:1)
			MNU_Append (vtMNU_DevelopperMenu;"Formularios";"";$b_itemActivo;"";"MNU_4DForms";"L";Option key mask:K16:7+Command key mask:K16:1)
			MNU_Append (vtMNU_DevelopperMenu;"Caja de Herramientas";"";$b_itemActivo;"";"MNU_ToolBox";"T";Option key mask:K16:7+Command key mask:K16:1)
			MNU_Append (vtMNU_DevelopperMenu;"Modo usuario";"";$b_itemActivo;"";"";"U";Option key mask:K16:7+Command key mask:K16:1)
			APPEND MENU ITEM:C411(vtMNU_DevelopperMenu;"(-")
			MNU_Append (vtMNU_DevelopperMenu;"Nuevo Método";"";$b_itemActivo;"";"MNU_4DNewMethod";"K";Option key mask:K16:7+Shift key mask:K16:3+Command key mask:K16:1)
			MNU_Append (vtMNU_DevelopperMenu;"Nuevo Formulario";"";$b_itemActivo;"";"MNU_4DNewForm";"L";Option key mask:K16:7+Shift key mask:K16:3+Command key mask:K16:1)
		End if 
	End if 
	$t_menuBarRef:=Get menu bar reference:C979
	APPEND MENU ITEM:C411($t_menuBarRef;"Desarrollo";vtMNU_DevelopperMenu)
	  //para crear menus específicos a la aplicación
	dhMNU_CreateReferencedMenus 
End if 