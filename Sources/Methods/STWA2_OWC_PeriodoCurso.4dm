//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 17/11/15, 17:44:23
  // ----------------------------------------------------
  // Método: STWA2_OWC_PeriodoCurso
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

$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
PERIODOS_Init 
PERIODOS_LoadData (KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$curso;->[Cursos:3]Nivel_Numero:7))

C_OBJECT:C1216($ob_periodosCurso;$ob_periodo)
ARRAY OBJECT:C1221($aob_periodos;0)
$ob_raiz:=OB_Create 
$ob_periodosCurso:=OB_Create 
For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	$ob_periodo:=OB_Create 
	OB_SET_Text ($ob_periodo;STWA2_MakeDate4JS (adSTR_Periodos_Desde{$i});"inicio")
	OB_SET_Text ($ob_periodo;STWA2_MakeDate4JS (adSTR_Periodos_Hasta{$i});"fin")
	APPEND TO ARRAY:C911($aob_periodos;$ob_periodo)
	CLEAR VARIABLE:C89($ob_periodo)
End for 
OB_SET ($ob_raiz;->$aob_periodos;"periodosCurso")
ARRAY TEXT:C222($aferiados;Size of array:C274(adSTR_Calendario_Feriados))

For ($i;1;Size of array:C274($aferiados))
	$aferiados{$i}:=STWA2_MakeDate4JS (adSTR_Calendario_Feriados{$i})
End for 
OB_SET ($ob_raiz;->$aferiados;"feriados")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json