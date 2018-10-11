//%attributes = {}
  // MÉTODO: CIM_FTP_ExplorerEvents
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/06/11, 17:26:08
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_FTP_ExplorerEvents()
  // ----------------------------------------------------
C_BLOB:C604($x_Blob)
C_BOOLEAN:C305($b_expanded)
C_LONGINT:C283($i;$l_itemRef;$l_processID;$l_subListRef;$l_subListRef2;$l_subRef)
C_POINTER:C301($y_Nil;$y_objectPointer)
C_TEXT:C284($t_dirPath;$t_itemText;$t_parameters;$t_path;$t_subText)

If (Count parameters:C259=1)
	$t_parameters:=$1
End if 

$l_processID:=IT_UThermometer (1;0;__ ("Conectando...");-5)
If ((Form event:C388=On Selection Change:K2:29) | ($t_parameters="updateDirectory"))
	GET LIST ITEM:C378(hlCIM_FTPDirectories;*;$l_itemRef;$t_itemText;$l_subListRef;$b_expanded)
	GET LIST ITEM PARAMETER:C985(hlCIM_FTPDirectories;$l_itemRef;"FTPpath";$t_dirPath)
	
	$x_Blob:=XS_CIM_ObjetMethods ("FTP_GetSubDirectories";$y_Nil;$t_dirPath)
	$l_subListRef:=BLOB to list:C557($x_Blob)
	
	If (Count list items:C380($l_subListRef)>0)
		For ($i;1;Count list items:C380($l_subListRef))
			GET LIST ITEM:C378($l_subListRef;$i;$l_subRef;$t_subText)
			GET LIST ITEM PARAMETER:C985($l_subListRef;$l_subRef;"FTPpath";$t_path)
			$x_Blob:=XS_CIM_ObjetMethods ("FTP_GetSubDirectories";$y_objectPointer;$t_path)
			$l_subListRef2:=BLOB to list:C557($x_Blob)
			If (Count list items:C380($l_subListRef2)>0)
				SET LIST ITEM:C385($l_subListRef;$l_subRef;$t_subText;$l_subRef;$l_subListRef2;False:C215)
			Else 
				SET LIST ITEM:C385($l_subListRef;$l_subRef;$t_subText;$l_subRef;0;False:C215)
			End if 
			SET LIST ITEM:C385(hlCIM_FTPDirectories;$l_itemRef;$t_itemText;$l_itemRef;$l_subListRef;True:C214)
		End for 
	Else 
		SET LIST ITEM:C385(hlCIM_FTPDirectories;$l_itemRef;$t_itemText;$l_itemRef;0;False:C215)
	End if 
	
	If ($t_dirPath="")
		$t_dirPath:="/"
	End if 
	XS_CIM_ObjetMethods ("FTP_ListFiles";$y_Nil;$t_dirPath)
	
End if 
$l_processID:=IT_UThermometer (-2;$l_processID)