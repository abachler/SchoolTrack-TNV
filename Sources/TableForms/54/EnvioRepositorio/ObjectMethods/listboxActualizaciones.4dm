  // [xShell_Reports].EnvioRepositorio.List Box()
  // Por: Alberto Bachler K.: 13-08-14, 16:57:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$y_actualizaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"comentariosActualizaciones")

(OBJECT Get pointer:C1124(Object named:K67:5;"comentarioHistorial"))->:=$y_actualizaciones->{$y_actualizaciones->}