  // [xShell_Reports].ReportProperties.permisosGrupos()
  // Por: Alberto Bachler K.: 20-08-14, 11:06:01
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_LONGINT:C283($i_elemento;$l_idGrupo;$l_IdGrupoSeleccionado)
C_TEXT:C284($t_grupoSeleccionado;$t_nombreGrupo;$t_refAcciones;$t_refElemento;$t_refMenuGrupos)

GET LIST ITEM:C378(hlQR_authorizedGroups;Selected list items:C379(hlQR_authorizedGroups);$l_IdGrupoSeleccionado;$t_grupoSeleccionado)


$t_refMenuGrupos:=Create menu:C408
For ($i_elemento;1;Count list items:C380(hlUSR_Groups))
	GET LIST ITEM:C378(hlUSR_Groups;$i_elemento;$l_idGrupo;$t_nombreGrupo)
	If (Find in list:C952(hlQR_AuthorizedGroups;$t_nombreGrupo;0)=0)
		APPEND MENU ITEM:C411($t_refMenuGrupos;$t_nombreGrupo)
		SET MENU ITEM PARAMETER:C1004($t_refMenuGrupos;-1;"A"+String:C10($l_idGrupo))
	End if 
End for 

$t_refAcciones:=Create menu:C408
APPEND MENU ITEM:C411($t_refAcciones;__ ("Añadir grupo");$t_refMenuGrupos)
If ($t_grupoSeleccionado#"")
	APPEND MENU ITEM:C411($t_refAcciones;__ ("Quitar grupo ")+$t_grupoSeleccionado)
Else 
	APPEND MENU ITEM:C411($t_refAcciones;"("+__ ("Quitar grupo"))
End if 
SET MENU ITEM PARAMETER:C1004($t_refAcciones;-1;"Q"+String:C10($l_IdGrupoSeleccionado))


$t_refElemento:=Dynamic pop up menu:C1006($t_refAcciones)
RELEASE MENU:C978($t_refMenuGrupos)
RELEASE MENU:C978($t_refAcciones)

Case of 
	: ($t_refElemento="A@")
		$l_idGrupo:=Num:C11($t_refElemento)
		SELECT LIST ITEMS BY REFERENCE:C630(hlUSR_Groups;$l_idGrupo)
		GET LIST ITEM:C378(hlUSR_Groups;Selected list items:C379(hlUSR_Groups);$l_idGrupo;$t_nombreGrupo)
		APPEND TO LIST:C376(hlQR_AuthorizedGroups;$t_nombreGrupo;$l_idGrupo)
		SORT LIST:C391(hlQR_AuthorizedGroups)
		LIST TO BLOB:C556(hlQR_AuthorizedGroups;[xShell_Reports:54]xAuthorizedGroups:27)
		SELECT LIST ITEMS BY REFERENCE:C630(hlQR_AuthorizedGroups;$l_idGrupo)
		If ((Count list items:C380(hlQR_AuthorizedGroups)=0) & (Count list items:C380(hlQR_AuthorizedUsers)=0))
			[xShell_Reports:54]Public:8:=False:C215
		End if 
	: ($t_refElemento="Q@")
		$l_idGrupo:=Num:C11($t_refElemento)
		DELETE FROM LIST:C624(hlQR_AuthorizedGroups;$l_idGrupo)
		SORT LIST:C391(hlQR_AuthorizedGroups)
		LIST TO BLOB:C556(hlQR_AuthorizedGroups;[xShell_Reports:54]xAuthorizedGroups:27)
		SELECT LIST ITEMS BY REFERENCE:C630(hlUSR_Groups;0)
End case 