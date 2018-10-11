  //Modificado por AS 23/08/2010 13:04

C_LONGINT:C283($rubOfst)
Case of 
	: (Form event:C388=On Header:K2:17)
		If ([Asignaturas:18]Seleccion:17=False:C215)
			vHeader:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
		Else 
			vHeader:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Nivel:30+" "+[Asignaturas:18]Curso:5
		End if 
		RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
		vTeacher:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
		dDate:=Current date:C33(*)
		vt_periodo:=atSTR_Periodos_Nombre{nperiodo}+" - "+String:C10(<>gYear)
		
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($i;$j)
		AS_InitStats 
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		
		Case of 
			: (iSelectedPrintMode=Notas)
				$colFormat:=vs_GradesFormat
			: (iSelectedPrintMode=Puntos)
				$colFormat:=vs_pointsFormat
			: (iSelectedPrintMode=Porcentaje)
				$colFormat:=vs_PercentFormat
		End case 
		  //******
		
		Case of 
			: (nperiodo=1)
				$crtPeriodArrName:="aNtaP1"
				$crtPeriodHeader:="P1"
			: (nperiodo=2)
				$crtPeriodArrName:="aNtaP2"
				$crtPeriodHeader:="P2"
			: (nperiodo=3)
				$crtPeriodArrName:="aNtaP3"
				$crtPeriodHeader:="P3"
			: (nperiodo=4)
				$crtPeriodArrName:="aNtaP4"
				$crtPeriodHeader:="P4"
		End case 
		sP1:=String:C10([Asignaturas:18]Promedio_P1:23)
		sP2:=String:C10([Asignaturas:18]Promedio_P2:22)
		sP3:=String:C10([Asignaturas:18]Promedio_P3:21)
		sP4:=String:C10([Asignaturas:18]Promedio_P4:59)
		sPF:=String:C10([Asignaturas:18]Promedio_final:20)
		sEX:=String:C10([Asignaturas:18]Examen:19)
		sNF:=String:C10([Asignaturas:18]Nota_final:18)
		
		
		EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;nperiodo)
		
		For ($k;1;Size of array:C274(aNtaStrArrPointers))
			NTA_PercentArray2StrGradeArray (aNtaRealArrPointers{$k};aNtaStrArrPointers{$k};iSelectedPrintMode)
		End for 
		
		  //*******
		
		
		AS_InitStats 
		
		For ($i;1;12)
			$pNota:=Get pointer:C304("aRealNta"+String:C10($i))  //pointeur sur le tableau contenant les notes
			$pStat:=Get pointer:C304("◊aStat"+String:C10($i))
			fStatistiques3 ($pNota)
			For ($j;1;7)
				$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
			End for 
		End for 
		If (vr_CTRL_PonderacionConstante>0)
			$pStat:=-><>aStatEP
			fStatistiques3 (->aRealNtaExP)
			For ($j;1;7)
				$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
			End for 
		End if 
		
		$pStat:=-><>aStatP1
		<>RealCrtPerPtr:=Get pointer:C304("aRealNtaP"+String:C10(nperiodo))
		fStatistiques3 (<>RealCrtPerPtr)
		For ($j;1;7)
			$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
		End for 
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
		
		Case of 
			: (vt_PLConfigMessage="byName")
				SORT ARRAY:C229(aNtaStdNme;aNtaCurso;aNtaOrden;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaPF;aNtaEx;aNtaF;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaExP;>)
			: (vt_PLConfigMessage="ByNumber")
				SORT ARRAY:C229(aNtaOrden;aNtaStdNme;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaPF;aNtaEx;aNtaF;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaExP;>)
			: (vt_PLConfigMessage="byClass")
				AT_MultiLevelSort (">>";->aNtaCurso;->aNtaStdNme;->aNtaOrden;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaExP;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaPF;->aNtaEx;->aNtaF)
		End case 
		
		
		
		
		If (iSelectedPrintMode>1)
			$fontsize:=6
		Else 
			$fontSize:=7
		End if 
		If ((iSelectedPrintMode=Simbolos) | (iSelectedPrintMode=4))
			$statFormat:="##0,00%"
		Else 
			$statFormat:="##0,00"
		End if 
		$cols:=[Asignaturas:18]Numero_de_evaluaciones:38+Num:C11(vr_CTRL_PonderacionConstante>0)+4
		$w:=Int:C8(400/$cols)
		$delta:=370-($cols*$w)
		$clW:=33
		$stdW:=150+$delta
		$err:=PL_SetArraysNam (xPL_List;1;3;"aNtaOrden";"aNtaStdNme";"aNtaCurso")
		PL_SetFormat (xPL_list;1;"###0";0;2)
		PL_SetHeight (xPL_List;1;1;0;4)
		
		
		  // Modificado por: Alexis Bustamante (17-07-2017)
		  //TICKET 185272.
		PL_SetWidths (xPL_List;1;3;15;$stdW;$clW)
		  //PL_SetWidths (xPL_List;1;3;20;$stdW;$clW)
		
		PL_SetHeaders (xPL_List;1;3;"Nº";"Alumno";"Curso")
		PL_SetStyle (xPL_List;0;"Arial";$fontsize;0)
		PL_SetStyle (xPL_list;1;"Arial";$fontsize;0)
		PL_SetFormat (xPL_list;1;"###";0;0)
		PL_SetStyle (xPL_list;2;"Arial";$fontsize;0)
		PL_SetStyle (xPL_list;3;"Arial";$fontsize;0)
		For ($i;1;12)
			$err:=PL_SetArraysNam (xpl_list;$i+3;1;aNtaArrNames{$i})
			PL_SetWidths (xPL_List;$i+3;1;$w)
			PL_SetStyle (xPL_list;$i+3;"Arial";$fontsize;0)
			PL_SetHeaders (xPL_List;$i+3;1;String:C10($i);"Curso")
		End for 
		If (vr_CTRL_PonderacionConstante>0)
			$err:=PL_SetArraysNam (xpl_list;$i+3;1;"aNtaExP")
			PL_SetWidths (xPL_List;$i+3;1;$w)
			PL_SetStyle (xPL_list;$i+3;"Arial";$fontsize;2)
			PL_SetHeaders (xPL_List;$i+3;1;"CP")
			$i:=$i+1
		End if 
		$err:=PL_SetArraysNam (xpl_list;$i+3;4;$crtPeriodArrName;"aNtaPF";"aNtaEx";"aNtaF")
		PL_SetHeaders (xPL_List;$i+3;4;$crtPeriodHeader;"PF";"EX";"NF")
		PL_SetWidths (xPL_List;$i+3;4;$w;$w;$w;$w)
		PL_SetStyle (xPL_list;$i+3;"Arial";$fontsize;1)
		PL_SetStyle (xPL_list;$i+4;"Arial";$fontsize;1)
		PL_SetStyle (xPL_list;$i+5;"Arial";$fontsize;1)
		PL_SetStyle (xPL_list;$i+6;"Arial";$fontsize;1)
		PL_SetBrkRowDiv (xPL_List;25;"Black";"Black";0)
		PL_SetBrkRowDiv (xPL_List;25;"Black";"Black";0)
		PL_SetBrkHeight (xPL_List;0;9;1)
		
		$titres:=AT_array2text (-><>aStatItems;Char:C90(Carriage return:K15:38))
		$titres:=$titres+"\r%Aprobados"
		
		PL_SetBrkText (xPL_List;0;2;$titres;0)
		PL_SetBrkColOpt (xPL_List;0;3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;2;"Arial";6;0)
		For ($i;1;[Asignaturas:18]Numero_de_evaluaciones:38)
			$pStat:=Get pointer:C304("◊aStat"+String:C10($i))
			$text:=""
			For ($j;1;Size of array:C274($pStat->)-1)
				If ($pStat->{$j}>0)
					  //$text:=$text+String($pStat->{$j};"##0,00")+Char(carriage return)
					$text:=$text+String:C10($pStat->{$j};$statFormat)+Char:C90(Carriage return:K15:38)
				Else 
					$text:=$text+Char:C90(Carriage return:K15:38)
				End if 
			End for 
			$text:=$text+String:C10($pStat->{7};"##")
			PL_SetBrkText (xPL_List;0;$i+3;$text;0)
			PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
			PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;0)
		End for 
		
		If (vr_CTRL_PonderacionConstante>0)
			$text:=""
			For ($j;1;Size of array:C274(<>aStatEP)-1)
				If (<>aStatEP{$j}>0)
					$text:=$text+String:C10(<>aStatEP{$j};$statFormat)+Char:C90(Carriage return:K15:38)
				Else 
					$text:=$text+Char:C90(Carriage return:K15:38)
				End if 
			End for 
			$text:=$text+String:C10(<>aStatEP{7};"##")
			PL_SetBrkText (xPL_List;0;$i+3;$text;0)
			PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
			PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;2)
			$i:=$i+1
		End if 
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatP1)-1)
			If (<>aStatP1{$j}>0)
				$text:=$text+String:C10(<>aStatP1{$j};$statFormat)+Char:C90(Carriage return:K15:38)
			Else 
				$text:=$text+Char:C90(Carriage return:K15:38)
			End if 
		End for 
		$text:=$text+String:C10(<>aStatP1{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatPF)-1)
			If (<>aStatPF{$j}>0)
				$text:=$text+String:C10(<>aStatPF{$j};$statFormat)+Char:C90(Carriage return:K15:38)
			Else 
				$text:=$text+Char:C90(Carriage return:K15:38)
			End if 
		End for 
		$text:=$text+String:C10(<>aStatPF{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatEX)-1)
			If (<>aStatEX{$j}>0)
				$text:=$text+String:C10(<>aStatEX{$j};$statFormat)+Char:C90(Carriage return:K15:38)
			Else 
				$text:=$text+Char:C90(Carriage return:K15:38)
			End if 
		End for 
		$text:=$text+String:C10(<>aStatEX{7};"##")
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;0)
		$i:=$i+1
		
		$text:=""
		For ($j;1;Size of array:C274(<>aStatNF)-1)
			If (<>aStatNF{$j}>0)
				$text:=$text+String:C10(<>aStatNF{$j};$statFormat)+Char:C90(Carriage return:K15:38)
			Else 
				$text:=$text+Char:C90(Carriage return:K15:38)
			End if 
		End for 
		$text:=$text+String:C10(<>aStatNF{7};"##")+Char:C90(Carriage return:K15:38)
		$text:=$text+String:C10([Asignaturas:18]PorcentajeAprobados:103;"##0,0")
		
		
		
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;0)
		
		PL_SetBrkRowDiv (xPL_List;2;"Black";"Black";0)
		PL_SetHdrOpts (xPL_List;2)
		PL_SetHdrStyle (xPL_List;0;"Arial";$fontsize;1)
		PL_SetDividers (xPL_List;5;"Black";"Black";0;5;"Black";"Black";0)
		PL_SetFrame (xPL_List;5;"Black";"Black";0;5;"Black";"Black";0)
End case 

