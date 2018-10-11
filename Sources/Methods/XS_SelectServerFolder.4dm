//%attributes = {}
  // XS_SelectServerFolder()
  // Por: Alberto Bachler K.: 09-11-14, 11:23:21
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_POINTER:C301($y_nil)

vt_mensaje:=$1


vt_SelectedFolderPath:=""

$machine:=SYS_GetServerProperty (XS_MachineName)
WDW_OpenFormWindow ($y_nil;"XS_SelectServerFolder";-1;8;__ ("Explorador ")+$machine)
DIALOG:C40("XS_SelectServerFolder")
CLOSE WINDOW:C154

$t_serverPlatform:=SYS_GetServerProperty (XS_Platform)
If (vt_SelectedFolderPath#"")
	Case of 
		: ($t_serverPlatform="Windows")
			vt_SelectedFolderPath:=vt_SelectedFolderPath+"\\"
		: ($t_serverPlatform="Mac OS")
			vt_SelectedFolderPath:=vt_SelectedFolderPath+":"
	End case 
End if 

$0:=vt_SelectedFolderPath