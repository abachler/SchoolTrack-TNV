C_LONGINT:C283($tableNum)
C_LONGINT:C283($fieldNum)

$tableNum:=Table:C252(vpBBL_MTField4MARC)
$fieldNum:=Field:C253(vpBBL_MTField4MARC)

READ ONLY:C145([xxBBL_MarcRecordStructure:75])

QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6=$tableNum;*)
QUERY:C277([xxBBL_MarcRecordStructure:75]; & ;[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7=$fieldNum)

$lista:=New list:C375

ARRAY TEXT:C222($atDistinctFields;0)
SELECTION TO ARRAY:C260([xxBBL_MarcRecordStructure:75]FieldNumber:1;$atDistinctFields)
AT_DistinctsArrayValues (->$atDistinctFields)

For ($i;1;Size of array:C274($atDistinctFields))
	QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]FieldNumber:1=$atDistinctFields{$i};*)
	QUERY:C277([xxBBL_MarcRecordStructure:75]; & ;[xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6#0)
	$subLista:=New list:C375
	For ($j;1;Records in selection:C76([xxBBL_MarcRecordStructure:75]))
		atBBL_MARCCode{0}:=[xxBBL_MarcRecordStructure:75]FieldNumber:1
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->atBBL_MARCCode;"=";->$DA_Return)
		$add:=True:C214
		If (Size of array:C274($DA_Return)>0)
			For ($u;1;Size of array:C274($DA_Return))
				If ((atBBL_SubFieldCode{$DA_Return{$u}}=[xxBBL_MarcRecordStructure:75]SubFieldCode:2) & (Not:C34([xxBBL_MarcRecordStructure:75]Es_Repetible:11)))
					$add:=False:C215
					$u:=Size of array:C274($DA_Return)+1
				End if 
			End for 
		End if 
		If ($add)
			APPEND TO LIST:C376($subLista;[xxBBL_MarcRecordStructure:75]SubFieldCode:2+" - "+[xxBBL_MarcRecordStructure:75]Name_en:3;Record number:C243([xxBBL_MarcRecordStructure:75]))
		End if 
		NEXT RECORD:C51([xxBBL_MarcRecordStructure:75])
	End for 
	QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]FieldNumber:1=$atDistinctFields{$i};*)
	QUERY:C277([xxBBL_MarcRecordStructure:75]; & ;[xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6=0)
	If (Size of array:C274($atDistinctFields)=1)
		$expanded:=True:C214
	Else 
		$expanded:=False:C215
	End if 
	APPEND TO LIST:C376($lista;[xxBBL_MarcRecordStructure:75]FieldNumber:1+" - "+[xxBBL_MarcRecordStructure:75]Name_en:3;-1;$subLista;$expanded)
	SET LIST ITEM PROPERTIES:C386($lista;0;False:C215;Bold:K14:2;0)
End for 

$selected:=HL_ShowHListPopWindow ($lista;"Seleccione el campo MARC:")

If (ok=1)
	If ($selected#-1)
		AL_UpdateArrays (xALP_MARCInput;0)
		AT_Insert (1;1;->atBBL_MARCCode;->atBBL_SubFieldCode;->atBBL_SubFieldName;->atBBL_MARCValue;->alBBL_MarcValueRecNum;->abBBL_EquivPrincipal)
		KRL_GotoRecord (->[xxBBL_MarcRecordStructure:75];$selected)
		atBBL_MARCCode{1}:=[xxBBL_MarcRecordStructure:75]FieldNumber:1
		atBBL_SubFieldCode{1}:=[xxBBL_MarcRecordStructure:75]SubFieldCode:2
		atBBL_SubFieldName{1}:=[xxBBL_MarcRecordStructure:75]Name_en:3
		alBBL_MarcValueRecNum{1}:=-1
		abBBL_EquivPrincipal{1}:=[xxBBL_MarcRecordStructure:75]Equivalencia_Principal:10
		AL_UpdateArrays (xALP_MARCInput;-2)
		AL_SetLine (xALP_MARCInput;1)
		ARRAY LONGINT:C221($aLong;2;0)
		For ($i;1;Size of array:C274(abBBL_EquivPrincipal))
			If (abBBL_EquivPrincipal{$i})
				  //AL_SetCellEnter (xALP_MARCInput;4;$i;0;0;$aLong;0)
				AL_SetRowStyle (xALP_MARCInput;$i;Bold:K14:2)
			Else 
				  //AL_SetCellEnter (xALP_MARCInput;4;$i;0;0;$aLong;1)
				AL_SetRowStyle (xALP_MARCInput;$i;Plain:K14:1)
			End if 
		End for 
		GOTO OBJECT:C206(xALP_MARCInput)
		AL_GotoCell (xALP_MARCInput;4;1)
		AL_SetCellHigh (xALP_MARCInput;1;80)
		_O_DISABLE BUTTON:C193(bDelMARC)
	End if 
End if 