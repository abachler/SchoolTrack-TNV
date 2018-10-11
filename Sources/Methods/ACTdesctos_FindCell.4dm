//%attributes = {}
  //ACTdesctos_FindCell

C_LONGINT:C283($valcol;$valrow;$1;$2)
C_POINTER:C301($colArray;$3;$rowArray;$4)
C_BOOLEAN:C305($0)

$0:=False:C215

$valcol:=$1
$valrow:=$2

$colArray:=$3
$rowArray:=$4

$colArray->{0}:=$valcol
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray ($colArray;"=";->$DA_Return)

For ($i;1;Size of array:C274($DA_Return))
	If ($rowArray->{$DA_Return{$i}}=$valrow)
		$0:=True:C214
		$i:=Size of array:C274($DA_Return)+1
	End if 
End for 