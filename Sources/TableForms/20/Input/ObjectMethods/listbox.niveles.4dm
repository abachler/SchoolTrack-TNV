  // [xxSTR_Materias].Input.listbox.niveles()
  //
  //
  // creado por: Alberto Bachler Klein: 01-12-15, 18:59:43
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_expanded;$b_isFolder)
C_LONGINT:C283($l_idCategoria;$l_idObservacion;$l_index)
C_POINTER:C301($y_categorias;$y_listaCategorias;$y_listaEnunciadosMapas;$y_listaEnunciadosMatriz;$y_listboxNiveles;$y_listboxObservaciones;$y_nivelNumero_al;$y_objeto_categorias;$y_objeto_observaciones;$y_observaciones)
C_POINTER:C301($y_recNumMatriz_al;$y_refNivel_t)
C_TEXT:C284($t_categoria;$t_nivelActual;$t_observacion;$t_ultimaCategoria)
C_OBJECT:C1216($ob_nodoCategoria;$ob_nodoNivel;$ob_observacion;$ob_observacionesNivel;$ob_raiz)

ARRAY TEXT:C222($at_pares;0)
ARRAY OBJECT:C1221($ao_Categorias;0)
ARRAY OBJECT:C1221($ao_observaciones;0)

$y_listboxNiveles:=OBJECT Get pointer:C1124(Object named:K67:5;"listbox.niveles")
$y_listaEnunciadosMapas:=OBJECT Get pointer:C1124(Object named:K67:5;"enunciadosMapa")
$y_listaEnunciadosMatriz:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$y_refNivel_t:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelActual")

$y_listboxObservaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_observaciones")  //20170623 RCH Retorno de observaciones
$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")

$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")

$t_nivelActual:=$y_refNivel_t->
Case of 
		
	: (Form event:C388=On Clicked:K2:4)
		Case of 
			: (FORM Get current page:C276=2)
				
				
			: (FORM Get current page:C276=3)
				If (Find in array:C230($y_listboxNiveles->;True:C214)<0)
					$y_recNumMatriz_al->:=0
					$y_nivelNumero_al->:=0
					LISTBOX SELECT ROW:C912(*;"lb_Matrices";0;lk remove from selection:K53:3)
					HL_ClearList ($y_listaEnunciadosMapas->)
					HL_ClearList ($y_listaEnunciadosMatriz->)
				End if 
		End case 
		
	: ((Form event:C388=On Selection Change:K2:29) | (Form event:C388=On Clicked:K2:4))
		Case of 
			: (FORM Get current page:C276=2)
				  // guardo las observaciones modificadas en el objeto correspondiente al nivel
				CFGstr_GuardaObsSubsectores 
				$y_refNivel_t->:=String:C10($y_nivelNumero_al->{$y_nivelNumero_al->})
				CFGstr_LeeObsSubsectores 
				
			: (FORM Get current page:C276=3)
				If ($y_nivelNumero_al->>0)
					MPA_Matrices 
					$y_matrizNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizNombre")
					$t_tituloMatriz:=__ ("Competencias en ^0")
					$t_tituloMatriz:=Replace string:C233($t_tituloMatriz;"^0";$y_matrizNombre->{$y_matrizNombre->})
					OBJECT SET TITLE:C194(*;"tituloMatriz";$t_tituloMatriz)
				End if 
		End case 
		
		
End case 