//%attributes = {}
  //xDOC_RestoreHelperDocument

C_TEXT:C284($1;$typeRef;$2;$docName;$3;$storePath)
C_LONGINT:C283($vlExpandedSize;$vlCurrentSize;$0)
$typeRef:=$1
$docName:=$2
$storePath:=$3

READ ONLY:C145([xShell_Documents:91])
QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1;=;-1;*)
QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedID:2;=;-1;*)
QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RefType:10;=;$typeRef;*)
QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]DocumentName:3;=;$docName)

If (Records in selection:C76([xShell_Documents:91])=1)
	$fileName:=$storePath+Folder separator:K24:12+$docName
	If (Test path name:C476($fileName)<0)
		$ref:=Create document:C266($fileName)
		CLOSE DOCUMENT:C267($ref)
		BLOB PROPERTIES:C536([xShell_Documents:91]xContent:7;$vlCompressed;$vlExpandedSize;$vlCurrentSize)
		If ($vlCurrentSize>0)
			BLOB_ExpandBlob_byPointer (->[xShell_Documents:91]xContent:7)
			BLOB TO DOCUMENT:C526($fileName;[xShell_Documents:91]xContent:7)
			If (SYS_IsMacintosh )
				_O_SET DOCUMENT CREATOR:C531($fileName;[xShell_Documents:91]DocumentCreator:8)
			End if 
		End if 
	End if 
End if 

$0:=$vlCurrentSize