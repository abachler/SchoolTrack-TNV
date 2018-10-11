  //Método de Formulario: Config


Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_LONGINT:C283($Error)
		
		  //specify fields to display
		$Error:=AL_SetFile (xALP_HSubjects;Table:C252(->[Asignaturas_Historico:84]))  //[Asignaturas_Histórico]
		$Error:=AL_SetFields (xALP_HSubjects;84;1;1;Field:C253(->[Asignaturas_Historico:84]Asignatura:2))  //[Asignaturas_Histórico]ASIGNATURA
		$Error:=AL_SetFields (xALP_HSubjects;84;2;1;5)  //[Asignaturas_Histórico]Año
		$Error:=AL_SetFields (xALP_HSubjects;84;3;1;-2)  //Calculated column (text)
		$Error:=AL_SetFields (xALP_HSubjects;84;4;1;7)  //[Asignaturas_Histórico]Incluida_En_Actas
		$Error:=AL_SetFields (xALP_HSubjects;84;5;1;6)  //[Asignaturas_Histórico]Promediable
		$Error:=AL_SetFields (xALP_HSubjects;84;6;1;10)  //[Asignaturas_Histórico]Electiva
		$Error:=AL_SetFields (xALP_HSubjects;84;7;1;24)  //[Asignaturas_Histórico]Optativa
		  //$Error:=AL_SetFields (xALP_HSubjects;84;8;1;8)  `[Asignaturas_Histórico]Evaluacion_en_Conceptos
		  //$Error:=AL_SetFields (xALP_HSubjects;84;9;1;13)  `[Asignaturas_Histórico]Profesor_Nombre
		
		  //column 1 settings
		AL_SetHeaders (xALP_HSubjects;1;1;__ ("Asignatura"))
		AL_SetWidths (xALP_HSubjects;1;1;261)
		AL_SetFormat (xALP_HSubjects;1;"";0;0;0;0)
		AL_SetHdrStyle (xALP_HSubjects;1;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_HSubjects;1;"Tahoma";9;0)
		AL_SetStyle (xALP_HSubjects;1;"Tahoma";9;0)
		AL_SetForeColor (xALP_HSubjects;1;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_HSubjects;1;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_HSubjects;1;1)
		AL_SetEntryCtls (xALP_HSubjects;1;0)
		
		  //column 2 settings
		AL_SetHeaders (xALP_HSubjects;2;1;__ ("Año"))
		AL_SetWidths (xALP_HSubjects;2;1;40)
		AL_SetFormat (xALP_HSubjects;2;"####";0;0;0;0)
		AL_SetHdrStyle (xALP_HSubjects;2;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_HSubjects;2;"Tahoma";9;0)
		AL_SetStyle (xALP_HSubjects;2;"Tahoma";9;0)
		AL_SetForeColor (xALP_HSubjects;2;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_HSubjects;2;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_HSubjects;2;0)
		AL_SetEntryCtls (xALP_HSubjects;2;0)
		
		  //column 3 settings
		AL_SetCalcCall (xALP_HSubjects;3;"xALPCB_Col_GetNivelName")
		AL_SetHeaders (xALP_HSubjects;3;1;"Nivel")
		AL_SetWidths (xALP_HSubjects;3;1;60)
		AL_SetFormat (xALP_HSubjects;3;"";0;0;0;0)
		AL_SetHdrStyle (xALP_HSubjects;3;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_HSubjects;3;"Tahoma";9;0)
		AL_SetStyle (xALP_HSubjects;3;"Tahoma";9;0)
		AL_SetForeColor (xALP_HSubjects;3;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_HSubjects;3;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_HSubjects;3;0)
		AL_SetEntryCtls (xALP_HSubjects;3;0)
		
		  //column 4 settings
		AL_SetHeaders (xALP_HSubjects;4;1;__ ("En actas"))
		AL_SetWidths (xALP_HSubjects;4;1;40)
		AL_SetFormat (xALP_HSubjects;4;"Si;No";0;0;0;0)
		AL_SetHdrStyle (xALP_HSubjects;4;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_HSubjects;4;"Tahoma";9;0)
		AL_SetStyle (xALP_HSubjects;4;"Tahoma";9;0)
		AL_SetForeColor (xALP_HSubjects;4;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_HSubjects;4;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_HSubjects;4;1)
		AL_SetEntryCtls (xALP_HSubjects;4;0)
		
		  //column 5 settings
		AL_SetHeaders (xALP_HSubjects;5;1;__ ("Promediable"))
		AL_SetWidths (xALP_HSubjects;5;1;70)
		AL_SetFormat (xALP_HSubjects;5;"Si;No";0;0;0;0)
		AL_SetHdrStyle (xALP_HSubjects;5;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_HSubjects;5;"Tahoma";9;0)
		AL_SetStyle (xALP_HSubjects;5;"Tahoma";9;0)
		AL_SetForeColor (xALP_HSubjects;5;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_HSubjects;5;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_HSubjects;5;0)
		AL_SetEntryCtls (xALP_HSubjects;5;0)
		
		  //column 6 settings
		AL_SetHeaders (xALP_HSubjects;6;1;__ ("Electiva"))
		AL_SetWidths (xALP_HSubjects;6;1;50)
		AL_SetFormat (xALP_HSubjects;6;"Si;No";0;0;0;0)
		AL_SetHdrStyle (xALP_HSubjects;6;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_HSubjects;6;"Tahoma";9;0)
		AL_SetStyle (xALP_HSubjects;6;"Tahoma";9;0)
		AL_SetForeColor (xALP_HSubjects;6;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_HSubjects;6;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_HSubjects;6;1)
		AL_SetEntryCtls (xALP_HSubjects;6;0)
		
		  //column 7 settings
		AL_SetHeaders (xALP_HSubjects;7;1;__ ("Optativa"))
		AL_SetFormat (xALP_HSubjects;7;"Si;No";0;0;0;0)
		AL_SetWidths (xALP_HSubjects;7;1;50)
		AL_SetHdrStyle (xALP_HSubjects;7;"Tahoma";9;1)
		AL_SetFtrStyle (xALP_HSubjects;7;"Tahoma";9;0)
		AL_SetStyle (xALP_HSubjects;7;"Tahoma";9;0)
		AL_SetForeColor (xALP_HSubjects;7;"Black";0;"Black";0;"Black";0)
		AL_SetBackColor (xALP_HSubjects;7;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_HSubjects;7;1)
		AL_SetFilter (xALP_HSubjects;7;"&9")
		AL_SetEntryCtls (xALP_HSubjects;7;0)
		
		  //  `column 8 settings
		  //AL_SetHeaders (xALP_HSubjects;8;1;"Ev. en conceptos")
		  //AL_SetFormat (xALP_HSubjects;8;"Si;No";0;0;0;0)
		  //AL_SetHdrStyle (xALP_HSubjects;8;"Tahoma";9;1)
		  //AL_SetFtrStyle (xALP_HSubjects;8;"Tahoma";9;0)
		  //AL_SetStyle (xALP_HSubjects;8;"Tahoma";9;0)
		  //AL_SetForeColor (xALP_HSubjects;8;"Black";0;"Black";0;"Black";0)
		  //AL_SetBackColor (xALP_HSubjects;8;"White";0;"White";0;"White";0)
		  //AL_SetEnterable (xALP_HSubjects;8;1)
		  //AL_SetEntryCtls (xALP_HSubjects;8;0)
		  //
		  //  `column 9 settings
		  //AL_SetHeaders (xALP_HSubjects;9;1;"Profesor")
		  //AL_SetFormat (xALP_HSubjects;9;"";0;0;0;0)
		  //AL_SetHdrStyle (xALP_HSubjects;9;"Tahoma";9;1)
		  //AL_SetFtrStyle (xALP_HSubjects;9;"Tahoma";9;0)
		  //AL_SetStyle (xALP_HSubjects;9;"Tahoma";9;0)
		  //AL_SetForeColor (xALP_HSubjects;9;"Black";0;"Black";0;"Black";0)
		  //AL_SetBackColor (xALP_HSubjects;9;"White";0;"White";0;"White";0)
		  //AL_SetEnterable (xALP_HSubjects;9;1)
		  //AL_SetEntryCtls (xALP_HSubjects;9;0)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_HSubjects;9;2;1;1;2)
		AL_SetColOpts (xALP_HSubjects;1;1;1;0;0)
		AL_SetRowOpts (xALP_HSubjects;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_HSubjects;0;1;1)
		AL_SetMiscOpts (xALP_HSubjects;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_HSubjects;"";"")
		AL_SetCallbacks (xALP_HSubjects;"";"xALCB_EX_Default")
		AL_SetScroll (xALP_HSubjects;0;0)
		AL_SetEntryOpts (xALP_HSubjects;2;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetColLock (xALP_HSubjects;1)
		AL_SetDrgOpts (xALP_HSubjects;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_HSubjects;1;"";"";"")
		AL_SetDrgSrc (xALP_HSubjects;2;"";"";"")
		AL_SetDrgSrc (xALP_HSubjects;3;"";"";"")
		AL_SetDrgDst (xALP_HSubjects;1;"";"";"")
		AL_SetDrgDst (xALP_HSubjects;1;"";"";"")
		AL_SetDrgDst (xALP_HSubjects;1;"";"";"")
		
		AL_SetSort (xALP_HSubjects;2;4;7;5;6;1)
		
		r1:=1
		bActas:=1
		bPromediables:=1
		bPC:=1
		bPE:=1
		
		
		
		
End case 
