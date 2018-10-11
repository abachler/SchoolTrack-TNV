//%attributes = {}
  //ACTcfgdes_OpcionesGenerales

C_TEXT:C284($1;$accion)
C_POINTER:C301($ptr1;$ptr2)
C_POINTER:C301(${2})
C_BLOB:C604($xBlob)

$accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 

Case of 
	: ($accion="InitArraysPref")
		ARRAY LONGINT:C221($al_NumeroNiveles;0)
		ACTcfgdes_OpcionesGenerales ("DeclaraArraysPref")
		ACTcfgdes_OpcionesGenerales ("BuscaNiveles";->[xxSTR_Niveles:6]NoNivel:5;->$al_NumeroNiveles)
		AT_CopyArrayElements (->$al_NumeroNiveles;->ai_nivelesConsideradoNoHijo)
		AT_CopyArrayElements (->$al_NumeroNiveles;->ai_nivelesConsideradoNoCarga)
		
	: ($accion="LeeBlob")
		ACTcfg_LeeBlob ("ACTcfg_NivelesCalculoNoCargas")
		
	: ($accion="DeclaraArrays")
		ARRAY LONGINT:C221(ai_numeroNivelForm;0)
		ARRAY TEXT:C222(at_nombreNivelForm;0)
		ARRAY BOOLEAN:C223(ab_nivelConsideradoNoHijoForm;0)
		ARRAY PICTURE:C279(ap_nivelConsideradoNoHijoForm;0)
		ARRAY BOOLEAN:C223(ab_nivelConsideradoNoCargaForm;0)
		ARRAY PICTURE:C279(ap_nivelConsideradoNoCargaForm;0)
		
	: ($accion="DeclaraArraysPref")
		ARRAY INTEGER:C220(ai_nivelesConsideradoNoHijo;0)
		ARRAY INTEGER:C220(ai_nivelesConsideradoNoCarga;0)
		
	: ($accion="InitArrays")
		ACTcfgdes_OpcionesGenerales ("DeclaraArrays")
		ACTcfgdes_OpcionesGenerales ("BuscaNiveles";->[xxSTR_Niveles:6]NoNivel:5;->ai_numeroNivelForm)
		AT_RedimArrays (Size of array:C274(ai_numeroNivelForm);->at_nombreNivelForm;->ab_nivelConsideradoNoHijoForm;->ap_nivelConsideradoNoHijoForm;->ab_nivelConsideradoNoCargaForm;->ap_nivelConsideradoNoCargaForm)
		
	: ($accion="AperturaModulo")
		ACTcfgdes_OpcionesGenerales ("InitArraysPref")
		ACTcfgdes_OpcionesGenerales ("GuardaBlob")
		
	: ($accion="UD_v20080805")
		If (Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))=1)
			ACTinit_LoadPrefs 
			ACTcfgdes_OpcionesGenerales ("LeeBlob")
			If (cbIncluirAdmision=0)  //debería ejecutarse sólo una vez y cuando la preferencia recién se crea
				$el:=Find in array:C230(ai_nivelesConsideradoNoHijo;Nivel_AdmisionDirecta)
				If ($el#-1)
					AT_Delete ($el;1;->ai_nivelesConsideradoNoHijo;->ai_nivelesConsideradoNoCarga)
				End if 
				$el:=Find in array:C230(ai_nivelesConsideradoNoHijo;Nivel_AdmissionTrack)
				If ($el#-1)
					AT_Delete ($el;1;->ai_nivelesConsideradoNoHijo;->ai_nivelesConsideradoNoCarga)
				End if 
			End if 
			ACTcfgdes_OpcionesGenerales ("GuardaBlob")
		End if 
		
	: ($accion="BuscaNiveles")
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214;*)
		QUERY:C277([xxSTR_Niveles:6]; | ;[xxSTR_Niveles:6]NoNivel:5;=;Nivel_AdmisionDirecta*1;*)
		QUERY:C277([xxSTR_Niveles:6]; | ;[xxSTR_Niveles:6]NoNivel:5;=;Nivel_AdmissionTrack*1)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		Case of 
			: (Count parameters:C259=3)
				SELECTION TO ARRAY:C260($ptr1->;$ptr2->)
			: (Count parameters:C259=5)
				SELECTION TO ARRAY:C260($ptr1->;$ptr2->;$ptr3->;$ptr4->)
		End case 
		REDUCE SELECTION:C351([xxSTR_Niveles:6];0)
		
	: ($accion="SeleccionaNivelesCargas")
		ACTcfgdes_OpcionesGenerales ("InitArrays")
		ACTcfgdes_OpcionesGenerales ("LeeBlob")
		ACTcfgdes_OpcionesGenerales ("BuscaNiveles";->[xxSTR_Niveles:6]Nivel:1;->at_nombreNivelForm;->[xxSTR_Niveles:6]NoNivel:5;->ai_numeroNivelForm)
		For ($i;1;Size of array:C274(ai_numeroNivelForm))
			If (Find in array:C230(ai_nivelesConsideradoNoHijo;ai_numeroNivelForm{$i})#-1)
				ab_nivelConsideradoNoHijoForm{$i}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_nivelConsideradoNoHijoForm{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_nivelConsideradoNoHijoForm{$i})
			End if 
			If (Find in array:C230(ai_nivelesConsideradoNoCarga;ai_numeroNivelForm{$i})#-1)
				ab_nivelConsideradoNoCargaForm{$i}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_nivelConsideradoNoCargaForm{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_nivelConsideradoNoCargaForm{$i})
			End if 
		End for 
		
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcfg_SeleccionaNivelesCarga";-1;8;"Selección de Nveles")
		DIALOG:C40([xxSTR_Constants:1];"ACTcfg_SeleccionaNivelesCarga")
		CLOSE WINDOW:C154
		If (ok=1)
			ACTcfgdes_OpcionesGenerales ("DeclaraArraysPref")
			ab_nivelConsideradoNoHijoForm{0}:=True:C214
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->ab_nivelConsideradoNoHijoForm;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911(ai_nivelesConsideradoNoHijo;ai_numeroNivelForm{$DA_Return{$i}})
			End for 
			ab_nivelConsideradoNoCargaForm{0}:=True:C214
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->ab_nivelConsideradoNoCargaForm;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911(ai_nivelesConsideradoNoCarga;ai_numeroNivelForm{$DA_Return{$i}})
			End for 
		End if 
		ACTcfgdes_OpcionesGenerales ("GuardaBlob")
	: ($accion="GuardaBlob")
		ACTcfg_GuardaBlob ("ACTcfg_CalculoNoHijo_NoCargas")
		ACTcfgdes_OpcionesGenerales ("DeclaraArrays")
End case 
