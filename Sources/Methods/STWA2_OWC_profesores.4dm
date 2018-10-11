//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:39:41
  // ----------------------------------------------------
  // Método: STWA2_OWC_profesores
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

$term:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"term")
READ ONLY:C145([Profesores:4])
QUERY:C277([Profesores:4];[Profesores:4]Apellidos_y_nombres:28=($term+"@");*)
QUERY:C277([Profesores:4]; & ;[Profesores:4]Inactivo:62=False:C215)
ARRAY TEXT:C222($aNombres;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY LONGINT:C221($aProfIDS;0)
SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;$aNombres;[Profesores:4]Numero:1;$aProfIDS)
LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$aRecNums)
SORT ARRAY:C229($aNombres;$aRecNums)
  //$alus:=JSON New 
  //$node:=JSON Append text array ($alus;"values";$aNombres)
  //$node:=JSON Append long array ($alus;"recnums";$aRecNums)
  //$node:=JSON Append long array ($alus;"profids";$aProfIDS)
  //$json:=JSON Export to text ($alus;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($alus)  //20150421 RCH Se agrega cierre

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$aNombres;"values")
OB_SET ($ob_raiz;->$aRecNums;"recnums")
OB_SET ($ob_raiz;->$aProfIDS;"profids")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json