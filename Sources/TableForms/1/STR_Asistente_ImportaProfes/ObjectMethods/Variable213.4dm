TRACE:C157
C_BLOB:C604(vx_blob)
AL_UpdateArrays (xALP_fieldNames;0)
AL_UpdateArrays (xALP_RecordData;0)
$fileName:=xfGetFileName ("Abrir modelo de importación...")
If ($fileName#"")
	SET CHANNEL:C77(10;$fileName)
	RECEIVE VARIABLE:C81($signature)
	If (Type:C295($signature)=Is text:K8:3)
		vt_signature:=$signature
		If (vt_signature="SchoolTrack Teacher Import Template")
			RECEIVE VARIABLE:C81(vx_blob)
			BLOB_Blob2Vars (->vx_blob;0;->aSourceDataName;->aSourceDataElement;->vtIOstr_FilePath;->viIOstr_PlatFormSource;->aRecordFieldKey)
			SET CHANNEL:C77(11)
			
			If (ok=1)
				$ref:=Open document:C264(vtIOstr_FilePath)
				RECEIVE PACKET:C104($ref;$Header;"\r")
				RECEIVE PACKET:C104($ref;$text;"\r")
				CLOSE DOCUMENT:C267($ref)
				ARRAY TEXT:C222(aRecordLine;0)
				ARRAY LONGINT:C221(aRecordLineElement;0)
				ARRAY TEXT:C222(aText1;0)
				AT_Text2Array (->aRecordLine;$header;"\t")
				AT_Text2Array (->aText1;$text;"\t")
				TRACE:C157
				ARRAY TEXT:C222(aText1;Size of array:C274(aRecordLine))
				ARRAY LONGINT:C221(aRecordLineElement;Size of array:C274(aRecordLine))
				For ($i;1;Size of array:C274(aRecordLine))
					aRecordLine{$i}:=aRecordLine{$i}+":"+aText1{$i}
					aRecordLineElement{$i}:=$i
				End for 
				
				For ($i;Size of array:C274(aRecordLine);1;-1)
					If (aRecordLine{$i}=":")
						DELETE FROM ARRAY:C228(aRecordLineElement;$i)
						DELETE FROM ARRAY:C228(aRecordLine;$i)
					End if 
				End for 
				
				
				vL_RecordLine:=2
				If (vL_RecordLine=2)
					_O_DISABLE BUTTON:C193(bPreviousLine)
				End if 
				FORM NEXT PAGE:C248
			Else 
				
			End if 
		Else 
			CD_Dlog (0;__ ("El archivo seleccionado no contiene ningún modelo de importación de datos"))
		End if 
	Else 
		CD_Dlog (0;__ ("El archivo seleccionado no contiene ningún modelo de importación de datos"))
	End if 
End if 
AL_UpdateArrays (xALP_fieldNames;-2)
AL_UpdateArrays (xALP_RecordData;Size of array:C274(aRecordLine))

