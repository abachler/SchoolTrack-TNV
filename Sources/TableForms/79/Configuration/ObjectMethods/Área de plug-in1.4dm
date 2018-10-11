C_POINTER:C301($file;$field;$table)
_O_C_INTEGER:C282($columna)
C_TEXT:C284($fila)
_O_C_INTEGER:C282($ID)
IT_MODIFIERS   //carga constantes por defecto
Case of 
	: (alProEvt=6)
		If (Selected list items:C379(vl_TabMetaDatos)#1)
			  //para las listas que configura el usuario, abro el cuadro de dialogo para editar listas
			  //WDW_OpenFormWindow (->[xxSTR_Constants];"ReligionExtendida";0;-1984)
			  //DIALOG([xxSTR_Constants];"ReligionExtendida")
			  //CLOSE WINDOW
		End if 
	: (alProEvt=5)
		  //If (Selected list items(vl_TabMetaDatos)=1)
		  //$row:=AL_GetLine (Self->)
		  //If ($row#0)
		  //If (Not(Is compiled mode))
		  //$fieldPointer:=0xDev_SelectField 
		  //If (Not(Nil($fieldPointer)))
		  //$table:=Table(Table($fieldPointer))
		  //$go:=True
		  //If ((Table($table)=Table(->[Alumnos])) | (Table($table)=Table(->[ADT_Candidatos])) | (Table($table)=Table(->[Personas])))
		  //Case of 
		  //: (Table($table)=Table(->[Alumnos]))
		  //$label:="[Candidatos]"
		  //: (Table($table)=Table(->[ADT_Candidatos]))
		  //$label:="[Candidatos]"
		  //: (Table($table)=Table(->[Personas]))
		  //$label:=CD_Request (__ ("Indique la etiqueta para este campo ([Padre], [Madre] o [Apoderado]):");__ ("Aceptar");__ ("Cancelar"))
		  //While ((($label#"[Padre]") & ($label#"[Madre]") & ($label#"[Apoderado]")) & (ok=1))
		  //$label:=CD_Request (__ ("Indique la etiqueta para este campo ([Padre], [Madre] o [Apoderado]):");__ ("Aceptar");__ ("Cancelar"))
		  //End while 
		  //If (ok=0)
		  //$go:=False
		  //End if 
		  //End case 
		  //If ($go)
		  //CREATE RECORD([xxADT_MetaDataDefinition])
		  //[xxADT_MetaDataDefinition]Category:=1
		  //[xxADT_MetaDataDefinition]FieldNum:=Field($fieldPointer)
		  //[xxADT_MetaDataDefinition]ID:=SQ_SeqNumber (->[xxADT_MetaDataDefinition]ID;True)
		  //[xxADT_MetaDataDefinition]Name:=$label+API Get Virtual Field Name (<>afilePop;<>aFieldPop)
		  //[xxADT_MetaDataDefinition]Posicion:=Size of array(atADT_DefTypeTxt)+1
		  //[xxADT_MetaDataDefinition]TableNum:=Table($table)
		  //[xxADT_MetaDataDefinition]Tag:=Field name($field)
		  //[xxADT_MetaDataDefinition]Tipo:=Type($field->)
		  //SAVE RECORD([xxADT_MetaDataDefinition])
		  //ADTcfg_LoadMetaDataDef (Selected list items(vl_TabMetaDatos))
		  //End if 
		  //End if 
		  //End if 
		  //End if 
		  //End if 
		  //Else 
		  //C_INTEGER($NumTab)
		  //$row:=AL_GetLine (Self->)
		  //  //abro el cuadro de dialogo para editar las listas
		  //$NumTab:=Selected list items(vl_TabMetaDatos)
		  //Case of 
		  //: ($NumTab=2)  //candidatos
		  //var_tablaAsociada:="Candidatos"
		  //: ($NumTab=3)  //padres
		  //var_tablaAsociada:="Padres"
		  //: ($NumTab=4)  //madres
		  //var_tablaAsociada:="Madres"
		  //: ($NumTab=5)  //apoderados
		  //var_tablaAsociada:="Apoderados"
		  //End case 
		  //
		  //C_TEXT($dato)
		  //$fila:=""
		  //AL_GetCellValue (xALP_MetaDef;$row;3;$dato)
		  //AL_GetCellValue (xALP_MetaDef;$row;1;$fila)
		  //$ID:=Num($fila)
		  //Case of 
		  //: ($dato="Lista")  //si es de tipo lista
		  //READ ONLY([xxADT_MetaDataDefinition])
		  //QUERY([xxADT_MetaDataDefinition];[xxADT_MetaDataDefinition]ID=$ID)
		  //
		  //READ ONLY([xxADT_listas])
		  //  //cargar los valores por defecto para la lista seleccionada
		  //KRL_RelateSelection (->[xxADT_listas]ID_Campo;->[xxADT_MetaDataDefinition]ID;"")
		  //SELECTION TO ARRAY([xxADT_listas]Valor Lista;<>valores)
		  //
		  //WDW_OpenFormWindow (->[xxSTR_Constants];"ADN_EditarLista";0;-1984;__ ("Editar Lista"))
		  //DIALOG([xxSTR_Constants];"ADN_EditarLista")
		  //CLOSE WINDOW
		  //End case 
		  //End if 
	: (alProEvt=1)
		$row:=AL_GetLine (Self:C308->)
		If (Selected list items:C379(vl_TabMetaDatos)=1)
			If (Not:C34(Is compiled mode:C492))
				IT_SetButtonState (($row#0);->bDelMetaData)
				_O_ENABLE BUTTON:C192(bAddMetaData)
			Else 
				_O_DISABLE BUTTON:C193(bAddMetaData)
				_O_DISABLE BUTTON:C193(bDelMetaData)
			End if 
		Else 
			IT_SetButtonState (($row#0);->bDelMetaData)
		End if 
	: (alProEvt=-5)
		AL_GetDrgArea (Self:C308->;$destinationArea)
		AL_GetDrgDstTyp (Self:C308->;$destinationType)
		AL_GetDrgSrcRow (Self:C308->;$selectedItemLine)
		AL_GetDrgDstRow (Self:C308->;$DestRow)
		If ($selectedItemLine>0)
			If ($destinationArea=Self:C308->)
				$reProcess:=False:C215
				$temp1:=alADT_DefID{$selectedItemLine}
				$temp2:=asADT_DefName{$selectedItemLine}
				$temp3:=atADT_DefTypeTxt{$selectedItemLine}
				$temp4:=atADT_DefHTMLTags{$selectedItemLine}
				$temp5:=alADT_DefRecNums{$selectedItemLine}
				$temp6:=alADT_DefType{$selectedItemLine}
				$temp7:=alADT_Positions{$selectedItemLine}
				$temp8:=alADT_DefTableNum{$selectedItemLine}
				$temp9:=alADT_DefFieldNum{$selectedItemLine}
				If ($selectedItemLine>$DestRow)
					AL_UpdateArrays (Self:C308->;0)
					AT_Delete ($selectedItemLine;1;->alADT_DefID;->asADT_DefName;->atADT_DefTypeTxt;->atADT_DefHTMLTags;->alADT_DefRecNums;->alADT_DefType;->alADT_Positions;->alADT_DefTableNum;->alADT_DefFieldNum)
					AT_Insert ($DestRow;1;->alADT_DefID;->asADT_DefName;->atADT_DefTypeTxt;->atADT_DefHTMLTags;->alADT_DefRecNums;->alADT_DefType;->alADT_Positions;->alADT_DefTableNum;->alADT_DefFieldNum)
					alADT_DefID{$DestRow}:=$temp1
					asADT_DefName{$DestRow}:=$temp2
					atADT_DefTypeTxt{$DestRow}:=$temp3
					atADT_DefHTMLTags{$DestRow}:=$temp4
					alADT_DefRecNums{$DestRow}:=$temp5
					alADT_DefType{$DestRow}:=$temp6
					alADT_Positions{$DestRow}:=$temp7
					alADT_DefTableNum{$DestRow}:=$temp8
					alADT_DefFieldNum{$DestRow}:=$temp9
					$reProcess:=True:C214
				Else 
					If ($selectedItemLine<$DestRow)
						AL_UpdateArrays (Self:C308->;0)
						AT_Insert ($DestRow+1;1;->alADT_DefID;->asADT_DefName;->atADT_DefTypeTxt;->atADT_DefHTMLTags;->alADT_DefRecNums;->alADT_DefType;->alADT_Positions;->alADT_DefTableNum;->alADT_DefFieldNum)
						alADT_DefID{$DestRow+1}:=$temp1
						asADT_DefName{$DestRow+1}:=$temp2
						atADT_DefTypeTxt{$DestRow+1}:=$temp3
						atADT_DefHTMLTags{$DestRow+1}:=$temp4
						alADT_DefRecNums{$DestRow+1}:=$temp5
						alADT_DefType{$DestRow+1}:=$temp6
						alADT_Positions{$DestRow+1}:=$temp7
						alADT_DefTableNum{$DestRow+1}:=$temp8
						alADT_DefFieldNum{$DestRow+1}:=$temp9
						AT_Delete ($selectedItemLine;1;->alADT_DefID;->asADT_DefName;->atADT_DefTypeTxt;->atADT_DefHTMLTags;->alADT_DefRecNums;->alADT_DefType;->alADT_Positions;->alADT_DefTableNum;->alADT_DefFieldNum)
						$reProcess:=True:C214
					End if 
				End if 
				If ($reProcess)
					READ WRITE:C146([xxADT_MetaDataDefinition:79])
					For ($i;1;Size of array:C274(alADT_DefRecNums))
						GOTO RECORD:C242([xxADT_MetaDataDefinition:79];alADT_DefRecNums{$i})
						[xxADT_MetaDataDefinition:79]Posicion:8:=$i
						SAVE RECORD:C53([xxADT_MetaDataDefinition:79])
					End for 
					KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
					ADTcfg_LoadMetaDataDef (Selected list items:C379(vl_TabMetaDatos))
					AL_SetLine (Self:C308->;$DestRow)
				End if 
			End if 
		End if 
End case 