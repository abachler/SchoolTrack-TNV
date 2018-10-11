//%attributes = {}
  // prSelection()
  // 
  //
  // creado por: Alberto Bachler Klein: 02-06-16, 12:45:08
  // -----------------------------------------------------------

  //prSelection

$tablePointer:=$1
$ReportName:=$2
$specialConfig:=$3


<>stopExec:=False:C215
FORM SET OUTPUT:C54($tablePointer->;$ReportName)
PAGE SETUP:C299($tablePointer->;$ReportName)
PRINT SETTINGS:C106
If (ok=1)
	If (<>shift)
		ORDER BY:C49($tablePointer->)
	End if 
	OK:=1
	While ((Not:C34(End selection:C36($tablePointer->))) & (OK=1))
		PRINT RECORD:C71($tablePointer->;>)
		NEXT RECORD:C51($tablePointer->)
	End while 
End if 


