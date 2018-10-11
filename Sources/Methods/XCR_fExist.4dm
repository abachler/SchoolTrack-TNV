//%attributes = {}
  //XCR_fExist

C_LONGINT:C283($r;$vl_records)
_O_C_STRING:C293(80;$name)
$name:=[Actividades:29]Nombre:2
$id:=[Actividades:29]ID:1
SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
QUERY:C277([Actividades:29];[Actividades:29]Nombre:2=$name;*)
QUERY:C277([Actividades:29]; & [Actividades:29]ID:1#$id)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($vl_records#0)
	$r:=CD_Dlog (1;__ ("Ya existe una actividad con el mismo nombre."))
	If (Is new record:C668([Actividades:29]))
		[Actividades:29]Nombre:2:=""
	Else 
		[Actividades:29]Nombre:2:=Old:C35([Actividades:29]Nombre:2)
	End if 
	GOTO OBJECT:C206([Actividades:29]Nombre:2)
	$0:=True:C214
End if 