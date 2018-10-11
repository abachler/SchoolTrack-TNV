C_BLOB:C604(vx_blob)
C_TEXT:C284(vt_signature)

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
			If (vt_signature="SchoolTrack Students Import Template")
				vt_ImportDocPath:=$fileName
				RECEIVE VARIABLE:C81(vx_blob)
				BLOB_Blob2Vars (->vx_blob;0;->aSourceDataName;->aSourceDataElement;->vtIOstr_FilePath;->viIOstr_PlatFormSource;->aRecordFieldKey)
				SET CHANNEL:C77(11)
				$result:=Test path name:C476(vtIOstr_FilePath)
				If ($result<0)
					CD_Dlog (0;__ ("No se encuentra el archivo con los datos. Deberá localizarlo usted mismo."))
					$ref:=Open document:C264("")
					If (ok=1)
						vtIOstr_FilePath:=document
					End if 
				Else 
					$ref:=Open document:C264(vtIOstr_FilePath)
					If (ok=0)
						OK:=CD_Dlog (0;__ ("No fue posible encontrar el archivo de datos definido en el modelo.\r\r¿Desea localizarlo usted mismo?");__ ("");__ ("Si");__ ("No"))
						If (ok=1)
							$ref:=Open document:C264("")
							If (ok=1)
								vtIOstr_FilePath:=document
							End if 
						End if 
					End if 
				End if 
				
				If (ok=1)
					vt_ErrorStatus:=""
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
					vL_RecordLine:=1
					_O_DISABLE BUTTON:C193(bPreviousLine)
					If (Size of array:C274(aText1)>0)
						_O_ENABLE BUTTON:C192(bNextLine)
					Else 
						_O_DISABLE BUTTON:C193(bNextLine)
					End if 
					vi_PageNumber:=4
					vt_recordNum:="Registro N° "+String:C10(vL_RecordLine)
					FORM GOTO PAGE:C247(4)
				Else 
					BEEP:C151
					OBJECT SET COLOR:C271(vt_errorStatus;-3)
					vt_errorStatus:="El archivo de datos definido en el modelo ("+vtIOstr_FilePath+") no pudo ser abierto."
					vt_ImportDocPath:=""
					vtIOstr_FilePath:=""
				End if 
			Else 
				SET CHANNEL:C77(11)
				BEEP:C151
				OBJECT SET COLOR:C271(vt_errorStatus;-3)
				vt_errorStatus:="El archivo seleccionado no contiene ningún modelo de importación de datos."
				vt_ImportDocPath:=""
				vtIOstr_FilePath:=""
			End if 
		Else 
			SET CHANNEL:C77(11)
			BEEP:C151
			OBJECT SET COLOR:C271(vt_errorStatus;-3)
			vt_errorStatus:="El archivo seleccionado no contiene ningún modelo de importación de datos."
			vt_ImportDocPath:=""
			vtIOstr_FilePath:=""
		End if 
	Else 
		SET CHANNEL:C77(11)
		BEEP:C151
		vt_errorStatus:="Por favor ingrese la ruta completa del archivo que contiene el modelo de importac"+"ión de datos."
		OBJECT SET COLOR:C271(vt_errorStatus;-3)
		vt_ImportDocPath:=""
		vtIOstr_FilePath:=""
	End if 
Else 
	If ((vtIOstr_FilePath="") | (viIOstr_PlatFormSource=0))
		vt_errorStatus:="Por favor ingrese la ruta completa del archivo que contiene los datos a import"+"ar."
		OBJECT SET COLOR:C271(vt_errorStatus;-3)
		vi_PageNumber:=3
		FORM GOTO PAGE:C247(3)
		_O_DISABLE BUTTON:C193(bNext)
	Else 
		If (Test path name:C476(vtIOstr_FilePath)=1)
			If (_o_Document type:C528(vtIOstr_FilePath)="TEXT")
				_O_ENABLE BUTTON:C192(bNext)
				vt_errorStatus:=""
			Else 
				OBJECT SET COLOR:C271(vt_errorStatus;-3)
				BEEP:C151
				vt_errorStatus:="El archivo indicado no es de tipo texto."
				_O_DISABLE BUTTON:C193(bNext)
			End if 
		Else 
			vtIOstr_FilePath:=""
			vt_errorStatus:="Debe indicar un nombre de archivo existente y donde fue originado."
			OBJECT SET COLOR:C271(vt_errorStatus;-3)
			BEEP:C151
			_O_DISABLE BUTTON:C193(bNext)
		End if 
		FORM GOTO PAGE:C247(3)
	End if 
End if 

AL_UpdateArrays (xALP_fieldNames;-2)
AL_UpdateArrays (xALP_RecordData;-2)

ARRAY INTEGER:C220(aInteger2D;2;0)
AL_SetCellColor (xALP_FieldNames;3;1;3;Size of array:C274(aRecordFieldNames);aInteger2D;"";0;"Light Gray";0)
AL_UpdateArrays (xALP_FieldNames;-1)


