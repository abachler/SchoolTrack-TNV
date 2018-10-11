//%attributes = {}
  //ACTcm_IsMonthOpenFromMonthYear

C_LONGINT:C283($1;$2;$month;$year;$recs)
C_POINTER:C301($3;$ptr)
C_BOOLEAN:C305($0)

$month:=$1
$year:=$2
If (Count parameters:C259=3)
	$ptr:=$3
End if 
If ($year<2000)
	$0:=False:C215
	If (Count parameters:C259=3)
		$ptr->:=True:C214
	End if 
Else 
	$recs:=0
	READ ONLY:C145([xxACT_CierresMensuales:108])
	SET QUERY LIMIT:C395(1)
	QUERY:C277([xxACT_CierresMensuales:108];[xxACT_CierresMensuales:108]Mes:1=$month;*)
	QUERY:C277([xxACT_CierresMensuales:108]; & ;[xxACT_CierresMensuales:108]Año:2=$year)
	If (Count parameters:C259=3)
		$ptr->:=[xxACT_CierresMensuales:108]BloqueoDefinitivo:3
	End if 
	SET QUERY LIMIT:C395(0)
	
	$0:=(Records in selection:C76([xxACT_CierresMensuales:108])=0)
End if 