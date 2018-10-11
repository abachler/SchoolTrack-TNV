//%attributes = {}
  //QRY_BuildQueryMenu

If (Count parameters:C259=1)
	$filePointer:=$1
Else 
	$filePointer:=yBWR_currentTable
End if 


ARRAY TEXT:C222(aQueryArray;0)
$searchF:=String:C10(Table:C252($filePointer);"000")+"/"+<>tUSR_CurrentUser
QUERY:C277([xShell_Queries:53];[xShell_Queries:53]InMenu:7=$searchF;*)
QUERY:C277([xShell_Queries:53]; | [xShell_Queries:53]InMenu:7=String:C10(Table:C252($filePointer);"000"))
CREATE SET:C116([xShell_Queries:53];"set")

QUERY SELECTION:C341([xShell_Queries:53];[xShell_Queries:53]No:1<0)
SELECTION TO ARRAY:C260([xShell_Queries:53]Name:2;aQueryArray)
SORT ARRAY:C229(aQueryArray)
$endStandard:=Size of array:C274(aQueryArray)



USE SET:C118("set")
CLEAR SET:C117("set")

QUERY SELECTION:C341([xShell_Queries:53];[xShell_Queries:53]No:1>0)
SELECTION TO ARRAY:C260([xShell_Queries:53]Name:2;$queryName)
SORT ARRAY:C229($queryName;>)

If (Size of array:C274($queryName)>0)
	If ($endStandard>0)
		INSERT IN ARRAY:C227(aQueryArray;$endStandard+1;1)
		aQueryArray{$endStandard+1}:="-"
	Else 
		$endStandard:=-1
	End if 
	AT_Insert ($endstandard+2;Size of array:C274($queryName);->aQueryArray)
	For ($i;1;Size of array:C274($queryName))
		aQueryArray{$i+$endstandard+1}:=$queryName{$i}
	End for 
End if 


INSERT IN ARRAY:C227(aQueryArray;Size of array:C274(aQueryArray)+1;2)
aQueryArray{Size of array:C274(aQueryArray)-1}:="-"
aQueryArray{Size of array:C274(aQueryArray)}:="Editor..."