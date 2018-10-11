  // GeneracionAplicacion.pagina2()
  // 
  //
  // creado por: Alberto Bachler Klein: 19-08-16, 11:57:38
  // -----------------------------------------------------------
GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
OBJECT GET COORDINATES:C663(*;"tareas_listBox";$l_ignorar;$l_ignorar;$l_ignorar;$l_abajoObjeto)
SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_arriba+$l_abajoObjeto)

If (Version type:C495 ?? 64 bit version:K5:25)
	$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac_html.xml";"BuildAppWin_html.xml")
Else 
	$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac.log.html";"BuildAppWin.log.html")
End if 
If (Test path name:C476($t_rutaLog)=Is a document:K24:1)
	WA OPEN URL:C1020(*;"WA";$t_rutaLog)
End if 
FORM GOTO PAGE:C247(2)
