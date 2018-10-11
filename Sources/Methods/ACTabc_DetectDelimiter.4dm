//%attributes = {}
  //ACTabc_DetectDelimiter

C_LONGINT:C283($del1;$del2;$del3)
C_TEXT:C284($delimiter;$0)

$del1:=0
$del2:=0
$del3:=0

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""

RECEIVE PACKET:C104($ref;$text;MAXTEXTLENBEFOREV11:K35:3)
CLOSE DOCUMENT:C267($ref)
$del1:=Position:C15("\r"+Char:C90(10);$text)
$del2:=Position:C15(Char:C90(10);$text)
$del3:=Position:C15("\r";$text)
Case of 
	: ($del1#0)
		$delimiter:="\r"+Char:C90(10)
	: ($del2#0)
		$delimiter:=Char:C90(10)
	: ($del3#0)
		$delimiter:="\r"
	Else 
		$delimiter:="\r"
End case 
$0:=$delimiter