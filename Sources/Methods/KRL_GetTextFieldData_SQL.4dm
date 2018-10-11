//%attributes = {"executedOnServer":true}
C_POINTER:C301($1;$refField;$2;$pointerToValue;$3;$dataField)
C_TEXT:C284($0;$res)
C_LONGINT:C283($vl_type)
C_BOOLEAN:C305($vb_go)

C_BOOLEAN:C305($boolean)
C_DATE:C307($date)
C_LONGINT:C283($longint)
C_REAL:C285($real)
C_TEXT:C284($text)
C_TIME:C306($time)

$refField:=$1
$pointerToValue:=$2
$dataField:=$3
$vl_type:=Type:C295($pointerToValue->)
$vb_go:=True:C214

SQL LOGIN:C817(SQL_INTERNAL:K49:11;"";"")
Case of 
	: ($vl_type=Is boolean:K8:9)
		$boolean:=$pointerToValue->
		SQL SET PARAMETER:C823($boolean;SQL param in:K49:1)
	: ($vl_type=Is date:K8:7)
		$date:=$pointerToValue->
		SQL SET PARAMETER:C823($date;SQL param in:K49:1)
	: (($vl_type=Is longint:K8:6) | ($vl_type=Is integer:K8:5))
		$longint:=$pointerToValue->
		SQL SET PARAMETER:C823($longint;SQL param in:K49:1)
	: ($vl_type=Is real:K8:4)
		$real:=$pointerToValue->
		SQL SET PARAMETER:C823($real;SQL param in:K49:1)
	: (($vl_type=Is text:K8:3) | ($vl_type=Is string var:K8:2) | ($vl_type=Is alpha field:K8:1))
		$text:=$pointerToValue->
		SQL SET PARAMETER:C823($text;SQL param in:K49:1)
	: ($vl_type=Is time:K8:8)
		$time:=$pointerToValue->
		SQL SET PARAMETER:C823($time;SQL param in:K49:1)
	Else 
		$vb_go:=False:C215
End case 
If ($vb_go)
	SQL EXECUTE:C820("SELECT ["+Field name:C257($dataField)+"] from ["+Table name:C256(Table:C252($dataField))+"] where ["+Field name:C257($refField)+"] = ?";$res)
	If (Not:C34(SQL End selection:C821))
		SQL LOAD RECORD:C822
	End if 
	SQL LOGOUT:C872
	$0:=$res
Else 
	SQL LOGOUT:C872
	$0:=""
	ALERT:C41("Tipo de datos de búsqueda no soportado.")
End if 