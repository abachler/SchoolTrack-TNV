//%attributes = {}
  //PCS_NextView

  //Next view(string) -> integer
$loc:=Find in array:C230(<>aViewName;$1)
If ($loc=-1)
	While (Semaphore:C143("$ModViewArrays"))
		DELAY PROCESS:C323(Current process:C322;1)
	End while 
	$loc:=Size of array:C274(<>aViewName)+1
	_O_ARRAY STRING:C218(80;<>aViewName;$loc)
	ARRAY LONGINT:C221(<>aViewNum;$loc)
	<>aViewName{$loc}:=$1
	CLEAR SEMAPHORE:C144("$ModViewArrays")
End if 
<>aViewNum{$loc}:=<>aViewNum{$loc}+1
$0:=<>aViewNum{$loc}