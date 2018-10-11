//%attributes = {}
  // MÉTODO: CIM_FTP_DirectoryEvents
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/06/11, 17:29:31
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_FTP_DirectoryEvents()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_expanded)
C_LONGINT:C283($l_choice;$l_foundedRef;$l_itemRef;$l_processID;$l_processIDositioninList;$l_subListRef;$l_subListRefRef)
C_POINTER:C301($y_Nil)
C_TEXT:C284($t_currentDirectory;$t_dirPath;$t_itemText)


  // DECLARACIONES E INICIALIZACIONES

  // CODIGO PRINCIPAL
Case of 
		
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		If (LB_GetSelectedRows (->lb_FTP_List)>0)
			$l_choice:=Pop up menu:C542(__ ("Nueva Carpeta...")+";-;"+__ ("Eliminar ")+atFTP_ObjectNames{atFTP_ObjectNames})
		Else 
			$l_choice:=Pop up menu:C542(__ ("Nueva Carpeta...")+";-;("+__ ("Eliminar ")+atFTP_ObjectNames{atFTP_ObjectNames})
		End if 
		Case of 
			: ($l_choice=1)
				XS_CIM_ObjetMethods ("FTP_MakeDir")
			: ($l_choice=3)
				XS_CIM_ObjetMethods ("FTP_Delete")
		End case 
		
	: (Form event:C388=On Double Clicked:K2:5)
		$l_processID:=IT_UThermometer (1;0;__ ("Conectando...");-5)
		$t_currentDirectory:=atFTP_ObjectNames{atFTP_ObjectNames}
		GET LIST ITEM:C378(hlCIM_FTPDirectories;*;$l_itemRef;$t_itemText;$l_subListRef;$b_expanded)
		GET LIST ITEM PARAMETER:C985(hlCIM_FTPDirectories;$l_itemRef;"FTPpath";$t_dirPath)
		XS_CIM_ObjetMethods ("FTPSelectDirectory")
		SELECT LIST ITEMS BY REFERENCE:C630(hlCIM_FTPDirectories;$l_itemRef)
		SET LIST ITEM:C385(hlCIM_FTPDirectories;$l_itemRef;$t_itemText;$l_itemRef;$l_subListRef;True:C214)
		
		If ($l_subListRef>0)
			$l_processIDositioninList:=HL_FindElement ($l_subListRef;$t_currentDirectory)
		End if 
		
		If ($l_processIDositioninList>0)
			GET LIST ITEM:C378($l_subListRef;$l_processIDositioninList;$l_foundedRef;$t_itemText;$l_subListRefRef;$b_expanded)
			SET LIST ITEM:C385($l_subListRef;$l_foundedRef;$t_itemText;$l_foundedRef;$l_subListRefRef;True:C214)
			SELECT LIST ITEMS BY REFERENCE:C630(hlCIM_FTPDirectories;$l_foundedRef)
			XS_CIM_ObjetMethods ("FTPSelectDirectory";$y_Nil;"updateDirectory")
		End if 
		$l_processID:=IT_UThermometer (-2;$l_processID)
		
	: (Form event:C388=On Drop:K2:12)
		XS_CIM_ObjetMethods ("FTP_Upload")
End case 