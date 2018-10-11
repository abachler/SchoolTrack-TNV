If (Lid#0)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=Lid)
	
	
	  // 20120710 ASM, validación en el ingreso de atrasos, para que la suma de estos no sobrepase el limite de un día.
	$resultado:=AL_validaIngresoAtraso ([Alumnos:2]numero:1;dFrom;vi_TiempoAtraso)
	If (Size of array:C274(<>aExAbs3)>0)
		$pos:=Find in array:C230(<>aExAbs2;Lid)
		If ($pos#-1)
			$resultado:=AL_validaIngresoAtraso ([Alumnos:2]numero:1;dFrom;<>aExAbs3{$pos})
			If ($resultado>=1)
				<>aExAbs3{$pos}:=0
				AL_UpdateArrays (xALP_Anot;0)
			End if 
		Else 
			$resultado:=0
		End if 
	End if 
	
	If ($resultado>=1)
		CD_Dlog (0;__ ("No puede ingresar mas atrasos para el alumno ")+[Alumnos:2]apellidos_y_nombres:40+".")
		vi_TiempoAtraso:=0
	Else 
		If (([Alumnos:2]Fecha_de_Ingreso:41<=dDate) | ([Alumnos:2]Fecha_de_Ingreso:41=!00-00-00!))
			AL_UpdateArrays (xALP_Anot;0)
			If (i_line<=0)
				$s:=Size of array:C274(<>aExAbs1)+1
				AT_Insert ($s;1;-><>aExAbs1;-><>aExAbs2;-><>aExAbs3)  //EMA 05/10/06
			Else 
				$s:=i_line
			End if 
			<>aExAbs1{$s}:=sName
			<>aExAbs2{$s}:=LId
			  //<>aExAbs3{$s}:=vi_TiempoAtrasoGral  //EMA 05/10/06
			<>aExAbs3{$s}:=vi_TiempoAtraso
			
			AL_UpdateArrays (xALP_Anot;Size of array:C274(<>aExAbs1))
			sName:=""
			Lid:=0
			GOTO OBJECT:C206(sName)
			AL_SetLine (xALP_Anot;0)
			i_Line:=0
		Else 
			CD_Dlog (0;__ ("La fecha de ingreso del alumno es: ")+String:C10([Alumnos:2]Fecha_de_Ingreso:41)+__ (". No es posible ingresar atrasos para esa fecha."))
		End if 
	End if 
Else 
	BEEP:C151
End if 