//%attributes = {}
  //lp_Libreta2

C_PICTURE:C286(vp_Lines)
QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
sProfJefe:=[Profesores:4]Nombre_comun:21
If ([Alumnos:2]Tutor_numero:36>0)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos:2]Tutor_numero:36)
	sTutor:=[Profesores:4]Nombre_comun:21
Else 
	sTutor:=""
End if 
QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_académico_Número:27)
Case of 
	: (popL=1)  //profesor jefe
		stitleL:=aText1{8}
		snameL:=sProfJefe
	: (popL=2)  //director de ciclo
		stitleL:=aText1{9}
		snameL:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Director:13)
	: (popL=3)  //Director
		stitleL:=aText1{10}
		snameL:=<>gRector
	: (popL=4)  //apoderado
		stitleL:=aText1{11}
		snameL:=Replace string:C233([Personas:7]Nombres:2+" "+[Personas:7]Apellido_paterno:3+" "+Substring:C12([Personas:7]Apellido_materno:4;1;1)+".";"  ";" ")
	: (popL=5)  //alumno
		stitleL:=aText1{12}
		snameL:=Replace string:C233([Alumnos:2]Nombres:2+" "+[Alumnos:2]Apellido_paterno:3+" "+Substring:C12([Alumnos:2]Apellido_materno:4;1;1)+".";"  ";" ")
	: (popL=6)  //tutor
		stitleL:=aText1{68}
		snameL:=sTutor
	Else 
		stitleL:=""
		snameL:=""
End case 
Case of 
	: (popC=1)  //profesor jefe
		stitleC:=aText1{8}
		snameC:=sProfJefe
	: (popC=2)  //director de ciclo 
		stitleC:=aText1{9}
		snameC:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Director:13)
	: (popC=3)  //Director
		stitleC:=aText1{10}
		snameC:=<>gRector
	: (popC=4)  //apoderado
		stitleC:=aText1{11}
		snameC:=Replace string:C233([Personas:7]Nombres:2+" "+[Personas:7]Apellido_paterno:3+" "+Substring:C12([Personas:7]Apellido_materno:4;1;1)+".";"  ";" ")
	: (popC=5)  //alumno
		stitleC:=aText1{12}
		snameC:=Replace string:C233([Alumnos:2]Nombres:2+" "+[Alumnos:2]Apellido_paterno:3+" "+Substring:C12([Alumnos:2]Apellido_materno:4;1;1)+".";"  ";" ")
	: (popC=6)  //tutor
		stitleC:=aText1{68}
		snameC:=sTutor
	Else 
		stitleC:=""
		snameC:=""
End case 
Case of 
	: (popR=1)  //profesor jefe
		stitleR:=aText1{8}
		snameR:=sProfJefe
	: (popR=2)  //director de ciclo
		stitleR:=aText1{9}
		snameR:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Director:13)
	: (popR=3)  //Director
		stitleR:=aText1{10}
		snameR:=<>gRector
	: (popR=4)  //apoderado
		stitleR:=aText1{11}
		snameR:=Replace string:C233([Personas:7]Nombres:2+" "+[Personas:7]Apellido_paterno:3+" "+Substring:C12([Personas:7]Apellido_materno:4;1;1)+".";"  ";" ")
	: (popR=5)  //alumno
		stitleR:=aText1{12}
		snameR:=Replace string:C233([Alumnos:2]Nombres:2+" "+[Alumnos:2]Apellido_paterno:3+" "+Substring:C12([Alumnos:2]Apellido_materno:4;1;1)+".";"  ";" ")
	: (popR=6)  //tutor
		stitleR:=aText1{68}
		snameR:=sTutor
	Else 
		stitleR:=""
		snameR:=""
End case 
If (bt1=1)
	sNameL:=""
End if 
If (bt2=1)
	sNameC:=""
End if 
If (bt3=1)
	sNameR:=""
End if 
ddate:=Current date:C33
sDate:=<>gComuna+", "+String:C10(dDate;"00/00/0000")
If (bNotes=1)
	Case of 
		: (vPeriodo=1)
			tNotes:=[Alumnos:2]Observaciones_Periodo1:44
		: (vPeriodo=2)
			tNotes:=[Alumnos:2]Observaciones_Periodo2:45
		: (vPeriodo=3)
			If ([Alumnos:2]Observaciones_Periodo3:46="")
				tNotes:=[Alumnos:2]Observaciones_Periodo3:46
			Else 
				tNotes:=[Alumnos:2]Observaciones_finales:47
			End if 
	End case 
Else 
	tNotes:=""
	sTtlNotas:=""
End if 
OBJECT SET FONT SIZE:C165(sttlNotas;9)
OBJECT SET FONT SIZE:C165(tNotes;9)
If (vi_FontSize>8)
	OBJECT SET FONT SIZE:C165(sNote;vi_FontSize-2)
End if 
If (bNotes=1)
Else 
	vp_Lines:=vp_Lines*0
	OBJECT SET VISIBLE:C603(vp_Lines;False:C215)
	OBJECT SET VISIBLE:C603(sTtlNotas;False:C215)
End if 
  //setting colors
OBJECT SET COLOR:C271(sColegio;-((aForColor{1}-1)+(256*(aBkgColor{1}-1))))
OBJECT SET COLOR:C271(sTitle;-((aForColor{2}-1)+(256*(aBkgColor{2}-1))))
OBJECT SET COLOR:C271(sSubTitle;-((aForColor{3}-1)+(256*(aBkgColor{3}-1))))
OBJECT SET COLOR:C271(sName;-((aForColor{4}-1)+(256*(aBkgColor{4}-1))))
OBJECT SET COLOR:C271([Alumnos:2]apellidos_y_nombres:40;-((aForColor{4}-1)+(256*(aBkgColor{4}-1))))
OBJECT SET COLOR:C271(sClass;-((aForColor{5}-1)+(256*(aBkgColor{5}-1))))
OBJECT SET COLOR:C271([Alumnos:2]curso:20;-((aForColor{5}-1)+(256*(aBkgColor{5}-1))))
OBJECT SET COLOR:C271(sttlNotas;-((aForColor{14}-1)+(256*(aBkgColor{14}-1))))
OBJECT SET COLOR:C271(tNotes;-((aForColor{14}-1)+(256*(aBkgColor{14}-1))))
If (bPrintFotoAl=1)
	vp_RightPict:=vp_RightPict*0
	vp_RightPict:=[Alumnos:2]Fotografía:78
End if 