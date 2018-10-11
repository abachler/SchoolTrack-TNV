If (Before:C29)
	Case of 
		: (prtCode="Detentions")
			TRACE:C157
			$err:=PL_SetArraysNam (Self:C308->;1;5;"atCastigos_curso";"atCastigos_NombreAlumno";"adCastigo_Fecha";"aiCastigo_Horas";"alCastigos_NoNivel")
			PL_SetHeaders (Self:C308->;1;4;"Curso";"Alumno";"Fecha";"No de horas")
			PL_SetSort (Self:C308->;5;1;2)
			
			  // Modificado por: Alexis Bustamante (12-04-2017)
			  //TICKET 179596 .....
			  //Agrego formato a la columna 4 ya que si se ingresaba un en casitgos 5 quedaba como 50
			PL_SetFormat (Self:C308->;4;"#####0")
			
			PL_SetWidths (Self:C308->;1;4;70;300;100;80)
			PL_SetHdrOpts (Self:C308->;2)
			PL_SetHeight (Self:C308->;1;1;0;0)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
			PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetBrkRowDiv (Self:C308->;0.25;"Black";"Black";0)
			PL_SetBrkHeight (Self:C308->;0;1;2)
			  //20121107 RCH Por problema en el formato
			  //PL_SetBrkText (Self->;0;1;"\\Count alumnos citados a la sesión";4;1)
			PL_SetBrkText (Self:C308->;0;1;String:C10(Size of array:C274(atCastigos_curso);"|Entero")+" alumnos citados a la sesión";4;1)
			PL_SetBrkColOpt (Self:C308->;0;0;0;1;"Black";"Black";0)
			PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";9;1)
		: (prtCode="Eximiciones")
			$err:=PL_SetArraysNam (Self:C308->;1;5;"<>aExmNo";"<>aExmDate";"<>aStdWhNme";"aPaName";"<>aStdClass")
			PL_SetSort (Self:C308->;1)
			PL_SetFormat (Self:C308->;1;"##0")
			PL_SetWidths (Self:C308->;1;5;20;70;195;195;70)
			PL_SetHeaders (Self:C308->;1;5;"Nº";"Fecha";"Nombre y apellidos";"Asignatura";"Curso")
			PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			PL_SetHdrOpts (Self:C308->;2)
			PL_SetHeight (Self:C308->;1;1;0;0)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
			PL_SetBrkRowDiv (Self:C308->;0.25;"Black";"Black";0)
			PL_SetBrkHeight (Self:C308->;0;1;2)
			  //20121107 RCH Por problema en el formato
			  //PL_SetBrkText (Self->;0;1;"\\Count alumnos registran eximiciones";4;1)
			PL_SetBrkText (Self:C308->;0;1;String:C10(Size of array:C274(<>aExmNo);"|Entero")+" alumnos registran eximiciones";4;1)
			PL_SetBrkColOpt (Self:C308->;0;0;0;1;"Black";"Black";0)
			PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";9;1)
	End case 
End if 