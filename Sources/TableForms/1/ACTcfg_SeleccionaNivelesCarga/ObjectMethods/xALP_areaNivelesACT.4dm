Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($error)
		$error:=ALP_DefaultColSettings (xALP_areaNivelesACT;1;"ai_numeroNivelForm";__ ("No Nivel");38;"####0")
		$error:=ALP_DefaultColSettings (xALP_areaNivelesACT;2;"at_nombreNivelForm";__ ("Nombre Nivel");150;"")
		$error:=ALP_DefaultColSettings (xALP_areaNivelesACT;3;"ap_nivelConsideradoNoHijoForm";__ ("No de Hijo");75;"1")
		$error:=ALP_DefaultColSettings (xALP_areaNivelesACT;4;"ap_nivelConsideradoNoCargaForm";__ ("No Cargas Totales");75;"1")
		$error:=ALP_DefaultColSettings (xALP_areaNivelesACT;5;"ab_nivelConsideradoNoHijoForm";"";50)
		$error:=ALP_DefaultColSettings (xALP_areaNivelesACT;6;"ab_nivelConsideradoNoCargaForm";"";50)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_areaNivelesACT;9;2;2;2;6)
		AL_SetColOpts (xALP_areaNivelesACT;0;0;0;0;0)
		AL_SetRowOpts (xALP_areaNivelesACT;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_areaNivelesACT;0;1;1)
		AL_SetMiscOpts (xALP_areaNivelesACT;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_areaNivelesACT;"";"")
		AL_SetSortOpts (xALP_areaNivelesACT;1;0)
		AL_SetCallbacks (xALP_areaNivelesACT;"";"")
		AL_SetScroll (xALP_areaNivelesACT;0;-3)
		AL_SetEntryOpts (xALP_areaNivelesACT;3;0;0;1;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_areaNivelesACT;0;30;0)
		
	: (alProEvt=1)
		$line:=AL_GetLine (xALP_areaNivelesACT)
		$col:=AL_GetColumn (xALP_areaNivelesACT)
		Case of 
			: ($col=3)
				If ($line#0)
					If (ab_nivelConsideradoNoHijoForm{$line})
						GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_nivelConsideradoNoHijoForm{$line})
						ab_nivelConsideradoNoHijoForm{$line}:=False:C215
					Else 
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_nivelConsideradoNoHijoForm{$line})
						ab_nivelConsideradoNoHijoForm{$line}:=True:C214
					End if 
				End if 
				
			: ($col=4)
				If ($line#0)
					If (ab_nivelConsideradoNoCargaForm{$line})
						GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_nivelConsideradoNoCargaForm{$line})
						ab_nivelConsideradoNoCargaForm{$line}:=False:C215
					Else 
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_nivelConsideradoNoCargaForm{$line})
						ab_nivelConsideradoNoCargaForm{$line}:=True:C214
					End if 
				End if 
		End case 
		AL_UpdateArrays (Self:C308->;-1)
End case 