If (Form event:C388=On Load:K2:1)
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	  //SELECTION TO ARRAY([Alumnos_Calificaciones]NoDeLista;aInt1;[Alumnos]Apellidos_y_Nombres;aText1;[Alumnos]Curso;aText2;[Alumnos]Status;aText4)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NoDeLista:10;aInt1;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]curso:20;aText2;[Alumnos:2]RUT:5;aText3;[Alumnos:2]Status:50;aText4)
	iTotal:=Size of array:C274(aInt1)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	
	Case of 
		: (vt_PLConfigMessage="byName")
			SORT ARRAY:C229(aText1;aText2;aText4;aInt1;>)
		: (vt_PLConfigMessage="ByNumber")
			SORT ARRAY:C229(aInt1;aText1;aText2;aText4;>)
		: (vt_PLConfigMessage="byClass")
			AT_MultiLevelSort (">>";->aText2;->aText1;->aInt1;->aText4)
			  //psv  --- nomina por curso con horario
		: (vt_PLConfigMessage="byClass w/TimeTable")
			  //AT_MultiLevelSort (">>";->aText2;->aText1;->aInt1;->aText4)
			AT_MultiLevelSort (">>";->aText2;->aText1;->aInt1;->aText3;->aText4)
			
	End case 
	
	  //$err:=PL_SetArraysNam (xPL_List;1;4;"aInt1";"aText2";"aText1";"aText4")
	$err:=PL_SetArraysNam (xPL_List;1;4;"aInt1";"aText2";"aText1";"aText3";"aText4")
	
	For ($i;1;Size of array:C274(aText1))
		If (aText3{$i}#"")
			aText3{$i}:=SR_FormatoRUT2 (aText3{$i})
		End if 
	End for 
	
	For ($i;1;Size of array:C274(aText1))
		If (aText4{$i}="Retirado@")
			PL_SetRowStyle (xPL_List;$i;2;"Tahoma";10)
		Else 
			aText4{$i}:=""
		End if 
	End for 
	
	Case of 
		: (vt_PLConfigMessage="byName")
			  // PL_SetSort (xPL_List;3)
		: (vt_PLConfigMessage="ByNumber")
			  //PL_SetSort (xPL_List;1)
		: (vt_PLConfigMessage="byClass")
			  //PL_SetSort (xPL_List;2;3)
			PL_SetRepeatVal (xPL_List;2;1)
			PL_SetBrkRowDiv (xPL_List;0.25;"Black";"Black";0)
			PL_SetBrkHeight (xPL_List;1;1;1)
			PL_SetBrkText (xPL_List;1;1;" ";3)
			PL_SetBrkColOpt (xPL_List;1;0;0;1;"Black";"Black";0)
			PL_SetBrkStyle (xPL_List;1;0;"Tahoma";9;1)
			PL_SetFormat (xPL_List;1;"###";0)
		: (vt_PLConfigMessage="byClass w/TimeTable")
			PL_SetRepeatVal (xPL_List;2;1)
			PL_SetBrkRowDiv (xPL_List;0.25;"Black";"Black";0)
			PL_SetBrkHeight (xPL_List;1;1;1)
			PL_SetBrkText (xPL_List;1;1;" ";3)
			PL_SetBrkColOpt (xPL_List;1;0;0;1;"Black";"Black";0)
			PL_SetBrkStyle (xPL_List;1;0;"Tahoma";9;1)
			PL_SetFormat (xPL_List;1;"###";0)
	End case 
	
	  //PL_SetWidths (xPL_List;1;3;20;60;470)
	PL_SetWidths (xPL_List;1;4;20;60;390;80)
	PL_SetHdrOpts (xPL_List;2)
	PL_SetHeight (xPL_List;1;1;0;0)
	PL_SetHdrStyle (xPL_List;0;"Geneva";9;1)
	PL_SetStyle (xPL_List;0;"Tahoma";9;0)
	PL_SetHeaders (xPL_List;1;4;"Nº";"Curso";"Alumno";"Rut")
	PL_SetFormat (xPL_List;1;"###0";0)
	PL_SetDividers (xPL_List;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_List;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
End if 







