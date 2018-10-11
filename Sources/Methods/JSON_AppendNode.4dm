//%attributes = {}
  // JSON_AppendNode()
  //
  //
  // creado por: Alberto Bachler Klein: 28-11-15, 14:29:32
  // -----------------------------------------------------------
C_OBJECT:C1216($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_error)
C_TEXT:C284($t_nombreNodo)
C_OBJECT:C1216($ob_Container;$ob_Objeto)



If (False:C215)
	C_OBJECT:C1216(JSON_AppendNode ;$1)
	C_TEXT:C284(JSON_AppendNode ;$2)
End if 

$ob_Container:=$1
$t_nombreNodo:=$2

If (OB Is defined:C1231($ob_Container))
	$ob_Objeto:=JSON_Create 
	JSON_SET ($ob_Container;->$ob_Objeto;$t_nombreNodo)
End if 

$0:=$ob_Objeto



