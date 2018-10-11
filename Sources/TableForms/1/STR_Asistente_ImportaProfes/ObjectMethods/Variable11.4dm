C_BLOB:C604(vx_blob)
C_TEXT:C284(vt_signature)
vi_PageNumber:=FORM Get current page:C276+1
AL_UpdateArrays (xALP_fieldNames;0)
AL_UpdateArrays (xALP_RecordData;0)

If (b1Mode=1)
	If (vt_ImportDocPath="")
		$fileName:=xfGetFileName ("Abrir modelo de importación...")
	Else 
		$fileName:=vt_ImportDocPath
	End if 
	If ($fileName#"")
		SET CHANNEL:C77(10;$fileName)
		RECEIVE VARIABLE:C81($signature)
		If (Type:C295($signature)=Is text:K8:3)
			vt_signature:=$signature
			If (vt_signature="SchoolTrack Teacher Import Template")
				vt_ImportDocPath:=$fileName
				RECEIVE VARIABLE:C81(vx_blob)
				BLOB_Blob2Vars (->vx_blob;0;->aSourceDataName;->aSourceDataElement;->vtIOstr_FilePath;->viIOstr_PlatFormSource;->aRecordFieldKey)
				
				SET CHANNEL:C77(11)
				$result:=Test path name:C476($fileName)
				If ($result>=0)
					CD_Dlog (0;__ ("No se encuentra el archivo con los datos. Deberá localizarlo usted mismo"))
					$ref:=Open document:C264("")
					vtIOstr_FilePath:=document
				Else 
					$ref:=Open document:C264(vtIOstr_FilePath)
				End if 
				
				If (ok=1)
					RECEIVE PACKET:C104($ref;$Header;"\r")
					RECEIVE PACKET:C104($ref;$text;"\r")
					CLOSE DOCUMENT:C267($ref)
					ARRAY TEXT:C222(aRecordLine;0)
					ARRAY LONGINT:C221(aRecordLineElement;0)
					ARRAY TEXT:C222(aText1;0)
					AT_Text2Array (->aRecordLine;$header;"\t")
					AT_Text2Array (->aText1;$text;"\t")
					ARRAY TEXT:C222(aText1;Size of array:C274(aRecordLine))
					ARRAY LONGINT:C221(aRecordLineElement;Size of array:C274(aRecordLine))
					For ($i;1;Size of array:C274(aRecordLine))
						If (viIOstr_PlatFormSource=3)
							aRecordLine{$i}:=ST_ConvertText (ST_GetCleanString (aRecordLine{$i}+":"+aText1{$i});"Win";"Mac")
						Else 
							aRecordLine{$i}:=aRecordLine{$i}+":"+aText1{$i}
						End if 
						aRecordLineElement{$i}:=$i
					End for 
					For ($i;Size of array:C274(aRecordLine);1;-1)
						If (aRecordLine{$i}=":")
							DELETE FROM ARRAY:C228(aRecordLineElement;$i)
							DELETE FROM ARRAY:C228(aRecordLine;$i)
						End if 
					End for 
					vL_RecordLine:=2
					If (vL_RecordLine=1)
						_O_DISABLE BUTTON:C193(bPreviousLine)
					End if 
					vi_PageNumber:=4
					FORM GOTO PAGE:C247(4)
				Else 
					OBJECT SET COLOR:C271(vt_errorStatus;-3)
					vt_errorStatus:="El archivo de datos definido en el modelo ("+vtIOstr_FilePath+") no pudo ser abierto."
				End if 
			Else 
				OBJECT SET COLOR:C271(vt_errorStatus;-3)
				vt_errorStatus:="El archivo seleccionado no contiene ningún modelo de importación de datos"
			End if 
		Else 
			OBJECT SET COLOR:C271(vt_errorStatus;-3)
			vt_errorStatus:="El archivo seleccionado no contiene ningún modelo de importación de datos"
		End if 
	Else 
		vt_errorStatus:="Por favor ingrese el nombre completo del archivo que contiene los datos a import"+"ar"
		OBJECT SET COLOR:C271(vt_errorStatus;-15)
	End if 
Else 
	If ((vtIOstr_FilePath="") | (viIOstr_PlatFormSource=0))
		vt_errorStatus:="Por favor ingrese el nombre completo del archivo que contiene los datos a import"+"ar"
		OBJECT SET COLOR:C271(vt_errorStatus;-3)
		vi_PageNumber:=3
		FORM GOTO PAGE:C247(3)
		_O_DISABLE BUTTON:C193(bNext)
	End if 
End if 

AL_UpdateArrays (xALP_fieldNames;-2)
AL_UpdateArrays (xALP_RecordData;Size of array:C274(aRecordLine))



