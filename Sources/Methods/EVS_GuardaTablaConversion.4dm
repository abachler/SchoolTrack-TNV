//%attributes = {}
  // EVS_GuardaTablaConversion()
  // 
  //
  // creado por: Alberto Bachler Klein: 14-07-16, 11:39:27
  // -----------------------------------------------------------
C_BOOLEAN:C305($1;$b_validaTablaConv)  //MONO Ticket 202359
$b_validaTablaConv:=True:C214
If (Count parameters:C259=1)
	$b_validaTablaConv:=$1
End if 

$y_intervalosNota:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota")
$y_intervalosPuntos:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos")
$y_bonificaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"bonificacion")
$y_intervalosNotaPct:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota%")
$y_intervalosPuntosPct:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos%")

If ($b_validaTablaConv)  //MONO Ticket 202359
	EVS_ValidaTablaConversion 
End if 

COPY ARRAY:C226($y_intervalosNota->;arEVS_ConvGrades)
COPY ARRAY:C226($y_intervalosPuntos->;arEVS_ConvPoints)
COPY ARRAY:C226($y_bonificaciones->;arEVS_ConvGradesOfficial)
COPY ARRAY:C226($y_intervalosNotaPct->;arEVS_ConvGradesPercent)
COPY ARRAY:C226($y_intervalosPuntosPct->;arEVS_ConvPointsPercent)
