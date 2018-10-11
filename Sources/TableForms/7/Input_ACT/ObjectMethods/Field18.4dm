READ ONLY:C145([Alumnos:2])
REDUCE SELECTION:C351([Alumnos:2];0)
If (Self:C308->=True:C214)
	If ([Personas:7]RUT:6#"")
		QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[Personas:7]RUT:6)
	End if 
	If (Records in selection:C76([Alumnos:2])=1)
		[Personas:7]ID_ExAlumno:87:=[Alumnos:2]numero:1
	Else 
		QUERY:C277([Alumnos:2];[Alumnos:2]Apellido_paterno:3=[Personas:7]Apellido_paterno:3;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Nombres:2;=;"@"+[Personas:7]Nombres:2+"@")
		
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=Nivel_Egresados;*)
		QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]nivel_numero:29=Nivel_Retirados)
		If (Records in selection:C76([Alumnos:2])>0)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aText1;[Alumnos:2]curso:20;<>aText2;[Alumnos:2]Direccion:12;<>aText3;[Alumnos:2]numero:1;aLong)
			For ($i;1;Size of array:C274(<>aText1))
				<>aText1{$i}:=Replace string:C233(<>aText1{$i};"*";"")
			End for 
			ARRAY POINTER:C280(<>aChoicePtrs;4)
			<>aChoicePtrs{1}:=-><>aText1
			<>aChoicePtrs{2}:=-><>aText2
			<>aChoicePtrs{3}:=-><>aText3
			<>aChoicePtrs{4}:=->aLong
			TBL_ShowChoiceList (1;"Ex-Alumnos";1)
			If ((ok=1) & (choiceIdx>0))
				[Personas:7]ID_ExAlumno:87:=aLong{choiceIdx}
			End if 
		End if 
	End if 
Else 
	
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Personas:7]ID_ExAlumno:87)
	Case of 
		: (Records in selection:C76([Alumnos:2])=0)
			[Personas:7]ID_ExAlumno:87:=0
		: ([Alumnos:2]nivel_numero:29<1000)
			[Personas:7]ID_ExAlumno:87:=0
		: ([Alumnos:2]RUT:5=[Personas:7]RUT:6)
			CD_Dlog (0;__ ("Esta padre o apoderado no puede ser desconectado del registro de ex-alumno ya que tienen el mismo identificador nacional."))
			Self:C308->:=True:C214
		Else 
			$r:=CD_Dlog (0;__ ("¿Desea eliminar la relación con el(la) ex-alumno(a) ")+[Alumnos:2]apellidos_y_nombres:40+__ ("?");__ ("");__ ("No");__ ("Si"))
			If ($r=2)
				[Personas:7]ID_ExAlumno:87:=0
			Else 
				Self:C308->:=True:C214
			End if 
	End case 
End if 