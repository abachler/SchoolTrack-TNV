//%attributes = {}
  // 4D_GetMethodText()
  // Por: Alberto Bachler: 18/11/13, 15:07:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($l_error;$l_indiceMetodo)
C_TEXT:C284($t_metodo)

ARRAY LONGINT:C221($al_IdMetodos;0)
ARRAY TEXT:C222($at_NombresMetodos;0)
If (False:C215)
	C_TEXT:C284(4D_GetMethodText ;$0)
End if 

$t_nombreMetodo:=$1



METHOD GET CODE:C1190($t_nombreMetodo;$t_metodo;*)



$0:=$t_metodo

