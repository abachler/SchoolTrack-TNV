//%attributes = {}
  //ACTcm_SaveYear

C_LONGINT:C283($añolong;$1)
READ WRITE:C146([xxACT_CierresMensuales:108])
$añolong:=$1
For ($i;1;12)
	$ptr1:=Get pointer:C304("cb_Cerrado"+String:C10($i))
	If ($ptr1->=1)
		QUERY:C277([xxACT_CierresMensuales:108];[xxACT_CierresMensuales:108]Mes:1=$i;*)
		QUERY:C277([xxACT_CierresMensuales:108]; & ;[xxACT_CierresMensuales:108]Año:2=$añolong)
		If (Records in selection:C76([xxACT_CierresMensuales:108])=0)
			CREATE RECORD:C68([xxACT_CierresMensuales:108])
			[xxACT_CierresMensuales:108]Mes:1:=$i
			[xxACT_CierresMensuales:108]Año:2:=$añolong
			[xxACT_CierresMensuales:108]BloqueoDefinitivo:3:=False:C215
			SAVE RECORD:C53([xxACT_CierresMensuales:108])
		End if 
	Else 
		QUERY:C277([xxACT_CierresMensuales:108];[xxACT_CierresMensuales:108]Mes:1=$i;*)
		QUERY:C277([xxACT_CierresMensuales:108]; & ;[xxACT_CierresMensuales:108]Año:2=$añolong)
		If (Records in selection:C76([xxACT_CierresMensuales:108])=1)
			If (Not:C34([xxACT_CierresMensuales:108]BloqueoDefinitivo:3))
				DELETE RECORD:C58([xxACT_CierresMensuales:108])
			End if 
		End if 
	End if 
End for 
KRL_UnloadReadOnly (->[xxACT_CierresMensuales:108])