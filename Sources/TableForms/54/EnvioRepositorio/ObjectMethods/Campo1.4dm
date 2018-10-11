  // [xShell_Reports].EnvioRepositorio.Campo1()
  // Por: Alberto Bachler K.: 16-08-14, 13:31:01
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_comentarios:=OBJECT Get pointer:C1124(Object named:K67:5;"comentario")
(OBJECT Get pointer:C1124(Object current:K67:2))->:=Get edited text:C655
$y_comentarios->:=RIN_ComparaInforme ([xShell_Reports:54]UUID:47)