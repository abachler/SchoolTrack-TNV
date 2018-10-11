  // XS_SelectServerFolder.nuevaCarpeta()
  // Por: Alberto Bachler K.: 09-11-14, 11:26:38
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($t_nombreCarpeta;$t_rutaCarpetaMadre)

If (Selected list items:C379(hl_volumes)>0)
	GET LIST ITEM:C378(hl_Volumes;*;$l_directoryRef;$t_volumeName;$l_subListRef;$b_Expanded)
	GET LIST ITEM PARAMETER:C985(hl_Volumes;*;"Path";$t_rutaCarpetaMadre)
	$t_nombreCarpeta:=ModernUI_Peticion (__ ("Seleccion de carpeta para respaldos");\
		__ ("Crear carpeta en ")+SYS_Path2FileName ($t_rutaCarpetaMadre);\
		__ ("Nombre de la carpeta");\
		"";\
		__ ("Crear Carpeta");\
		__ ("Cancelar"))
	If (($t_nombreCarpeta#"") & (OK=1))
		vt_SelectedFolderPath:=$t_rutaCarpetaMadre+SYS_FolderDelimiterOnServer +$t_nombreCarpeta
		SYS_CreaCarpetaServidor (vt_SelectedFolderPath)
		$x_Blob:=SYS_GetServerFolderHList ($t_rutaCarpetaMadre)
		If (SYS_TestPathName (vt_SelectedFolderPath;Server)=Is a folder:K24:2)
			$l_subListRef:=BLOB to list:C557($x_Blob)
			For ($ii;1;Count list items:C380($l_subListRef))
				GET LIST ITEM:C378($l_subListRef;$ii;$l_itemRef;$t_itemText)
				GET LIST ITEM PARAMETER:C985($l_subListRef;$l_itemRef;"Path";$t_folderPath)
				$p_icon:=SYS_GetServerDocumentIcon ($t_folderPath;16)
				SET LIST ITEM ICON:C950($l_subListRef;$l_itemRef;$p_icon)
			End for 
			SET LIST ITEM:C385(hl_Volumes;$l_directoryRef;$t_volumeName;$l_directoryRef;$l_subListRef;True:C214)
			$l_refItem:=Find in list:C952($l_subListRef;$t_nombreCarpeta;0)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_Volumes;$l_refItem)
			ACCEPT:C269
		Else 
			ModernUI_Notificacion (__ ("La carpeta no pudo ser creada."))
		End if 
	End if 
End if 
