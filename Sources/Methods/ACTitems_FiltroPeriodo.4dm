//%attributes = {}
  //ACTitems_FiltroPeriodo

C_TEXT:C284($t_accion;$1)

$t_accion:=$1

Case of 
	: ($t_accion="CreaLista")
		C_REAL:C285(al_FiltroYears)
		C_LONGINT:C283($l_periodo)
		C_TEXT:C284($t_periodo)
		ARRAY TEXT:C222($atACT_periodo;0)
		
		al_FiltroYears:=New list:C375
		
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1>0)
		DISTINCT VALUES:C339([xxACT_Items:179]Periodo:42;$atACT_periodo)
		SORT ARRAY:C229($atACT_periodo;>)
		
		AT_Insert (1;1;->$atACT_periodo)
		$atACT_periodo{1}:=__ ("Todos")
		
		For ($l_periodo;1;Size of array:C274($atACT_periodo))
			APPEND TO LIST:C376(al_FiltroYears;$atACT_periodo{$l_periodo};$l_periodo)
		End for 
		
		ARRAY LONGINT:C221($alACT_posiciones;0)
		
		$t_periodo:=PREF_fGet (0;"ACT_pref_filtroItems";"Todos")  //al crear el item tambien se obtiene la preferencia
		$atACT_periodo{0}:=$t_periodo+"@"
		AT_SearchArray (->$atACT_periodo;"=";->$alACT_posiciones)
		
		If (Size of array:C274($alACT_posiciones)>0)
			SELECT LIST ITEMS BY POSITION:C381(al_FiltroYears;$alACT_posiciones{Size of array:C274($alACT_posiciones)})
			$l_periodo:=$alACT_posiciones{Size of array:C274($alACT_posiciones)}
		Else 
			If (Size of array:C274($atACT_periodo)>0)
				SELECT LIST ITEMS BY POSITION:C381(al_FiltroYears;Size of array:C274($atACT_periodo))
				$l_periodo:=Size of array:C274($atACT_periodo)
			Else 
				$l_periodo:=0
			End if 
		End if 
		
		ACTitems_CargaLista ($atACT_periodo{$l_periodo})
		
End case 