Case of 
	: (Form event:C388=On Load:K2:1)
		If ((Not:C34(Is compiled mode:C492)) & (USR_GetUserID <0))
			OBJECT SET VISIBLE:C603(*;"developer@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"developer@";False:C215)
		End if 
		READ WRITE:C146([xShell_List:39])
		QUERY:C277([xShell_List:39];[xShell_List:39]Module:4=vsBWR_CurrentModule;*)
		QUERY:C277([xShell_List:39]; | [xShell_List:39]Module:4="All")
		ARRAY TEXT:C222(pLists;0)
		SELECTION TO ARRAY:C260([xShell_List:39]Listname:1;pLists)
		SORT ARRAY:C229(pLists;>)
		C_BOOLEAN:C305(changed)
		Changed:=False:C215
		pLists:=1
		If (Size of array:C274(pLists)>0)
			vListName:=pLists{1}
			ARRAY TEXT:C222(sElements;0)
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=vListName)
			sLayout:=[xShell_List:39]Form_Name:6
			BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->sElements)
			
			
			IT_SetButtonState (False:C215;->bDel;->bEdit;->bInfos)
			  //tables
			ARRAY INTEGER:C220(aLines;0)
			$err:=AL_SetArraysNam (xALP_Tables;1;1;"sElements")
			AL_SetSort (xALP_Tables;1)
			AL_SetStyle (xALP_Tables;1;"Tahoma";11;0)
			AL_SetRowOpts (xALP_Tables;1;1;0;0;0)
			AL_SetSortOpts (xALP_Tables;0;0;0;"";0)
			AL_SetMiscOpts (xALP_Tables;1;0;"'";0;1)
			AL_SetSelect (xALP_Tables;aLines)
			AL_SetHeight (xALP_Tables;1;1;1;4)
			ARRAY TEXT:C222(at_g1;0)
			AT_Text2Array (->at_g1;[xShell_List:39]DefaultValues:10;"\r")
			If (Size of array:C274(at_g1)>0)
				For ($i;1;Size of array:C274(at_g1))
					$pos:=Find in array:C230(sElements;at_g1{$i})
					If ($pos>0)
						AL_SetRowStyle (xALP_Tables;$pos;2)
					End if 
				End for 
			End if 
			ALP_SetAlternateLigneColor (xALP_Tables)
			ALP_SetInterface (xALP_Tables)
		Else 
			CD_Dlog (0;__ ("No hay tablas disponibles para este modulo."))
		End if 
		XS_SetConfigInterface 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
	: (Form event:C388=On Menu Selected:K2:14)
		
	: (Form event:C388=On Unload:K2:2)
		AL_RemoveArrays (xALP_Tables;1;20)
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
