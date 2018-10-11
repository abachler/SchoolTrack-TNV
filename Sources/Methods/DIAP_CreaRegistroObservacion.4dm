//%attributes = {}
  //DIAP_CreaRegistroObservacion 

C_LONGINT:C283($id_alu;$1)
$id_alu:=$1

READ ONLY:C145([DIAP_Observaciones:207])
QUERY:C277([DIAP_Observaciones:207];[DIAP_Observaciones:207]ID_alumno:2=$id_alu;*)
QUERY:C277([DIAP_Observaciones:207]; & ;[DIAP_Observaciones:207]Año:3=<>GYEAR)

If (Records in selection:C76([DIAP_Observaciones:207])=0)
	READ WRITE:C146([DIAP_Observaciones:207])
	CREATE RECORD:C68([DIAP_Observaciones:207])
	[DIAP_Observaciones:207]ID_alumno:2:=$id_alu
	[DIAP_Observaciones:207]Año:3:=<>gyear
	SAVE RECORD:C53([DIAP_Observaciones:207])
	KRL_UnloadReadOnly (->[DIAP_Observaciones:207])
End if 
