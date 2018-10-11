//%attributes = {}
  //ACTmnu_Prorrogar

If (USR_GetMethodAcces (Current method name:C684))
	  //Esto es para compatibilidad con el reemplazo que ocupa el mismo on load.
	vl_indiceFormasDePago:=4
	ARRAY TEXT:C222(aACT_DocsReemp;vl_indiceFormasDePago)
	aACT_DocsReemp{1}:="Efectivo"
	aACT_DocsReemp{2}:="Mismo cheque"
	aACT_DocsReemp{3}:="(-"
	aACT_DocsReemp{4}:="Otro cheque"
	C_TEXT:C284($cargarDesde)
	If (Count parameters:C259>=1)
		$cargarDesde:=$1
	End if 
	
	If (vb_RecordInInputForm)
		$line:=AL_GetLine (xALP_DocsenCartera)
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=aACT_ApdosDCarID{$line})
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
		  //If ([ACT_Documentos_en_Cartera]Estado#"Protestado@")
		  //If ([ACT_Documentos_en_Cartera]id_estado#-2)
		$vl_idNulo:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNulo";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
		If ([ACT_Documentos_en_Cartera:182]id_estado:21#$vl_idNulo)
			ARRAY LONGINT:C221(alACT_RecNumsDocs;1)
			alACT_RecNumsDocs{1}:=Record number:C243([ACT_Documentos_en_Cartera:182])
		Else 
			ARRAY LONGINT:C221(alACT_RecNumsDocs;0)
		End if 
		If (Size of array:C274(alACT_RecNumsDocs)>0)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTdc_Prorrogador";0;4;__ ("Prorroga de Documentos en Cartera"))
			DIALOG:C40([xxSTR_Constants:1];"ACTdc_Prorrogador")
			CLOSE WINDOW:C154
		End if 
		If ($cargarDesde="terceros")
			ACTter_PageDocEnCartera 
		Else 
			ACTpp_CargaALPPersonas (7)
		End if 
		  //ACTpp_CargaALPPersonas (7)
		AL_SetLine (xALP_DocsenCartera;0)
		ACTpp_HabDesHabAcciones (False:C215)
	Else 
		ARRAY LONGINT:C221(abrSelect;0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		ARRAY LONGINT:C221(alACT_RecNumsDocs;0)
		$j:=1
		For ($i;1;Size of array:C274(abrSelect))
			GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];alBWR_recordNumber{abrSelect{$i}})
			If (([ACT_Documentos_en_Cartera:182]id_estado:21#-2) & ([ACT_Documentos_en_Cartera:182]id_forma_de_pago:19#-8))
				INSERT IN ARRAY:C227(alACT_RecNumsDocs;Size of array:C274(alACT_RecNumsDocs)+1;1)
				alACT_RecNumsDocs{$j}:=alBWR_recordNumber{abrSelect{$i}}
				$j:=$j+1
			End if 
		End for 
		
		If (Size of array:C274(alACT_RecNumsDocs)>0)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTdc_Prorrogador";0;4;__ ("Prorroga de Documentos en Cartera"))
			DIALOG:C40([xxSTR_Constants:1];"ACTdc_Prorrogador")
			CLOSE WINDOW:C154
		End if 
	End if 
End if 