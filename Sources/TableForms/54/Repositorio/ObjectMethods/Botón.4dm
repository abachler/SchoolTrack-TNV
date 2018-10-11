  // [xShell_Reports].Repositorio.Botón()
  // Por: Alberto Bachler K.: 12-08-14, 10:41:36
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_posicion:=Selected list items:C379(hlRIN_Informes)
OBJECT SET SCROLL POSITION:C906(*;"hlRIN_Informes";$l_posicion;*)
SELECT LIST ITEMS BY POSITION:C381(*;"hlRIN_Informes";$l_posicion)
