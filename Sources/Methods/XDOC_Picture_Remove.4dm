//%attributes = {"executedOnServer":true}
C_PICTURE:C286($Pict)
C_TEXT:C284($UUIDref;$1)

$UUIDref:=$1
$externalDBPath:=XDOC_ExternalDB_GetPath 


OK:=0
Begin SQL
	USE DATABASE DATAFILE <<$externalDBPath>>;
	DELETE FROM Pictures
	WHERE MainDBRef=:$UUIDref;
	
	USE LOCAL DATABASE SQL_INTERNAL;
End SQL
