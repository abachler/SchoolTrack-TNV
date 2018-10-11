//%attributes = {}
  //  SYS_Get_Check_ServerFilePath

$folder:=$1
$fileName:=$2

C_TEXT:C284(vt_server_path)
C_BOOLEAN:C305($primera;processComplete)
$primera:=True:C214
If (SYS_IsMacintosh )
	$folder:=Replace string:C233(Replace string:C233($folder;"\\";Folder separator:K24:12);": ";Folder separator:K24:12)
Else 
	$folder:=Replace string:C233(Replace string:C233($folder;":";Folder separator:K24:12);": ";Folder separator:K24:12)
End if 

doProcess:=True:C214

If ($folder[[Length:C16($folder)]]=Folder separator:K24:12)
	$folder:=Substring:C12($folder;1;Length:C16($folder)-1)
End if 
$folder:=<>syT_ArchivosFolder+$folder+Folder separator:K24:12
$filePath:=$folder+$fileName
SET BLOB SIZE:C606(blob;0)

If (SYS_TestPathName ($filePath)=Is a document:K24:1)
	vt_server_path:=$folder
Else 
	vt_server_path:=""
End if 

receivingDocument:=True:C214
processComplete:=False:C215
While (Not:C34(processComplete))
	DELAY PROCESS:C323(Current process:C322;5)
End while 
processComplete:=True:C214
receivingDocument:=False:C215
SET BLOB SIZE:C606(blob;0)
DELAY PROCESS:C323(Current process:C322;15)
doProcess:=False:C215
DELAY PROCESS:C323(Current process:C322;15)