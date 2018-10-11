  // [TMT_Horario].Horario.cursos()
  // 
  //
  // creado por: Alberto Bachler Klein: 20-07-16, 11:19:41
  // -----------------------------------------------------------

Case of 
		  //: (Form event=On Begin Drag Over)
		  //$0:=-1
		  //OBJECT SET VISIBLE(*;"rectanguloSeleccion";False)
		
		
	: (Form event:C388=On Clicked:K2:4)
		vs_SelectedClass:=at_CursosEnHorario{at_CursosEnHorario}
		  //lectura de los parametros de horario
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=vs_SelectedClass)
		PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
		Case of 
			: (vlSTR_Horario_NoCiclos=1)
				OBJECT SET VISIBLE:C603(*;"ciclo@";False:C215)
				vlSTR_Horario_CicloNumero:=1
			: (vlSTR_Horario_NoCiclos=2)
				ARRAY TEXT:C222(atSTR_NombresCiclos;2)
				atSTR_NombresCiclos{1}:="A"
				atSTR_NombresCiclos{1}:="B"
				atSTR_NombresCiclos:=1
				vlSTR_Horario_CicloNumero:=1
				OBJECT SET VISIBLE:C603(*;"ciclo@";True:C214)
			Else 
				CD_Dlog (0;__ ("No se ha definido el tipo de horario a utilizar\rEl horario no puede ser configurado ahora."))
				CANCEL:C270
		End case 
		TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
		OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
		  //LB_SelectCell (0;0;"lbHorario")
End case 