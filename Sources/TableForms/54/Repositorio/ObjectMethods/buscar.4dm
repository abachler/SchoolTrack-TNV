  // [xShell_Reports].Repositorio.buscar()
  // Por: Alberto Bachler K.: 21-08-14, 10:15:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_palabrasCompletas)
C_LONGINT:C283($l_refModulo;$l_refPanel;$l_tipoComparacion;$l_tipoInforme)
C_POINTER:C301($y_expresion;$y_palabrasCompletas;$y_tipoComparacion)
C_TEXT:C284($t_modulo;$t_panel;$t_tipoInforme)

$y_tipoComparacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoComparacion")
$y_palabrasCompletas:=OBJECT Get pointer:C1124(Object named:K67:5;"palabrasCompletas")
$l_tipoComparacion:=Num:C11($y_tipoComparacion->)
$b_palabrasCompletas:=($y_palabrasCompletas->=1)

GET LIST ITEM:C378(hlRIN_Tipo;*;$l_tipoInforme;$t_tipoInforme)
GET LIST ITEM:C378(hlRIN_Modulos;*;$l_refModulo;$t_modulo)
GET LIST ITEM:C378(hlRIN_Paneles;*;$l_refPanel;$t_panel)

$y_expresion:=OBJECT Get pointer:C1124(Object named:K67:5;"expresionBusqueda")
  //RIN_BuscaInformes ($y_expresion->)
RIN_BuscaInformes (vSearch)
SELECT LIST ITEMS BY POSITION:C381(hlRIN_Informes;0)
OBJECT SET VISIBLE:C603(*;"informe_@";False:C215)
OBJECT SET FONT STYLE:C166(*;"informe_Boton@";0)

