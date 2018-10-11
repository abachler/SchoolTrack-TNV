//%attributes = {}
  //ADTpp_FormArrayDeclarations 

C_LONGINT:C283($1;$vl_declaraciones)

If (Count parameters:C259>=1)
	$vl_declaraciones:=$1
Else 
	$vl_declaraciones:=0
End if 

Case of 
	: ($vl_declaraciones=1)  //Area Formacion Apoderados
		ARRAY TEXT:C222(atTipoInstitucion;0)
		ARRAY TEXT:C222(atInstitucion;0)
		ARRAY TEXT:C222(atPaisEducacion;0)
		ARRAY TEXT:C222(atGradoONivel;0)
		ARRAY LONGINT:C221(aiAno;0)
		ARRAY LONGINT:C221(IDEducacionAnterior;0)
		
	Else   // Todos los casos
		ADTpp_FormArrayDeclarations (1)
End case 