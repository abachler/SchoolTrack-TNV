//%attributes = {}
  // AS_ALP_ConfigAreaSubEvals()
  // Por: Alberto Bachler K.: 22-02-14, 17:37:01
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_columna;$l_anchoColumna;$l_anchoColumnaAlumnos;$l_anchoColumnaControles;$l_anchoColumnaCurso;$l_anchoTotalParciales;$l_calificacionesEditables;$l_columnaCurso;$l_columnaNoLista)
C_LONGINT:C283($l_columnaNombres;$l_columnaParciales;$l_columnaSexo;$l_ErrorALP;$l_iconoEditable;$l_iconoNoEditable)

ARRAY TEXT:C222($aArrayNames;0)


If (Application version:C493<"1400@")
	ASsev_AreaSettings 
	
Else 
	Case of 
		: (vi_LastGradeView=Simbolos)
			$l_anchoColumna:=33
		: (vi_LastGradeView=Notas)
			$l_anchoColumna:=33
		: (vi_LastGradeView=Puntos)
			$l_anchoColumna:=33
		: (vi_LastGradeView=Porcentaje)
			$l_anchoColumna:=33
	End case 
	$l_anchoTotalParciales:=$l_anchoColumna*12
	If ((Not:C34([Asignaturas:18]Seleccion:17)) & (Not:C34([Asignaturas:18]Electiva:11)))
		$l_anchoColumnaCurso:=1
	Else 
		$l_anchoColumnaCurso:=40
	End if 
	If ([xxSTR_Subasignaturas:83]ModoControles:5>0)
		$l_anchoColumnaControles:=30
	Else 
		$l_anchoColumnaControles:=0
	End if 
	$l_anchoColumnaAlumnos:=693-20-40-$l_anchoTotalParciales-$l_anchoColumnaCurso-$l_anchoColumnaControles
	
	
	$l_iconoEditable:=8
	$l_iconoNoEditable:=9
	
	
	If ((vb_calificacionesEditables) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))  //vb_calificacionesEditables es asignada en AS_PageNotas
		$l_calificacionesEditables:=1
	Else 
		$l_calificacionesEditables:=0
	End if 
	If (<>vb_BloquearModifSituacionFinal)
		$l_calificacionesEditables:=0
	End if 
	
	AL_RemoveArrays (xALP_SubEvals;1;35)
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;1;1;"aSubEvalOrden")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;2;1;"aSubEvalStdNme")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;3;1;"aSubEvalCurso")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;4;1;"aSubEvalP1")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;5;1;"aSubEvalControles")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;6;1;"aSubEval1")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;7;1;"aSubEval2")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;8;1;"aSubEval3")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;9;1;"aSubEval4")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;10;1;"aSubEval5")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;11;1;"aSubEval6")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;12;1;"aSubEval7")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;13;1;"aSubEval8")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;14;1;"aSubEval9")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;15;1;"aSubEval10")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;16;1;"aSubEval11")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;17;1;"aSubEval12")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;18;1;"aSubEvalStatus")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;19;1;"aSubEvalId")
	  //MONO TICKET 187315
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_TraceOnError;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_Compatibility;0)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_MinHdrHeight;60)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_MinRowHeight;20)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_HeaderMode;1)
	AL_SetAreaRealProperty (xALP_SubEvals;ALP_Area_HdrIndentV;10)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_UserSort;0)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_EntryClick;2)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_ClickDelay;8)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_EntryAllowArrows;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_EntryMapEnter;2)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_ShowSortIndicator;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_DrawFrame;0)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_ShowColDividers;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_ShowRowDividers;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_ColDivColor;0xFFEEEEEE)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_RowDivColor;0xFFEEEEEE)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_ColumnLock;0)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_ColumnResize;0)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_SmallScrollbar;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_AltRowOptions;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_SelMultiple;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_SelPreserve;1)
	AL_SetAreaLongProperty (xALP_SubEvals;ALP_Area_SelNoCtrlSelect;1)
	
	AL_SetColumnTextProperty (xALP_SubEvals;-2;ALP_Column_HdrFontName;"Tahoma")
	AL_SetColumnLongProperty (xALP_SubEvals;-2;ALP_Column_HdrStyleF;Plain:K14:1)
	AL_SetColumnLongProperty (xALP_SubEvals;-2;ALP_Column_HdrSize;9)
	AL_SetColumnTextProperty (xALP_SubEvals;-2;ALP_Column_FontName;"Tahoma")
	AL_SetColumnLongProperty (xALP_SubEvals;-2;ALP_Column_StyleF;Plain:K14:1)
	AL_SetColumnLongProperty (xALP_SubEvals;-2;ALP_Column_Size;9)
	AL_SetColumnLongProperty (xALP_SubEvals;-2;ALP_Column_CalcHeight;1)
	AL_SetColumnRealProperty (xALP_SubEvals;-2;ALP_Column_HdrRotation;90)
	
	For ($i_columna;20;31)
		$l_ErrorALP:=$l_ErrorALP+AL_SetArraysNam (xALP_SubEvals;$i_columna;1;aRealSubEvalArrNames{$i_columna-19})
	End for 
	$l_ErrorALP:=$l_ErrorALP+AL_SetArraysNam (xALP_SubEvals;32;1;"aRealSubEvalP1")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;33;1;"aRealSubEvalControles")
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;34;1;"aRealSubEvalPresentacion")
	
	$l_ErrorALP:=AL_SetArraysNam (xALP_SubEvals;35;1;"aSubEvalSex")
	
	  //column 1 settings
	AL_SetHeaders (xALP_SubEvals;1;1;__ ("Nº"))
	AL_SetWidths (xALP_SubEvals;1;1;20)
	AL_SetFormat (xALP_SubEvals;1;"##";2;0;0;0)
	  //AL_SetHdrStyle (xALP_SubEvals;1;"Tahoma";9;1)
	  //AL_SetFtrStyle (xALP_SubEvals;1;"Tahoma";9;0)
	AL_SetStyle (xALP_SubEvals;1;"Tahoma";9;0)
	  //AL_SetForeColor (xALP_SubEvals;1;"Black";0;"Black";0;"Black";0)
	  //AL_SetBackColor (xALP_SubEvals;1;"White";0;"";(16*13)+1;"White";0)
	AL_SetEnterable (xALP_SubEvals;1;0)
	  //MONO Ticket 186325
	AL_SetColumnRealProperty (xALP_SubEvals;1;ALP_Column_HdrRotation;0)
	AL_SetColumnLongProperty (xALP_SubEvals;1;ALP_Column_HdrVertAlign;2)
	
	  //column 2 settings
	AL_SetHeaders (xALP_SubEvals;2;1;__ ("Alumno"))
	AL_SetWidths (xALP_SubEvals;2;1;$l_anchoColumnaAlumnos)
	AL_SetFormat (xALP_SubEvals;2;"";0;0;0;0)
	  //AL_SetHdrStyle (xALP_SubEvals;2;"Tahoma";9;1)
	  //AL_SetFtrStyle (xALP_SubEvals;2;"Tahoma";9;0)
	AL_SetStyle (xALP_SubEvals;2;"Tahoma";9;0)
	  //AL_SetForeColor (xALP_SubEvals;2;"Black";0;"Black";0;"Black";0)
	  //AL_SetBackColor (xALP_SubEvals;2;"White";0;"";(16*13)+1;"White";0)
	AL_SetEnterable (xALP_SubEvals;2;0)
	AL_SetColumnRealProperty (xALP_SubEvals;2;ALP_Column_HdrRotation;0)
	AL_SetColumnLongProperty (xALP_SubEvals;2;ALP_Column_HdrVertAlign;2)
	
	  //column 3 settings
	AL_SetHeaders (xALP_SubEvals;3;1;__ ("Curso"))
	AL_SetWidths (xALP_SubEvals;3;1;$l_anchoColumnaCurso)
	AL_SetFormat (xALP_SubEvals;3;"";2;0;0;0)
	  //AL_SetHdrStyle (xALP_SubEvals;3;"Tahoma";9;1)
	  //AL_SetFtrStyle (xALP_SubEvals;3;"Tahoma";9;0)
	AL_SetStyle (xALP_SubEvals;3;"Tahoma";9;0)
	  //AL_SetForeColor (xALP_SubEvals;3;"Black";0;"Black";0;"Black";0)
	  //AL_SetBackColor (xALP_SubEvals;3;"White";0;"";(16*13)+1;"White";0)
	AL_SetEnterable (xALP_SubEvals;3;0)
	AL_SetColumnRealProperty (xALP_SubEvals;3;ALP_Column_HdrRotation;0)
	AL_SetColumnLongProperty (xALP_SubEvals;3;ALP_Column_HdrVertAlign;2)
	
	  //column 4 settings
	AL_SetWidths (xALP_SubEvals;4;1;40)
	AL_SetFormat (xALP_SubEvals;4;"";2;0;0;0)
	AL_SetHeaders (xALP_SubEvals;4;1;__ ("Prom."))
	  //AL_SetHdrStyle (xALP_SubEvals;4;"Tahoma";9;1)
	  //AL_SetFtrStyle (xALP_SubEvals;4;"Tahoma";9;0)
	AL_SetStyle (xALP_SubEvals;4;"Tahoma";9;2)
	  //AL_SetForeColor (xALP_SubEvals;4;"Black";0;"Black";0;"Black";0)
	  //AL_SetBackColor (xALP_SubEvals;4;"White";0;"";(16*9)+1;"White";0)
	AL_SetEnterable (xALP_SubEvals;4;0)
	AL_SetColumnRealProperty (xALP_SubEvals;4;ALP_Column_HdrRotation;0)
	AL_SetColumnLongProperty (xALP_SubEvals;4;ALP_Column_HdrVertAlign;2)
	
	  //column 5 settings
	AL_SetWidths (xALP_SubEvals;5;1;$l_anchoColumnaControles)
	AL_SetHeaders (xALP_SubEvals;5;1;__ ("Control"))
	AL_SetFormat (xALP_SubEvals;5;"";2;0;0;0)
	  //AL_SetHdrStyle (xALP_SubEvals;5;"Tahoma";9;1)
	  //AL_SetFtrStyle (xALP_SubEvals;5;"Tahoma";9;0)
	AL_SetStyle (xALP_SubEvals;5;"Tahoma";9;2)
	  //AL_SetForeColor (xALP_SubEvals;5;"Black";0;"Black";0;"Black";0)
	  //AL_SetBackColor (xALP_SubEvals;5;"White";0;"";(16*9)+1;"White";0)
	AL_SetEntryCtls (xALP_SubEvals;5;$l_calificacionesEditables)
	AL_SetColumnRealProperty (xALP_SubEvals;5;ALP_Column_HdrRotation;0)
	AL_SetColumnLongProperty (xALP_SubEvals;5;ALP_Column_HdrVertAlign;2)
	
	  //column 18  settings
	AL_SetHeaders (xALP_SubEvals;18;1;__ ("Status"))
	AL_SetFormat (xALP_SubEvals;18;"";0;0;0;0)
	  //AL_SetHdrStyle (xALP_SubEvals;18;"Tahoma";9;1)
	  //AL_SetFtrStyle (xALP_SubEvals;18;"Tahoma";9;0)
	AL_SetStyle (xALP_SubEvals;18;"Tahoma";9;0)
	  //AL_SetForeColor (xALP_SubEvals;18;"Black";0;"Black";0;"Black";0)
	  //AL_SetBackColor (xALP_SubEvals;18;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_SubEvals;18;0)
	AL_SetEntryCtls (xALP_SubEvals;18;0)
	
	  //column 19 settings
	AL_SetHeaders (xALP_SubEvals;19;1;"ID alumno")
	AL_SetFormat (xALP_SubEvals;19;"";0;0;0;0)
	  //AL_SetHdrStyle (xALP_SubEvals;19;"Tahoma";9;1)
	  //AL_SetFtrStyle (xALP_SubEvals;19;"Tahoma";9;0)
	AL_SetStyle (xALP_SubEvals;19;"Tahoma";9;0)
	  //AL_SetForeColor (xALP_SubEvals;19;"Black";0;"Black";0;"Black";0)
	  //AL_SetBackColor (xALP_SubEvals;19;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_SubEvals;19;0)
	AL_SetEntryCtls (xALP_SubEvals;19;0)
	
	AL_SetRowOpts (xALP_SubEvals;0;1;0;0;1;0)
	AL_SetCellOpts (xALP_SubEvals;0;1;1)
	AL_SetMiscOpts (xALP_SubEvals;0;0;"\\";0;1)
	AL_SetMiscColor (xALP_SubEvals;0;"White";0)
	AL_SetMiscColor (xALP_SubEvals;1;"White";0)
	AL_SetMiscColor (xALP_SubEvals;2;"White";0)
	AL_SetMiscColor (xALP_SubEvals;3;"White";0)
	AL_SetMainCalls (xALP_SubEvals;"";"")
	AL_SetScroll (xALP_SubEvals;0;0)
	AL_SetCopyOpts (xALP_SubEvals;0;"\t";"\r";Char:C90(0))
	AL_SetSortOpts (xALP_SubEvals;0;1;0;"Ordenamiento:";0)
	AL_SetEntryOpts (xALP_SubEvals;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
	AL_SetCallbacks (xALP_SubEvals;"xALCB_EN_NotasSubasignaturas";"xALCB_EX_NotasSubasignaturas")
	AL_SetHeight (xALP_SubEvals;1;1;1;1;2)
	AL_SetDividers (xALP_SubEvals;"Black";"Gray";0;"Black";"Light Gray";0)
	AL_SetColLock (xALP_SubEvals;4)
	AL_SetDrgOpts (xALP_SubEvals;0;30;0)
	
	  //dragging options
	AL_SetDrgSrc (xALP_SubEvals;1;"";"";"")
	AL_SetDrgSrc (xALP_SubEvals;2;"";"";"")
	AL_SetDrgSrc (xALP_SubEvals;3;"";"";"")
	AL_SetDrgDst (xALP_SubEvals;1;"";"";"")
	AL_SetDrgDst (xALP_SubEvals;1;"";"";"")
	AL_SetDrgDst (xALP_SubEvals;1;"";"";"")
	
	  //ALP_SetDefaultAppareance (xALP_SubEvals;0;0;8;1;8)
	  //ALP_SetAlternateLigneColor (xALP_SubEvals;Size of array(aSubEvalOrden))
	
	
	  //hidding cols
	If ([xxSTR_Subasignaturas:83]ModoControles:5=0)
		AL_RemoveArrays (xALP_SubEvals;5;1)
	End if 
	If (Not:C34([Asignaturas:18]Seleccion:17))
		AL_RemoveArrays (xALP_SubEvals;3;1)
		AL_SetColLock (xALP_SubEvals;3)
	Else 
		AL_SetColLock (xALP_SubEvals;4)
	End if 
	
	AL_SetFooters (xALP_SubEvals;2;1;"Promedios")
	  //AL_SetFtrStyle (xALP_SubEvals;0;"Tahoma";9;1)
	
	
	AL_UpdateArrays (xALP_SubEvals;-2)
	
	
	
	$l_ErrorALP:=AL_GetArrayNames (xALP_SubEvals;$aArrayNames)
	$l_columnaNoLista:=Find in array:C230($aArrayNames;"aSubEvalOrden")
	$l_columnaNombres:=Find in array:C230($aArrayNames;"aSubEvalStdNme")
	$l_columnaCurso:=Find in array:C230($aArrayNames;"aSubEvalCurso")
	$l_columnaSexo:=Find in array:C230($aArrayNames;"aSubEvalSex")
	
	$l_columnaParciales:=Find in array:C230($aArrayNames;"aSubEval1")
	For ($i_columna;$l_columnaParciales;$l_columnaParciales+11)
		AL_SetCellLongProperty (xALP_SubEvals;0;$i_columna;ALP_Cell_RightIconID;Choose:C955($l_calificacionesEditables=1;$l_iconoEditable;$l_iconoNoEditable))
		AL_SetWidths (xALP_SubEvals;$i_columna;1;$l_anchoColumna)
		AL_SetFormat (xALP_SubEvals;$i_columna;"";2;0;0;0)
		  //AL_SetHdrStyle (xALP_SubEvals;$i_columna;"Tahoma";9;1)
		  //AL_SetFtrStyle (xALP_SubEvals;$i_columna;"Tahoma";9;0)
		AL_SetStyle (xALP_SubEvals;$i_columna;"Tahoma";9;0)
		  //AL_SetForeColor (xALP_SubEvals;$i_columna;"Black";0;"Black";0;"Black";0)
		  //AL_SetBackColor (xALP_SubEvals;$i_columna;"White";0;"White";0;"White";0)
		AL_SetEnterable (xALP_SubEvals;$i_columna;$l_calificacionesEditables)
		AL_SetEntryCtls (xALP_SubEvals;$i_columna;0)
		$t_encabezado:=aSubEvalNombreParciales{$i_columna-($l_columnaParciales-1)}
		AL_SetColumnTextProperty (xALP_SubEvals;$i_columna;ALP_Column_HeaderText;$t_encabezado)
		  //AL_SetHeaders (xALP_SubEvals;$i_columna;1;String($i_columna-3))
	End for 
	
	  // 20181008 Patricio Aliaga Ticket N° 204363
	C_OBJECT:C1216($o_obj;$o_in)
	OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
	$o_obj:=STR_ordenNominas ("query";$o_in)
	Case of 
		: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
			If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
				$l_columnaSexo:=$l_columnaSexo*-1
			End if 
			Case of 
				: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
					AL_SetSort (xALP_SubEvals;$l_columnaSexo;$l_columnaNoLista)
				: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
					If ($l_columnaCurso>0)
						AL_SetSort (xALP_SubEvals;$l_columnaSexo;$l_columnaCurso;$l_columnaNombres)
					Else 
						AL_SetSort (xALP_SubEvals;$l_columnaSexo;$l_columnaNombres)
					End if 
				: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
					AL_SetSort (xALP_SubEvals;$l_columnaSexo;$l_columnaNombres)
			End case 
		: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
			AL_SetSort (xALP_SubEvals;$l_columnaNoLista)
		: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
			If ($l_columnaCurso>0)
				AL_SetSort (xALP_SubEvals;$l_columnaCurso;$l_columnaNombres)
			Else 
				AL_SetSort (xALP_SubEvals;$l_columnaNombres)
			End if 
		: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
			AL_SetSort (xALP_SubEvals;$l_columnaNombres)
	End case 
	  //If (<>viSTR_AgruparPorSexo=0)
	  //Case of 
	  //: (<>gOrdenNta=0)
	  //If ($l_columnaCurso>0)
	  //AL_SetSort (xALP_SubEvals;$l_columnaCurso;$l_columnaNombres)
	  //Else 
	  //AL_SetSort (xALP_SubEvals;$l_columnaNombres)
	  //End if 
	  //: (<>gOrdenNta=1)
	  //AL_SetSort (xALP_SubEvals;$l_columnaNoLista)
	  //: (<>gOrdenNta=2)
	  //AL_SetSort (xALP_SubEvals;$l_columnaNombres)
	  //End case 
	  //Else 
	  //Case of 
	  //: (<>gOrdenNta=0)
	  //If ($l_columnaCurso>0)
	  //AL_SetSort (xALP_SubEvals;-$l_columnaSexo;$l_columnaCurso;$l_columnaNombres)
	  //Else 
	  //AL_SetSort (xALP_SubEvals;-$l_columnaSexo;$l_columnaNombres)
	  //End if 
	  //: (<>gOrdenNta=1)
	  //AL_SetSort (xALP_SubEvals;-$l_columnaSexo;$l_columnaNoLista)
	  //: (<>gOrdenNta=2)
	  //AL_SetSort (xALP_SubEvals;-$l_columnaSexo;$l_columnaNombres)
	  //End case 
	  //End if 
	ASsev_SetColors 
	AL_SetColOpts (xALP_SubEvals;0;0;0;18)
End if 
