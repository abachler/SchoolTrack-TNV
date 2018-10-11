If (Before:C29)
	C_LONGINT:C283($i)
	ARRAY REAL:C219(aReel1;Size of array:C274(aInt1))
	ARRAY REAL:C219(aReel2;Size of array:C274(aInt1))
	PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	
	Case of 
		: (vt_PLConfigMessage="diario")
			$err:=PL_SetArraysNam (Self:C308->;1;4;"aText1";"aInt1";"aReel1";"aReel2")
			For ($i;1;Size of array:C274(aText1))
				aReel1{$i}:=Round:C94(viSTR_Calendario_DiasAHoy-aInt1{$i}/viSTR_Calendario_DiasAHoy*100;1)
				aReel2{$i}:=Round:C94(viSTR_Periodos_DiasAgno-aInt1{$i}/viSTR_Periodos_DiasAgno*100;1)
			End for 
			PL_SetWidths (Self:C308->;1;4;250;100;100;100)
			PL_SetHdrOpts (Self:C308->;2)
			PL_SetHeight (Self:C308->;1;1;0;0)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
			PL_SetFormat (Self:C308->;2;"";1;2)
			PL_SetFormat (Self:C308->;2;"##0";2;2)
			PL_SetFormat (Self:C308->;3;"##0"+<>tXS_RS_DecimalSeparator+"0";2;2)
			PL_SetFormat (Self:C308->;4;"##0"+<>tXS_RS_DecimalSeparator+"0";2;2)
			PL_SetHeaders (Self:C308->;1;4;"Alumno";"Inasist.";"% a la fecha";"% / días año")
			PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetBrkStyle (Self:C308->;1;0;"Tahoma";12;1)
			
			PL_SetSort (Self:C308->;1;2;3;4)
			PL_SetRepeatVal (Self:C308->;1;1)
			PL_SetRepeatVal (Self:C308->;2;1)
			PL_SetRepeatVal (Self:C308->;3;1)
			PL_SetRepeatVal (Self:C308->;4;1)
			PL_SetBrkRowDiv (Self:C308->;0.25;"Black";"Black";0)
			PL_SetBrkHeight (Self:C308->;1;1;2)
			If (vt_PLConfigMessage="diario")
				  //20121107 RCH Problema con formato
				  //PL_SetBrkText (Self->;0;1;"Nº de alumnos inasistentes en "+[Cursos]Curso+":  \\count";0)
				PL_SetBrkText (Self:C308->;0;1;"Nº de alumnos inasistentes en "+[Cursos:3]Curso:1+": "+String:C10(Size of array:C274(aText1);"|Entero");0)
				
			Else 
				PL_SetBrkText (Self:C308->;0;1;"Inasistencia en "+[Cursos:3]Curso:1;0)
			End if 
			PL_SetBrkText (Self:C308->;0;2;"\\sum";0)
			PL_SetBrkText (Self:C308->;0;3;"\\Average";0)
			PL_SetBrkText (Self:C308->;0;4;"\\Average";0)
			PL_SetBrkColOpt (Self:C308->;0;0;1;1;"Black";"Black";0)
			PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";10;1)
		Else 
			$err:=PL_SetArraysNam (Self:C308->;1;5;"aText1";"aDate1";"aInt1";"aReel1";"aReel2")
			For ($i;1;Size of array:C274(aText1))
				aReel1{$i}:=Round:C94(viSTR_Calendario_DiasAHoy-aInt1{$i}/viSTR_Calendario_DiasAHoy*100;1)
				aReel2{$i}:=Round:C94(viSTR_Periodos_DiasAgno-aInt1{$i}/viSTR_Periodos_DiasAgno*100;1)
			End for 
			
			PL_SetWidths (Self:C308->;1;5;250;75;75;75;75)
			PL_SetHdrOpts (Self:C308->;2)
			PL_SetHeight (Self:C308->;1;1;0;0)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
			PL_SetFormat (Self:C308->;1;"";1;2)
			PL_SetFormat (Self:C308->;2;"";2;2)
			PL_SetFormat (Self:C308->;3;"##0";2;2)
			PL_SetFormat (Self:C308->;4;"##0"+<>tXS_RS_DecimalSeparator+"0";2;2)
			PL_SetFormat (Self:C308->;5;"##0"+<>tXS_RS_DecimalSeparator+"0";2;2)
			PL_SetHeaders (Self:C308->;1;5;"Alumno";"Fecha";"Inasist.";"% a la fecha";"% / días año")
			PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetBrkStyle (Self:C308->;1;0;"Tahoma";12;1)
			PL_SetSort (Self:C308->;1;3;4;5;2)
			PL_SetRepeatVal (Self:C308->;1;1)
			PL_SetRepeatVal (Self:C308->;2;1)
			PL_SetRepeatVal (Self:C308->;3;1)
			PL_SetRepeatVal (Self:C308->;4;1)
			PL_SetRepeatVal (Self:C308->;5;1)
			PL_SetBrkRowDiv (Self:C308->;0.25;"Black";"Black";0)
			PL_SetBrkHeight (Self:C308->;1;0;0)
			  //20121107 RCH Problema con formato
			  //PL_SetBrkText (Self->;0;1;"Inasistencia en "+[Cursos]Curso+": \\count";2)
			PL_SetBrkText (Self:C308->;0;1;"Inasistencia en "+[Cursos:3]Curso:1+": "+String:C10(Size of array:C274(aText1);"|Entero");2)
			PL_SetBrkText (Self:C308->;0;4;"\\Average";0)
			PL_SetBrkText (Self:C308->;0;5;"\\Average";0)
			PL_SetBrkColOpt (Self:C308->;0;0;1;1;"Black";"Black";0)
			PL_SetBrkStyle (Self:C308->;1;0;"Tahoma";1;1)
			PL_SetBrkText (Self:C308->;1;1;" ";4)
			  //   PL_SetBrkColOpt (Self>>;1;0;1;1;"Black";"Black";0)
			  // PL_SetBrkStyle (Self>>;1;0;"Tahoma";10;2)
	End case 
End if 








