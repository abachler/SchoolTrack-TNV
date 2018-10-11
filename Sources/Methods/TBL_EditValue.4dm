//%attributes = {}
  //TBL_EditValue

$pos:=Find in array:C230(at_g1;sElements{aLines{1}})
If ($pos>0)
	CD_Dlog (0;sElements{aLines{1}}+__ (" es un valor por defecto y no puede ser editado."))
Else 
	sValue:=sElements{aLines{1}}
	sElements:=aLines{1}
	If ([xShell_List:39]Form_TableNumber:12=0)
		$tablePointer:=->[xShell_List:39]
	Else 
		$tablePointer:=Table:C252([xShell_List:39]Form_TableNumber:12)
	End if 
	WDW_OpenFormWindow ($tablePointer;[xShell_List:39]Form_Name:6;-1;Movable form dialog box:K39:8;pLists{pLists};"WDW_Closedlog")
	DIALOG:C40($tablePointer->;[xShell_List:39]Form_Name:6)
	CLOSE WINDOW:C154
	If (ok=1)
		changed:=True:C214
		ARRAY TEXT:C222(aText2;1)
		aText2{1}:=Substring:C12(sElements{aLines{1}};1;70)+"@"
		  //ok:=TBL_ChangeValue (sElements{sElements};sValue)
		ok:=TBL_ChangeValue (sValue)
		If (ok=1)
			  //157382
			If ([xShell_List:39]PopupArrayName:3="◊at_EventosAsignatura")
				CFG_ST_BlockEvtAsigNiveles ("edit";sValue;sElements{sElements})
			End if 
			sElements{sElements}:=sValue
		End if 
		SORT ARRAY:C229(sElements;>)
		$el:=Find in array:C230(sElements;sValue)
		AL_UpdateArrays (xALP_Tables;-2)
		If ($el>0)
			ARRAY INTEGER:C220(aLines;1)
			aLines{1}:=$el
			AL_SetSelect (xALP_Tables;aLines)
		Else 
			ARRAY INTEGER:C220(aLines;0)
			AL_SetSelect (xALP_Tables;aLines)
			_O_DISABLE BUTTON:C193(bDel)
			_O_DISABLE BUTTON:C193(bEdit)
			_O_DISABLE BUTTON:C193(bInfos)
		End if 
	End if 
End if 