ARRAY LONGINT:C221($al_SelectedLines;0)
$line:=AL_GetLine (ALP_AlumnosXPagar)
ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
Case of 
	: (alProEvt=1)
		$col:=AL_GetColumn (ALP_AlumnosXPagar)
		If ($col=1)
			If ($line#0)
				If (abACT_ASelectedAlumno{$line})
					abACT_ASelectedAlumno{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAlumnos{$line})
				Else 
					abACT_ASelectedAlumno{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAlumnos{$line})
				End if 
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				AL_UpdateArrays (ALP_AlumnosXPagar;-1)
			End if 
		End if 
		ACTpgs_LoadCargosAviso (->$al_SelectedLines)
		
	: (alProEvt=2)
		ACTpgs_LoadCargosAviso (->$al_SelectedLines)
	: (alProEvt=5)
		If (abACT_ASelectedAlumno{$line})
			$text:="Mostrar cargos de la cuenta...;(-;No pagar"
		Else 
			$text:="Mostrar cargos de la cuenta...;(-;Pagar"
		End if 
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		If ($choice#0)
			ACTpgs_LoadCargosAviso (->$al_SelectedLines)
		End if 
		Case of 
			: ($choice=1)
				ACTpgs_LoadCargosAviso (->$al_SelectedLines)
			: ($choice=3)
				If (abACT_ASelectedAlumno{$line})
					abACT_ASelectedAlumno{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAlumnos{$line})
				Else 
					abACT_ASelectedAlumno{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAlumnos{$line})
				End if 
				APPEND TO ARRAY:C911($al_SelectedLines;$line)
				AL_UpdateArrays (ALP_AlumnosXPagar;-1)
			: ($choice=5)
				For ($i;1;Size of array:C274(abACT_ASelectedAlumno))
					abACT_ASelectedAlumno{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAlumnos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AlumnosXPagar;-1)
			: ($choice=6)
				For ($i;1;Size of array:C274(abACT_ASelectedAlumno))
					abACT_ASelectedAlumno{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAlumnos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AlumnosXPagar;-1)
		End case 
	: (alProEvt=6)
		$text:="(Mostrar cargos de la cuenta...."
		$text:=$text+";(-;No Pagar Todos;Pagar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=3)
				For ($i;1;Size of array:C274(abACT_ASelectedAlumno))
					abACT_ASelectedAlumno{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAlumnos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AlumnosXPagar;-1)
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_ASelectedAlumno))
					abACT_ASelectedAlumno{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAlumnos{$i})
					APPEND TO ARRAY:C911($al_SelectedLines;$i)
				End for 
				AL_UpdateArrays (ALP_AlumnosXPagar;-1)
		End case 
End case 

ACTpgs_MarkNotMark ("DesdeAlumnos";->$al_SelectedLines)
If (modCargos)
	ACTpgs_LimpiaVarsInterfaz ("RecargaDatos")
End if 
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas3")