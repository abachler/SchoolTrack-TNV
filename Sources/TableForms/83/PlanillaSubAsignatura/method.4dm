<>ST_v461:=False:C215  //10/8/98 at 08:51:18 by: Alberto Bachler
  //implementación de bimestres

Case of 
	: (Form event:C388=On Header:K2:17)
		dDate:=Current date:C33
		vHeader:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+"\r"+[xxSTR_Subasignaturas:83]Name:2
		RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
		vTeacher:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
		
	: (Form event:C388=On Load:K2:1)
		Case of 
			: (atSTR_Periodos_Nombre=1)
				$crtPeriodHeader:="P1"
			: (atSTR_Periodos_Nombre=2)
				$crtPeriodHeader:="P2"
			: (atSTR_Periodos_Nombre=3)
				$crtPeriodHeader:="P3"
			: (atSTR_Periodos_Nombre=4)
				$crtPeriodHeader:="P4"
		End case 
		vtPeriodo:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
		
		Case of 
			: (iPrintMode=Notas)
				$colFormat:=vs_GradesFormat
			: (iPrintMode=Puntos)
				$colFormat:=vs_pointsFormat
			: (iPrintMode=Porcentaje)
				$colFormat:=vs_PercentFormat
		End case 
		
		If ((iPrintMode=Simbolos) | (iPrintMode=4))
			$statFormat:="##0"+<>tXS_RS_DecimalSeparator+"00%"
		Else 
			$statFormat:="##0"+<>tXS_RS_DecimalSeparator+"00"
		End if 
		
		
		If (iPrintMode>1)
			$fontsize:=6
		Else 
			$fontSize:=7
		End if 
		
		  // Saúl Ponce 10.08.2015 - Ticket Nº 147004 El seteo de $statFormat es el de arriba
		  //If ((iPrintMode=Simbolos) | (iPrintMode=4))
		  //$statFormat:="##0,00%"
		  //Else 
		  //$statFormat:="##0,00"
		  //End if 
		
		AS_InitStats 
		
		For ($i;1;12)
			$pNota:=Get pointer:C304("aRealSubEval"+String:C10($i))  //pointeur sur le tableau contenant les notes
			$pStat:=Get pointer:C304("◊aStat"+String:C10($i))
			fStatistiques3 ($pNota)
			For ($j;1;7)
				$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
			End for 
		End for 
		If ([xxSTR_Subasignaturas:83]ModoControles:5>0)
			$pStat:=-><>aStatEP
			fStatistiques3 (->aRealSubEvalControles)
			For ($j;1;7)
				$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
			End for 
		End if 
		$pStat:=-><>aStatP1
		fStatistiques3 (->aRealSubEvalP1)
		For ($j;1;7)
			$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
		End for 
		
		
		$cols:=16+Num:C11([xxSTR_Subasignaturas:83]ModoControles:5>0)
		$w:=Int:C8(370/$cols)
		$delta:=370-($cols*$w)
		$clW:=33
		$stdW:=150+$delta
		  // Saúl Ponce 30.07.2015 - Ticket Nº 147004 
		  // El ancho de la primera columna quedaba más angosto de los que se necesitaba al cargar el array después de PL_SetWidths se solucionó
		  // sin alterar las demás columnas
		  //$err:=PL_SetArraysNam (xPL_List;1;3;"aSubEvalOrden";"aSubEvalStdNme";"aSubEvalCurso")
		PL_SetHeight (xPL_List;1;1;0;4)
		PL_SetWidths (xPL_List;1;3;12;$stdW;$clW)
		$err:=PL_SetArraysNam (xPL_List;1;3;"aSubEvalOrden";"aSubEvalStdNme";"aSubEvalCurso")
		PL_SetHeaders (xPL_List;1;3;"Nº";"Alumno";"Curso")
		PL_SetStyle (xPL_List;0;"Arial";$fontsize;0)
		PL_SetStyle (xPL_list;1;"Arial";$fontsize;0)
		  // Saúl Ponce 10.08.2015 - Ticket Nº 147004 Seteo formato para la primera columna evitando que añada un cero al final del número de lista
		PL_SetFormat (xPL_list;1;"###";0;2)
		PL_SetStyle (xPL_list;2;"Arial";$fontsize;0)
		PL_SetStyle (xPL_list;3;"Arial";$fontsize;0)
		For ($i;1;12)
			$arrayName:="aSubEval"+String:C10($i)
			$err:=PL_SetArraysNam (xpl_list;$i+3;1;$arrayName)
			PL_SetWidths (xPL_List;$i+3;1;$w)
			PL_SetStyle (xPL_list;$i+3;"Arial";$fontsize;0)
			PL_SetHeaders (xPL_List;$i+3;1;String:C10($i);"Curso")
		End for 
		If ([xxSTR_Subasignaturas:83]ModoControles:5>0)
			$err:=PL_SetArraysNam (xpl_list;$i+3;1;"aSubEvalP1")
			PL_SetWidths (xPL_List;$i+3;1;$w)
			PL_SetStyle (xPL_list;$i+3;"Arial";$fontsize;2)
			PL_SetHeaders (xPL_List;$i+3;1;"CP")
			$i:=$i+1
		End if 
		$err:=PL_SetArraysNam (xpl_list;$i+3;1;"aSubEvalP1")
		PL_SetHeaders (xPL_List;$i+3;4;$crtPeriodHeader)
		PL_SetWidths (xPL_List;$i+3;4;$w;$w;$w;$w)
		PL_SetStyle (xPL_list;$i+3;"Arial";$fontsize;1)
		PL_SetBrkRowDiv (xPL_List;0.25;"Black";"Black";0)
		PL_SetBrkRowDiv (xPL_List;0.25;"Black";"Black";0)
		PL_SetBrkHeight (xPL_List;0;9;1)
		
		$titres:=AT_array2text (-><>aStatItems;"\r")
		
		PL_SetBrkText (xPL_List;0;2;$titres;0)
		PL_SetBrkColOpt (xPL_List;0;3;1;0.5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;2;"Arial";6;0)
		For ($i;1;12)
			$pStat:=Get pointer:C304("◊aStat"+String:C10($i))
			$text:=""
			For ($j;1;Size of array:C274($pStat->)-1)
				If ($pStat->{$j}>0)
					  //$text:=$text+String($pStat->{$j};"##0,00")+<>cr
					$text:=$text+String:C10($pStat->{$j};$statFormat)+"\r"
				Else 
					$text:=$text+"\r"
				End if 
			End for 
			$text:=$text+String:C10($pStat->{7};"##")
			PL_SetBrkText (xPL_List;0;$i+3;$text;0)
			PL_SetBrkColOpt (xPL_List;0;$i+3;1;0.5;"Black";"Black";0)
			PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;0)
		End for 
		
		If ([xxSTR_Subasignaturas:83]ModoControles:5>0)
			$text:=""
			For ($j;1;Size of array:C274(<>aStatEP)-1)
				If (<>aStatEP{$j}>0)
					$text:=$text+String:C10(<>aStatEP{$j};$statFormat)+"\r"
				Else 
					$text:=$text+"\r"
				End if 
			End for 
			$text:=$text+String:C10(<>aStatEP{7};"##")
			PL_SetBrkText (xPL_List;0;$i+3;$text;0)
			PL_SetBrkColOpt (xPL_List;0;$i+3;1;0.5;"Black";"Black";0)
			PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;2)
			$i:=$i+1
		End if 
		
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
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;0.5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;0)
		$i:=$i+1
		
		
		
		
		PL_SetBrkText (xPL_List;0;$i+3;$text;0)
		PL_SetBrkColOpt (xPL_List;0;$i+3;1;0.5;"Black";"Black";0)
		PL_SetBrkStyle (xPL_List;0;$i+3;"Arial";6;0)
		
		PL_SetBrkRowDiv (xPL_List;2;"Black";"Black";0)
		PL_SetHdrOpts (xPL_List;2)
		PL_SetHdrStyle (xPL_List;0;"Arial";$fontsize;1)
		PL_SetDividers (xPL_List;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetFrame (xPL_List;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		
End case 