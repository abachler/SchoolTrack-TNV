//%attributes = {}
  //ACTmnu_CambiarUbicacion

If (USR_GetMethodAcces (Current method name:C684))
	  //Esto es para compatibilidad con el reemplazo que ocupa el mismo on load.
	vl_indiceFormasDePago:=4
	ARRAY TEXT:C222(aACT_DocsReemp;vl_indiceFormasDePago)
	aACT_DocsReemp{1}:="Efectivo"
	aACT_DocsReemp{2}:="Mismo cheque"
	aACT_DocsReemp{3}:="(-"
	aACT_DocsReemp{4}:="Otro cheque"
	If (vb_RecordInInputForm)
		$line:=AL_GetLine (xALP_DocsenCartera)
		$vl_idDocCartera:=aACT_ApdosDCarID{$line}
		If (ACTdc_DocumentoNoBloq ("CambiarU";->$vl_idDocCartera))
			ARRAY LONGINT:C221(alACT_RecNumsDocs;1)
			alACT_RecNumsDocs{1}:=Record number:C243([ACT_Documentos_en_Cartera:182])
			If (Size of array:C274(alACT_RecNumsDocs)>0)
				WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTdc_CambiadordeUbicacion";0;4;__ ("Cambiar Ubicación"))
				DIALOG:C40([xxSTR_Constants:1];"ACTdc_CambiadordeUbicacion")
				CLOSE WINDOW:C154
			End if 
		Else 
			ACTdc_DocumentoNoBloq ("CambiarUMensaje")
		End if 
		ACTdc_DocumentoNoBloq ("CambiarULiberaRegistros")
		ACTpp_CargaALPPersonas (7)
		AL_SetLine (xALP_DocsenCartera;0)
		ALP_SetAlternateLigneColor (xALP_DocsenCartera;Size of array:C274(aACT_ApdosDCarID))
		ACTpp_HabDesHabAcciones (False:C215)
	Else 
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		ARRAY LONGINT:C221(alACT_RecNumsDocs;0)
		$j:=1
		For ($i;1;Size of array:C274(abrSelect))
			GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];alBWR_recordNumber{abrSelect{$i}})
			  //If ([ACT_Documentos_en_Cartera]Estado#"Protestado@")
			INSERT IN ARRAY:C227(alACT_RecNumsDocs;Size of array:C274(alACT_RecNumsDocs)+1;1)
			alACT_RecNumsDocs{$j}:=alBWR_recordNumber{abrSelect{$i}}
			$j:=$j+1
		End for 
		
		If (Size of array:C274(alACT_RecNumsDocs)>0)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTdc_CambiadordeUbicacion";0;4;__ ("Cambiar Ubicación"))
			DIALOG:C40([xxSTR_Constants:1];"ACTdc_CambiadordeUbicacion")
			CLOSE WINDOW:C154
			UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
			READ ONLY:C145([ACT_Documentos_en_Cartera:182])
		End if 
	End if 
End if 
