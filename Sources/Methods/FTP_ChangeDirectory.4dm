//%attributes = {}
  // Project Method: FTP_ChangeDirectory
  // Description: Obtains the list of all files and folders within the target path

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$ftp_ID;$err)
C_TEXT:C284($2;$directory)
$ftp_ID:=$1
$directory:=$2
$0:=False:C215

  // *** Goto the target directory ***
$err:=FTP_ChangeDir ($ftp_ID;$directory)

If ($err=0)
	
	ARRAY TEXT:C222(atFTP_ObjectNames;0)
	ARRAY LONGINT:C221(alFTP_ObjectSize;0)
	ARRAY LONGINT:C221(alFTP_ObjectTime;0)
	ARRAY DATE:C224(adFTP_ObjectDate;0)
	ARRAY INTEGER:C220(aiFTP_ObjectKInd;0)
	ARRAY TEXT:C222(atFTP_ObjectSize;0)
	ARRAY PICTURE:C279(apFTP_ObjectIcon;0)
	
	
	  // *** Get a listing of the objects in a directory ***
	$err:=FTP_GetDirList ($ftp_ID;$directory;atFTP_ObjectNames;alFTP_ObjectSize;aiFTP_ObjectKInd;adFTP_ObjectDate;alFTP_ObjectTime)
	
	
	If ($err=0)
		$0:=True:C214
		
	Else 
		
		IC_Error_Handling ($err;"FTP_GetDirList")
		
	End if 
Else 
	
	IC_Error_Handling ($err;"FTP_ChangeDir")
	
End if 
