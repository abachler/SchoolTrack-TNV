If (False:C215)
	  //Object Method: xPL_XCR
	  //Written by  Alberto Bachler on 9/8/98
	  //Module: 
	  //Purpose: 
	  //Syntax: Object  xPL_XCR()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	
	  //modified on v461
End if 


  //DECLARATIONS


  //INITIALIZATION

  //MAIN CODE
Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($i)
		ARRAY TEXT:C222(aXCRNam;0)
		ARRAY TEXT:C222(aXCRCl;0)
		ARRAY TEXT:C222(aText1;0)
		  //QUERY([Alumnos_Actividades];[Alumnos_Actividades]Actividad_numero=[Actividades]ID) 20130502 ASM. Se estaban cargando alumnos de años anteriores.
		QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
		QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Año:3=<>gyear)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Alumnos:2]apellidos_y_nombres:40;aXCRnam;[Alumnos:2]curso:20;aXcrCl)
		ARRAY TEXT:C222(aText1;Size of array:C274(aXCRnam))
		$err:=PL_SetArraysNam (xPL_XCR;1;3;"aXCrNam";"aXcrCL";"aText1")
		PL_SetWidths (xPL_XCR;1;3;180;90;300)
		PL_SetHeaders (xPL_XCR;1;3;"Alumno";"Curso";"")
		PL_SetStyle (xPL_XCR;0;"Tahoma";9;0)
		PL_SetFormat (xPL_XCR;0;"";2;2;0)
		PL_SetFormat (xPL_XCR;1;"";0;0)
		
		PL_SetSort (xPL_XCR;1)
		PL_SetHeight (xPL_XCR;1;1)
		PL_SetHdrOpts (xPL_XCR;1;0)
		PL_SetHdrStyle (xPL_XCR;0;"Tahoma";9;1)
		PL_SetDividers (xPL_XCR;0.25;"Black";"Black";0;0.25;"Black";"Black";0)
		PL_SetFrame (xPL_XCR;1;"Black";"Black";0;1;"Black";"Black";0)
	: (Form event:C388=On Unload:K2:2)
End case 
  //END OF MAIN CODE 

  //CLEANING

  //END OF METHOD 

