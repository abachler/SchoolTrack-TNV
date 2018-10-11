  //AL_ExitCell (xALP_MetaDef)
  //C_INTEGER($num)
  //CREATE RECORD([xxADT_MetaDataDefinition])
  //[xxADT_MetaDataDefinition]Category:=Selected list items(vl_TabMetaDatos)
  //[xxADT_MetaDataDefinition]FieldNum:=0
  //If ([xxADT_MetaDataDefinition]Category=1)
  //[xxADT_MetaDataDefinition]ID:=SQ_SeqNumber (->[xxADT_MetaDataDefinition]ID;True)
  //Else 
  //$num:=SQ_SeqNumber (->[xxADT_MetaDataDefinition]ID)
  //While ($num<4)
  //$num:=SQ_SeqNumber (->[xxADT_MetaDataDefinition]ID)
  //End while 
  //[xxADT_MetaDataDefinition]ID:=$num
  //End if 
  //
  //QUERY([xxADT_listas];[xxADT_listas]ID_Campo=$num)
  //If (Records in selection([xxADT_listas])>0)
  //DELETE SELECTION([xxADT_listas])
  //End if 
  //[xxADT_MetaDataDefinition]Name:=""
  //[xxADT_MetaDataDefinition]Posicion:=Size of array(atADT_DefTypeTxt)+1
  //[xxADT_MetaDataDefinition]TableNum:=0
  //[xxADT_MetaDataDefinition]Tag:=""
  //[xxADT_MetaDataDefinition]Tipo:=Is Text
  //
  //
  //  //generar la etiqueta del formulario
  //
  //SAVE RECORD([xxADT_MetaDataDefinition])
  //ADTcfg_LoadMetaDataDef (Selected list items(vl_TabMetaDatos))
  //AL_GotoCell (xALP_MetaDef;2;Size of array(atADT_DefTypeTxt))

C_POINTER:C301($table)
If (Selected list items:C379(vl_TabMetaDatos)=1)
	$row:=Size of array:C274(atADT_DefTypeTxt)
	If ($row#0)
		If (Not:C34(Is compiled mode:C492))
			$fieldPointer:=0xDev_SeleccionCampo 
			If (Not:C34(Is nil pointer:C315($fieldPointer)))
				$table:=Table:C252(Table:C252($fieldPointer))
				$go:=True:C214
				If ((Table:C252($table)=Table:C252(->[Alumnos:2])) | (Table:C252($table)=Table:C252(->[ADT_Candidatos:49])) | (Table:C252($table)=Table:C252(->[Personas:7])) | (Table:C252($table)=Table:C252(->[Familia:78])) | (Table:C252($table)=Table:C252(->[Alumnos_Conexiones:212])))
					Case of 
						: (Table:C252($table)=Table:C252(->[Alumnos:2]))
							$label:="[Candidatos]"
						: (Table:C252($table)=Table:C252(->[ADT_Candidatos:49]))
							$label:="[Candidatos]"
						: (Table:C252($table)=Table:C252(->[Personas:7]))
							$label:=CD_Request (__ ("Indique la etiqueta para este campo ([Padre], [Madre] o [Apoderado]):");__ ("Aceptar");__ ("Cancelar"))
							While ((($label#"[Padre]") & ($label#"[Madre]") & ($label#"[Apoderado]")) & (ok=1))
								$label:=CD_Request (__ ("Indique la etiqueta para este campo ([Padre], [Madre] o [Apoderado]):");__ ("Aceptar");__ ("Cancelar"))
							End while 
							If (ok=0)
								$go:=False:C215
							End if 
						: (Table:C252($table)=Table:C252(->[Familia:78]))
							$label:="[familia]"
						: (Table:C252($table)=Table:C252(->[Alumnos_Conexiones:212]))
							$label:="[Candidato]"
					End case 
					If ($go)
						CREATE RECORD:C68([xxADT_MetaDataDefinition:79])
						[xxADT_MetaDataDefinition:79]Category:4:=1
						[xxADT_MetaDataDefinition:79]FieldNum:6:=Field:C253($fieldPointer)
						[xxADT_MetaDataDefinition:79]ID:1:=SQ_SeqNumber (->[xxADT_MetaDataDefinition:79]ID:1;True:C214)
						[xxADT_MetaDataDefinition:79]Name:2:=$label+API Get Virtual Field Name (Table:C252($fieldPointer);Field:C253($fieldPointer))
						[xxADT_MetaDataDefinition:79]Posicion:8:=Size of array:C274(atADT_DefTypeTxt)+1
						[xxADT_MetaDataDefinition:79]TableNum:7:=Table:C252($table)
						[xxADT_MetaDataDefinition:79]Tag:5:=Field name:C257($fieldPointer)
						[xxADT_MetaDataDefinition:79]Tipo:3:=Type:C295($fieldPointer->)
						SAVE RECORD:C53([xxADT_MetaDataDefinition:79])
						ADTcfg_LoadMetaDataDef (Selected list items:C379(vl_TabMetaDatos))
					End if 
				End if 
			End if 
		End if 
	End if 
Else 
	If ((Selected list items:C379(vl_TabMetaDatos)=2) | (Selected list items:C379(vl_TabMetaDatos)=3) | (Selected list items:C379(vl_TabMetaDatos)=4) | (Selected list items:C379(vl_TabMetaDatos)=5))
		_O_C_INTEGER:C282($num)
		CREATE RECORD:C68([xxADT_MetaDataDefinition:79])
		[xxADT_MetaDataDefinition:79]Category:4:=Selected list items:C379(vl_TabMetaDatos)
		[xxADT_MetaDataDefinition:79]FieldNum:6:=0
		If ([xxADT_MetaDataDefinition:79]Category:4=1)
			[xxADT_MetaDataDefinition:79]ID:1:=SQ_SeqNumber (->[xxADT_MetaDataDefinition:79]ID:1;True:C214)
		Else 
			$num:=SQ_SeqNumber (->[xxADT_MetaDataDefinition:79]ID:1)
			While ($num<4)
				$num:=SQ_SeqNumber (->[xxADT_MetaDataDefinition:79]ID:1)
			End while 
			[xxADT_MetaDataDefinition:79]ID:1:=$num
		End if 
		
		QUERY:C277([xxADT_listas:254];[xxADT_listas:254]ID_Campo:3=$num)
		If (Records in selection:C76([xxADT_listas:254])>0)
			DELETE SELECTION:C66([xxADT_listas:254])
		End if 
		[xxADT_MetaDataDefinition:79]Name:2:=""
		[xxADT_MetaDataDefinition:79]Posicion:8:=Size of array:C274(atADT_DefTypeTxt)+1
		[xxADT_MetaDataDefinition:79]TableNum:7:=0
		[xxADT_MetaDataDefinition:79]Tag:5:=""
		[xxADT_MetaDataDefinition:79]Tipo:3:=Is text:K8:3
		
		  //generar la etiqueta del formulario
		SAVE RECORD:C53([xxADT_MetaDataDefinition:79])
		ADTcfg_LoadMetaDataDef (Selected list items:C379(vl_TabMetaDatos))
		AL_GotoCell (xALP_MetaDef;2;Size of array:C274(atADT_DefTypeTxt))
	Else 
		_O_C_INTEGER:C282($NumTab)
		$row:=Size of array:C274(atADT_DefTypeTxt)
		  //abro el cuadro de dialogo para editar las listas
		$NumTab:=Selected list items:C379(vl_TabMetaDatos)
		Case of 
			: ($NumTab=2)  //candidatos
				var_tablaAsociada:="Candidatos"
			: ($NumTab=3)  //padres
				var_tablaAsociada:="Padres"
			: ($NumTab=4)  //madres
				var_tablaAsociada:="Madres"
			: ($NumTab=5)  //apoderados
				var_tablaAsociada:="Apoderados"
		End case 
		
		C_TEXT:C284($dato)
		$fila:=""
		AL_GetCellValue (xALP_MetaDef;$row;3;$dato)
		AL_GetCellValue (xALP_MetaDef;$row;1;$fila)
		$ID:=Num:C11($fila)
		Case of 
			: ($dato="Lista")  //si es de tipo lista
				READ ONLY:C145([xxADT_MetaDataDefinition:79])
				QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]ID:1=$ID)
				
				READ ONLY:C145([xxADT_listas:254])
				  //cargar los valores por defecto para la lista seleccionada
				KRL_RelateSelection (->[xxADT_listas:254]ID_Campo:3;->[xxADT_MetaDataDefinition:79]ID:1;"")
				SELECTION TO ARRAY:C260([xxADT_listas:254]Valor Lista:2;<>valores)
				
				WDW_OpenFormWindow (->[xxSTR_Constants:1];"ADN_EditarLista";0;-Palette form window:K39:9;__ ("Editar Lista"))
				DIALOG:C40([xxSTR_Constants:1];"ADN_EditarLista")
				CLOSE WINDOW:C154
		End case 
	End if 
End if 