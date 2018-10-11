If (Self:C308->)
	If ([Asignaturas:18]Consolidacion_Madre_Id:7>0)
		$id:=[Asignaturas:18]Numero:1
		$motherId:=[Asignaturas:18]Consolidacion_Madre_Id:7
		$motherName:=[Asignaturas:18]Consolidacion_Madre_nombre:8
		PUSH RECORD:C176([Asignaturas:18])
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$motherId)
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			For ($periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
				AS_PropEval_Lectura ("";$periodo)
				$el:=Find in array:C230(alAS_EvalPropSourceID;$id)
				If ($el>0)
					$periodo:=Size of array:C274(atSTR_Periodos_Nombre)+1
				End if 
			End for 
		Else 
			AS_PropEval_Lectura 
			$el:=Find in array:C230(alAS_EvalPropSourceID;$id)
		End if 
		POP RECORD:C177([Asignaturas:18])
		If ($el>0)
			$answer:=CD_Dlog (0;__ ("Esta asignatura consolida en ")+$motherName+__ (" y ha sido configurada para ser impresa bajo ella.\rSi continúa es posible que aparezca dos veces en los informes de notas.\r¿Que desea usted hacer?");__ ("");__ ("Cancelar");__ ("Continuar"))
			If ($answer=2)
				  //
			Else 
				Self:C308->:=False:C215
			End if 
		End if 
	Else 
		  //
	End if 
End if 
