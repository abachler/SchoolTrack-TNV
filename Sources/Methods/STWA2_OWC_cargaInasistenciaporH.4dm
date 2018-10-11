//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:34:29
  // ----------------------------------------------------
  // Método: STWA2_OWC_cargaInasistenciaporH
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$idalumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idalumno"))
$idsesion:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idsesion"))
READ ONLY:C145([Asignaturas_Inasistencias:125])
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$idalumno;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Sesión:1=$idsesion)
If (Records in selection:C76([Asignaturas_Inasistencias:125])=1)
	$b_justificadoConLicencia:=(Find in field:C653([Alumnos_Licencias:73]ID:6;[Asignaturas_Inasistencias:125]ID_Licencia:9)>=0)
	$ob_raiz:=OB_Create 
	OB_SET_Long ($ob_raiz;Record number:C243([Asignaturas_Inasistencias:125]);"rn")
	OB_SET ($ob_raiz;->[Asignaturas_Inasistencias:125]Justificacion:3;"justificacion")
	OB_SET ($ob_raiz;->[Asignaturas_Inasistencias:125]Observaciones:5;"observacion")
	OB_SET ($ob_raiz;->$b_justificadoConLicencia;"conlicencia")
	$json:=OB_Object2Json ($ob_raiz)
Else 
End if 
$0:=$json

