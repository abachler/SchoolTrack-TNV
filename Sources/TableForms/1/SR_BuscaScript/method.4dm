$y_Metodos:=OBJECT Get pointer:C1124(Object named:K67:5;"metodos")
$y_seleccionados:=OBJECT Get pointer:C1124(Object named:K67:5;"seleccionados")


Case of 
	: (Form event:C388=On Load:K2:1)
		0xDev_BuscaScriptEnInformeSR ("OnLoad")
		METHOD GET NAMES:C1166($y_Metodos->;*)
		SORT ARRAY:C229($y_Metodos->)
		AT_ResizeArrays ($y_seleccionados;Size of array:C274($y_Metodos->))
		  //4D_GetMethodList (->aMethodNames;->al_IdMetodos)
		
	: (Form event:C388=On After Keystroke:K2:26)
		
	: (Form event:C388=On Close Box:K2:21)
		If (FORM Get current page:C276=2)
			FORM GOTO PAGE:C247(1)
			SET WINDOW TITLE:C213(__ ("Búsqueda de código en informes"))
		Else 
			CANCEL:C270
		End if 
		
	: (Form event:C388=On Resize:K2:27)
		$l_AnchoArea:=IT_Objeto_Ancho ("lb_informes")
		$l_anchoColumnaFijas:=320
		LISTBOX SET COLUMN WIDTH:C833(*;"nombreInforme";$l_anchoArea-$l_anchoColumnaFijas)
		
End case 
