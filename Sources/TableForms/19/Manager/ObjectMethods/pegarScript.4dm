  // ()
  // Por: Alberto Bachler K.: 20-02-14, 19:22:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_codigo)
C_TEXT:C284($t_codigo)


$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")
$t_codigo:=Get text from pasteboard:C524
$y_codigo->:=$t_codigo
$t_codigo:=CODE_Get_html ($y_codigo->)
WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigo;"")
GOTO OBJECT:C206(*;"codigo")

