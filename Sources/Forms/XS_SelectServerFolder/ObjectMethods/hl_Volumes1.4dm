  // XS_SelectServerFolder.hl_Volumes1()
  // Por: Alberto Bachler K.: 08-11-14, 19:05:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_Blob)
C_BOOLEAN:C305($b_expanded)
C_LONGINT:C283($ii;$l_directoryRef;$l_itemRef;$l_sublist;$l_subListRef)
C_PICTURE:C286($p_icon)
C_TEXT:C284($t_folderPath;$t_itemText;$t_parameters;$t_path;$t_volumeName)
  // Código principal
Case of 
	: ((Form event:C388=On Selection Change:K2:29) | (Form event:C388=On Clicked:K2:4) | ($t_parameters="updateDirectory"))
		GET LIST ITEM:C378(hl_Volumes;*;$l_directoryRef;$t_volumeName;$l_subListRef;$b_Expanded)
		GET LIST ITEM PARAMETER:C985(hl_Volumes;$l_directoryRef;"Path";$t_path)
		$x_Blob:=SYS_GetServerFolderHList ($t_path)
		If (BLOB size:C605($x_Blob)>0)
			$l_subListRef:=BLOB to list:C557($x_Blob)
			For ($ii;1;Count list items:C380($l_subListRef))
				GET LIST ITEM:C378($l_subListRef;$ii;$l_itemRef;$t_itemText)
				SET LIST ITEM PARAMETER:C986($l_subListRef;$l_itemRef;Additional text:K28:7;String:C10($l_itemRef))
				GET LIST ITEM PARAMETER:C985($l_subListRef;$l_itemRef;"Path";$t_folderPath)
				$p_icon:=SYS_GetServerDocumentIcon ($t_folderPath;16)
				SET LIST ITEM ICON:C950($l_subListRef;$l_itemRef;$p_icon)
			End for 
			SET LIST ITEM:C385(hl_Volumes;$l_directoryRef;$t_volumeName;$l_directoryRef;$l_subListRef;True:C214)
		End if 
		GET LIST ITEM:C378(hl_Volumes;Selected list items:C379(hl_Volumes);$l_itemRef;$t_volumeName;$l_subListRef;$b_expanded)
		GET LIST ITEM PARAMETER:C985(hl_Volumes;$l_itemRef;"Path";$t_path)
		
	: (Form event:C388=On Collapse:K2:42)
		GET LIST ITEM:C378(hl_Volumes;Selected list items:C379(hl_Volumes);$l_itemRef;$t_volumeName;$l_subListRef;$b_expanded)
		SET LIST ITEM:C385(hl_Volumes;$l_itemRef;$t_volumeName;$l_itemRef;$l_subListRef;False:C215)
		GET LIST ITEM PARAMETER:C985(hl_Volumes;$l_itemRef;"Path";$t_path)
		_O_REDRAW LIST:C382(hl_Volumes)
		
	: (Form event:C388=On Expand:K2:41)
		GET LIST ITEM:C378(hl_Volumes;Selected list items:C379(hl_Volumes);$l_itemRef;$t_volumeName;$l_subListRef;$b_expanded)
		SET LIST ITEM:C385(hl_Volumes;$l_itemRef;$t_volumeName;$l_itemRef;$l_subListRef;True:C214)
		GET LIST ITEM PARAMETER:C985(hl_Volumes;$l_itemRef;"Path";$t_path)
		_O_REDRAW LIST:C382(hl_Volumes)
		
End case 

