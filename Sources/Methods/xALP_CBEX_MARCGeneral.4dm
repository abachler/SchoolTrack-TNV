//%attributes = {}
  // xALP_CBEX_MARCGeneral()
  // Por: Alberto Bachler: 17/09/13, 13:51:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)

If (AL_GetCellMod (xALP_MARCInputGeneral)=1)
	AL_GetCurrCell (xALP_MARCInputGeneral;$l_columna;$l_fila)
	If ($l_columna=4)
		If ((atBBL_FieldSubFieldGeneral{$l_fila}="650a") | (atBBL_FieldSubFieldGeneral{$l_fila}="651a") | (atBBL_FieldSubFieldGeneral{$l_fila}="600a"))
			$t_texto:=atBBL_MARCValueGeneral{$l_fila}
			$t_texto:=ST_Format (->$t_texto;->[BBL_Thesaurus:68]Materia:13)
			QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13=(atBBL_MARCValueGeneral{$l_fila}+"@"))
			Case of 
				: ((Records in selection:C76([BBL_Thesaurus:68])=0) & (USR_checkRights ("A";->[BBL_Thesaurus:68])))
					BBLitm_AgregaMateria ([BBL_Items:61]Numero:1;$t_texto)
					
				: ((Records in selection:C76([BBL_Thesaurus:68])=0) & (Not:C34(USR_checkRights ("A";->[BBL_Thesaurus:68]))))
					CD_Dlog (0;__ ("Encabezamiento de materia inexistente."))
					
				: (Records in selection:C76([BBL_Thesaurus:68])=1)
					$t_materia:="[K]"+atBBL_MARCValueGeneral{$l_fila}
					BBLitm_AgregaMateria ([BBL_Items:61]Numero:1;atBBL_MARCValueGeneral{$l_fila})
					
				: (Records in selection:C76([BBL_Thesaurus:68])>1)
					vs_SearchedHeader:=aSbjctText{vRow}
					BBLitm_OpenThesaurus 
					SAVE RECORD:C53([BBL_Items:61])
			End case 
		Else 
			READ ONLY:C145([xxBBL_MarcRecordStructure:75])
			READ WRITE:C146([BBL_ItemMarcFields:205])
			QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8=atBBL_FieldSubFieldGeneral{$l_fila})
			QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Item:1=[BBL_Items:61]Numero:1;*)
			QUERY:C277([BBL_ItemMarcFields:205]; & ;[BBL_ItemMarcFields:205]SubFieldRef:3=[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8)
			If (Records in selection:C76([BBL_ItemMarcFields:205])=0)
				CREATE RECORD:C68([BBL_ItemMarcFields:205])
			End if 
			[BBL_ItemMarcFields:205]Dato:6:=atBBL_MARCValueGeneral{$l_fila}
			[BBL_ItemMarcFields:205]ID_Item:1:=[BBL_Items:61]Numero:1
			[BBL_ItemMarcFields:205]FieldRef:2:=Num:C11(atBBL_MARCCodeGeneral{$l_fila})
			[BBL_ItemMarcFields:205]SubFieldRef:3:=atBBL_FieldSubFieldGeneral{$l_fila}
			[BBL_ItemMarcFields:205]FieldNum:8:=[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7
			[BBL_ItemMarcFields:205]TableNum:7:=[xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6
			SAVE RECORD:C53([BBL_ItemMarcFields:205])
			If (([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6#0) & ([xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7#0))
				$y_CampoMarc:=Field:C253([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6;[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7)
				$y_CampoMarc->:=atBBL_MARCValueGeneral{$l_fila}
				SAVE RECORD:C53(Table:C252([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6)->)
			End if 
		End if 
	End if 
End if 
$0:=True:C214