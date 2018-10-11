READ ONLY:C145([xxBBL_MarcRecordStructure:75])

$lista:=New list:C375

ALL RECORDS:C47([xxBBL_MarcRecordStructure:75])

ARRAY TEXT:C222($atDistinctFields;0)
ARRAY TEXT:C222($atDistinctNames;0)
SELECTION TO ARRAY:C260([xxBBL_MarcRecordStructure:75]FieldNumber:1;$atDistinctFields;[xxBBL_MarcRecordStructure:75]Name_en:3;$atDistinctNames)

SORT ARRAY:C229($atDistinctFields;$atDistinctNames)
For ($k;Size of array:C274($atDistinctFields);1;-1)
	If (($atDistinctFields{$k-1}=$atDistinctFields{$k}) & ($k>1))
		DELETE FROM ARRAY:C228($atDistinctFields;$k)
		DELETE FROM ARRAY:C228($atDistinctNames;$k)
	End if 
End for 

For ($i;1;Size of array:C274($atDistinctFields))
	QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]FieldNumber:1=$atDistinctFields{$i};*)
	QUERY:C277([xxBBL_MarcRecordStructure:75]; & ;[xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6#0)
	$subLista:=New list:C375
	For ($j;1;Records in selection:C76([xxBBL_MarcRecordStructure:75]))
		$found:=Find in array:C230(atBBL_FieldSubFieldGeneral;[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8)
		If ($found=-1)
			APPEND TO LIST:C376($subLista;[xxBBL_MarcRecordStructure:75]SubFieldCode:2+" - "+[xxBBL_MarcRecordStructure:75]Name_en:3;Record number:C243([xxBBL_MarcRecordStructure:75]))
		Else 
			If (($found#1) & ([xxBBL_MarcRecordStructure:75]Es_Repetible:11))
				APPEND TO LIST:C376($subLista;[xxBBL_MarcRecordStructure:75]SubFieldCode:2+" - "+[xxBBL_MarcRecordStructure:75]Name_en:3;Record number:C243([xxBBL_MarcRecordStructure:75]))
			End if 
		End if 
		NEXT RECORD:C51([xxBBL_MarcRecordStructure:75])
	End for 
	$expanded:=(Size of array:C274($atDistinctFields)=1)
	APPEND TO LIST:C376($lista;$atDistinctFields{$i}+" - "+$atDistinctNames{$i};-1;$subLista;$expanded)
	SET LIST ITEM PROPERTIES:C386($lista;0;False:C215;Bold:K14:2;0)
End for 

$selected:=HL_ShowHListPopWindow ($lista;"Seleccione el campo MARC:")

If (ok=1)
	If ($selected#-1)
		AL_UpdateArrays (xALP_MARCInputGeneral;0)
		AT_Insert (1;1;->atBBL_MARCCodeGeneral;->atBBL_SubFieldCodeGeneral;->atBBL_SubFieldNameGeneral;->atBBL_MARCValueGeneral;->alBBL_MarcValueRecNumGeneral;->abBBL_EquivPrincipalGeneral;->atBBL_FieldSubFieldGeneral)
		KRL_GotoRecord (->[xxBBL_MarcRecordStructure:75];$selected)
		atBBL_MARCCodeGeneral{1}:=[xxBBL_MarcRecordStructure:75]FieldNumber:1
		atBBL_SubFieldCodeGeneral{1}:=[xxBBL_MarcRecordStructure:75]SubFieldCode:2
		atBBL_SubFieldNameGeneral{1}:=[xxBBL_MarcRecordStructure:75]Name_en:3
		alBBL_MarcValueRecNumGeneral{1}:=-1
		atBBL_FieldSubFieldGeneral{1}:=[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8
		abBBL_EquivPrincipalGeneral{1}:=[xxBBL_MarcRecordStructure:75]Equivalencia_Principal:10
		AL_UpdateArrays (xALP_MARCInputGeneral;-2)
		AL_SetLine (xALP_MARCInputGeneral;1)
		ARRAY LONGINT:C221($aLong;2;0)
		For ($i;1;Size of array:C274(abBBL_EquivPrincipalGeneral))
			If (abBBL_EquivPrincipalGeneral{$i})
				  //AL_SetCellEnter (xALP_MARCInputGeneral;4;$i;0;0;$aLong;0)
				AL_SetRowStyle (xALP_MARCInputGeneral;$i;Bold:K14:2)
			Else 
				  //AL_SetCellEnter (xALP_MARCInputGeneral;4;$i;0;0;$aLong;1)
				AL_SetRowStyle (xALP_MARCInputGeneral;$i;Plain:K14:1)
			End if 
		End for 
		GOTO OBJECT:C206(xALP_MARCInputGeneral)
		AL_GotoCell (xALP_MARCInputGeneral;4;1)
		_O_DISABLE BUTTON:C193(bDelMARCGeneral)
	End if 
End if 