//%attributes = {}
  //TBL_ClearValue

  //modificada el 22/08/96 para permitir el remplazo o la eliminación
  //de multiples elementos
  //Atención toda la gestió necesita de AreaList, 
  //Ver [Constants]Parametros, página 6 (enSchoolTrack)

C_LONGINT:C283($i;$f)
$message:=False:C215
For ($i;Size of array:C274(aLines);1;-1)
	$pos:=Find in array:C230(at_g1;sElements{aLines{$i}})
	If ($pos>0)
		AT_Delete ($i;1;->aLines)
		$message:=True:C214
	End if 
End for 

If ($message)
	CD_Dlog (0;__ ("Los valores por defecto (en cursivas) no pueden ser eliminados."))
End if 

If (Size of array:C274(aLines)>0)
	ARRAY TEXT:C222(aText2;Size of array:C274(aLines))
	For ($i;1;Size of array:C274(aText2))
		aText2{$i}:=Substring:C12(sElements{aLines{$i}};1;70)+"@"
	End for 
	$f:=0
	auxVal:=sElements{aLines{1}}
	$SetCreated:=False:C215
	If (Size of array:C274(aLines)>0)
		MESSAGES ON:C181
		QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=pLists{pLists})
		
		  //20110531 AS. cambios para manejar los datos en tabla nueva.
		QUERY:C277([xShell_List_FieldRefs:236];[xShell_List_FieldRefs:236]ListName:4=[xShell_List:39]Listname:1)
		If (Records in selection:C76([xShell_List_FieldRefs:236])#0)
			While (Not:C34(End selection:C36([xShell_List_FieldRefs:236])))
				  //If (Is table number valid([xShell_List_FieldRefs]FileRef))
				  //If (Is field number valid([xShell_List_FieldRefs]FileRef;[xShell_List_FieldRefs]FieldRef))
				If (Type:C295(Field:C253([xShell_List_FieldRefs:236]FileRef:1;[xShell_List_FieldRefs:236]FieldRef:2)->)#7)
					READ ONLY:C145(Table:C252([xShell_List_FieldRefs:236]FieldRef:2)->)
					CREATE SET:C116(Table:C252([xShell_List_FieldRefs:236]FieldRef:2)->;"CurrSel")
					$SetCreated:=True:C214
					QRY_QueryWithArray (Field:C253([xShell_List_FieldRefs:236]FileRef:1;[xShell_List_FieldRefs:236]FieldRef:2);->aText2)
					$f:=Records in selection:C76(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->)
					If ($f#0)
						LAST RECORD:C200([xShell_List_FieldRefs:236])
					End if 
				End if 
				  //End if 
				  //End if 
				NEXT RECORD:C51([xShell_List_FieldRefs:236])
			End while 
		End if 
		MESSAGES OFF:C175
	End if 
	If ($f#0)
		ARRAY TEXT:C222(aTblValues;0)
		COPY ARRAY:C226(sElements;aTblValues)
		If (Not:C34([xShell_List:39]NoReemplazarXVacio:13))
			auxVal:="*** Ninguno ***"
			INSERT IN ARRAY:C227(aTblValues;1;2)
			aTblValues{1}:=auxVal
			aTblValues{2}:="-"
		Else 
			auxVal:=sElements{1}
		End if 
		aTblValues:=0
		WDW_OpenFormWindow (->[xShell_List:39];"DeleteValue";-1;Movable form dialog box:K39:8;__ ("Eliminar o reemplazar"))
		DIALOG:C40([xShell_List:39];"DeleteValue")
		CLOSE WINDOW:C154
		Case of 
			: (bReplace=1)
				If (auxVal="*** Ninguno ***")
					auxVal:=""
				End if 
				  //OK:=TBL_ChangeValue (sElements{sElements};auxVal)
				OK:=TBL_ChangeValue (auxVal)  //JHB 18/4/2008 TBL_ChangeValue no usa el primer parametro...
				If (OK=1)
					changed:=True:C214
					AL_UpdateArrays (xALP_Tables;0)
					For ($i;Size of array:C274(aLines);1;-1)
						If (Find in array:C230(at_g1;sElements{aLines{$i}})=-1)
							DELETE FROM ARRAY:C228(sElements;aLines{$i})
						End if 
					End for 
					If (auxVal#"")
						If (Find in array:C230(sElements;auxVal)=-1)
							INSERT IN ARRAY:C227(sElements;Size of array:C274(sElements)+1)
							sElements{Size of array:C274(sElements)}:=auxVal
							sElements:=Size of array:C274(sElements)
						Else 
							sElements:=Find in array:C230(sElements;auxVal)
						End if 
					End if 
				End if 
			: (bDel=1)
				If (OK=1)
					AL_UpdateArrays (xALP_Tables;0)
					For ($i;Size of array:C274(aLines);1;-1)
						If (Find in array:C230(at_g1;sElements{aLines{$i}})=-1)
							  //157382
							If ([xShell_List:39]PopupArrayName:3="◊at_EventosAsignatura")
								CFG_ST_BlockEvtAsigNiveles ("delete";sElements{aLines{$i}})
							End if 
							DELETE FROM ARRAY:C228(sElements;aLines{$i})
						End if 
					End for 
					changed:=True:C214
				End if 
		End case 
		If ($SetCreated)
			USE SET:C118("CurrSel")
			CLEAR SET:C117("CurrSel")
		End if 
	Else 
		
		AL_UpdateArrays (xALP_Tables;0)
		For ($i;Size of array:C274(aLines);1;-1)
			If (Find in array:C230(at_g1;sElements{aLines{$i}})=-1)
				  //157382
				If ([xShell_List:39]PopupArrayName:3="◊at_EventosAsignatura")
					CFG_ST_BlockEvtAsigNiveles ("delete";sElements{aLines{$i}})
				End if 
				DELETE FROM ARRAY:C228(sElements;aLines{$i})
			End if 
		End for 
		changed:=True:C214
	End if 
	
	If (Size of array:C274(at_g1)>0)
		For ($i;1;Size of array:C274(at_g1))
			$pos:=Find in array:C230(sElements;at_g1{$i})
			If ($pos>0)
				AL_SetRowStyle (xALP_Tables;$pos;2)
			End if 
		End for 
	End if 
Else 
	auxVal:=""
End if 