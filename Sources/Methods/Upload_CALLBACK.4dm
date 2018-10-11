//%attributes = {"invisible":true}
C_LONGINT:C283($1;$2;$3;$4;$5)
C_BOOLEAN:C305($0)

$total:=$1
$count:=$5

If (<>UPLOAD_ABORT)
	<>UPLOAD_STATUS:=0
Else 
	<>UPLOAD_STATUS:=($count/$total)*1000
End if 

  //CALL PROCESS(-1)
POST OUTSIDE CALL:C329(vl_UploadCallingProcess)

$0:=<>UPLOAD_ABORT