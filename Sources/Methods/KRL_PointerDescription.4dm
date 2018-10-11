//%attributes = {}
  //KRL_PointerDescription

C_TEXT:C284($0;$result)
C_POINTER:C301($1;$pointer)
_O_C_STRING:C293(255;$vsVarName)
C_LONGINT:C283($vlTableNum;$vlFieldNum)

$pointer:=$1
RESOLVE POINTER:C394($pointer;$vsVarName;$vlTableNum;$vlFieldNum)
Case of 
	: (($vsVarName="") & ($vlTableNum=-1))
		$result:="Nil Pointer"
	: ($vsVarName#"")
		$result:="Pointer to Variable: "+$vsVarName
	: (($vlTableNum>0) & ($vlFieldNum=-1))
		$result:="Pointer to table: "+Table name:C256($vlTableNum)
	: (($vlTableNum>0) & ($vlFieldNum>0))
		$result:="Pointer to field: "+Table name:C256($vlTableNum)+Field name:C257($vlTableNum;$vlFieldNum)
End case 
$0:=$result