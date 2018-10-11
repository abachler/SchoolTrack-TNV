//%attributes = {}
  // BBLitm_OnRecordLoad()
  // Por: Alberto Bachler: 17/09/13, 13:24:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_RefItem)
C_POINTER:C301($y_contenedor;$y_terminos)
C_TEXT:C284($t_textoItem)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)
ARRAY POINTER:C280($ay_Jerarquia;0)
ARRAY TEXT:C222($at_terminos;0)
ARRAY TEXT:C222($at_terminos2;0)

If (False:C215)
	C_LONGINT:C283(BBLitm_OnRecordLoad ;$1)
End if 

If ((Form event:C388#On Load:K2:1) & (Form event:C388#On Activate:K2:9))
	viBWR_RecordWasSaved:=BBL_dcSave 
End if 

IT_SetButtonState (USR_checkRights ("M";->[BBL_Items:61]);->bDuplica)

If (viBWR_RecordWasSaved>=0)
	If (Count parameters:C259=1)
		vlSTR_PaginaFormItems:=$1
	End if 
	
	Case of 
		: (vlSTR_PaginaFormItems=1)
			SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;1)
			If ([BBL_Items:61]Numero:1=0)
				[BBL_Items:61]Numero:1:=SQ_SeqNumber (->[BBL_Items:61]Numero:1)
				[BBL_Items:61]Tipo_de_registro:18:="Monografía"
				READ ONLY:C145([xxBBL_ReglasParaItems:69])
				QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Default:10=True:C214)
				If (Records in selection:C76([xxBBL_ReglasParaItems:69])>0)
					[BBL_Items:61]Regla:20:=[xxBBL_ReglasParaItems:69]Codigo_regla:1
				Else 
					[BBL_Items:61]Regla:20:="GEN"
				End if 
				[BBL_Items:61]ID_Media:48:=<>vlBBL_MediaPorDefecto
				[BBL_Items:61]Media:15:=<>atBBL_Media{Find in array:C230(<>alBBL_IDMedia;[BBL_Items:61]ID_Media:48)}
				[BBL_Items:61]Nivel_de_registro:19:="Monografía"
				[BBL_Items:61]Creado_por:33:=<>tUSR_CurrentUser
				[BBL_Items:61]Fecha_de_creacion:36:=Current date:C33
				[BBL_Items:61]Idioma:35:="Español"
				vlSTR_PaginaFormItems:=1
			End if 
			FORM GOTO PAGE:C247(1)
			SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;1)
			
		: (vlSTR_PaginaFormItems=2)
			BBL_dcPaginaIndexacion 
			
			
		: (vlSTR_PaginaFormItems=3)
			IT_SetButtonState (USR_checkRights ("A";->[BBL_Registros:66]);->bAddCopy)
			BBL_dcLdCopys 
			FORM GOTO PAGE:C247(3)
			SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;3)
			
		: (vlSTR_PaginaFormItems=4)
			IT_SetButtonState (USR_checkRights ("A";->[BBL_Registros:66]);->bAddAnalitico)
			BBL_dcLdSubRec 
			FORM GOTO PAGE:C247(4)
			SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;4)
			
		: (vlSTR_PaginaFormItems=5)
			FORM GOTO PAGE:C247(5)
			SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;5)
			For ($i;1;Count list items:C380(<>hl_InterestList))
				GET LIST ITEM:C378(<>hl_InterestList;$i;$l_RefItem;$t_textoItem)
				If ([BBL_Items:61]Publico_bitArray:46 ?? $i)
					SET LIST ITEM PROPERTIES:C386(<>hl_InterestList;$l_RefItem;False:C215;1;0)
				Else 
					SET LIST ITEM PROPERTIES:C386(<>hl_InterestList;$l_RefItem;False:C215;0;0)
				End if 
			End for 
			SET LIST PROPERTIES:C387(<>hl_InterestList;1;0;16)
			
		: (vlSTR_PaginaFormItems=6)
			READ ONLY:C145([xxBBL_MarcRecordStructure:75])
			READ ONLY:C145([BBL_ItemMarcFields:205])
			QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Item:1=[BBL_Items:61]Numero:1)
			AL_UpdateArrays (xALP_MARCInputGeneral;-2)
			ARRAY TEXT:C222(atBBL_MARCCodeGeneral;0)
			ARRAY TEXT:C222(atBBL_SubFieldCodeGeneral;0)
			ARRAY TEXT:C222(atBBL_SubFieldNameGeneral;0)
			ARRAY TEXT:C222(atBBL_MARCValueGeneral;0)
			ARRAY LONGINT:C221(alBBL_MarcValueRecNumGeneral;0)
			ARRAY BOOLEAN:C223(abBBL_EquivPrincipalGeneral;0)
			ARRAY TEXT:C222(atBBL_FieldSubFieldGeneral;0)
			For ($i;1;Records in selection:C76([BBL_ItemMarcFields:205]))
				QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8=[BBL_ItemMarcFields:205]SubFieldRef:3)
				If (Records in selection:C76([xxBBL_MarcRecordStructure:75])#0)
					APPEND TO ARRAY:C911(atBBL_MARCCodeGeneral;[xxBBL_MarcRecordStructure:75]FieldNumber:1)
					APPEND TO ARRAY:C911(atBBL_SubFieldCodeGeneral;[xxBBL_MarcRecordStructure:75]SubFieldCode:2)
					APPEND TO ARRAY:C911(atBBL_SubFieldNameGeneral;[xxBBL_MarcRecordStructure:75]Name_en:3)
					APPEND TO ARRAY:C911(atBBL_MARCValueGeneral;[BBL_ItemMarcFields:205]Dato:6)
					APPEND TO ARRAY:C911(alBBL_MarcValueRecNumGeneral;Record number:C243([BBL_ItemMarcFields:205]))
					APPEND TO ARRAY:C911(abBBL_EquivPrincipalGeneral;[xxBBL_MarcRecordStructure:75]Equivalencia_Principal:10)
					APPEND TO ARRAY:C911(atBBL_FieldSubFieldGeneral;[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8)
				End if 
				NEXT RECORD:C51([BBL_ItemMarcFields:205])
			End for 
			AL_UpdateArrays (xALP_MARCInputGeneral;-2)
			AL_SetLine (xALP_MARCInputGeneral;0)
			For ($i;1;Size of array:C274(abBBL_EquivPrincipalGeneral))
				If (abBBL_EquivPrincipalGeneral{$i})
					AL_SetRowStyle (xALP_MARCInputGeneral;$i;Bold:K14:2)
				Else 
					AL_SetRowStyle (xALP_MARCInputGeneral;$i;Plain:K14:1)
				End if 
			End for 
			FORM GOTO PAGE:C247(6)
			SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;6)
			
		: (vlSTR_PaginaFormItems=7)
			BBLitm_PaginaDocumentos 
			
		: (vlSTR_PaginaFormItems=8)
			BBLitm_MuestraFichaCatalogo 
			FORM GOTO PAGE:C247(8)
			
	End case 
	
Else 
	FORM GOTO PAGE:C247(1)
	SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;1)
End if 

