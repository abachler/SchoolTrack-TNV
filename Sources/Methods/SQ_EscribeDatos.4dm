//%attributes = {}
  //SQ_EscribeDatos
  // SQ_EscribeDatos()
  // Por: Alberto Bachler K.: 17-04-15, 16:05:13
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If (Application type:C494#4D Remote mode:K5:5)
	If (Type:C295(<>atSQ_TableFieldRef)=Text array:K8:16)
		If (Size of array:C274(<>atSQ_TableFieldRef)>0)
			AT_MultiLevelSort (">>";-><>alSQ_TableNumber;-><>alSQ_FieldNumber;-><>alSQ_PositiveSequence;-><>alSQ_NegativeSequence;-><>atSQ_TableFieldRef)
			ARRAY BOOLEAN:C223($aSaved;Size of array:C274(<>alSQ_TableNumber))
			$booleanTrue:=True:C214
			AT_Populate (->$aSaved;->$booleanTrue)
			READ WRITE:C146([xShell_SequenceNumbers:67])
			ALL RECORDS:C47([xShell_SequenceNumbers:67])
			If (Records in selection:C76([xShell_SequenceNumbers:67])>Size of array:C274(<>alSQ_TableNumber))
				KRL_DeleteSelection (->[xShell_SequenceNumbers:67])
			End if 
			ARRAY TO SELECTION:C261(<>alSQ_TableNumber;[xShell_SequenceNumbers:67]Table_Number:1;<>alSQ_FieldNumber;[xShell_SequenceNumbers:67]FieldNumber:4;<>alSQ_PositiveSequence;[xShell_SequenceNumbers:67]ID_Positif:2;<>alSQ_NegativeSequence;[xShell_SequenceNumbers:67]ID_Negatif:3;$aSaved;[xShell_SequenceNumbers:67]Saved:5)
		Else 
			  //TRACE
			  //20110120 RCH hay un problema....posible causa: los arreglos interproceso de este metodo estan en compiler_array_inter
		End if 
	End if 
End if 