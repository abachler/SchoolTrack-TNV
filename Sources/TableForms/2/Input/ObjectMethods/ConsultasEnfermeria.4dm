Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState ((USR_checkRights ("M";->[Alumnos_FichaMedica:13]) & ($line>0));->bDelSalud_Consulta)
	: (alProEvt=2)
		If (USR_checkRights ("L";->[Alumnos_EventosEnfermeria:14]))
			$line:=AL_GetLine (xALP_ConsultasEnfermeria)
			If ($line>0)
				ARRAY OBJECT:C1221($aob_afeccion;0)
				ARRAY TEXT:C222($at_afeccion;0)
				GOTO RECORD:C242([Alumnos_EventosEnfermeria:14];aCENo{$line})
				WDW_OpenFormWindow (->[Alumnos_EventosEnfermeria:14];"Input";-1;5;__ ("Consulta de: ")+[Alumnos:2]Nombre_Común:30)
				KRL_ModifyRecord (->[Alumnos_EventosEnfermeria:14];"Input")
				CLOSE WINDOW:C154
				QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Alumno_Numero:1=[Alumnos:2]numero:1)
				AL_UpdateArrays (xALP_ConsultasEnfermeria;0)
				OB_GET ([Alumnos_EventosEnfermeria:14]OB_Afeccion:20;->$aob_afeccion;"OB")
				SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Fecha:2;aDateCE;[Alumnos_EventosEnfermeria:14]Afeccion:6;aMotCons;[Alumnos_EventosEnfermeria:14];aCENo;[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;aCEHora;[Alumnos_EventosEnfermeria:14]OB_Afeccion:20;$aob_afeccion)
				For ($i;1;Size of array:C274($aob_afeccion))
					OB_GET ($aob_afeccion{$i};->$at_afeccion;"OB")
					$t_afeccion:=AT_array2text (->$at_afeccion;";")
					aMotCons{$i}:=$t_afeccion
				End for 
				AL_UpdateArrays (xALP_ConsultasEnfermeria;Size of array:C274(aDateCE))
				IT_SetButtonState ((Size of array:C274(aDateCE)>0);->bDelSalud_Consulta)
				AL_SetLine (xALP_ConsultasEnfermeria;$line)
			End if 
		End if 
End case 