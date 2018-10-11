Case of 
	: (Form event:C388=On Load:K2:1)
		  //reading log
		ARRAY TEXT:C222(atBBL_LogCol_1;0)
		ARRAY TEXT:C222(atBBL_LogCol_2;0)
		ARRAY TEXT:C222(atBBL_LogCol_3;0)
		QUERY:C277([xxBBL_Logs:41];[xxBBL_Logs:41]Date_log:1=Current date:C33(*))
		EM_ErrorManager ("install")
		EM_ErrorManager ("setMode";"")
		
		BLOB_ExpandBlob_byPointer (->[xxBBL_Logs:41]ID:4)
		$offset:=0
		BLOB_Blob2Vars (->[xxBBL_Logs:41]ID:4;$offset;->atBBL_LogCol_1;->atBBL_LogCol_2;->atBBL_LogCol_3)
		
		EM_ErrorManager ("clear")
		
		$err:=PL_SetArraysNam (Self:C308->;1;3;"atBBL_LogCol1";"atBBL_LogCol2";"atBBL_LogCol3")
		
		PL_SetHeaders (Self:C308->;1;3;"Lector";"Titulo";"Hasta")
		PL_SetWidths (Self:C308->;1;3;100;100;100)
		PL_SetHdrOpts (Self:C308->;3)
		
		PL_SetHeight (Self:C308->;1;1;0;0)
		PL_SetHdrStyle (Self:C308->;0;"Tahoma";8;1)
		PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
		PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetBrkRowDiv (Self:C308->;0.25;"Black";"Black";0)
		PL_SetBrkHeight (Self:C308->;0;1;2)
		PL_SetBrkColOpt (Self:C308->;0;0;0;1;"Black";"Black";0)
		PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";8;1)
		
End case 

