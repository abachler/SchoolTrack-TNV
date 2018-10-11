$y_refMenu:=OBJECT Get pointer:C1124(Object named:K67:5;"menuImpresion")
If (Contextual click:C713)
	$t_destinoImpresion:=Dynamic pop up menu:C1006($y_refMenu->)
Else 
	$t_destinoImpresion:="preview"
End if 

QR_ImprimeInforme (Record number:C243([xShell_Reports:54]);$t_destinoImpresion)
QR_AjustesMenu 