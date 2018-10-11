//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:40:18
  // ----------------------------------------------------
  // Método: STWA2_OWC_asignaturasprof
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

$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
KRL_GotoRecord (->[Profesores:4];$rn;False:C215)
QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1;*)
QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1)
ARRAY TEXT:C222($aAsignaturasProfesor;0)
AT_DistinctsFieldValues (->[Asignaturas:18]denominacion_interna:16;->$aAsignaturasProfesor)

  //20160606 ASM Ticket 156940
AT_Insert (1;1;->$aAsignaturasProfesor)
$aAsignaturasProfesor{1}:="Sin Asignatura"

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$aAsignaturasProfesor;"asignaturas")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json