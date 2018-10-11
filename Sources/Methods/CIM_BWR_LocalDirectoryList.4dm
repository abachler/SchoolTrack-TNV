//%attributes = {}
  // MÉTODO: CIM_BWR_LocalDirectoryList
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 27/06/11, 11:26:43
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_BWR_LocalDirectoryList()
  // ----------------------------------------------------
C_BLOB:C604($x_Blob)
C_BOOLEAN:C305($b_expanded)
C_LONGINT:C283($directoriesRef;$i;$ii;$l_itemRef;$l_Ref;$l_subListRef;$l_sublistID)
C_PICTURE:C286($p_icon)
C_TEXT:C284($t_DirName;$t_folderPath;$t_itemText;$t_path;$t_volumeName)

$directoriesRef:=1

ARRAY TEXT:C222($at_fechaCreacion;0)
$y_localIcono:=OBJECT Get pointer:C1124(Object named:K67:5;"localIcono")
$y_localDocumento:=OBJECT Get pointer:C1124(Object named:K67:5;"localDocumento")
$y_localFechaModificacion:=OBJECT Get pointer:C1124(Object named:K67:5;"localFechaModificacion")
$y_localTamaño:=OBJECT Get pointer:C1124(Object named:K67:5;"localTamaño")
$y_localRuta:=OBJECT Get pointer:C1124(Object named:K67:5;"localRuta")
$y_fechaCreacion:=->$at_fechaCreacion


Case of 
	: ($directoriesRef=1)  //local machine
		vt_CurrentLocalMachine:="Client"
		GET LIST ITEM:C378(vl_CurrentBrowserHList;Selected list items:C379(vl_CurrentBrowserHList);$l_itemRef;$t_volumeName;$l_sublistID;$b_expanded)
		GET LIST ITEM PARAMETER:C985(vl_CurrentBrowserHList;$l_itemRef;"Path";$t_path)
		SYS_GetLocalDocumentList ($t_path;$y_localDocumento;$y_localRuta;$y_FechaCreacion;$y_localFechaModificacion;$y_localTamaño;$y_localIcono)
		
		
		For ($i;1;Count list items:C380($l_sublistID))
			GET LIST ITEM:C378($l_sublistID;$i;$l_Ref;$t_DirName;$l_subListRef;$b_expanded)
			GET LIST ITEM PARAMETER:C985($l_sublistID;$l_Ref;"Path";$t_path)
			If ($l_subListRef=0)
				$x_Blob:=SYS_GetServerFolderHList ($t_path)
				If (BLOB size:C605($x_Blob)>0)
					$l_subListRef:=BLOB to list:C557($x_Blob)
					vl_objectIndex:=vl_objectIndex+Count list items:C380($l_subListRef)
					
					For ($ii;1;Count list items:C380($l_subListRef))
						GET LIST ITEM:C378($l_subListRef;$ii;$l_itemRef;$t_itemText)
						GET LIST ITEM PARAMETER:C985($l_subListRef;$l_itemRef;"Path";$t_folderPath)
						$p_icon:=SYS_GetDocumentIcon ($t_folderPath;16)
						SET LIST ITEM ICON:C950($l_subListRef;$l_itemRef;$p_icon)
					End for 
					
					SET LIST ITEM:C385(vl_CurrentBrowserHList;$l_Ref;$t_DirName;$l_Ref;$l_subListRef;False:C215)
				End if 
			Else 
				  //SET LIST ITEM(hl_Volumes;$l_Ref;$t_DirName;$l_Ref;$l_subListRef;True)
			End if 
		End for 
		
End case 