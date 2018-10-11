//%attributes = {}
  //STRcal_FijaFeriadoLaborable

C_DATE:C307($1)
C_LONGINT:C283($2)
$Date:=$1
vlSTR_Periodos_CurrentRef:=$2

ARRAY LONGINT:C221($IdsRegistros;0)
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=vlSTR_Periodos_CurrentRef)
KRL_RelateSelection (->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]NoNivel:5;"")
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$IdsRegistros)

$semaphore:=Semaphore:C143("CambioStatus"+String:C10($date))
QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$date)
QRY_QueryWithArray (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->$IdsRegistros;True:C214)
If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
	$ignore:=KRL_DeleteSelection (->[Alumnos_Inasistencias:10];False:C215)
End if 

QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=$date)
QRY_QueryWithArray (->[Alumnos_Atrasos:55]Alumno_numero:1;->$IdsRegistros;True:C214)
If (Records in selection:C76([Alumnos_Atrasos:55])>0)
	$ignore:=KRL_DeleteSelection (->[Alumnos_Atrasos:55];False:C215)
End if 

QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Fecha:1=$date)
QRY_QueryWithArray (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->$IdsRegistros;True:C214)
If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
	$ignore:=KRL_DeleteSelection (->[Alumnos_Anotaciones:11];False:C215)
End if 

QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Fecha:9=$date)
QRY_QueryWithArray (->[Alumnos_Castigos:9]Alumno_Numero:8;->$IdsRegistros;True:C214)
If (Records in selection:C76([Alumnos_Castigos:9])>0)
	$ignore:=KRL_DeleteSelection (->[Alumnos_Castigos:9];False:C215)
End if 

QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4=$date)
QRY_QueryWithArray (->[Asignaturas_Inasistencias:125]ID_Alumno:2;->$IdsRegistros;True:C214)
If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
	$ignore:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125];False:C215)
End if 


QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=vlSTR_Periodos_CurrentRef)
KRL_RelateSelection (->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]NoNivel:5;"")
SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$IdsRegistros)
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$date)
QRY_QueryWithArray (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->$IdsRegistros;True:C214)
If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
	$ignore:=KRL_DeleteSelection (->[Asignaturas_RegistroSesiones:168];False:C215)
End if 

CLEAR SEMAPHORE:C144("CambioStatus"+String:C10($date))