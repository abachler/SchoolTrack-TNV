//%attributes = {}
  //xALSet_BBL_Transacciones

Case of 
	: (Form event:C388=On Load:K2:1)
		  //Configuration commands for ALP object 'xALP_Transactions'
		  //You can paste this into an ALP object's method, rather than
		  //use the Advanced Properties dialog to control the configuration.
		  //Commands always have priority over the settings in the dialog.
		
		C_LONGINT:C283($Error)
		
		  //specify arrays to display
		$Error:=AL_SetArraysNam (xALP_Transactions;1;1;"aDate1")
		$Error:=AL_SetArraysNam (xALP_Transactions;2;1;"aText1")
		$Error:=AL_SetArraysNam (xALP_Transactions;3;1;"aReal1")
		$Error:=AL_SetArraysNam (xALP_Transactions;4;1;"aReal2")
		$Error:=AL_SetArraysNam (xALP_Transactions;5;1;"aLong1")
		
		  //column 1 settings
		AL_SetFooters (xALP_Transactions;1;2;__ ("Saldo"))
		AL_SetHeaders (xALP_Transactions;1;1;__ ("Fecha"))
		AL_SetWidths (xALP_Transactions;1;1;70)
		AL_SetFormat (xALP_Transactions;1;"7";0;0;0;0)
		AL_SetHdrStyle (xALP_Transactions;1;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_Transactions;1;"Tahoma";9;1)
		AL_SetStyle (xALP_Transactions;1;"Tahoma";9;0)
		AL_SetForeColor (xALP_Transactions;1;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Transactions;1;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Transactions;1;0)
		AL_SetEntryCtls (xALP_Transactions;1;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_Transactions;2;1;__ ("Glosa"))
		AL_SetWidths (xALP_Transactions;2;1;230)
		AL_SetFormat (xALP_Transactions;2;"";0;0;0;0)
		AL_SetHdrStyle (xALP_Transactions;2;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_Transactions;2;"Tahoma";9;0)
		AL_SetStyle (xALP_Transactions;2;"Tahoma";9;0)
		AL_SetForeColor (xALP_Transactions;2;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_Transactions;2;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Transactions;2;0)
		AL_SetEntryCtls (xALP_Transactions;2;0)
		
		  //column 3 settings
		AL_SetHeaders (xALP_Transactions;3;1;__ ("Pagos"))
		AL_SetWidths (xALP_Transactions;3;1;60)
		AL_SetFormat (xALP_Transactions;3;"### ### ##0";0;0;0;0)
		AL_SetHdrStyle (xALP_Transactions;3;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_Transactions;3;"Tahoma";9;1)
		AL_SetStyle (xALP_Transactions;3;"Tahoma";9;0)
		AL_SetBackColor (xALP_Transactions;3;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Transactions;3;0)
		AL_SetEntryCtls (xALP_Transactions;3;0)
		
		  //column 4 settings
		
		AL_SetHeaders (xALP_Transactions;4;1;__ ("Cargos"))
		AL_SetWidths (xALP_Transactions;4;1;60)
		AL_SetFormat (xALP_Transactions;4;"### ### ##0";0;0;0;0)
		AL_SetHdrStyle (xALP_Transactions;4;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_Transactions;4;"Tahoma";9;1)
		AL_SetStyle (xALP_Transactions;4;"Tahoma";9;0)
		AL_SetBackColor (xALP_Transactions;4;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_Transactions;4;0)
		AL_SetEntryCtls (xALP_Transactions;4;0)
		
		
		If ([BBL_Lectores:72]Saldo:27<0)
			AL_SetFooters (xALP_Transactions;3;1;"")
			AL_SetForeColor (xALP_Transactions;3;"Black";0;"Black";0;"Red";0)
			AL_SetFooters (xALP_Transactions;4;1;String:C10([BBL_Lectores:72]Saldo:27;"### ### ##0"))
			AL_SetForeColor (xALP_Transactions;4;"Black";0;"Black";0;"Red";0)
		Else 
			AL_SetFooters (xALP_Transactions;4;1;"")
			AL_SetForeColor (xALP_Transactions;4;"Black";0;"Black";0;"Red";0)
			AL_SetFooters (xALP_Transactions;3;1;String:C10([BBL_Lectores:72]Saldo:27;"### ### ##0"))
			AL_SetForeColor (xALP_Transactions;3;"Black";0;"Black";0;"Blue";0)
		End if 
		
		  //general options
		
		AL_SetColOpts (xALP_Transactions;1;1;1;1;0)
		AL_SetRowOpts (xALP_Transactions;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_Transactions;0;1;1)
		AL_SetMiscOpts (xALP_Transactions;0;0;"\\";1;1)
		AL_SetMiscColor (xALP_Transactions;0;"White";0)
		AL_SetMiscColor (xALP_Transactions;1;"White";0)
		AL_SetMiscColor (xALP_Transactions;2;"White";0)
		AL_SetMiscColor (xALP_Transactions;3;"White";0)
		AL_SetMainCalls (xALP_Transactions;"";"")
		AL_SetScroll (xALP_Transactions;0;-3)
		AL_SetCopyOpts (xALP_Transactions;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xALP_Transactions;0;1;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xALP_Transactions;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetHeight (xALP_Transactions;1;2;1;1;2)
		AL_SetDividers (xALP_Transactions;"Black";"Gray";0;"Black";"Gray";0)
		AL_SetDrgOpts (xALP_Transactions;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_Transactions;1;"";"";"")
		AL_SetDrgSrc (xALP_Transactions;2;"";"";"")
		AL_SetDrgSrc (xALP_Transactions;3;"";"";"")
		AL_SetDrgDst (xALP_Transactions;1;"";"";"")
		AL_SetDrgDst (xALP_Transactions;1;"";"";"")
		AL_SetDrgDst (xALP_Transactions;1;"";"";"")
		ARRAY INTEGER:C220(aint2D;2;0)
		For ($i;1;Size of array:C274(aDate1))
			If (aReal1{$i}>0)
				AL_SetCellColor (xALP_Transactions;3;$i;0;0;aInt2D;"Blue";0;"";0)
			Else 
				AL_SetCellColor (xALP_Transactions;3;$i;0;0;aInt2D;"White";0;"";0)
			End if 
			If (aReal2{$i}>0)
				AL_SetCellColor (xALP_Transactions;4;$i;0;0;aInt2D;"Red";0;"";0)
			Else 
				AL_SetCellColor (xALP_Transactions;4;$i;0;0;aInt2D;"White";0;"";0)
			End if 
		End for 
		
		AL_SetSort (xALP_Transactions;-1)
End case 