//%attributes = {}
  //TMT_AsistImport_Log 
  //MONO
C_POINTER:C301($y_ab_log;$1;$y_at_log;$2)
$y_ab_log:=$1
$y_at_log:=$2
READ WRITE:C146([XShell_FatObjects:86])
CREATE RECORD:C68([XShell_FatObjects:86])
[XShell_FatObjects:86]FatObjectName:1:="TMT_AsistImport_"+DTS_Get_GMT_TimeStamp 
[XShell_FatObjects:86]DateObject:7:=Current date:C33(*)
[XShell_FatObjects:86]TextObject:3:=String:C10(Current time:C178(*))
BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;$y_ab_log;$y_at_log)
SAVE RECORD:C53([XShell_FatObjects:86])
KRL_UnloadReadOnly (->[XShell_FatObjects:86])