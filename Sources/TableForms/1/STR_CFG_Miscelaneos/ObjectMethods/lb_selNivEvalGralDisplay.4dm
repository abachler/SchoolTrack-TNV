  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
If (Form event:C388=On Clicked:K2:4)
	
	$y_NivelesEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"SelAsigNiveles")
	$y_nombreEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreEvaGral")
	$y_displayEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"displayEvaGral")
	
	If (l_lbNivPosSel#$y_NivelesEvaGral->)
		
		If (l_lbNivPosSel#0)
			OB_SET (o_nomEvaGral;$y_displayEvaGral;String:C10(<>al_NumeroNivelesActivos{l_lbNivPosSel})+".display")
		End if 
		
		l_lbNivPosSel:=$y_NivelesEvaGral->
		OBJECT SET TITLE:C194(*;"tl_CopyConfigEvalDisplay";__ ("Copiar la configuración de ")+" "+$y_NivelesEvaGral->{$y_NivelesEvaGral->})
		OBJECT SET ENABLED:C1123(*;"btn_CopyConfigEvalDisplay";True:C214)
		
		OB_GET (o_nomEvaGral;$y_nombreEvaGral;"nombreEva")
		OB_GET (o_nomEvaGral;$y_displayEvaGral;String:C10(<>al_NumeroNivelesActivos{$y_NivelesEvaGral->})+".display")
		
	End if 
	
End if 
