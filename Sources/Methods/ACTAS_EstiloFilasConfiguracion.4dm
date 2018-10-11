//%attributes = {}
  // ACTAS_EstiloFilasConfiguracion()
  // Por: Alberto Bachler K.: 02-03-14, 10:44:15
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_filas;$l_asignaturas;$l_electivas;$l_optativas)

For ($i_filas;1;Size of array:C274(atActas_Subsectores))
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_asignaturas)
	If (Record number:C243([Cursos:3])>No current record:K29:2)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=[Cursos:3]Curso:1)
		If ($l_asignaturas=0)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=[Cursos:3]Nivel_Numero:7)
		End if 
	Else 
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=[xxSTR_Niveles:6]NoNivel:5)
	End if 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_electivas)
	If (Record number:C243([Cursos:3])>No current record:K29:2)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=[Cursos:3]Curso:1;*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Electiva:11=True:C214)
		If ($l_electivas=0)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=[Cursos:3]Nivel_Numero:7;*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Electiva:11=True:C214)
		End if 
	Else 
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=[xxSTR_Niveles:6]NoNivel:5;*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Electiva:11=True:C214)
	End if 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_optativas)
	If (Record number:C243([Cursos:3])>No current record:K29:2)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=[Cursos:3]Curso:1;*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Electiva:11=True:C214)
		If ($l_optativas=0)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=[Cursos:3]Nivel_Numero:7;*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Electiva:11=True:C214)
		End if 
	Else 
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=[xxSTR_Niveles:6]NoNivel:5;*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Electiva:11=True:C214)
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	Case of 
		: ($l_asignaturas=0)
			LISTBOX SET ROW FONT STYLE:C1268(*;"acta.lista";$i_filas;Bold:K14:2)
		: ($l_electivas>0)
			LISTBOX SET ROW FONT STYLE:C1268(*;"acta.lista";$i_filas;Italic:K14:3)
		: (($l_optativas>0) | (atActas_Subsectores{$i_filas}="Religión"))
			LISTBOX SET ROW FONT STYLE:C1268(*;"acta.lista";$i_filas;Plain:K14:1)
		Else 
			LISTBOX SET ROW FONT STYLE:C1268(*;"acta.lista";$i_filas;Plain:K14:1)
	End case 
End for 



