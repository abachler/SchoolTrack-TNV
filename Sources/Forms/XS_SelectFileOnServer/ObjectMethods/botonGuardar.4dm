If (vt_nombreArchivo#"")
	GET LIST ITEM:C378(hl_Volumes;Selected list items:C379(hl_Volumes);$l_itemRef;$t_volumeName;$t_sublist;$b_expanded)
	GET LIST ITEM PARAMETER:C985(hl_Volumes;$l_itemRef;"Path";vt_SelectedFolderPath)
	vt_rutaArchivo:=vt_SelectedFolderPath+SYS_FolderDelimiterOnServer +vt_nombreArchivo
	ACCEPT:C269
End if 

