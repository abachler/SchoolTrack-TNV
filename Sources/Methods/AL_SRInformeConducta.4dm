//%attributes = {}
  //AL_SRInformeConducta

vlAL_WinRef:=WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_SpecialFind2";-1;4;__ ("Búsqueda de registros"))
DIALOG:C40([xxSTR_Constants:1];"STR_SpecialFind2")
CLOSE WINDOW:C154

If (ok=1)
	C_TEXT:C284(vTituloInforme)
	C_TEXT:C284(vNombreColumna)
	If (vCantidad2=0)
		vCantidad2:=10000
	End if 
	If (vCantidad2=10000)
		vTituloInforme:="Informe de Alumnos con  número de "+ST_Boolean2Str (cbAtrasos=1;"Atrasos";"Ausencias")+" mayor o igual que "+String:C10(vCantidad1)+", entre las fechas "+String:C10(dDate1)+" y "+String:C10(dDate2)
	Else 
		If (vCantidad1=vCantidad2)
			vTituloInforme:="Informe de Alumnos con  número de "+ST_Boolean2Str (cbAtrasos=1;"Atrasos";"Ausencias")+" igual a "+String:C10(vCantidad1)+", entre las fechas "+String:C10(dDate1)+" y "+String:C10(dDate2)
		Else 
			vTituloInforme:="Informe de Alumnos con  número de "+ST_Boolean2Str (cbAtrasos=1;"Atrasos";"Ausencias")+" mayor o igual que "+String:C10(vCantidad1)+" y menor o igual que "+String:C10(vCantidad2)+", entre las fechas "+String:C10(dDate1)+" y "+String:C10(dDate2)
		End if 
	End if 
	vNombreColumna:=ST_Boolean2Str (cbAtrasos=1;"Número de Atrasos";"Número de Ausencias")
	
	REDUCE SELECTION:C351([Alumnos:2];0)
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=vNivelInterno1;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=vNivelInterno2)
	
	If (Records in selection:C76([Alumnos:2])>0)
		If (cbAtrasos=1)
			$it:=IT_UThermometer (1;0;__ ("Buscando Atrasos ..."))
			ARRAY TEXT:C222(at_NomAlumnos;0)
			ARRAY INTEGER:C220(ai_NoAtrasos;0)
			ARRAY TEXT:C222(at_Cursos;0)
			ARRAY INTEGER:C220(ai_NivelAlumnos;0)
			KRL_RelateSelection (->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2>=dDate1;*)
			QUERY SELECTION:C341([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2<=dDate2)
			CREATE SET:C116([Alumnos_Atrasos:55];"AlumnosConAtraso")
			While (Records in selection:C76([Alumnos_Atrasos:55])>0)
				USE SET:C118("AlumnosConAtraso")
				FIRST RECORD:C50([Alumnos_Atrasos:55])
				If (Records in selection:C76([Alumnos_Atrasos:55])>0)
					QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos_Atrasos:55]Alumno_numero:1)
					CREATE SET:C116([Alumnos_Atrasos:55];"ConAtraso")
					DIFFERENCE:C122("AlumnosConAtraso";"ConAtraso";"AlumnosConAtraso")
					If ((Records in selection:C76([Alumnos_Atrasos:55])>=vCantidad1) & (Records in selection:C76([Alumnos_Atrasos:55])<=vCantidad2))
						QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Atrasos:55]Alumno_numero:1)
						AT_Insert (1;1;->at_NomAlumnos;->ai_NoAtrasos;->at_Cursos;->ai_NivelAlumnos)
						at_NomAlumnos{1}:=[Alumnos:2]apellidos_y_nombres:40
						ai_NoAtrasos{1}:=Records in selection:C76([Alumnos_Atrasos:55])
						at_Cursos{1}:=[Alumnos:2]curso:20
						ai_NivelAlumnos{1}:=[Alumnos:2]nivel_numero:29
					End if 
				End if 
			End while 
			IT_UThermometer (-2;$it)
			If (Size of array:C274(at_NomAlumnos)=0)
				CD_Dlog (0;__ ("No hay alumnos que cumplan con el criterio ingresado"))
				CANCEL:C270
			End if 
			CLEAR SET:C117("AlumnosConAtraso")
			CLEAR SET:C117("ConAtraso")
		Else 
			$it:=IT_UThermometer (1;0;__ ("Buscando Atrasos ..."))
			ARRAY TEXT:C222(at_NomAlumnos;0)
			ARRAY INTEGER:C220(ai_NoAtrasos;0)
			ARRAY TEXT:C222(at_Cursos;0)
			ARRAY INTEGER:C220(ai_NivelAlumnos;0)
			KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1>=dDate1;*)
			QUERY SELECTION:C341([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1<=dDate2)
			CREATE SET:C116([Alumnos_Inasistencias:10];"AlumnosConInas")
			While (Records in selection:C76([Alumnos_Inasistencias:10])>0)
				USE SET:C118("AlumnosConInas")
				FIRST RECORD:C50([Alumnos_Inasistencias:10])
				If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
					QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos_Inasistencias:10]Alumno_Numero:4)
					CREATE SET:C116([Alumnos_Inasistencias:10];"ConInas")
					DIFFERENCE:C122("AlumnosConInas";"ConInas";"AlumnosConInas")
					If ((Records in selection:C76([Alumnos_Inasistencias:10])>=vCantidad1) & (Records in selection:C76([Alumnos_Inasistencias:10])<=vCantidad2))
						QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Inasistencias:10]Alumno_Numero:4)
						AT_Insert (1;1;->at_NomAlumnos;->ai_NoAtrasos;->at_Cursos;->ai_NivelAlumnos)
						at_NomAlumnos{1}:=[Alumnos:2]apellidos_y_nombres:40
						ai_NoAtrasos{1}:=Records in selection:C76([Alumnos_Inasistencias:10])
						at_Cursos{1}:=[Alumnos:2]curso:20
						ai_NivelAlumnos{1}:=[Alumnos:2]nivel_numero:29
					End if 
				End if 
			End while 
			IT_UThermometer (-2;$it)
			If (Size of array:C274(at_NomAlumnos)=0)
				CD_Dlog (0;__ ("No hay alumnos que cumplan con el criterio ingresado"))
				CANCEL:C270
			End if 
			CLEAR SET:C117("AlumnosConInas")
			CLEAR SET:C117("ConInas")
		End if 
		
		If (btNivelCurso=1)
			MULTI SORT ARRAY:C718(ai_NivelAlumnos;>;at_Cursos;>;at_NomAlumnos;>;ai_NoAtrasos;>)
		Else 
			If (btApellidoNombre=1)
				MULTI SORT ARRAY:C718(at_NomAlumnos;>;ai_NivelAlumnos;>;at_Cursos;>;ai_NoAtrasos;>)
			Else 
				MULTI SORT ARRAY:C718(ai_NoAtrasos;>;at_NomAlumnos;>;ai_NivelAlumnos;>;at_Cursos;>)
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("No hay registros que cumplan con su consulta"))
	End if 
End if 