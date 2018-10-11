//%attributes = {}
  // BWR_BrowserMenuHandler()
  // Por: Alberto Bachler: 09/03/13, 16:55:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($b_accionProcesada;$b_moduloAutorizado;$b_moduloLicenciado)
C_LONGINT:C283($l_itemMenuSeleccionado;$l_menuSeleccionado;$l_referenciaModulo)
C_TEXT:C284($t_metodo;$t_nombreModulo;$t_referenciaSubMenu)

If (False:C215)
	C_LONGINT:C283(BWR_BrowserMenuHandler ;$1)
	C_LONGINT:C283(BWR_BrowserMenuHandler ;$2)
	C_TEXT:C284(BWR_BrowserMenuHandler ;$3)
End if 

C_LONGINT:C283(<>lXS_ResourceEditorProcessID)
C_TEXT:C284(vmref_proyectSubMenuRef;vmref_SN3SubMenuRef;vmref_proyectSubMenuRef)
$t_referenciaSubMenu:=""
If (Count parameters:C259=3)
	$t_referenciaSubMenu:=$3
End if 
$l_menuSeleccionado:=$1
$l_itemMenuSeleccionado:=$2

If ($l_menuSeleccionado>0)
	$b_accionProcesada:=dhBWR_BrowserMenuHandler ($l_menuSeleccionado;$l_itemMenuSeleccionado)
	If (Not:C34($b_accionProcesada))
		Case of 
			: ($l_menuSeleccionado=7)
				If ((<>lUSR_CurrentUserID>-99) & (<>lUSR_CurrentUserID<0))
					Case of 
						Else 
							$t_metodo:=Get menu item method:C981($l_menuSeleccionado;$l_itemMenuSeleccionado)
							EXECUTE METHOD:C1007($t_metodo;*)
					End case 
				Else 
					Case of 
						Else 
							$t_metodo:=Get menu item method:C981($l_menuSeleccionado;$l_itemMenuSeleccionado)
							EXECUTE METHOD:C1007($t_metodo;*)
					End case 
				End if 
				
		End case 
	End if 
Else 
	If ($l_menuSeleccionado=0)  //aca manejamos jerarquicos!!!!
		If ($t_referenciaSubMenu#"")
			Case of 
				: ($t_referenciaSubMenu=vmref_proyectSubMenuRef)
					dhBWR_HandleProyections ($l_itemMenuSeleccionado)
				: ($t_referenciaSubMenu=vmref_SN3SubMenuRef)
					SN3_MenuHandler ($l_itemMenuSeleccionado)
			End case 
		End if 
	End if 
End if 