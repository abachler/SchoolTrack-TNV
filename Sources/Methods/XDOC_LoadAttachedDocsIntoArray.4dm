//%attributes = {}
  //XDOC_LoadAttachedDocsIntoArray

C_LONGINT:C283($table;$1;$recordID;$2)
C_TEXT:C284($ref;$3)

$table:=$1
$RecordID:=$2
If (Count parameters:C259=3)
	$refType:=$3
Else 
	$refType:="DOC"
End if 

QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=$table;*)
QUERY:C277([xShell_Documents:91]; & [xShell_Documents:91]RefType:10=$refType;*)
QUERY:C277([xShell_Documents:91]; & [xShell_Documents:91]RelatedID:2=$recordID)


Case of 
	: ($refType="DOC")
		ARRAY TEXT:C222(atXDOC_AttachedDocs;0)
		ARRAY LONGINT:C221(alXDOC_AttachedRecNum;0)
		SELECTION TO ARRAY:C260([xShell_Documents:91]DocumentName:3;atXDOC_AttachedDocs;[xShell_Documents:91];alXDOC_AttachedRecNum)
	: ($refType="URL")
		ARRAY TEXT:C222(atXDOC_AttachedURL;0)
		ARRAY LONGINT:C221(alXDOC_AttachedURLRecNum;0)
		SELECTION TO ARRAY:C260([xShell_Documents:91]DocumentName:3;atXDOC_AttachedURL;[xShell_Documents:91];alXDOC_AttachedURLRecNum)
End case 