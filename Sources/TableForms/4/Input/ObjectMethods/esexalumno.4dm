READ ONLY:C145([Alumnos:2])
REDUCE SELECTION:C351([Alumnos:2];0)
If (Self:C308->=True:C214)
	If ([Profesores:4]RUT:27#"")
		QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[Profesores:4]RUT:27)
	End if 
	If (Records in selection:C76([Alumnos:2])=1)
		[Profesores:4]ID_ExAlumno:69:=[Alumnos:2]numero:1
	Else 
		QUERY:C277([Alumnos:2];[Alumnos:2]Apellido_paterno:3=[Profesores:4]Apellido_paterno:3;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Nombres:2;=;"@"+[Profesores:4]Nombres:2+"@";*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>=1000)
		
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aText1;[Alumnos:2]curso:20;<>aText2;[Alumnos:2]Direccion:12;<>aText3;[Alumnos:2]numero:1;aLong)
		If ((Size of array:C274(aLong))>0)
			For ($i;1;Size of array:C274(<>aText1))
				<>aText1{$i}:=Replace string:C233(<>aText1{$i};"*";"")
			End for 
			ARRAY POINTER:C280(<>aChoicePtrs;4)
			<>aChoicePtrs{1}:=-><>aText1
			<>aChoicePtrs{2}:=-><>aText2
			<>aChoicePtrs{3}:=-><>aText3
			<>aChoicePtrs{4}:=->aLong
			TBL_ShowChoiceList (2;"Ex-Alumnos";1)
			If ((ok=1) & (choiceIdx>0))
				[Profesores:4]ID_ExAlumno:69:=aLong{choiceIdx}
			End if 
		End if 
	End if 
Else 
	
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Profesores:4]ID_ExAlumno:69)
	Case of 
		: (Records in selection:C76([Alumnos:2])=0)
			[Profesores:4]ID_ExAlumno:69:=0
		: ([Alumnos:2]nivel_numero:29<1000)
			[Profesores:4]ID_ExAlumno:69:=0
		: ([Alumnos:2]RUT:5=[Profesores:4]RUT:27)
			CD_Dlog (0;__ ("Esta profesor o funcionario no puede ser desconectado del registro de ex-alumno ya que tienen el mismo identificador nacional."))
			Self:C308->:=True:C214
		Else 
			$r:=CD_Dlog (0;__ ("¿Desea eliminar la relación con el(la) ex-alumno(a) ")+[Alumnos:2]apellidos_y_nombres:40+__ ("?");__ ("");__ ("No");__ ("Si"))
			If ($r=2)
				[Profesores:4]ID_ExAlumno:69:=0
			Else 
				Self:C308->:=True:C214
			End if 
	End case 
End if 
