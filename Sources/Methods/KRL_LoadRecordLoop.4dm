//%attributes = {}
  //KRL_LoadRecordLoop

C_BOOLEAN:C305($0)
C_TIME:C306($currentTime;$tryUntil)
$tablePointer:=$1
If (Count parameters:C259=2)
	$seconds2wait:=$2
Else 
	$seconds2Wait:=5
End if 

If (Record number:C243($tablePointer->)>=0)
	READ WRITE:C146($tablePointer->)
	LOAD RECORD:C52($tablePointer->)
	$currentTime:=Current time:C178(*)
	$tryUntil:=$currentTime+$seconds2Wait
	While ((Locked:C147($tablePointer->)) & ($currentTime<$tryUntil))
		DELAY PROCESS:C323(Current process:C322;10)
		LOAD RECORD:C52($tablePointer->)
		$currentTime:=Current time:C178(*)
	End while 
	If (Not:C34(Locked:C147($tablePointer->)))
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
End if 