//%attributes = {}
  // EVS_GuardaTablaEsfuerzo()
  // 
  //
  // creado por: Alberto Bachler Klein: 14-07-16, 19:48:31
  // -----------------------------------------------------------

$y_esfuerzoIndicador:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_indicador")
$y_esfuerzoDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_descripcion")
$y_esfuerzoFactor:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_factor")

COPY ARRAY:C226($y_esfuerzoIndicador->;aIndEsfuerzo)
COPY ARRAY:C226($y_esfuerzoDescripcion->;aDescEsfuerzo)
COPY ARRAY:C226($y_esfuerzoFactor->;aFactorEsfuerzo)