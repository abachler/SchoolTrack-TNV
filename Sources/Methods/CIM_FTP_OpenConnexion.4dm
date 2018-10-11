//%attributes = {}
  // MÉTODO: CIM_FTP_OpenConnexion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/06/11, 16:42:55
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_FTP_OpenConnexion()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BLOB:C604($x_Blob)
C_BOOLEAN:C305($b_expanded)
C_LONGINT:C283($hl_Volumes;$i;$ii;$l_error;$l_itemRef;$l_processID;$l_subitemRef;$l_subListRef;$l_subListRef2;$l_volumeRef)
C_LONGINT:C283($vl_Volumes)
C_PICTURE:C286($p_icon)
C_POINTER:C301($y_objectPointer)
C_TEXT:C284($t_dirPath;$t_folderPath;$t_homeName;$t_itemText;$t_path;$t_subText;$t_volumeName)


  // CODIGO PRINCIPAL


  //SELECT LIST ITEMS BY POSITION(hlCIM_LocalBrowser_FTP;1)
  //XS_CIM_ObjetMethods ("LocalDirectoriesBrowser")
  //--------------------------------------------------------

$l_processID:=IT_UThermometer (1;0;"Conectando...";-5)
$l_error:=FTP_Login (vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;vlFTP_ConectionID)
$l_error:=FTP_SetPassive (vlFTP_ConectionID;1)
vtWS_ftpDirectory:="/"
vtFTP_CurrentDirectory:=vtWS_ftpDirectory
vtDir:=vtWS_ftpDirectory
  //HL_ClearList (hlCIM_FTPDirectories)
XS_CIM_ObjetMethods ("FTP_GetRootDirectories";$y_objectPointer;vtWS_ftpDirectory)
XS_CIM_ObjetMethods ("FTP_ListFiles";$y_objectPointer;vtWS_ftpDirectory)
  //$l_processID:=IT_UThermometer (-2;$l_processID)

OBJECT SET TITLE:C194(bFTPBrowser;vtFTP_Url)
OBJECT SET TITLE:C194(bLocalBrowser;SYS_GetLocalProperty (XS_MachineName))
vtCIM_SwithLocalPopup:=SYS_GetLocalProperty (XS_MachineName)+";"+SYS_GetServerProperty (XS_MachineName)

SELECT LIST ITEMS BY POSITION:C381(hlCIM_FTPDirectories;1)
GET LIST ITEM:C378(hlCIM_FTPDirectories;*;$l_itemRef;$t_itemText;$l_subListRef;$b_expanded)
GET LIST ITEM PARAMETER:C985(hlCIM_FTPDirectories;$l_itemRef;"FTPpath";$t_dirPath)
If ($b_expanded=True:C214)
	
	$x_Blob:=XS_CIM_ObjetMethods ("FTP_GetSubDirectories";$y_objectPointer;$t_dirPath)
	$l_subListRef:=BLOB to list:C557($x_Blob)
	
	If (Count list items:C380($l_subListRef)>0)
		For ($i;1;Count list items:C380($l_subListRef))
			GET LIST ITEM:C378($l_subListRef;$i;$l_subitemRef;$t_subText)
			GET LIST ITEM PARAMETER:C985($l_subListRef;$l_subitemRef;"FTPpath";$t_path)
			$x_Blob:=XS_CIM_ObjetMethods ("FTP_GetSubDirectories";$y_objectPointer;$t_path)
			$l_subListRef2:=BLOB to list:C557($x_Blob)
			If (Count list items:C380($l_subListRef2)>0)
				SET LIST ITEM:C385($l_subListRef;$l_subitemRef;$t_subText;$l_subitemRef;$l_subListRef2;False:C215)
			Else 
				SET LIST ITEM:C385($l_subListRef;$l_subitemRef;$t_subText;$l_subitemRef;0;False:C215)
			End if 
			SET LIST ITEM:C385(hlCIM_FTPDirectories;$l_itemRef;$t_itemText;$l_itemRef;$l_subListRef;True:C214)
		End for 
	Else 
		SET LIST ITEM:C385(hlCIM_FTPDirectories;$l_itemRef;$t_itemText;$l_itemRef;0;False:C215)
	End if 
	  //CLEAR LIST($l_subListRef)
End if 
$l_processID:=IT_UThermometer (-2;$l_processID)