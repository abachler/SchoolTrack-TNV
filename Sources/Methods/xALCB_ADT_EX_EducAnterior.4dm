//%attributes = {}
  //xALCB_ADT_EX_EducAnterior

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_EducAnterior;$col;$row)
	If (AL_GetCellMod (xALP_EducAnterior)=1)
		Case of 
			: ($col=1)
				<>aPrevSchool{0}:=atADT_ColAnt_Nombre{$row}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (-><>aPrevSchool;">>";->$DA_Return)
				If (Size of array:C274($DA_Return)>1)
					ARRAY TEXT:C222(aColAntNombres;0)
					For ($i;1;Size of array:C274($DA_Return))
						INSERT IN ARRAY:C227(aColAntNombres;Size of array:C274(aColAntNombres)+1)
						aColAntNombres{Size of array:C274(aColAntNombres)}:=<>aPrevSchool{$DA_Return{$i}}
					End for 
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					ARRAY POINTER:C280(<>aChoicePtrs;1)
					<>aChoicePtrs{1}:=->aColAntNombres
					TBL_ShowChoiceList (0;__ ("Seleccione el colegio");2)
					If (ok=1)
						atADT_ColAnt_Nombre{$row}:=aColAntNombres{choiceIdx}
					Else 
						atADT_ColAnt_Nombre{$row}:=""
					End if 
				Else 
					If (Size of array:C274($DA_Return)>0)
						atADT_ColAnt_Nombre{$row}:=<>aPrevSchool{$DA_Return{1}}
					Else 
						$listName:="Colegio anterior"
						ARRAY TEXT:C222($tempTextArray;0)
						$textArrayPointer:=-><>aPrevSchool
						$s:=atADT_ColAnt_Nombre{$row}
						If (USR_GetMethodAcces ("Listas";0))
							QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$listName)
							If (Records in selection:C76([xShell_List:39])=1)
								KRL_LoadRecord (->[xShell_List:39])
								If (ok=1)
									BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$tempTextArray)  //releemos el arreglo para asegurarnos que otro usuario no haya creado el valor
									COPY ARRAY:C226($tempTextArray;$textArrayPointer->)
									AT_Initialize (->$tempTextArray)
									If (Find in array:C230($textArrayPointer->;$s)=-1)
										If ([xShell_List:39]Enriquecible:8)
											OK:=CD_Dlog (0;__ ("Valor inexistente. \r¿Desea Ud. agregarlo a la tabla?");__ ("");__ ("Sí");__ ("No"))
										Else 
											OK:=0
											CD_Dlog (0;__ ("Esta tabla no ha sido configurada para poder agregar valores durante el ingreso.\rPor favor consulte al administrador de SchoolTrack."))
										End if 
										If (ok=1)
											If ([xShell_List:39]Form_Name:6#"OneValueInput")
												sValue:=$s
												WDW_Open (290;84;0;4;[xShell_List:39]Listname:1)
												DIALOG:C40([xShell_List:39];[xShell_List:39]Form_Name:6)
												CLOSE WINDOW:C154
												If ((ok=1) & (sValue#""))
													TRACE:C157
													INSERT IN ARRAY:C227($textArrayPointer->;1;1)
													$textArrayPointer->{1}:=sValue
													SORT ARRAY:C229($textArrayPointer->)
													COPY ARRAY:C226($textArrayPointer->;$tempTextArray)
													  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->$tempTextArray)
													  //SAVE RECORD([xShell_List])
													  //20140107 ASM Ticket  128514
													TBL_SaveListAndArrays ($textArrayPointer;->$tempTextArray)
													KRL_ReloadAsReadOnly (->[xShell_List:39])
													atADT_ColAnt_Nombre{$row}:=svalue
												End if 
											Else 
												$value:=$s
												INSERT IN ARRAY:C227($textArrayPointer->;1;1)
												$textArrayPointer->{1}:=$value
												SORT ARRAY:C229($textArrayPointer->)
												COPY ARRAY:C226($textArrayPointer->;$tempTextArray)
												  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->$tempTextArray)
												  //SAVE RECORD([xShell_List])
												  //20140107 ASM Ticket  128514
												TBL_SaveListAndArrays ($textArrayPointer;->$tempTextArray)
												atADT_ColAnt_Nombre{$row}:=$value
											End if 
										Else 
											atADT_ColAnt_Nombre{$row}:=""
										End if 
									Else 
										atADT_ColAnt_Nombre{$row}:=$textArrayPointer->{Find in array:C230($textArrayPointer->;$s)}
									End if 
								End if 
								UNLOAD RECORD:C212([xShell_List:39])
								READ ONLY:C145([xShell_List:39])
							End if 
						Else 
							QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$listName)
							BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$tempTextArray)  //releemos el arreglo para asegurarnos que otro usuario no haya creado el valor
							COPY ARRAY:C226($tempTextArray;$textArrayPointer->)
							AT_Initialize (->$tempTextArray)
							If (Find in array:C230($textArrayPointer->;$s)=-1)
								CD_Dlog (0;__ ("Valor inexistente. Consulte con el administrador del sistema."))
							Else 
								atADT_ColAnt_Nombre{$row}:=$textArrayPointer->{Find in array:C230($textArrayPointer->;$s)}
							End if 
						End if 
					End if 
				End if 
				  //AL_SetEnterable (xALP_EducAnterior;1;3;<>aPrevSchool)
			: ($col=3)
				
		End case 
	End if 
End if 