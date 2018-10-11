Case of 
	: (Form event:C388=On Load:K2:1)
		TMT_AsistImport_init 
		
		sepColOpc1:=1
		sepColOpc2:=0
		sepColOpc3:=0
		
		C_TEXT:C284(vt_file)
		vt_file:=""
		C_LONGINT:C283(vlimportaHorario)
		vlimportaHorario:=New list:C375
		APPEND TO LIST:C376(vlimportaHorario;"Gp Untis";1)
		  //la idea es agregar despues otros
		
		OBJECT SET TITLE:C194(*;"Encabezado1";__ ("Horas"))
		OBJECT SET TITLE:C194(*;"Encabezado2";__ ("Lunes"))
		OBJECT SET TITLE:C194(*;"Encabezado3";__ ("Martes"))
		OBJECT SET TITLE:C194(*;"Encabezado4";__ ("Miércoles"))
		OBJECT SET TITLE:C194(*;"Encabezado5";__ ("Jueves"))
		OBJECT SET TITLE:C194(*;"Encabezado6";__ ("Viernes"))
		OBJECT SET TITLE:C194(*;"Encabezado7";__ ("Sábado"))
		
		OBJECT SET TITLE:C194(*;"lb_asignivel_title1";"Curso")
		OBJECT SET TITLE:C194(*;"lb_asignivel_title2";"Asignatura")
		OBJECT SET TITLE:C194(*;"lb_asignivel_title3";"Profesor")
		OBJECT SET TITLE:C194(*;"lb_asignivel_title4";"Abrev.")
		
		OBJECT SET TITLE:C194(*;"lb_asignotfound_title1";"Curso")
		OBJECT SET TITLE:C194(*;"lb_asignotfound_title2";"Llave Bloque")
		
		OBJECT SET ENTERABLE:C238(*;"LB_BloquesSinAsignatura";False:C215)
		OBJECT SET ENTERABLE:C238(*;"LB_AsignaturasNivel";False:C215)
		
	: (Form event:C388=On Close Box:K2:21)
		TMT_AsistImport_init 
End case 