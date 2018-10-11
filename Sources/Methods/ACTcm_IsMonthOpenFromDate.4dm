//%attributes = {}
  //ACTcm_IsMonthOpenFromDate

C_DATE:C307($1;$date)
C_POINTER:C301($2;$ptr)
C_LONGINT:C283($month;$year;$recs)
C_BOOLEAN:C305($0)

$date:=$1
If (Count parameters:C259=2)
	$ptr:=$2
End if 
$month:=Month of:C24($date)
$year:=Year of:C25($date)

If ($year<2000)
	$0:=False:C215
	If (Count parameters:C259=2)
		$ptr->:=True:C214
	End if 
Else 
	$recs:=0
	READ ONLY:C145([xxACT_CierresMensuales:108])
	SET QUERY LIMIT:C395(1)
	QUERY:C277([xxACT_CierresMensuales:108];[xxACT_CierresMensuales:108]Mes:1=$month;*)
	QUERY:C277([xxACT_CierresMensuales:108]; & ;[xxACT_CierresMensuales:108]Año:2=$year)
	If (Count parameters:C259=2)
		$ptr->:=[xxACT_CierresMensuales:108]BloqueoDefinitivo:3
	End if 
	SET QUERY LIMIT:C395(0)
	
	$0:=(Records in selection:C76([xxACT_CierresMensuales:108])=0)
End if 