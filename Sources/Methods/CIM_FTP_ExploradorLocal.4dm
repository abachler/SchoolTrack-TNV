//%attributes = {}
  // CIM_FTP_ExploradorLocal()
  // Por: Alberto Bachler K.: 04-11-14, 10:45:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


  // Lectura de volumenes ocales
vl_objectIndex:=0
$x_Blob:=SYS_GetLocalVolumeList (vl_objectIndex)
$hl_Volumes:=BLOB to list:C557($x_Blob)
$vl_Volumes:=Count list items:C380($hl_Volumes)

HL_ClearList (hlCIM_LocalBrowser_FTP)
hlCIM_LocalBrowser_FTP:=New list:C375

$t_nombreUsuario:=Current system user:C484
For ($i;1;$vl_Volumes)
	GET LIST ITEM:C378($hl_Volumes;$i;$l_itemRef;$t_volumeName)
	vl_objectIndex:=vl_objectIndex+1
	APPEND TO LIST:C376(hlCIM_LocalBrowser_FTP;$t_volumeName;vl_objectIndex)
	$l_volumeRef:=vl_objectIndex
	$t_volumeName:=Replace string:C233($t_volumeName;"\\\\";"\\")
	SET LIST ITEM PARAMETER:C986(hlCIM_LocalBrowser_FTP;$l_volumeRef;"Path";$t_volumeName)
	$p_icon:=SYS_GetDocumentIcon ($t_volumeName;0)
	If (SYS_IsMacintosh )
		$p_icon:=SYS_GetDocumentIcon ("Volumes"+Folder separator:K24:12+$t_volumeName;16)
	Else 
		$p_icon:=SYS_GetDocumentIcon ($t_volumeName;16)
	End if 
	SET LIST ITEM ICON:C950(hlCIM_LocalBrowser_FTP;$l_volumeRef;$p_icon)
	$x_Blob:=SYS_GetServerFolderHList ($t_volumeName;vl_objectIndex)
	If (BLOB size:C605($x_Blob)>0)
		$l_subListRef:=BLOB to list:C557($x_Blob)
		For ($ii;1;Count list items:C380($l_subListRef))
			GET LIST ITEM:C378($l_subListRef;$ii;$l_itemRef;$t_itemText)
			GET LIST ITEM PARAMETER:C985($l_subListRef;$l_itemRef;"Path";$t_folderPath)
			$p_icon:=SYS_GetDocumentIcon ($t_folderPath;16)
			SET LIST ITEM ICON:C950($l_subListRef;$l_itemRef;$p_icon)
		End for 
		vl_objectIndex:=vl_objectIndex+Count list items:C380($l_subListRef)
		SET LIST ITEM:C385(hlCIM_LocalBrowser_FTP;$l_volumeRef;$t_volumeName;$l_volumeRef;$l_subListRef;False:C215)
	End if 
End for 
SELECT LIST ITEMS BY POSITION:C381(hlCIM_LocalBrowser_FTP;1)