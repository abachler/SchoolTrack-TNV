//%attributes = {}
  //STWA2_OWC_verificaLicencia
C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$b_editar:=True:C214
$t_licenciaNumero:=""
$t_licenciaTipo:=""

$l_idAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idalumno"))
$l_idSesion:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idsesion"))

  // busco la inasistencia
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_idSesion;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Alumno:2=$l_idAlumno)
If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
	  //verifico si la inasistencia tiene una licencia asociada
	If ([Asignaturas_Inasistencias:125]ID_Licencia:9#0)
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]ID:6=[Asignaturas_Inasistencias:125]ID_Licencia:9)
		$t_licenciaNumero:=String:C10([Alumnos_Licencias:73]ID:6)
		$t_licenciaTipo:=[Alumnos_Licencias:73]Tipo_licencia:4
		$b_editar:=False:C215
	End if 
End if 

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$t_licenciaTipo;"licenciatipo")
OB_SET ($ob_raiz;->$t_licenciaNumero;"licencianumero")
OB_SET_Boolean ($ob_raiz;$b_editar;"editar")
$json:=OB_Object2Json ($ob_raiz)
CLEAR VARIABLE:C89($ob_raiz)
$0:=$json

