//%attributes = {}
  //QR_SetReportManagerMenu

C_TEXT:C284(vtQR_CurrentReportType)

C_BOOLEAN:C305($isStandard;$isPublic;$cannotBeEdited)
C_LONGINT:C283($folderRef)
C_TEXT:C284($folderName)
ARRAY TEXT:C222($aMenuItems;0)

If (vbQR_FavoritesSelected)
	GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$folderRef;$folderName)
	$folderName:="["+$folderName+"]"
End if 
$RecsInList:=(Count list items:C380(hl_informes)>0)
$canAddReport:=(([xShell_Reports:54]ReportType:2#"4DFO") & (USR_checkRights ("L";vyQR_TablePointer)))
$userIsPropietary:=(((<>lUSR_CurrentUserID=[xShell_Reports:54]Propietary:9) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))) & ($RecsInList))
$isStandard:=(([xShell_Reports:54]IsStandard:38) & ($RecsInList))
$isPublic:=(([xShell_Reports:54]Public:8) & ($RecsInList))
$reportIsAllowed:=((($userIsPropietary) | (QR_IsReportAllowed )) & ($RecsInList))
$hasQuery:=Num:C11(BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)>0)
$canBeStandard:=((<>lUSR_CurrentUserID<0) & ($RecsInList))
$canBeEdited:=(($userIsPropietary) & ([xShell_Reports:54]ReportType:2#"4DFO"))
$propertiesAllowed:=$userIsPropietary
$canBeRenamed:=(($userIsPropietary) | (([xShell_Reports:54]ReportType:2="4DFO") & (<>lUSR_CurrentUserID<0)))
$canbeDuplicated:=((($userIsPropietary) | ($isPublic) | ($isStandard)) & ([xShell_Reports:54]ReportType:2#"4DFO") & (vbQR_FavoritesSelected=False:C215))
$canBePrinted:=(($reportIsAllowed) & ((Records in selection:C76(vyQR_TablePointer->)>0) | ([xShell_Reports:54]NoRequiereSeleccion:40)))
$canBeDeleted:=((([xShell_Reports:54]ReportType:2#"4DFO") & (Not:C34($isStandard) & ($userIsPropietary)) | (<>lUSR_CurrentUserID<0)) & ($RecsInList))
$canBeSentToText:=($canBePrinted & ([xShell_Reports:54]ReportType:2#"4DFO"))
$canBeSentToHTML:=($canBePrinted & ([xShell_Reports:54]ReportType:2#"4DFO"))
$canBeSentTo4DView:=($canBePrinted & ([xShell_Reports:54]ReportType:2="4DSE"))
$canBeSentToGraph:=($canBePrinted & ([xShell_Reports:54]ReportType:2="4DSE"))
$canArchiveModel:=($reportIsAllowed & ([xShell_Reports:54]ReportType:2#"4DFO"))
$sn:=LICENCIA_esModuloAutorizado (1;SchoolNet)

$canBeUploaded2SN:=($canBePrinted & [xShell_Reports:54]isOneRecordReport:11 & (vtQR_CurrentReportType="gSR2") & $sn)
$canBeUploaded2SN:=$canBeUploaded2SN & (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))

MNU_SetMenuBar ("XS_ReportManager")
MNU_SetMenuItemState ($canAddReport;1;1)
MNU_SetMenuItemState ($canBePrinted;1;3;1;4)
MNU_SetMenuItemState ($canBeSentToText;1;6)
MNU_SetMenuItemState ($canBeSentToHTML;1;7)
MNU_SetMenuItemState ($canBeSentTo4DView;1;8)
MNU_SetMenuItemState ($canBeSentToGraph;1;9)
MNU_SetMenuItemState ($canBeEdited;1;11)
MNU_SetMenuItemState ($canBeDuplicated;1;13)
MNU_SetMenuItemState ($canBeRenamed;1;14)
$favs:=Get menu item:C422(1;16;Current process:C322)
SET MENU ITEM:C348(1;16;$favs+" "+ST_Uppercase ($folderName))
MNU_SetMenuItemState (vbQR_FavoritesSelected;1;16)
MNU_SetMenuItemState ($canBeDeleted;1;17)
If ($isStandard)
	SET MENU ITEM MARK:C208(1;19;Char:C90(165))
End if 
MNU_SetMenuItemState ($canBeStandard;1;19)
If (($isPublic) | ($isStandard))
	SET MENU ITEM MARK:C208(1;20;Char:C90(165))
End if 
MNU_SetMenuItemState ($userIsPropietary;1;20)
If ($hasQuery=1)
	SET MENU ITEM MARK:C208(1;22;Char:C90(165))
End if 
MNU_SetMenuItemState ($userIsPropietary;1;22)
MNU_SetMenuItemState ($propertiesAllowed;1;23)
MNU_SetMenuItemState ($canArchiveModel;1;25)

APPEND TO ARRAY:C911($aMenuItems;"#01"+Get menu item:C422(1;1;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"(-")
APPEND TO ARRAY:C911($aMenuItems;"#03"+Get menu item:C422(1;3;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#04"+Get menu item:C422(1;4;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"(-")
APPEND TO ARRAY:C911($aMenuItems;"#06"+Get menu item:C422(1;6;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#07"+Get menu item:C422(1;7;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#08"+Get menu item:C422(1;8;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#09"+Get menu item:C422(1;9;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"(-")
APPEND TO ARRAY:C911($aMenuItems;"#11"+Get menu item:C422(1;11;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"(-")
APPEND TO ARRAY:C911($aMenuItems;"#13"+Get menu item:C422(1;13;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#14"+Get menu item:C422(1;14;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"(-")
APPEND TO ARRAY:C911($aMenuItems;"#16"+Get menu item:C422(1;16;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#17"+Get menu item:C422(1;17;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"(-")
APPEND TO ARRAY:C911($aMenuItems;"#19"+Get menu item:C422(1;19;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#20"+Get menu item:C422(1;20;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"(-")
APPEND TO ARRAY:C911($aMenuItems;"#22"+Get menu item:C422(1;22;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#23"+Get menu item:C422(1;23;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"(-")
APPEND TO ARRAY:C911($aMenuItems;"#25"+Get menu item:C422(1;25;Current process:C322))
APPEND TO ARRAY:C911($aMenuItems;"#26"+Get menu item:C422(1;26;Current process:C322))

$aMenuItems{1}:=Replace string:C233($aMenuItems{1};"#01";"("*Num:C11(Not:C34($canAddReport)))  //New
$aMenuItems{3}:=Replace string:C233($aMenuItems{3};"#03";"("*Num:C11(Not:C34($canBePrinted)))  //Print
$aMenuItems{4}:=Replace string:C233($aMenuItems{4};"#04";"("*Num:C11(Not:C34($canBePrinted)))  //Preview
$aMenuItems{6}:=Replace string:C233($aMenuItems{6};"#06";"("*Num:C11(Not:C34($canBeSentToText)))  //Text file
$aMenuItems{7}:=Replace string:C233($aMenuItems{7};"#07";"("*Num:C11(Not:C34($canBeSentToHTML)))  //html file
$aMenuItems{8}:=Replace string:C233($aMenuItems{8};"#08";"("*Num:C11(Not:C34($canBeSentTo4DView)))  //4D View
$aMenuItems{9}:=Replace string:C233($aMenuItems{9};"#09";"("*Num:C11(Not:C34($canBeSentToGraph)))  //4D Chart
$aMenuItems{11}:=Replace string:C233($aMenuItems{11};"#11";"("*Num:C11(Not:C34($canBeEdited)))  //Editar
$aMenuItems{13}:=Replace string:C233($aMenuItems{13};"#13";"("*Num:C11(Not:C34($canBeDuplicated)))  //duplicar
$aMenuItems{14}:=Replace string:C233($aMenuItems{14};"#14";"("*Num:C11(Not:C34($canBeRenamed)))  //renombrar
$aMenuItems{16}:=Replace string:C233($aMenuItems{16};"#16";"("*Num:C11(Not:C34(vbQR_FavoritesSelected)))+" "+ST_Uppercase ($folderName)  //retirar de favoritos
$aMenuItems{17}:=Replace string:C233($aMenuItems{17};"#17";"("*Num:C11(Not:C34($canBeDeleted)))  //eliminar
$aMenuItems{19}:=Replace string:C233($aMenuItems{19};"#19";"("*Num:C11(Not:C34($canBeStandard)))+(("!"+Char:C90(165))*Num:C11($isStandard))  //estándar
$aMenuItems{20}:=Replace string:C233($aMenuItems{20};"#20";"("*Num:C11(Not:C34($userIsPropietary)))+(("!"+Char:C90(165))*Num:C11(($isPublic) | ($isStandard)))  //public
$aMenuItems{22}:=Replace string:C233($aMenuItems{22};"#22";"("*Num:C11(Not:C34($userIsPropietary)))+(("!"+Char:C90(165))*$hasQuery)  //associated query
$aMenuItems{23}:=Replace string:C233($aMenuItems{23};"#23";"("*Num:C11(Not:C34($propertiesAllowed)))
$aMenuItems{25}:=Replace string:C233($aMenuItems{25};"#25";"("*Num:C11(Not:C34($canArchiveModel)))
$aMenuItems{26}:=Replace string:C233($aMenuItems{26};"#26";"")


vtQR_ContextualMenuItems:=AT_array2text (->$aMenuItems;";")

ARRAY TEXT:C222(atQR_PrintingPopUpItems;8)
atQR_PrintingPopUpItems{1}:=$aMenuItems{3}
atQR_PrintingPopUpItems{2}:=$aMenuItems{4}
atQR_PrintingPopUpItems{3}:="(-"
atQR_PrintingPopUpItems{4}:=$aMenuItems{6}
atQR_PrintingPopUpItems{5}:=$aMenuItems{7}
atQR_PrintingPopUpItems{6}:="(-"
atQR_PrintingPopUpItems{7}:=$aMenuItems{8}
atQR_PrintingPopUpItems{8}:=$aMenuItems{9}

MNU_SetMenuItemState (False:C215;2;11;2;13;2;14;2;15;2;16;2;18)

IT_SetButtonState (($canAddReport);->bNew)
IT_SetButtonState (($canBeEdited);->bEdit)
IT_SetButtonState (($canBePrinted);->bPreview)
IT_SetButtonState (($canBePrinted);->bPrint)
OBJECT SET ENABLED:C1123(bUpload2SN;($canBeUploaded2SN))