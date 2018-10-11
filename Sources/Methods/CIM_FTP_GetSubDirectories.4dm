//%attributes = {}
  // MÉTODO: CIM_FTP_GetSubDirectories
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/06/11, 17:06:16
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_FTP_GetSubDirectories()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1)

C_BLOB:C604($x_Blob)
C_LONGINT:C283($err;$iSub;$l_subListRef)
C_PICTURE:C286($p_icon)
C_TEXT:C284($t_directoryPath;$t_parameters;$t_subPath)

ARRAY DATE:C224($ad_FTP_SubDirDate;0)
ARRAY INTEGER:C220($ai_FTP_SubDirKInd;0)
ARRAY LONGINT:C221($al_FTP_SubDirSize;0)
ARRAY LONGINT:C221($al_FTP_SubDirTime;0)
ARRAY TEXT:C222($at_FTP_SubDirNames;0)
If (False:C215)
	C_TEXT:C284(CIM_FTP_GetSubDirectories ;$1)
End if 
$t_parameters:=$1

  // CODIGO PRINCIPAL
$t_directoryPath:=$t_parameters
If ($t_directoryPath=vtFTP_RootDirectory)
	$t_directoryPath:=""
End if 
$err:=FTP_GetDirList (vlFTP_ConectionID;$t_directoryPath;$at_FTP_SubDirNames;$al_FTP_SubDirSize;$ai_FTP_SubDirKInd;$ad_FTP_SubDirDate;$al_FTP_SubDirTime)
If (Size of array:C274($at_FTP_SubDirNames)>0)
	$l_subListRef:=New list:C375
	For ($iSub;1;Size of array:C274($at_FTP_SubDirNames))
		If (($ai_FTP_SubDirKInd{$iSub}=1) & ($at_FTP_SubDirNames{$iSub}#".") & ($at_FTP_SubDirNames{$iSub}#".."))
			vlFTP_hlDirectoriesIndex:=vlFTP_hlDirectoriesIndex+1
			$t_subPath:=$t_directoryPath+"/"+$at_FTP_SubDirNames{$iSub}
			APPEND TO LIST:C376($l_subListRef;$at_FTP_SubDirNames{$iSub};vlFTP_hlDirectoriesIndex)
			GET PICTURE FROM LIBRARY:C565(31981;$p_icon)
			SET LIST ITEM PROPERTIES:C386($l_subListRef;vlFTP_hlDirectoriesIndex;False:C215;Plain:K14:1;Use PicRef:K28:4+31981)
			
			SET LIST ITEM PARAMETER:C986($l_subListRef;vlFTP_hlDirectoriesIndex;"FTPpath";$t_subPath)
		End if 
	End for 
	LIST TO BLOB:C556($l_subListRef;$x_Blob)
End if 
$0:=$x_Blob