//%attributes = {}
  // FORMS_CountPages()
  //
  //
  // creado por: Alberto Bachler Klein: 09-09-16, 10:50:56
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_POINTER:C301($2)

C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreFormulario)

ARRAY LONGINT:C221($al_paginas;0)
ARRAY POINTER:C280($ay_objetos;0)
ARRAY TEXT:C222($at_Objetos;0)



If (False:C215)
	C_LONGINT:C283(FORMS_CountPages ;$0)
	C_TEXT:C284(FORMS_CountPages ;$1)
	C_POINTER:C301(FORMS_CountPages ;$2)
End if 

$t_nombreFormulario:=$1
If (Count parameters:C259=2)
	$y_tabla:=$2
	FORM LOAD:C1103($y_tabla->;$t_nombreFormulario)
Else 
	FORM LOAD:C1103($t_nombreFormulario)
End if 
FORM GET OBJECTS:C898($at_Objetos;$ay_objetos;$al_paginas)

$0:=Max:C3($al_paginas)


