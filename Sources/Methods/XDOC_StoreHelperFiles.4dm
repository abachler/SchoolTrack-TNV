//%attributes = {}
  //XDOC_StoreHelperFiles

$ref:=Open document:C264("")
CLOSE DOCUMENT:C267($ref)

GET DOCUMENT PROPERTIES:C477(document;$locked;$invisible;$createdOn;$createdAt;$modifiedOn;$modifiedAt)
$type:=_o_Document type:C528(document)
$size:=Get document size:C479(document)
$docName:=SYS_Path2FileName (document)
If (SYS_IsMacintosh )
	$creator:=_o_Document creator:C529(document)
Else 
	$creator:=""
End if 
READ WRITE:C146([xShell_Documents:91])
QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RefType:10="HLPR";*)
QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]DocumentName:3;=;$docName)
If (Records in selection:C76([xShell_Documents:91])=0)
	CREATE RECORD:C68([xShell_Documents:91])
End if 
[xShell_Documents:91]RelatedTable:1:=-1
[xShell_Documents:91]RelatedID:2:=-1
[xShell_Documents:91]DocumentType:5:=$type
[xShell_Documents:91]RefType:10:="HLPR"
[xShell_Documents:91]DocumentName:3:=$docName
[xShell_Documents:91]OriginalPath:12:=""
[xShell_Documents:91]Created_On:14:=$createdOn
[xShell_Documents:91]CreatedAt:15:=$createdAt
[xShell_Documents:91]ModifiedOn:16:=$modifiedOn
[xShell_Documents:91]ModifiedAt:17:=$modifiedAt
[xShell_Documents:91]DocSize:13:=$size
[xShell_Documents:91]DocumentDescription:4:=""
[xShell_Documents:91]ApplicationName:6:=""
[xShell_Documents:91]DocumentCreator:8:=$creator
DOCUMENT TO BLOB:C525(document;[xShell_Documents:91]xContent:7)
COMPRESS BLOB:C534([xShell_Documents:91]xContent:7)
SAVE RECORD:C53([xShell_Documents:91])