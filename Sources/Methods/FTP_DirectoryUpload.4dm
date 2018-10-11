//%attributes = {}
  // Project Method: FTP_DirectoryUpload

C_TEXT:C284($1;$2;$hostPath;$localPath)
$hostPath:=$1
$localPath:=$2

  // *** Get all subdirectory path in the selected directory ***
ARRAY TEXT:C222(atDirectoryList;1)
atDirectoryList{1}:=$localPath
SYS_GetAllSubpaths (->atDirectoryList)

  // *** Get all file paths within the selected directory ***
ARRAY TEXT:C222(atFileList;0)
SYS_DocumentList ($localPath;->atFileList;0;Client)

  // *** Create folders on the Server to correspond the selected directory tree ***
C_TEXT:C284($vtToBeDeleted)


$vtToBeDeleted:=SYS_GetFolderNam ($localPath)
$vtToBeDeleted:=SYS_GetParentNme (Substring:C12($localPath;1;Length:C16($localPath)-1))

FTP_UploadFolders (->atDirectoryList;$hostPath;$vtToBeDeleted)

  // *** Upload files to the Server ***
FTP_UploadMultipleFiles (->atFileList;$hostPath;$vtToBeDeleted)