  // _TestABK.nuevaLinea1()
  //
  //
  // creado por: Alberto Bachler Klein: 30-02-16, 07:35:53
  // -----------------------------------------------------------
C_LONGINT:C283($l_abajoLB;$l_abajoW;$l_altoFila;$l_altoListbox;$l_altoPantalla;$l_arribaLB;$l_arribaW;$l_derechaLB;$l_derechaW;$l_filas)
C_LONGINT:C283($l_indexActual;$l_izquierdaLB;$l_izquierdaW;$l_maxFilas;$l_maxSize;$l_nuevoIndex;$l_posicion;$l_posicionActual)
C_POINTER:C301($y_index;$y_indexCount;$y_instancias;$y_menuCampos;$y_menuCondicion;$y_menuConector;$y_nil;$y_objectCount)


$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$y_objectCount:=OBJECT Get pointer:C1124(Object named:K67:5;"objectCount")
$y_objectCount:=OBJECT Get pointer:C1124(Object named:K67:5;"objectCount")
$y_indexCount:=OBJECT Get pointer:C1124(Object named:K67:5;"indexCount")

$l_indexActual:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
$y_instancias:=OBJECT Get pointer:C1124(Object named:K67:5;"instancias"+String:C10($l_indexActual))
$l_posicionActual:=Find in array:C230($y_index->;$l_indexActual)
For ($i;Size of array:C274($y_index->);$l_posicionActual+1;-1)
	OBJECT MOVE:C664(*;"criterio"+String:C10($y_index->{$i})+"@";0;30)
End for 

$l_nuevoIndex:=$y_indexCount->+1

OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_nuevaLinea";"criterio"+String:C10($l_nuevoIndex)+"_nuevaLinea";$y_nil;"";0;30)
If (OK=1)
	OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_eliminaLinea";"criterio"+String:C10($l_nuevoIndex)+"_eliminaLinea";$y_nil;"";0;30)
End if 
If (OK=1)
	OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_conector";"criterio"+String:C10($l_nuevoIndex)+"_conector";$y_nil;"";0;30)
End if 
If (OK=1)
	OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_campo";"criterio"+String:C10($l_nuevoIndex)+"_campo";$y_nil;"";0;30)
End if 
If (OK=1)
	OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_condicion";"criterio"+String:C10($l_nuevoIndex)+"_condicion";$y_nil;"";0;30)
End if 
If (OK=1)
	OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_lista";"criterio"+String:C10($l_nuevoIndex)+"_lista";$y_nil;"";0;30)
End if 
If (OK=1)
	OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_btnConector";"criterio"+String:C10($l_nuevoIndex)+"_btnConector";$y_nil;"";0;30)
End if 
If (OK=1)
	OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_btnCampo";"criterio"+String:C10($l_nuevoIndex)+"_btnCampo";$y_nil;"";0;30)
End if 
If (OK=1)
	OBJECT DUPLICATE:C1111(*;"criterio"+String:C10($l_indexActual)+"_btnCondicion";"criterio"+String:C10($l_nuevoIndex)+"_btnCondicion";$y_nil;"";0;30)
End if 
FORM GET OBJECTS:C898($at_objetos;$ay_variables;$al_paginas;Form all pages:K67:7)
If (OK=1)
	$t_ObjetoActual:="criterio"+String:C10($l_indexActual)+"_variable"
	$t_ObjetoNuevo:="criterio"+String:C10($l_nuevoIndex)+"_variable"
	$t_relacionadoA:="criterio"+String:C10($l_indexActual)+"_variable"
	OBJECT DUPLICATE:C1111(*;$t_ObjetoActual;$t_ObjetoNuevo;$y_nil;"";0;30)
End if 




If (OK=1)
	
	$y_indexCount->:=$l_nuevoIndex
	OBJECT SET VISIBLE:C603(*;"criterio"+String:C10($l_nuevoIndex)+"_btnconector";True:C214)
	OBJECT SET VISIBLE:C603(*;"criterio"+String:C10($l_nuevoIndex)+"_conector";True:C214)
	OBJECT SET VISIBLE:C603(*;"criterio"+String:C10($l_nuevoIndex)+"_lista";False:C215)
	OBJECT SET VISIBLE:C603(*;"criterio"+String:C10($l_nuevoIndex)+"_variable";True:C214)
	
	  //OBJECT SET PLACEHOLDER(*;"criterio"+String($l_nuevoIndex)+"_variable";"")
	
	If (OK=1)
		$l_posicion:=$l_posicionActual+1
		AT_Insert ($l_posicion;1;->atQRY_NombreVirtualCampo;->ayQRY_Campos;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;->alQRY_numeroTabla;->alQRY_numeroCampo;$y_index)
		atQRY_NombreVirtualCampo{$l_posicion}:=""
		ayQRY_Campos{$l_posicion}:=$y_Nil
		atQRY_Operador_Literal{$l_posicion}:=__ ("comienza con")
		alQRY_Operador_ID{$l_posicion}:=1
		atQRY_ValorLiteral{$l_posicion}:=""
		atQRY_Conector_Literal{$l_posicion}:=__ ("Y")
		atQRY_NombreInternoCampo{$l_posicion}:=""
		atQRY_Conector_Simbolo{$l_posicion}:="&"
		alQRY_numeroTabla{$l_posicion}:=0
		alQRY_numeroCampo{$l_posicion}:=0
		$y_index->{$l_posicion}:=$y_indexCount->
		
		$y_menuConector:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_nuevoIndex)+"_Conector")
		AT_Initialize ($y_menuConector)
		If (Size of array:C274($y_menuConector->)=0)
			APPEND TO ARRAY:C911($y_menuConector->;"")
		End if 
		$y_menuConector->{1}:=atQRY_Conector_Literal{$l_posicion}
		$y_menuConector->:=1
		
		$y_menuCampos:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_nuevoIndex)+"_Campo")
		AT_Initialize ($y_menuCampos)
		If (Size of array:C274($y_menuCampos->)=0)
			APPEND TO ARRAY:C911($y_menuCampos->;"")
		End if 
		$y_menuCampos->{1}:=Choose:C955(atQRY_NombreVirtualCampo{$l_posicion}#"";atQRY_NombreVirtualCampo{$l_posicion};__ ("Seleccione el campo…"))
		$y_menuCampos->:=1
		
		$y_menuCondicion:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_nuevoIndex)+"_Condicion")
		AT_Initialize ($y_menuCondicion)
		If (Size of array:C274($y_menuCondicion->)=0)
			APPEND TO ARRAY:C911($y_menuCondicion->;"")
		End if 
		$y_menuCondicion->{1}:=atQRY_Operador_Literal{$l_posicion}
		$y_menuCondicion->:=1
		
		$y_objectCount->:=$y_objectCount->+1
		
		$l_altoFila:=LISTBOX Get rows height:C836(*;"lb_criterios")
		$l_filas:=Size of array:C274($y_index->)
		$l_altoListbox:=$l_altoFila*$l_filas
		OBJECT GET COORDINATES:C663(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
		GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
		$l_altoPantalla:=Screen height:C188
		$l_maxSize:=$l_altoPantalla-$l_arribaLB-$l_arribaW
		$l_maxFilas:=Int:C8($l_maxSize/$l_altoFila)-1
		$l_maxFilas:=Choose:C955($l_maxFilas>16;16;$l_maxFilas)
		If ($l_filas<=$l_maxFilas)
			OBJECT GET COORDINATES:C663(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
			OBJECT SET COORDINATES:C1248(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_arribaLB+$l_altoListbox)
			GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
			SET WINDOW RECT:C444($l_izquierdaW;$l_arribaW;$l_derechaW;$l_arribaW+$l_arribaLB+($l_filas*$l_altoFila)+40)
		End if 
		
		OBJECT SET ENABLED:C1123(*;"@_nuevaLinea";$l_filas<$l_maxFilas)
		
	End if 
End if 