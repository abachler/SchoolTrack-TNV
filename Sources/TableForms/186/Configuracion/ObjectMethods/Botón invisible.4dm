
If (vb_wholeScreen)
	$t_textoPopUpTareas:="(Ver a Pantalla completa/F;(-;"
Else 
	$t_textoPopUpTareas:="Ver a Pantalla completa/F;(-;"
End if 
If (vi_LineasPorFila<10)
	$t_textoPopUpTareas:=$t_textoPopUpTareas+"Agrandar tamaño de celda/+;"
Else 
	$t_textoPopUpTareas:=$t_textoPopUpTareas+"(Agrandar tamaño de celda/+;"
End if 
If (vi_LineasPorFila>1)
	$t_textoPopUpTareas:=$t_textoPopUpTareas+"Disminuir tamaño de celda/-;"
Else 
	$t_textoPopUpTareas:=$t_textoPopUpTareas+"(Disminuir tamaño de celda/-;"
End if 
$t_textoPopUpTareas:=$t_textoPopUpTareas+"(-;Distribuir ancho de las celdas/D"

$l_seleccionUsuario:=Pop up menu:C542($t_textoPopUpTareas)

Case of 
	: ($l_seleccionUsuario=1)  // pantalla completa
		POST KEY:C465(Character code:C91("f");Command key mask:K16:1)
		
	: ($l_seleccionUsuario=3)  //Agrandar tamaño de celda
		POST KEY:C465(Character code:C91("+");Command key mask:K16:1)
		
	: ($l_seleccionUsuario=4)  //Disminuir tamaño de celda
		POST KEY:C465(Character code:C91("-");Command key mask:K16:1)
		
	: ($l_seleccionUsuario=6)
		POST KEY:C465(Character code:C91("d");Command key mask:K16:1)
End case 