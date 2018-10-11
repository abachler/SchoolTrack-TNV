
  // ()
  // Por: Alberto Bachler K.: 21-02-14, 12:43:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

C_BLOB:C604($x_blob)
C_TIME:C306($f_refDocumento)
C_POINTER:C301($y_codigo)
C_TEXT:C284($t_codigo)

$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")
$f_refDocumento:=Open document:C264("";".TXT";Get pathname:K24:6)
If (ok=1)  //ABC 198967 //20180226
	DOCUMENT TO BLOB:C525(document;$x_blob)
	$t_codigo:=BLOB to text:C555($x_blob;UTF8 text without length:K22:17)
	$y_codigo->:=$t_codigo
	$t_codigo:=CODE_Get_html ($t_codigo)
	WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigo;"")
	GOTO OBJECT:C206(*;"codigo")
End if 
