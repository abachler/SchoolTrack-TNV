  // [xShell_AnotacionesRegistros].Registro.anotacion()
  // Por: Alberto Bachler K.: 17-03-15, 10:37:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

[xShell_RecordNotes:283]Anotacion:8:=Get edited text:C655
$t_texto:=ST_CleanString (ST Get plain text:C1092([xShell_RecordNotes:283]Anotacion:8))
OBJECT SET ENABLED:C1123(*;"botonAceptar";$t_texto#"")

