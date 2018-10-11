//%attributes = {}
  // ST_CleanFileName()
  //
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 12:14:32
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($platForm)
C_TEXT:C284($t_nombreArchivo)


If (False:C215)
	C_TEXT:C284(ST_CleanFileName ;$0)
	C_TEXT:C284(ST_CleanFileName ;$1)
End if 

$t_nombreArchivo:=ST_ClearSpaces ($1)

$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;"/";"-")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;"\\";"-")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;":";"-")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;"*";"•")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;"?";"")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;Char:C90(34);"'")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;">";"[")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;"<";"]")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;"|";"-")
$t_nombreArchivo:=Replace string:C233($t_nombreArchivo;"^";" ")

$0:=$t_nombreArchivo