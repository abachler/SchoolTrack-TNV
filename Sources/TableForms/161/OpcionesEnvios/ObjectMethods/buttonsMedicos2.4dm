C_BOOLEAN:C305($mark)
C_BOOLEAN:C305($mark2)

$selectedDataRef:=Selected list items:C379(hl_Dato;*)
$selectedLevelRef:=Selected list items:C379(hl_Niveles;*)

If ($selectedDataRef>=90000)
	$selectedLevelRef:=0
End if 

SN3_Manual_DataRefs{0}:=$selectedDataRef
SN3_Manual_NivelesLong{0}:=$selectedLevelRef
SN3_Manual_CualesDatosBool{0}:=(SN3_Manual_Todo=1)
If (Size of array:C274(SN3_Manual_DataRefs)=1)
	If ((SN3_Manual_DataRefs{0}=SN3_Manual_DataRefs{1}) & (SN3_Manual_NivelesLong{0}=SN3_Manual_NivelesLong{1}) & (SN3_Manual_CualesDatosBool{0}=SN3_Manual_CualesDatosBool{1}))
		$found:=1
	Else 
		$found:=0
	End if 
Else 
	ARRAY LONGINT:C221($DA_Return;0)
	$found:=AT_MultiArraySearch (False:C215;->$DA_Return;->SN3_Manual_DataRefs;->SN3_Manual_NivelesLong;->SN3_Manual_CualesDatosBool)
End if 
If ($found=0)
	SN3_Manual_DataRefs{0}:=$selectedDataRef
	SN3_Manual_NivelesLong{0}:=$selectedLevelRef
	SN3_Manual_CualesDatosBool{0}:=True:C214
	If (Size of array:C274(SN3_Manual_DataRefs)=1)
		If ((SN3_Manual_DataRefs{0}=SN3_Manual_DataRefs{1}) & (SN3_Manual_NivelesLong{0}=SN3_Manual_NivelesLong{1}) & (SN3_Manual_CualesDatosBool{0}=SN3_Manual_CualesDatosBool{1}))
			$found:=1
		Else 
			$found:=0
		End if 
	Else 
		ARRAY LONGINT:C221($DA_Return;0)
		$found:=AT_MultiArraySearch (False:C215;->$DA_Return;->SN3_Manual_DataRefs;->SN3_Manual_NivelesLong;->SN3_Manual_CualesDatosBool)
	End if 
End if 
If ($found=0)
	SN3_Manual_DataRefs{0}:=$selectedDataRef
	SN3_Manual_NivelesLong{0}:=-9999  //Todos
	SN3_Manual_CualesDatosBool{0}:=(SN3_Manual_Todo=1)
	If (Size of array:C274(SN3_Manual_DataRefs)=1)
		If ((SN3_Manual_DataRefs{0}=SN3_Manual_DataRefs{1}) & (SN3_Manual_NivelesLong{0}=SN3_Manual_NivelesLong{1}) & (SN3_Manual_CualesDatosBool{0}=SN3_Manual_CualesDatosBool{1}))
			$found:=1
		Else 
			$found:=0
		End if 
	Else 
		ARRAY LONGINT:C221($DA_Return;0)
		$found:=AT_MultiArraySearch (False:C215;->$DA_Return;->SN3_Manual_DataRefs;->SN3_Manual_NivelesLong;->SN3_Manual_CualesDatosBool)
	End if 
End if 
If ($found=0)
	$data:=HL_FindInListByReference (hl_Dato;$selectedDataRef;True:C214)
	$nivel:=HL_FindInListByReference (hl_Niveles;$selectedLevelRef;True:C214)
	If ($selectedDataRef>=90000)
		$selectedLevelRef:=0
		$nivel:=""
	End if 
	If ($selectedLevelRef=-9999)
		  //eliminar los otros niveles que haya...
		SN3_Manual_DataRefs{0}:=$selectedDataRef
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->SN3_Manual_DataRefs;"=";->$DA_Return)
		SORT ARRAY:C229($DA_Return;<)
		For ($i;1;Size of array:C274($DA_Return))
			AT_Delete ($DA_Return{$i};1;->SN3_Manual_Styles;->SN3_Manual_TipoDato;->SN3_Manual_DataRefs;->SN3_Manual_Niveles;->SN3_Manual_NivelesLong;->SN3_Manual_CualesDatos;->SN3_Manual_CualesDatosBool)
		End for 
		$mark:=(Size of array:C274($DA_Return)>0)
	End if 
	If (SN3_Manual_Todo=1)
		SN3_Manual_DataRefs{0}:=$selectedDataRef
		SN3_Manual_NivelesLong{0}:=$selectedLevelRef
		SN3_Manual_CualesDatosBool{0}:=True:C214
		If (Size of array:C274(SN3_Manual_DataRefs)=1)
			If ((SN3_Manual_DataRefs{0}=SN3_Manual_DataRefs{1}) & (SN3_Manual_NivelesLong{0}=SN3_Manual_NivelesLong{1}) & (SN3_Manual_CualesDatosBool{0}=SN3_Manual_CualesDatosBool{1}))
				$found:=1
			Else 
				$found:=0
			End if 
		Else 
			ARRAY LONGINT:C221($DA_Return;0)
			$found:=AT_MultiArraySearch (False:C215;->$DA_Return;->SN3_Manual_DataRefs;->SN3_Manual_NivelesLong;->SN3_Manual_CualesDatosBool)
		End if 
		If ($found#0)
			SORT ARRAY:C229($DA_Return;<)
			For ($i;1;Size of array:C274($DA_Return))
				AT_Delete ($DA_Return{$i};1;->SN3_Manual_Styles;->SN3_Manual_TipoDato;->SN3_Manual_DataRefs;->SN3_Manual_Niveles;->SN3_Manual_NivelesLong;->SN3_Manual_CualesDatos;->SN3_Manual_CualesDatosBool)
			End for 
			$mark2:=(Size of array:C274($DA_Return)>0)
		End if 
	End if 
	APPEND TO ARRAY:C911(SN3_Manual_TipoDato;$data)
	APPEND TO ARRAY:C911(SN3_Manual_DataRefs;$selectedDataRef)
	APPEND TO ARRAY:C911(SN3_Manual_Niveles;$nivel)
	APPEND TO ARRAY:C911(SN3_Manual_NivelesLong;$selectedLevelRef)
	$cuales:=("Todos"*SN3_Manual_Todo)+("Sólo Modificados"*SN3_Manual_Modificados)
	APPEND TO ARRAY:C911(SN3_Manual_CualesDatos;$cuales)
	$cualesBool:=(SN3_Manual_Todo=1)
	APPEND TO ARRAY:C911(SN3_Manual_CualesDatosBool;$cualesBool)
	APPEND TO ARRAY:C911(SN3_Manual_Styles;Plain:K14:1)
	If (($mark) | ($mark2))
		SN3_Manual_Styles{Size of array:C274(SN3_Manual_Styles)}:=Bold:K14:2+Italic:K14:3
		SET TIMER:C645(90)
	End if 
Else 
	BEEP:C151
End if 
SELECT LIST ITEMS BY POSITION:C381(hl_Dato;1)
SELECT LIST ITEMS BY POSITION:C381(hl_Niveles;1)
_O_REDRAW LIST:C382(hl_Dato)
_O_REDRAW LIST:C382(hl_Niveles)
SN3_Manual_Todo:=1
SN3_Manual_Modificados:=0
_O_ENABLE BUTTON:C192(b_Manual_Enviar)
_O_ENABLE BUTTON:C192(b_Manual_Limpiar)
IT_SetButtonState (False:C215;->SN3_Manual_Todo;->SN3_Manual_Modificados;->hl_Niveles;->bAddEnvio;->bDelEnvio)