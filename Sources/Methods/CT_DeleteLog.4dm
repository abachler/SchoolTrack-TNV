//%attributes = {}
  //CT_DeleteLog
C_DATE:C307($fecha;$1)
C_LONGINT:C283($proc)

If (Count parameters:C259=0)
	$fecha:=Add to date:C393(Current date:C33(*);0;-2;0)
Else 
	$fecha:=$1
End if 

$proc:=IT_UThermometer (1;0;__ ("Eliminando registro de actividades obsoleto de Commtrack..."))
READ WRITE:C146([xxSNT_LOG:93])
QUERY:C277([xxSNT_LOG:93];[xxSNT_LOG:93]_date:1<$fecha;*)
QUERY:C277([xxSNT_LOG:93]; & ;[xxSNT_LOG:93]Modulo:8=CommTrack)
DELETE SELECTION:C66([xxSNT_LOG:93])
KRL_UnloadReadOnly (->[xxSNT_LOG:93])
IT_UThermometer (-2;$proc)