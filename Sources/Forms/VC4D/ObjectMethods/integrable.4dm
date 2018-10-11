  // VC4D.integrable()
  //
  //
  // creado por: Alberto Bachler Klein: 14-02-16, 12:34:55
  // -----------------------------------------------------------
C_LONGINT:C283($l_tipoMetodo)
C_POINTER:C301($y_integrable;$y_ruta;$y_statusServer;$y_tabla)
C_TEXT:C284($t_nombreObjeto;$t_nombreObjetoFormulario)

$y_ruta:=OBJECT Get pointer:C1124(Object named:K67:5;"ruta")
$y_statusServer:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer")
$y_integrable:=OBJECT Get pointer:C1124(Object named:K67:5;"integrable")

METHOD RESOLVE PATH:C1165($y_ruta->{$y_ruta->};$l_tipoMetodo;$y_tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
$t_Status:=ST Get plain text:C1092($y_statusServer->{$y_ruta->})
If ((($l_tipoMetodo=Path table form:K72:5) | ($l_tipoMetodo=Path project form:K72:3)) & ($t_Status="Nuevo@"))
	$0:=-1
	$y_integrable->{$y_integrable->}:=False:C215
End if 

