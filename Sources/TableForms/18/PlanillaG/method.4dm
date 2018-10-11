<>ST_v461:=False:C215  //10/8/98 at 08:51:18 by: Alberto Bachler
  //implementación de bimestres

Case of 
	: (Form event:C388=On Header:K2:17)
		dDate:=Current date:C33
		If ([Asignaturas:18]Seleccion:17=False:C215)
			vHeader:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
		Else 
			vHeader:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Nivel:30+" "+[Asignaturas:18]Curso:5
		End if 
		RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
		vTeacher:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
		
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($i;$j)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		AS_InitStats 
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		AS_InitReport 
		ARRAY POINTER:C280(<>aNtaFldPtr;[Asignaturas:18]Numero_de_evaluaciones:38)
		ARRAY POINTER:C280(<>aNtaArrPtr;[Asignaturas:18]Numero_de_evaluaciones:38)
		
		RELATE MANY:C262([Asignaturas:18]Numero:1)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aNo;[Alumnos:2]apellidos_y_nombres:40;$aStdWhNme)
		EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;0;->iSelectedPrintMode)
		
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		
		
		For ($i;1;Size of array:C274(aNtaIDAlumno))
			$el:=Find in array:C230($aNo;aNtaIDAlumno{$i})
			If ($el>0)
				aNtaStdNme{$i}:=$aStdWhNme{$el}
			End if 
		End for 
		
		If (iSelectedPrintMode=1)
			iSelectedPrintMode:=iPrintMode
		Else 
			iSelectedPrintMode:=iSelectedPrintMode-2
		End if 
		Case of 
			: (iSelectedPrintMode=Notas)
				$colFormat:=vs_GradesFormat
			: (iSelectedPrintMode=Puntos)
				$colFormat:=vs_pointsFormat
			: (iSelectedPrintMode=Porcentaje)
				$colFormat:=vs_PercentFormat
		End case 
		
		If ((iSelectedPrintMode=Simbolos) | (iSelectedPrintMode=4))
			$statFormat:="##0"+<>tXS_RS_DecimalSeparator+"00%"
		Else 
			$statFormat:="##0"+<>tXS_RS_DecimalSeparator+"00"
		End if 
		
		TRACE:C157
		  //Calculs statistiques
		$pStat:=-><>aStatP1
		fStatistiques3 (->aRealNtaP1)
		For ($j;1;7)
			$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
		End for 
		If (viSTR_Periodos_NumeroPeriodos>=2)
			$pStat:=-><>aStatP2
			fStatistiques3 (->aREalNtaP2)
			For ($j;1;7)
				$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
			End for 
		End if 
		If (viSTR_Periodos_NumeroPeriodos>=3)
			$pStat:=-><>aStatP3
			fStatistiques3 (->aRealNtaP3)
			For ($j;1;7)
				$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
			End for 
		End if 
		If (viSTR_Periodos_NumeroPeriodos>=4)
			$pStat:=-><>aStatP4
			fStatistiques3 (->aRealNtaP4)
			For ($j;1;7)
				$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
			End for 
		End if 
		$pStat:=-><>aStatPF
		fStatistiques3 (->aRealNtaPF)
		For ($j;1;7)
			$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
		End for 
		$pStat:=-><>aStatEX
		fStatistiques3 (->aRealNtaEX)
		For ($j;1;7)
			$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
		End for 
		$pStat:=-><>aStatNF
		fStatistiques3 (->aRealNtaF)
		For ($j;1;7)
			$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
		End for 
		  //fin de calculs statistiques
		$colFormat:=""
		
		
		Case of 
			: (vt_PLConfigMessage="byName")
				SORT ARRAY:C229(aNtaStdNme;aNtaCurso;aNtaOrden;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaPF;aNtaEx;aNtaF;>)
			: (vt_PLConfigMessage="ByNumber")
				SORT ARRAY:C229(aNtaOrden;aNtaStdNme;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaPF;aNtaEx;aNtaF;>)
			: (vt_PLConfigMessage="byClass")
				AT_MultiLevelSort (">>";->aNtaCurso;->aNtaStdNme;->aNtaOrden;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaPF;->aNtaEx;->aNtaF)
		End case 
		
		
		
		$err:=PL_SetArraysNam (xPL_List;1;3;"aNtaOrden";"aNtaStdNme";"aNtaCurso")
		PL_SetWidths (xPL_List;1;3;20;175;45)
		PL_SetHeaders (xPL_List;1;3;"Nº";"Alumno";"Curso")
		PL_SetStyle (xPL_List;0;"Geneva";7;0)
		  //  PL_SetStyle (xPL_list;1;"Geneva";7;0)
		  //    PL_SetStyle (xPL_list;2;"Geneva";7;0)
		  //    PL_SetStyle (xPL_list;3;"Geneva";7;0)  
		
		$err:=PL_SetArraysNam (xpl_list;4;7;"aNtaP1";"aNtaP2";"aNtaP3";"aNtaP4";"aNtaPF";"aNtaEx";"aNtaF")
		Case of 
			: (Size of array:C274(atSTR_Periodos_Nombre)=4)
				PL_SetHeaders (xPL_List;4;7;"B1.";"B2";"B3";"B4";"Promedio";"Examen";"Nota final")
			: (Size of array:C274(atSTR_Periodos_Nombre)=3)
				PL_SetHeaders (xPL_List;4;7;"T1";"T2";"T3";"";"Promedio";"Examen";"Nota final")
			: (Size of array:C274(atSTR_Periodos_Nombre)=2)
				PL_SetHeaders (xPL_List;4;7;"S1";"S2";"";"";"Promedio";"Examen";"Nota final")
		End case 
		PL_SetWidths (xPL_List;4;7;30;30;30;30;60;60;60)
		PL_SetHeight (xPL_List;1;1;0;2)
		PL_SetFormat (xPL_list;1;"###0";0;2)
		PL_SetFormat (xPL_list;2;"";0;2)
		PL_SetFormat (xPL_list;3;"";0;2)
		PL_SetFormat (xPL_list;4;$colFormat;2;2)
		PL_SetFormat (xPL_list;5;$colFormat;2;2)
		PL_SetFormat (xPL_list;6;$colFormat;2;2)
		PL_SetFormat (xPL_list;7;$colFormat;2;2)
		PL_SetFormat (xPL_list;8;$colFormat;2;2)
		PL_SetFormat (xPL_list;9;$colFormat;2;2)
		PL_SetFormat (xPL_list;10;$colFormat;2;2)
		PL_SetBrkRowDiv (xPL_List;25;"Black";"Black";0)
		PL_SetBrkRowDiv (xPL_List;25;"Black";"Black";0)
		PL_SetBrkHeight (xPL_List;0;9;1)
		
		$titres:=AT_array2text (-><>aStatItems;"\r")
		$titres:=$titres+"\r%Aprobados"
		
		PL_SetBrkText (xPL_List;0;2;$titres;0)
		PL_SetBrkColOpt (xPL_List;0;3;1)
		PL_SetBrkStyle (xPL_List;0;2;"Geneva";7;1)
		
		$i:=1
		$text:=""
		For ($j;1;Size of array:C274(<>aStatP1)-1)
			If (<>aStatP1{$j}>0)
				$text:=$text+String:C10(<>aStatP1{$j};$statFormat)+"\r"
			Else 
				$text:=$text+"\r"
			End if 
		End for 
		$text:=$text+String:C10(<>aStatP1{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Geneva";7;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatP2)-1)
			If (<>aStatP2{$j}>0)
				$text:=$text+String:C10(<>aStatP2{$j};$statFormat)+"\r"
			Else 
				$text:=$text+"\r"
			End if 
		End for 
		$text:=$text+String:C10(<>aStatP2{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Geneva";7;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatP3)-1)
			If (<>aStatP3{$j}>0)
				$text:=$text+String:C10(<>aStatP3{$j};$statFormat)+"\r"
			Else 
				$text:=$text+"\r"
			End if 
		End for 
		$text:=$text+String:C10(<>aStatP3{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Geneva";7;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatP4)-1)
			If (<>aStatP4{$j}>0)
				$text:=$text+String:C10(<>aStatP4{$j};$statFormat)+"\r"
			Else 
				$text:=$text+"\r"
			End if 
		End for 
		$text:=$text+String:C10(<>aStatP4{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Geneva";7;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatPF)-1)
			If (<>aStatPF{$j}>0)
				$text:=$text+String:C10(<>aStatPF{$j};$statFormat)+"\r"
			Else 
				$text:=$text+"\r"
			End if 
		End for 
		$text:=$text+String:C10(<>aStatPF{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Geneva";7;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatEX)-1)
			If (<>aStatEX{$j}>0)
				$text:=$text+String:C10(<>aStatEX{$j};$statFormat)+"\r"
			Else 
				$text:=$text+"\r"
			End if 
		End for 
		$text:=$text+String:C10(<>aStatEX{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Geneva";7;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatNF)-1)
			If (<>aStatNF{$j}>0)
				$text:=$text+String:C10(<>aStatNF{$j};$statFormat)+"\r"
			Else 
				$text:=$text+"\r"
			End if 
		End for 
		$text:=$text+String:C10(<>aStatNF{7};"##")+"\r"
		$text:=$text+String:C10([Asignaturas:18]PorcentajeAprobados:103;"##0,0")
		
		
		
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Geneva";7;0)
		
		PL_SetBrkRowDiv (xPL_List;2;"Black";"Black";0)
		PL_SetHdrOpts (xPL_List;2)
		PL_SetHdrStyle (xPL_List;0;"Geneva";7;1)
		PL_SetDividers (xPL_List;5;"Black";"Black";0;5;"Black";"Black";0)
		PL_SetFrame (xPL_List;5;"Black";"Black";0;5;"Black";"Black";0)
		
		
		PL_SetStyle (xPL_List;0;"Geneva";7;0)
End case 

