//%attributes = {}
  //xALP_ADT_CB_MetaDef

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_MetaDef)=1)
		$mod:=False:C215
		AL_GetCurrCell (xALP_MetaDef;$col;$row)
		Case of 
			: ($col=2)
				$mod:=True:C214
				If (asADT_DefName{$row}#"")
					READ ONLY:C145([xxADT_MetaDataDefinition:79])
					QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Name:2=asADT_DefName{$row})
					If (Records in selection:C76([xxADT_MetaDataDefinition:79])=1)
						If (Record number:C243([xxADT_MetaDataDefinition:79])#alADT_DefRecNums{$row})
							CD_Dlog (0;__ ("Este nombre ya está siendo utilizado. Por favor eliga otro."))
							asADT_DefName{$row}:=asADT_DefName{0}
						End if 
					End if 
				End if 
			: ($col=3)
				$mod:=True:C214
				$pos:=Find in array:C230(atADT_TypesTxt;atADT_DefTypeTxt{$row})
				If ($pos#-1)
					$oldTypeTxt:=atADT_DefTypeTxt{0}
					If (atADT_DefTypeTxt{$row}#$oldTypeTxt)
						READ WRITE:C146([xxADT_MetaDataValues:80])
						QUERY:C277([xxADT_MetaDataValues:80];[xxADT_MetaDataValues:80]ID_Definition:1=alADT_DefID{$row})
						If (Records in selection:C76([xxADT_MetaDataValues:80])>0)
							$r:=CD_Dlog (0;__ ("Existen datos ingresados para este campo. El cambio de tipo eliminará dichos valores.\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
							If ($r=2)
								DELETE SELECTION:C66([xxADT_MetaDataValues:80])
								alADT_DefType{$row}:=0
								alADT_DefType{$row}:=alADT_TypesLong{$pos}
							Else 
								atADT_DefTypeTxt{$row}:=$oldTypeTxt
								$mod:=False:C215
							End if 
						Else 
							alADT_DefType{$row}:=0
							alADT_DefType{$row}:=alADT_TypesLong{$pos}
						End if 
						KRL_UnloadReadOnly (->[xxADT_MetaDataValues:80])
					End if 
				Else 
					alADT_DefType{$row}:=0
				End if 
			: ($col=4)
				$mod:=True:C214
				If (atADT_DefHTMLTags{$row}#"")
					READ ONLY:C145([xxADT_MetaDataDefinition:79])
					QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Tag:5=atADT_DefHTMLTags{$row})
					If (Records in selection:C76([xxADT_MetaDataDefinition:79])=1)
						If (Record number:C243([xxADT_MetaDataDefinition:79])#alADT_DefRecNums{$row})
							CD_Dlog (0;__ ("Esta etiqueta ya está siendo utilizada. Por favor eliga otra."))
							atADT_DefHTMLTags{$row}:=atADT_DefHTMLTags{0}
						End if 
					End if 
				End if 
		End case 
		If ($mod)
			READ WRITE:C146([xxADT_MetaDataDefinition:79])
			GOTO RECORD:C242([xxADT_MetaDataDefinition:79];alADT_DefRecNums{$row})
			[xxADT_MetaDataDefinition:79]Name:2:=asADT_DefName{$row}
			[xxADT_MetaDataDefinition:79]Tipo:3:=alADT_DefType{$row}
			[xxADT_MetaDataDefinition:79]Tag:5:=atADT_DefHTMLTags{$row}
			SAVE RECORD:C53([xxADT_MetaDataDefinition:79])
			KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
		End if 
	End if 
End if 