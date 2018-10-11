//%attributes = {}
  // EVS_CargaTablaEsfuerzo()
  // 
  //
  // creado por: Alberto Bachler Klein: 14-07-16, 19:48:20
  // -----------------------------------------------------------

$y_esfuerzoIndicador:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_indicador")
$y_esfuerzoDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_descripcion")
$y_esfuerzoFactor:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_factor")

COPY ARRAY:C226(aIndEsfuerzo;$y_esfuerzoIndicador->)
COPY ARRAY:C226(aDescEsfuerzo;$y_esfuerzoDescripcion->)
COPY ARRAY:C226(aFactorEsfuerzo;$y_esfuerzoFactor->)

GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_separadorDecimal)
$t_formato:="##0"+$t_separadorDecimal+"00"
OBJECT SET FORMAT:C236(*;"esfuerzo_factor";$t_formato)

