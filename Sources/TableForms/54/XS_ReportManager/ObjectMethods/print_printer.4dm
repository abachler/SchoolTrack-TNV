C_LONGINT:C283($l_proceso;$l_recNum)
C_TEXT:C284($t_destinoImpresion;$t_expresion;$t_menu;$t_nombreProceso;$t_rutaCarpetaPDF)



$y_refMenu:=OBJECT Get pointer:C1124(Object named:K67:5;"menuImpresion")
If (Contextual click:C713)
	$t_destinoImpresion:=Dynamic pop up menu:C1006($y_refMenu->)
Else 
	$t_destinoImpresion:="printer"
End if 

If ($t_destinoImpresion#"")
	QR_ImprimeInforme (Record number:C243([xShell_Reports:54]);$t_destinoImpresion)
End if 

