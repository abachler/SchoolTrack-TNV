ARRAY LONGINT:C221($alACT_linesSelected;0)
$line:=AL_GetLine (xALP_ACT_Terc_CtasXItems)
Case of 
	: ((alProEvt=1) | (alProEvt=2))
		$col:=AL_GetColumn (xALP_ACT_Terc_CtasXItems)
		If ($col=1)
			If ($line#0)
				If (abACT_ActivoCXI{$line})
					abACT_ActivoCXI{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ActivoCXI{$line})
				Else 
					abACT_ActivoCXI{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ActivoCXI{$line})
				End if 
				APPEND TO ARRAY:C911($alACT_linesSelected;$line)
			End if 
		End if 
		
	: (alProEvt=5)
		If (abACT_ActivoCXI{$line})
			$text:="No utilizar"
		Else 
			$text:="Utilizar"
		End if 
		$text:=$text+";(-;No Utilizar Todos;Utilizar Todos"
		$choice:=Pop up menu:C542($text)
		
		Case of 
			: ($choice=1)
				If (abACT_ActivoCXI{$line})
					abACT_ActivoCXI{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ActivoCXI{$line})
				Else 
					abACT_ActivoCXI{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ActivoCXI{$line})
				End if 
				APPEND TO ARRAY:C911($alACT_linesSelected;$line)
				
			: ($choice=3)
				For ($i;1;Size of array:C274(abACT_ActivoCXI))
					abACT_ActivoCXI{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ActivoCXI{$i})
					APPEND TO ARRAY:C911($alACT_linesSelected;$line)
				End for 
				
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_ActivoCXI))
					abACT_ActivoCXI{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ActivoCXI{$i})
					APPEND TO ARRAY:C911($alACT_linesSelected;$line)
				End for 
				
		End case 
	: (alProEvt=6)
		$text:="No Utilizar Todos;Utilizar Todos"
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				For ($i;1;Size of array:C274(abACT_ActivoCXI))
					abACT_ActivoCXI{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ActivoCXI{$i})
					APPEND TO ARRAY:C911($alACT_linesSelected;$line)
				End for 
				
			: ($choice=2)
				For ($i;1;Size of array:C274(abACT_ActivoCXI))
					abACT_ActivoCXI{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ActivoCXI{$i})
					APPEND TO ARRAY:C911($alACT_linesSelected;$line)
				End for 
				
		End case 
End case 
For ($i;1;Size of array:C274($alACT_linesSelected))
	$line:=$alACT_linesSelected{$i}
	ACTter_Datos_ALP ("Guarda";->$line)
End for 
AL_UpdateArrays (xALP_ACT_Terc_CtasXItems;-1)
ACTter_SetObjects 