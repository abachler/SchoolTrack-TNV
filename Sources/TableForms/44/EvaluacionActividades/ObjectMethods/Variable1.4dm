For ($i;1;6)
	<>aXCRCcept{$i}:=(Get pointer:C304("sValor"+String:C10($i)))->
	<>aXCRAbrv{$i}:=(Get pointer:C304("sAbrevV"+String:C10($i)))->
End for 
For ($i;1;4)
	<>aXCRInd{$i}:=(Get pointer:C304("sEvDesc"+String:C10($i)))->
	<>aXCRAbrvInd{$i}:=(Get pointer:C304("sEvValor"+String:C10($i)))->
End for 
SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;-><>aXCRCcept;-><>aXCRAbrv;-><>aXCRInd;-><>aXCRAbrvInd;-><>sXCRExpl1;-><>sXCRExpl2)
$diff:=BLOB_CompareBlobs (->xBlob;->[xxSTR_Constants:1]xIndicadoresEvExtra:39)
If ($diff=0)
	[xxSTR_Constants:1]xIndicadoresEvExtra:39:=xBlob
	SAVE RECORD:C53([xxSTR_Constants:1])
End if 
KRL_ReloadAsReadOnly (->[xxSTR_Constants:1])