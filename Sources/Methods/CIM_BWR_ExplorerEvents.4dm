//%attributes = {}
  // MÉTODO: CIM_BWR_ExplorerEvents
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 27/06/11, 11:07:42
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_BWR_ExplorerEvents()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BLOB:C604($x_Blob)
C_BOOLEAN:C305($b_Expanded)
C_LONGINT:C283($i;$ii;$l_directoryRef;$l_docType;$l_draggedElement;$l_dropPosition;$l_itemRef;$l_processID;$l_subListRef;$l_subListRef)
C_PICTURE:C286($p_icon)
C_POINTER:C301($y_source)
C_TEXT:C284($t_dirPath;$t_folderPath;$t_itemText;$t_parameters;$t_path;$t_sourcePath;$t_volumeName)

ARRAY TEXT:C222($at_fechaCreacion;0)
$y_localIcono:=OBJECT Get pointer:C1124(Object named:K67:5;"localIcono")
$y_localDocumento:=OBJECT Get pointer:C1124(Object named:K67:5;"localDocumento")
$y_localFechaModificacion:=OBJECT Get pointer:C1124(Object named:K67:5;"localFechaModificacion")
$y_localTamaño:=OBJECT Get pointer:C1124(Object named:K67:5;"localTamaño")
$y_localRuta:=OBJECT Get pointer:C1124(Object named:K67:5;"localRuta")
$y_fechaCreacion:=->$at_fechaCreacion

Case of 
	: ((Form event:C388=On Selection Change:K2:29) | (Form event:C388=On Clicked:K2:4) | ($t_parameters="updateDirectory"))
		GET LIST ITEM:C378(hlCIM_LocalBrowser_FTP;*;$l_directoryRef;$t_volumeName;$l_subListRef;$b_Expanded)
		GET LIST ITEM PARAMETER:C985(hlCIM_LocalBrowser_FTP;$l_directoryRef;"Path";$t_path)
		$x_Blob:=SYS_GetServerFolderHList ($t_path)
		If (BLOB size:C605($x_Blob)>0)
			$l_subListRef:=BLOB to list:C557($x_Blob)
			For ($ii;1;Count list items:C380($l_subListRef))
				GET LIST ITEM:C378($l_subListRef;$ii;$l_itemRef;$t_itemText)
				GET LIST ITEM PARAMETER:C985($l_subListRef;$l_itemRef;"Path";$t_folderPath)
				$p_icon:=SYS_GetDocumentIcon ($t_folderPath;16)
				SET LIST ITEM ICON:C950($l_subListRef;$l_itemRef;$p_icon)
			End for 
			vl_objectIndex:=vl_objectIndex+Count list items:C380($l_subListRef)
			SET LIST ITEM:C385(hlCIM_LocalBrowser_FTP;$l_directoryRef;$t_volumeName;$l_directoryRef;$l_subListRef;True:C214)
		End if 
		GET LIST ITEM:C378(hlCIM_LocalBrowser_FTP;Selected list items:C379(hlCIM_LocalBrowser_FTP);$l_itemRef;$t_volumeName;$l_subListRef;$b_expanded)
		GET LIST ITEM PARAMETER:C985(hlCIM_LocalBrowser_FTP;$l_itemRef;"Path";$t_path)
		
		SYS_GetLocalDocumentList ($t_path;$y_localDocumento;$y_localRuta;$y_FechaCreacion;$y_localFechaModificacion;$y_localTamaño;$y_localIcono)
		
	: (Form event:C388=On Drop:K2:12)
		Case of 
			: (FORM Get current page:C276=9)  //explorer
				DRAG AND DROP PROPERTIES:C607($y_source;$l_draggedElement;$l_processID)
				Case of 
					: ($y_source->=hlCIM_ServerBrowser)
						  //fuente del arrastre
						GET LIST ITEM:C378(hlCIM_ServerBrowser;$l_draggedElement;$l_itemRef;$t_itemText;$l_subListRef;$b_expanded)
						GET LIST ITEM PARAMETER:C985(hlCIM_ServerBrowser;$l_itemRef;"Path";$t_sourcePath)
						$l_docType:=SYS_TestPathName ($t_sourcePath;Server)
						
						  //destino del arrastre
						$l_dropPosition:=Drop position:C608
						GET LIST ITEM:C378(hlCIM_LocalBrowser_FTP;$l_dropPosition;$l_itemRef;$t_itemText;$l_subListRef;$b_expanded)
						GET LIST ITEM PARAMETER:C985(hlCIM_LocalBrowser_FTP;$l_itemRef;"Path";$t_dirPath)
						$l_dropPosition:=Drop position:C608
						If (($l_dropPosition>=1) & ($l_docType=Is a folder:K24:2))
							SYS_CopyFolder_FromServer ($t_sourcePath;$t_dirPath;False:C215)
							  //XS_CIM_ObjetMethods ("LocalDirectoriesBrowser")
						Else 
							CD_Dlog (0;__ ("El documento ")+aQR_Text11{aQR_Text11}+__ (" no pudo ser localizado en el servidor"))
						End if 
				End case 
		End case 
End case 