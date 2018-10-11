//%attributes = {}
  // MÉTODO: CIM_FTP_GetRootDirectories
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/06/11, 16:52:35
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_FTP_GetRootDirectories()
  // ----------------------------------------------------


  //DECLARACIONES E INICIALIZACIONES
C_BLOB:C604($x_Blob)
C_LONGINT:C283($l_err;$l_subListRef)
C_POINTER:C301($y_objectPointer)

ARRAY DATE:C224($ad_FTP_ObjectDate;0)
ARRAY INTEGER:C220($ai_FTP_ObjectKInd;0)
ARRAY LONGINT:C221($al_FTP_ObjectSize;0)
ARRAY LONGINT:C221($al_FTP_ObjectTime;0)
ARRAY TEXT:C222($at_FTP_ObjectNames;0)


  // CODIGO PRINCIPAL
C_LONGINT:C283(hlCIM_FTPDirectories)

XS_CIM_ObjetMethods ("LocalMachinesBrowser")

vtWS_ftpDirectory:="/"
FTP_SetCurrentDirPath (vtWS_ftpDirectory;True:C214)
$l_err:=FTP_GetDirList (vlFTP_ConectionID;vtWS_ftpDirectory;$at_FTP_ObjectNames;$al_FTP_ObjectSize;$ai_FTP_ObjectKInd;$ad_FTP_ObjectDate;$al_FTP_ObjectTime)
HL_ClearList (hlCIM_FTPDirectories)

vlFTP_hlDirectoriesIndex:=1
hlCIM_FTPDirectories:=New list:C375
  //APPEND TO LIST(hlCIM_FTPDirectories;vtWS_ftpDirectory;vlFTP_hlDirectoriesIndex)
vtFTP_RootDirectory:="FTP "+<>gCustom
APPEND TO LIST:C376(hlCIM_FTPDirectories;vtFTP_RootDirectory;vlFTP_hlDirectoriesIndex)
$x_Blob:=XS_CIM_ObjetMethods ("FTP_GetSubDirectories";$y_objectPointer;vtWS_ftpDirectory)
$l_subListRef:=BLOB to list:C557($x_Blob)
If (Count list items:C380($l_subListRef)>0)
	SET LIST ITEM:C385(hlCIM_FTPDirectories;1;vtFTP_RootDirectory;1;$l_subListRef;True:C214)
End if 
