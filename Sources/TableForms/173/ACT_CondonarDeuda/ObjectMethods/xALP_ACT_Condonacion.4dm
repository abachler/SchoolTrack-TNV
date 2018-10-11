  //AL_UpdateArrays (xALP_ACT_Condonacion;0)
$line:=AL_GetLine (xALP_ACT_Condonacion)
$col:=AL_GetColumn (xALP_ACT_Condonacion)
Case of 
	: ((alProEvt=1) | (alProEvt=2))
		Case of 
			: ($col=1)
				If (abACT_AvisosCargoSel{$line})
					abACT_AvisosCargoSel{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_AvisosCargoSel{$line})
				Else 
					abACT_AvisosCargoSel{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_AvisosCargoSel{$line})
				End if 
		End case 
		
	: (alProEvt=5)
		If (abACT_AvisosCargoSel{$line})
			$text:=__ ("No Condonar")
		Else 
			$text:=__ ("Condonar")
		End if 
		$text:=$text+";(-;"+__ ("No Condonar Todos")+";"+__ ("Condonar Todos")
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				If (abACT_AvisosCargoSel{$line})
					abACT_AvisosCargoSel{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_AvisosCargoSel{$line})
				Else 
					abACT_AvisosCargoSel{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_AvisosCargoSel{$line})
				End if 
			: ($choice=3)
				For ($i;1;Size of array:C274(abACT_AvisosCargoSel))
					abACT_AvisosCargoSel{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_AvisosCargoSel{$i})
				End for 
			: ($choice=4)
				For ($i;1;Size of array:C274(abACT_AvisosCargoSel))
					abACT_AvisosCargoSel{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_AvisosCargoSel{$i})
				End for 
		End case 
	: (alProEvt=6)
		$text:=__ ("No Condonar Todos")+";"+__ ("Condonar Todos")
		$choice:=Pop up menu:C542($text)
		Case of 
			: ($choice=1)
				For ($i;1;Size of array:C274(abACT_AvisosCargoSel))
					abACT_AvisosCargoSel{$i}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_AvisosCargoSel{$i})
				End for 
				
			: ($choice=2)
				For ($i;1;Size of array:C274(abACT_AvisosCargoSel))
					abACT_AvisosCargoSel{$i}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_AvisosCargoSel{$i})
				End for 
		End case 
End case 
AL_UpdateArrays (xALP_ACT_Condonacion;-1)
REDRAW WINDOW:C456