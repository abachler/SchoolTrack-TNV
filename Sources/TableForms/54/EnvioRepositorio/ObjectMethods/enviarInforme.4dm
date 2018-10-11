  // [xShell_Reports].EnvioRepositorio.Botón()
  // Por: Alberto Bachler K.: 13-08-14, 18:33:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_actualizarUltimaVersion)
C_POINTER:C301($y_build;$y_Comentarios;$y_RutaPdf)
C_TEXT:C284($t_dtsRepositorio)

$y_RutaPdf:=OBJECT Get pointer:C1124(Object named:K67:5;"rutaPdf")
$y_build:=OBJECT Get pointer:C1124(Object named:K67:5;"build")
$y_Comentarios:=OBJECT Get pointer:C1124(Object named:K67:5;"comentario")
$l_actualizarUltimaVersion:=(OBJECT Get pointer:C1124(Object named:K67:5;"enviarInforme_actualizar"))->

$t_dtsRepositorio:=RIN_EnviaInforme ($y_Comentarios->;$y_RutaPdf->;$y_build->;$l_actualizarUltimaVersion)
If ($t_dtsRepositorio#"")
	Notificacion_Mostrar ("Envio de informe al repositorio";"El informe "+[xShell_Reports:54]ReportName:26+" fue almacenado en el repositorio de informes")
	ACCEPT:C269
End if 