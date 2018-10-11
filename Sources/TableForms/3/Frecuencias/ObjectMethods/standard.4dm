If (Form event:C388=On Load:K2:1)
	PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
	sProf:=[Profesores:4]Apellidos_y_nombres:28
	dDate:=Current date:C33(*)
	hHeure:=Current time:C178(*)
	$columns:=CU_FrecuenciaCalificaciones (vPeriodo;vi_Parciales)
	
	$columnWidth:=44
	$firstColumnWidth:=44
	$fontSize:=7
	
	$err:=PL_SetArraysNam (xPL_List;1;1;"ar_Real1")
	  //PL_SetWidths (xPL_List;1;1;$firstColumnWidth)
	PL_SetHeaders (xPL_List;1;1;"Nota")
	PL_SetFormat (xPL_List;1;"0,0";2;0;0)
	PL_SetBrkText (xPL_List;0;1;"Alumnos")
	For ($i;1;$columns)
		$err:=PL_SetArraysNam (xPL_List;$i+1;1;"aInt"+String:C10($i))
		PL_SetHeaders (xPL_List;$i+1;1;Get pointer:C304("vs_string"+String:C10($i))->)
		  //PL_SetWidths (xPL_List;$i+1;1;$columnWidth)
		PL_SetFormat (xPL_List;$i+1;"###";2;0;0)
		PL_SetBrkText (xPL_List;0;$i+1;String:C10(aLong1{$i}))
	End for 
	If ($columns<12)
		ARRAY INTEGER:C220(aInt0;Size of array:C274(aInt1))
		$err:=PL_SetArraysNam (xPL_List;$Columns+2;1;"aInt0")
		  //PL_SetWidths (xPL_List;$Columns+2;1;0)
		PL_SetHeaders (xPL_List;$Columns+2;1;"")
		PL_SetFormat (xPL_List;$Columns+2;"###";2;0;0)
	End if 
	
	  // Saúl Ponce - 23.06.2015 - Ticket N° 146371 
	  // Se modifica el seteo de los anchos de columna ya que producía inconvenientes en 11.10
	  // La primera columna de notas era demasiado ancha  no daba espacio para las columnas de asignaturas
	
	PL_SetWidths (xPL_List;1;1;$firstColumnWidth)
	
	For ($i;1;$columns)
		PL_SetWidths (xPL_List;$i+1;1;$columnWidth)
	End for 
	
	If ($columns<12)
		PL_SetWidths (xPL_List;$Columns+2;1;0)
	End if 
	
	  // Saúl Ponce - 23.06.2015
	
	PL_SetHdrStyle (xPL_List;0;"Tahoma";$fontSize;1)
	PL_SetStyle (xPL_List;0;"Tahoma";$fontSize;0)
	PL_SetDividers (xPL_List;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_List;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetHdrOpts (xPL_List;2)
	PL_SetHeight (xPL_List;2)
	
	If (vi_parciales=1)
		vt_text2:="Frecuencia de Calificaciones Parciales"+"\r"+atSTR_Periodos_Nombre{vPeriodo}
	Else 
		If (vPeriodo=0)
			vt_text2:="Frecuencia de Calificaciones Finales"
		Else 
			vt_text2:="Frecuencia de Promedios en el Período"+"\r"+atSTR_Periodos_Nombre{vPeriodo}
		End if 
	End if 
End if 

