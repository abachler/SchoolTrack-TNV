//%attributes = {}
  // QR_AjustesMenu()
  //
  //
  // creado por: Alberto Bachler Klein: 25-03-16, 09:39:03
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_conBusquedaAsociada;$b_conLicenciaSchoolNet;$b_crearInformeActivo;$b_envioSchoolnetPosible;$b_esArchivable;$b_esExportable_4DView;$b_esExportable_HTML;$b_esExportable_Texto;$b_esInformeEditable;$b_esInformeEstandar)
C_BOOLEAN:C305($b_esInformePublico;$b_hayInformeSeleccionado;$b_impresionPermitida;$b_propiedadesEditables;$b_puedeSerDuplicado;$b_puedeSerEjecutado;$b_puedeSerEliminado;$b_puedeSerEstandar;$b_puedeSerRenombrado;$b_usuarioEsPropietario)
C_BOOLEAN:C305($cannotBeEdited)
C_LONGINT:C283($folderRef)
C_POINTER:C301($y_refMenu)
C_TEXT:C284($t_carpetaFavoritos;$t_item)

ARRAY TEXT:C222($aMenuItems;0)



C_TEXT:C284(vtQR_CurrentReportType)


If (vbQR_FavoritesSelected)
	GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$folderRef;$t_carpetaFavoritos)
	$t_carpetaFavoritos:="["+$t_carpetaFavoritos+"]"
End if 
$b_hayInformeSeleccionado:=(Selected list items:C379(hl_informes)>0)
$b_crearInformeActivo:=(([xShell_Reports:54]ReportType:2#"4DFO") & (USR_checkRights ("L";vyQR_TablePointer)) & (USR_GetMethodAcces ("QR_NewTemplate";0)))
$b_usuarioEsPropietario:=(((<>lUSR_CurrentUserID=[xShell_Reports:54]Propietary:9) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))) & ($b_hayInformeSeleccionado))
$b_esInformeEstandar:=(([xShell_Reports:54]IsStandard:38) & ($b_hayInformeSeleccionado))
$b_esInformePublico:=(([xShell_Reports:54]Public:8) & ($b_hayInformeSeleccionado))
$b_impresionPermitida:=((($b_usuarioEsPropietario) | (QR_IsReportAllowed )) & ($b_hayInformeSeleccionado))
$b_conBusquedaAsociada:=(BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)>0)
$b_puedeSerEstandar:=((<>lUSR_CurrentUserID<0) & ($b_hayInformeSeleccionado))
$b_esInformeEditable:=Not:C34($b_esInformeEstandar) | ((<>lUSR_CurrentUserID<0) & (<>lUSR_CurrentUserID>-100))
$b_esInformeEditable:=$b_esInformeEditable & (([xShell_Reports:54]ReportType:2#"4DFO") & (($b_esInformePublico) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))) & (($b_usuarioEsPropietario) | (USR_GetMethodAcces ("QR_EditTemplate";0))))

$b_propiedadesEditables:=$b_usuarioEsPropietario
$b_puedeSerRenombrado:=(($b_usuarioEsPropietario) | (([xShell_Reports:54]ReportType:2="4DFO") & (<>lUSR_CurrentUserID<0)))
$b_puedeSerDuplicado:=((($b_usuarioEsPropietario) | ($b_esInformePublico) | ($b_esInformeEstandar)) & ([xShell_Reports:54]ReportType:2#"4DFO") & (vbQR_FavoritesSelected=False:C215) & (USR_GetMethodAcces ("QR_NewTemplate";0)))
$b_puedeSerEjecutado:=(($b_impresionPermitida) & ((Records in selection:C76(vyQR_TablePointer->)>0) | ([xShell_Reports:54]NoRequiereSeleccion:40)))
$b_puedeSerEliminado:=((([xShell_Reports:54]ReportType:2#"4DFO") & (Not:C34($b_esInformeEstandar) & ($b_usuarioEsPropietario)) | (<>lUSR_CurrentUserID<0)) & ($b_hayInformeSeleccionado))
$b_esExportable_Texto:=($b_puedeSerEjecutado & ([xShell_Reports:54]ReportType:2#"4DFO"))
$b_esExportable_XML:=($b_puedeSerEjecutado & ([xShell_Reports:54]ReportType:2="gSR2"))
$b_esExportable_Imagenes:=($b_puedeSerEjecutado & ([xShell_Reports:54]ReportType:2="gSR2"))
$b_esExportable_HTML:=($b_puedeSerEjecutado & ([xShell_Reports:54]ReportType:2#"4DFO"))
$b_esExportable_4DView:=($b_puedeSerEjecutado & ([xShell_Reports:54]ReportType:2="4DSE"))
$b_esArchivable:=($b_impresionPermitida & ([xShell_Reports:54]ReportType:2#"4DFO")) & ([xShell_Reports:54]IsStandard:38=False:C215)  //ABC 187033

$b_conLicenciaSchoolNet:=LICENCIA_esModuloAutorizado (1;SchoolNet)
$b_envioSchoolnetPosible:=($b_puedeSerEjecutado & [xShell_Reports:54]isOneRecordReport:11 & (vtQR_CurrentReportType="gSR2") & $b_conLicenciaSchoolNet)
$b_envioSchoolnetPosible:=$b_envioSchoolnetPosible & (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))

MNU_SetMenuBar ("XS_ReportManager")
MNU_SetMenuItemState ($b_crearInformeActivo;1;1)
MNU_SetMenuItemState ($b_esInformeEditable;1;5)
MNU_SetMenuItemState ($b_puedeSerDuplicado;1;7)
MNU_SetMenuItemState ($b_puedeSerRenombrado;1;8)
$favs:=Get menu item:C422(1;10;Current process:C322)
SET MENU ITEM:C348(1;10;$favs+" "+ST_Uppercase ($t_carpetaFavoritos))
MNU_SetMenuItemState (vbQR_FavoritesSelected;1;10)
MNU_SetMenuItemState ($b_puedeSerEliminado;1;11)
If ($b_esInformeEstandar)
	SET MENU ITEM MARK:C208(1;13;Char:C90(165))
End if 
MNU_SetMenuItemState ($b_puedeSerEstandar;1;13)
If (($b_esInformePublico) | ($b_esInformeEstandar))
	SET MENU ITEM MARK:C208(1;14;Char:C90(165))
End if 
MNU_SetMenuItemState ($b_usuarioEsPropietario;1;14)
If ($b_conBusquedaAsociada)
	SET MENU ITEM MARK:C208(1;16;Char:C90(165))
End if 
MNU_SetMenuItemState ($b_usuarioEsPropietario;1;16)
MNU_SetMenuItemState ($b_propiedadesEditables;1;17)
MNU_SetMenuItemState ($b_esArchivable;1;19)
MNU_SetMenuItemState ([xShell_Reports:54]IsStandard:38 & (<>lUSR_CurrentUserID<0) & (<>lUSR_CurrentUserID>-100);1;22)
$y_refMenu:=OBJECT Get pointer:C1124(Object named:K67:5;"menuImpresion")

If (Not:C34(Is nil pointer:C315($y_refMenu)))  //MONO 205372
	If ($y_refMenu->#"")
		RELEASE MENU:C978($y_refMenu->)
	End if 
	
	$y_refMenu->:=Create menu:C408
	MNU_Append ($y_refMenu->;__ ("Imprimir…");"printer";$b_puedeSerEjecutado;"";"";"P";Command key mask:K16:1)
	MNU_Append ($y_refMenu->;__ ("Previsualizar…");"preview";$b_puedeSerEjecutado;"";"";"P";Command key mask:K16:1+Shift key mask:K16:3)
	MNU_Append ($y_refMenu->;__ ("Enviar a PDF…");"pdf";$b_puedeSerEjecutado;"";"";"P";Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
	MNU_Append ($y_refMenu->;"(-")
	MNU_Append ($y_refMenu->;__ ("Exportar a un archivo de texto tabulado…");"txt";$b_esExportable_Texto)
	MNU_Append ($y_refMenu->;__ ("Enviar a planilla de calculo interna…");"4Dview";$b_esExportable_4DView)
	MNU_Append ($y_refMenu->;__ ("Exportar a un archivo xml…");"xml";$b_esExportable_xml)
	MNU_Append ($y_refMenu->;__ ("Exportar a imagenes…");"pict";$b_esExportable_Imagenes)
	MNU_Append ($y_refMenu->;__ ("Exportar a HTML…");"html";$b_esExportable_HTML)
	
	$t_item:=Get menu item:C422(1;3)
	DELETE MENU ITEM:C413(1;3;Current process:C322)
	INSERT MENU ITEM:C412(1;2;__ ("Imprimir");$y_refMenu->;Current process:C322)
	
End if 

MNU_SetMenuItemState (False:C215;2;11;2;13;2;14;2;15;2;16;2;18)

OBJECT SET ENABLED:C1123(*;"print@";$b_puedeSerEjecutado)
OBJECT SET ENABLED:C1123(*;"new";$b_crearInformeActivo)
OBJECT SET ENABLED:C1123(*;"edit";$b_esInformeEditable)

OBJECT SET ENABLED:C1123(bUpload2SN;$b_envioSchoolnetPosible)


Case of 
	: ($b_esInformeEditable)
		vtQR_Permissions:=__ ("Edición e impresión.")
		OBJECT SET COLOR:C271(vtQR_Permissions;-9)
		QR_GetAvailableTables 
		OBJECT SET VISIBLE:C603(hl_AvailableTables;True:C214)
		If ([xShell_Reports:54]RelatedTable:14>0)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_AvailableTables;[xShell_Reports:54]RelatedTable:14)
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_AvailableTables;[xShell_Reports:54]MainTable:3)
		End if 
		
	: (Not:C34(QR_IsReportAllowed ))
		vtQR_Permissions:=__ ("No tiene autorización para editar o imprimir este informe.")
		OBJECT SET COLOR:C271(vtQR_Permissions;-3)
		OBJECT SET VISIBLE:C603(hl_AvailableTables;False:C215)
		
	Else 
		vtQR_Permissions:=__ ("Solo impresión.")
		OBJECT SET COLOR:C271(vtQR_Permissions;-2)
		OBJECT SET VISIBLE:C603(hl_AvailableTables;False:C215)
		
End case 