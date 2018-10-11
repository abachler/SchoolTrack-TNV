  // XS_SelectFileOnServer()
  // Por: Alberto Bachler K.: 10-11-14, 12:41:29
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BLOB:C604($blob)
C_LONGINT:C283(hl_volumes;$i;$ii;$itemRef;vl_refIndex;$subList;$vl_Volumes;vl_refIndex)
C_PICTURE:C286($vp_Icon)
C_TEXT:C284($folderPath;$itemText;$volumeName)

Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283(hl_Volumes)
		
		vl_refIndex:=0
		$blob:=SYS_GetServerVolumeList 
		
		If (Is a list:C621(hl_volumes))
			CLEAR LIST:C377(hl_volumes)
		End if 
		hl_volumes:=New list:C375
		$l_volumes:=BLOB to list:C557($blob)
		For ($i;1;Count list items:C380($l_volumes))
			GET LIST ITEM:C378($l_volumes;$i;$itemRef;$volumeName)
			$volumeName:=Replace string:C233($volumeName;"\\\\";"\\")
			vl_refIndex:=vl_refIndex+1
			APPEND TO LIST:C376(hl_volumes;$volumeName;vl_refIndex)
			  //SET LIST ITEM PARAMETER(hl_volumes;vl_refIndex;Additional text;String(vl_refIndex))
			SET LIST ITEM PARAMETER:C986(hl_volumes;vl_refIndex;"Path";$volumeName)
			$vp_Icon:=SYS_GetServerDocumentIcon ($volumeName;0)
			If (SYS_IsMacintosh )
				$vp_Icon:=SYS_GetServerDocumentIcon ("Volumes"+Folder separator:K24:12+$volumeName;16)
			Else 
				$vp_Icon:=SYS_GetServerDocumentIcon ($volumeName;16)
			End if 
			  //SET LIST ITEM ICON(hl_volumes;vl_refIndex;$vp_Icon)
			$blob:=SYS_GetServerFolderHList ($volumeName;Count list items:C380(hl_volumes;*))
			If (BLOB size:C605($blob)>0)
				$subList:=BLOB to list:C557($blob)
				For ($ii;1;Count list items:C380($subList))
					GET LIST ITEM:C378($subList;$ii;$itemRef;$itemText)
					GET LIST ITEM PARAMETER:C985($subList;$itemRef;"Path";$folderPath)
					$vp_Icon:=SYS_GetDocumentIcon ($folderPath;16;Server)
					SET LIST ITEM ICON:C950($subList;$itemRef;$vp_icon)
				End for 
				SET LIST ITEM:C385(hl_Volumes;vl_refIndex;$volumeName;vl_refIndex;$subList;False:C215)
			End if 
			
		End for 
		SELECT LIST ITEMS BY POSITION:C381(hl_Volumes;1)
		OBJECT SET TITLE:C194(*;"texto";vt_mensaje)
		OBJECT SET ENABLED:C1123(*;"botonGuardar";vt_NombreArchivo#"")
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hl_volumes)
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

