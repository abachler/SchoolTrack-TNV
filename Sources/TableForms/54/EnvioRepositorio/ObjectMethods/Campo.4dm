  // [xShell_Reports].EnvioRepositorio.Campo()
  // Por: Alberto Bachler K.: 16-08-14, 13:29:25
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_comentarios:=OBJECT Get pointer:C1124(Object named:K67:5;"comentario")
(OBJECT Get pointer:C1124(Object current:K67:2))->:=Get edited text:C655
$y_comentarios->:=RIN_ComparaInforme ([xShell_Reports:54]UUID:47)
