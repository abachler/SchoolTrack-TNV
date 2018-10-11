If (Form event:C388=On Data Change:K2:15)
	C_LONGINT:C283($l_col;$l_fila)
	LISTBOX GET CELL POSITION:C971(*;"lb_PromoverNiveles";$l_col;$l_fila)
	If ($l_col=3)
		
		ARRAY LONGINT:C221($al_nivSel;0)
		C_POINTER:C301($y_lbColSeleccion;$y_lbColNoNivel)
		C_LONGINT:C283($i)
		C_TEXT:C284($t_msg;$t_niveles)
		
		$y_lbColNoNivel:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColNoNivel")
		$y_lbColSeleccion:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColSeleccion")
		
		READ ONLY:C145([Alumnos:2])
		
		For ($i;1;Size of array:C274($y_lbColSeleccion->))
			
			If ($y_lbColSeleccion->{$i})
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$y_lbColNoNivel->{$i};*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@ADT")
				If (Records in selection:C76([Alumnos:2])>0)
					APPEND TO ARRAY:C911($al_nivSel;$y_lbColNoNivel->{$i})
				Else 
					CD_Dlog (0;"El nivel no cuenta con alumnos en los cursos oficales, este nivel no será incluido en la promoción.")
					$y_lbColSeleccion->{$i}:=False:C215
				End if 
			End if 
			
		End for 
		
		QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;$al_nivSel)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
		CREATE SET:C116([Alumnos:2];"$Alumnos")
		
		OBJECT Get pointer:C1124(Object named:K67:5;"totalAlumnos")->:=Records in selection:C76([Alumnos:2])
		USE SET:C118("$Alumnos")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P")
		OBJECT Get pointer:C1124(Object named:K67:5;"alumnosPromovidos")->:=Records in selection:C76([Alumnos:2])
		USE SET:C118("$Alumnos")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="R")
		OBJECT Get pointer:C1124(Object named:K67:5;"alumnosReprobados")->:=Records in selection:C76([Alumnos:2])
		USE SET:C118("$Alumnos")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="Y")
		OBJECT Get pointer:C1124(Object named:K67:5;"alumnosRetirados")->:=Records in selection:C76([Alumnos:2])
		USE SET:C118("$Alumnos")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="X")
		OBJECT Get pointer:C1124(Object named:K67:5;"alumnosEspeciales")->:=Records in selection:C76([Alumnos:2])
		USE SET:C118("$Alumnos")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="";*)
		QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="??")
		OBJECT Get pointer:C1124(Object named:K67:5;"alumnosPendientes")->:=Records in selection:C76([Alumnos:2])
		
		OBJECT SET ENABLED:C1123(*;"btn_verAluSinStiFinal";(Records in selection:C76([Alumnos:2])>0))
		
		CLEAR SET:C117("$Alumnos")
	End if 
End if 