AL_ExitCell (xALP_CsdList2)

$confirm:=""
For ($i;1;Size of array:C274(arAS_EvalPropPercent))
	If (arAS_EvalPropPercent{$i}>0)
		$confirm:=__ ("Las notas parciales de esta asignatura tienen pesos específicos diferenciados. \rSi selecciona este modo de consolidación cada parcial tendrá necesariamente el mismo peso.\r¿Es lo que desea hacer?")
		$i:=Size of array:C274(arAS_EvalPropPercent)+1
	End if 
End for 
If ($confirm#"")
	OK:=CD_Dlog (0;$confirm;__ ("");__ ("No");__ ("Sí"))
	If (ok=2)
		vi_metodo:=2
		For ($i;1;Size of array:C274(arAS_EvalPropPercent))
			arAS_EvalPropPercent{$i}:=0
			arAS_EvalPropPonderacion{$i}:=0
			arAS_EvalPropCoefficient{$i}:=1
		End for 
		w0iguales:=1
		w1coeficiente:=0
		w2porcentaje:=0
		vlAS_CalcMethod:=0
		AL_UpdateArrays (xALP_CsdList2;0)
		AL_SetColOpts (xALP_CsdList2;0;0;0;3)
		AL_SetWidths (xALP_CsdList2;5;1;200)
		AL_UpdateArrays (xALP_CsdList2;-2)
		vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")
		
		vbRecalcPromedios:=True:C214
	Else 
		Case of 
			: (vi_metodo=0)
				m0:=1
				m1:=0
				m2:=0
			: (vi_metodo=1)
				m0:=0
				m1:=1
				m2:=0
			: (vi_metodo=2)
				m0:=0
				m1:=0
				m2:=1
		End case 
		  // Ticket 175179
		  //APPEND TO ARRAY(atSTR_EventLog;"Atributo \"Promediar todas las evaluaciones parciales de todas las asignaturas de "+"origen\" activado")
	End if 
Else 
	vi_metodo:=2
	For ($i;1;Size of array:C274(atAS_EvalPropSourceName))
		arAS_EvalPropPercent{$i}:=0
		arAS_EvalPropPonderacion{$i}:=0
		arAS_EvalPropCoefficient{$i}:=1
	End for 
	w0iguales:=1
	w1coeficiente:=0
	w2porcentaje:=0
	vlAS_CalcMethod:=0
	AL_UpdateArrays (xALP_CsdList2;0)
	AL_SetColOpts (xALP_CsdList2;0;0;0;3)
	AL_SetWidths (xALP_CsdList2;5;1;200)
	AL_UpdateArrays (xALP_CsdList2;-2)
	vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")
End if 
vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")


