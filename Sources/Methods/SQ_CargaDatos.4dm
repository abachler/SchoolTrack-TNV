//%attributes = {}
  //SQ_CargaDatos

C_POINTER:C301($pointer)
ARRAY TEXT:C222(<>atSQ_TableFieldRef;0)
ARRAY LONGINT:C221(<>alSQ_TableNumber;0)
ARRAY LONGINT:C221(<>alSQ_FieldNumber;0)
ARRAY REAL:C219(<>alSQ_PositiveSequence;0)
ARRAY REAL:C219(<>alSQ_NegativeSequence;0)


MESSAGES OFF:C175
If (Application type:C494#4D Remote mode:K5:5)
	SQ_LimpiaSecuenciasInvalidas 
	
	SQ_SetSequences 
	
	QUERY:C277([xShell_SequenceNumbers:67];[xShell_SequenceNumbers:67]FieldNumber:4=0)
	KRL_DeleteSelection (->[xShell_SequenceNumbers:67])
	KRL_UnloadReadOnly (->[xShell_SequenceNumbers:67])
	
	READ ONLY:C145([xShell_SequenceNumbers:67])
	QUERY:C277([xShell_SequenceNumbers:67];[xShell_SequenceNumbers:67]Saved:5=False:C215)
	If (Records in selection:C76([xShell_SequenceNumbers:67])>0)
		$p:=IT_UThermometer (1;0;__ ("Restaurando tabla de secuencias"))
		SELECTION TO ARRAY:C260([xShell_SequenceNumbers:67]Table_Number:1;$aTableNumbers;[xShell_SequenceNumbers:67]FieldNumber:4;$aFieldNumbers)
		For ($i;1;Size of array:C274($aTableNumbers))
			For ($i;1;Size of array:C274($aTableNumbers))
				EM_ErrorManager ("Install")
				EM_ErrorManager ("SetMode";"")
				$pointer:=Field:C253($aTableNumbers{$i};$aFieldNumbers{$i})
				If ((error=0) & (Not:C34(Is nil pointer:C315($pointer))))
					SQ_getLastID (Field:C253($aTableNumbers{$i};$aFieldNumbers{$i}))
				End if 
				EM_ErrorManager ("Clear")
			End for 
		End for 
		$p:=IT_UThermometer (-2;$p)
	End if 
	
	ALL RECORDS:C47([xShell_SequenceNumbers:67])
	SELECTION TO ARRAY:C260([xShell_SequenceNumbers:67]Table_Number:1;<>alSQ_TableNumber;[xShell_SequenceNumbers:67]FieldNumber:4;<>alSQ_FieldNumber;[xShell_SequenceNumbers:67]ID_Positif:2;<>alSQ_PositiveSequence;[xShell_SequenceNumbers:67]ID_Negatif:3;<>alSQ_NegativeSequence)
	ARRAY BOOLEAN:C223($aSaved;Size of array:C274(<>alSQ_TableNumber))
	$booleanFalse:=False:C215
	AT_Populate (->$aSaved;->$booleanFalse)
	KRL_Array2Selection (->$aSaved;->[xShell_SequenceNumbers:67]Saved:5)
	KRL_UnloadReadOnly (->[xShell_SequenceNumbers:67])
	
	FLUSH CACHE:C297
	ARRAY TEXT:C222(<>atSQ_TableFieldRef;Size of array:C274(<>alSQ_TableNumber))
	For ($i;1;Size of array:C274(<>atSQ_TableFieldRef))
		<>atSQ_TableFieldRef{$i}:=String:C10(<>alSQ_TableNumber{$i})+"."+String:C10(<>alSQ_FieldNumber{$i})
	End for 
	AT_MultiLevelSort (">>";-><>alSQ_TableNumber;-><>alSQ_FieldNumber;-><>alSQ_PositiveSequence;-><>alSQ_NegativeSequence;-><>atSQ_TableFieldRef)
	
Else 
	$p:=Execute on server:C373("SQ_CargaDatos";Pila_256K;"Lectura tabla SQ")
End if 





