  // [xxSTR_Materias].Input.Botón1()
  // Por: Alberto Bachler K.: 21-05-14, 12:15:27
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_nivelNumero:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")

$t_menuRef:=Create menu:C408
APPEND MENU ITEM:C411($t_menuRef;__ ("Común a todos los períodos"))
SET MENU ITEM PARAMETER:C1004($t_menuRef;-1;"0")
APPEND MENU ITEM:C411($t_menuRef;"-")
SET MENU ITEM PARAMETER:C1004($t_menuRef;-1;"")
For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	APPEND MENU ITEM:C411($t_menuRef;atSTR_Periodos_Nombre{$i})
	SET MENU ITEM PARAMETER:C1004($t_menuRef;-1;String:C10($i))
End for 

$t_periodoSeleccionado:=Dynamic pop up menu:C1006($t_menuRef)
Case of 
	: ($t_periodoSeleccionado="0")
		(OBJECT Get pointer:C1124(Object named:K67:5;"refPeriodo"))->:=0
	: ($t_periodoSeleccionado#"0")
		(OBJECT Get pointer:C1124(Object named:K67:5;"refPeriodo"))->:=Num:C11($t_periodoSeleccionado)
End case 

$y_refPeriodo:=OBJECT Get pointer:C1124(Object named:K67:5;"refPeriodo")
Case of 
	: ($y_refPeriodo->=0)
		OBJECT SET TITLE:C194(*;"MenuPeriodo";__ ("Común a todos los períodos"))
		MPA_Matrices 
	: ($y_refPeriodo->>0)
		OBJECT SET TITLE:C194(*;"MenuPeriodo";atSTR_Periodos_Nombre{$y_refPeriodo->})
		MPA_Matrices 
End case 

RELEASE MENU:C978($t_menuRef)

  //GET LIST ITEM(hl_Periodos;Selected list items(hl_Periodos);$l_numeroPeriodo;$t_nombrePeriodo)
  //vl_PeriodoSeleccionado:=$l_numeroPeriodo
  //aiSTR_Periodos_Numero:=$l_numeroPeriodo
  //vlSTR_PeriodoSeleccionado:=$l_numeroPeriodo
  //atSTR_Periodos_Nombre:=Find in array(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)
