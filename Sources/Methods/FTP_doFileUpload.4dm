//%attributes = {}
  //FTP_doFileUpload

  // Project Method: Do_FileUpload
  // Description: Upload a file

C_LONGINT:C283($ok)
C_TEXT:C284($path)
C_BOOLEAN:C305($success)
ARRAY TEXT:C222($types;0)
$path:=SYS_SelectFile ($path)

If ($path#"")
	FTP_UploadFile (vtFTP_CurrentDirectory;$path)
	$success:=FTP_ChangeDirectory (vlFTP_ConectionID;vtFTP_CurrentDirectory)
	CD_Dlog (0;__ ("Transferencia FTP terminada"))
End if 
