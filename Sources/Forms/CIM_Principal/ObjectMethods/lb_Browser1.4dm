C_BOOLEAN:C305($b_expanded)
C_LONGINT:C283($i;$l_docType;$l_draggedElement;$l_dropPosition;$l_foundedRef;$l_itemRef;$l_processID;$l_processIDositioninList;$l_selectedItem;$l_subListRef)
C_LONGINT:C283($l_subListRefRef)
C_POINTER:C301($y_Nil;$y_RutasElementos;$y_source)
C_TEXT:C284($t_currentDirectory;$t_destinationFilePath;$t_destinationPath;$t_directorioEnLista;$t_dirPath;$t_filePath;$t_itemText;$t_rutaSeleccionada)

ARRAY LONGINT:C221($al_RefItems;0)
ARRAY TEXT:C222($at_Items;0)
$y_RutasElementos:=OBJECT Get pointer:C1124(Object named:K67:5;"localRuta")
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$t_rutaSeleccionada:=$y_RutasElementos->{$y_RutasElementos->}
		If (Test path name:C476($t_rutaSeleccionada)=Is a folder:K24:2)
			GET LIST ITEM:C378(hlCIM_LocalBrowser_FTP;*;$l_itemActual;$t_itemActual)
			For ($i;1;Count list items:C380(hlCIM_LocalBrowser_FTP))
				SELECT LIST ITEMS BY POSITION:C381(hlCIM_LocalBrowser_FTP;$i)
				GET LIST ITEM:C378(hlCIM_LocalBrowser_FTP;*;$l_refitem;$t_item)
				GET LIST ITEM PARAMETER:C985(hlCIM_LocalBrowser_FTP;$l_refitem;"Path";$t_directorioEnLista)
				If ($t_directorioEnLista=$t_rutaSeleccionada)
					SELECT LIST ITEMS BY REFERENCE:C630(hlCIM_LocalBrowser_FTP;$l_refitem)
					OBJECT SET SCROLL POSITION:C906(hlCIM_LocalBrowser_FTP;$i)
					$i:=Count list items:C380(hlCIM_LocalBrowser_FTP)+1
				End if 
			End for 
			CIM_BWR_LocalDirectoryList 
		End if 
		
		
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($y_source;$l_draggedElement;$l_processID)
		
		
		If ($y_source->=lb_FTP_List)
			XS_CIM_ObjetMethods ("FTP_Download";$y_Nil;String:C10($l_draggedElement))
		End if 
		
End case 
