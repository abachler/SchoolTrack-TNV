Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		
		tInfos:=""
		_O_C_STRING:C293(30;$str)
		ARRAY TEXT:C222(<>aUFValues;0)
		ARRAY TEXT:C222(<>aUFFileNm;0)
		ARRAY INTEGER:C220(<>aUDFileNo;0)
		ARRAY TEXT:C222(aUFname;0)
		ARRAY LONGINT:C221(aUFid;0)
		ARRAY INTEGER:C220(aUFFileNo;0)
		
		  //QUERY([xShell_Tables];[xShell_Tables]has_Userfields=True)
		  //SELECTION TO ARRAY([xShell_Tables]Alias;◊aUFFileNm;[xShell_Tables]TableNumber;◊aUFFileNo)
		SYS_TableModulesWithUF 
		UFLD_LoadArrays 
		
		C_LONGINT:C283($Error)
		
		  //specify arrays to display
		$Error:=AL_SetArraysNam (xALP_UserFields;1;1;"aUFName")
		$Error:=AL_SetArraysNam (xALP_UserFields;2;1;"aUFFile")
		$Error:=AL_SetArraysNam (xALP_UserFields;3;1;"aUFId")
		
		  //column 1 settings
		AL_SetHeaders (xALP_UserFields;1;1;__ ("Campo"))
		AL_SetWidths (xALP_UserFields;1;1;220)
		AL_SetFormat (xALP_UserFields;1;"";0;0;0;0)
		AL_SetHdrStyle (xALP_UserFields;1;"Tahoma";11;1)
		AL_SetFtrStyle (xALP_UserFields;1;"Tahoma";9;0)
		AL_SetStyle (xALP_UserFields;1;"Tahoma";11;0)
		AL_SetForeColor (xALP_UserFields;1;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_UserFields;1;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_UserFields;1;1)
		AL_SetEntryCtls (xALP_UserFields;1;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_UserFields;2;1;__ ("Utilizado en"))
		AL_SetWidths (xALP_UserFields;2;1;180)
		AL_SetFormat (xALP_UserFields;2;"";0;0;0;0)
		AL_SetHdrStyle (xALP_UserFields;2;"Tahoma";11;1)
		AL_SetFtrStyle (xALP_UserFields;2;"Tahoma";9;0)
		AL_SetStyle (xALP_UserFields;2;"Tahoma";11;0)
		AL_SetForeColor (xALP_UserFields;2;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_UserFields;2;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_UserFields;2;1)
		AL_SetEntryCtls (xALP_UserFields;2;0)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_UserFields;9;1;4;1;6)
		AL_SetColOpts (xALP_UserFields;1;1;1;1;0)
		AL_SetRowOpts (xALP_UserFields;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_UserFields;0;1;1)
		AL_SetMainCalls (xALP_UserFields;"";"")
		AL_SetScroll (xALP_UserFields;0;-3)
		AL_SetEntryOpts (xALP_UserFields;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetSortOpts (xALP_UserFields;0;0;0;"Seleccione las columnas a ordenar:";0;1)
		AL_SetDrgOpts (xALP_UserFields;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_UserFields;1;"";"";"")
		AL_SetDrgSrc (xALP_UserFields;2;"";"";"")
		AL_SetDrgSrc (xALP_UserFields;3;"";"";"")
		AL_SetDrgDst (xALP_UserFields;1;"";"";"")
		AL_SetDrgDst (xALP_UserFields;1;"";"";"")
		AL_SetDrgDst (xALP_UserFields;1;"";"";"")
		
		AL_SetSort (xALP_UserFields;2;1)
		
		If (Size of array:C274(aUFName)>0)
			aUFName:=1
			$id:=String:C10(aUFid{aUFname};"00000/"+"@")
			READ ONLY:C145([xShell_Userfields:76])
			QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FieldID:7=aUFid{aUFname})
			vField:="["+Table name:C256([xShell_Userfields:76]FileNo:6)+"]Userfields'Value"
			EXECUTE FORMULA:C63("vPointer:=»"+vField)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$f)
			QUERY:C277(Table:C252([xShell_Userfields:76]FileNo:6)->;vPointer->=$id)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			  //$f:=Records in selection(Table([xShell_Userfields]FileNo)->)
			If ($f>0)
				$t:=Records in table:C83(Table:C252([xShell_Userfields:76]FileNo:6)->)
				$ratio:=String:C10(Round:C94($f/$t*100;2);"##0,00%")
				tInfos:=__ ("Utilizado en un ")+$ratio+__ (" de los registros del archivo.")
			Else 
				tInfos:=__ ("No utilizado.")
			End if 
		End if 
		IT_SetButtonState (aUFName#0;->bDelUF;->bEdit)
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
	: (Form event:C388=On Menu Selected:K2:14)
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
