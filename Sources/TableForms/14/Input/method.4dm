Spell_CheckSpelling 


Case of 
	: (Form event:C388=On Load:K2:1)
		vProfIngresa:=""
		ARRAY TEXT:C222(atSTR_ModelosEnfermeria;0)
		XS_SetInterface 
		vl_WinRef:=Frontmost window:C447
		If ([Alumnos_EventosEnfermeria:14]Alumno_Numero:1=0)
			
			If (vLocation="Browser")
				GOTO RECORD:C242([Alumnos:2];alBWR_RecordNumber{abrSelect{1}})
			End if 
			[Alumnos_EventosEnfermeria:14]Alumno_Numero:1:=[Alumnos:2]numero:1
			AL_Enfermeria 
			vProfIngresa:=USR_GetUserName (USR_GetUserID )
		Else 
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13)
			vProfAutoriza:=[Profesores:4]Apellidos_y_nombres:28
			
			If ([Alumnos_EventosEnfermeria:14]ID_ProfesorIngresa:16<0)
				  //superUsuario
				vProfIngresa:=USR_GetUserName ([Alumnos_EventosEnfermeria:14]ID_ProfesorIngresa:16)
			Else 
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosEnfermeria:14]ID_ProfesorIngresa:16)
				vProfIngresa:=[Profesores:4]Apellidos_y_nombres:28
			End if 
			
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosEnfermeria:14]ID_Profesor:12)
			OBJECT SET VISIBLE:C603(*;"asignatura@";Records in selection:C76([Profesores:4])>0)
		End if 
		
		  //IMPRESION DE TICKET DE ENFERMERIA//MONO TICKET 203131
		C_OBJECT:C1216($o_tEnf)
		ARRAY LONGINT:C221($al_idTicketEnf;0)
		ARRAY TEXT:C222($at_TicketEnf;0)
		$o_tEnf:=OB_Create 
		
		cb_ticketEnfermeria:=Num:C11(PREF_fGet (0;"ImprimirTicketEnfermeria"))
		
		$y_nomTickEnfSel:=OBJECT Get pointer:C1124(Object named:K67:5;"ticketEnfermeria_nombre")
		$y_objtEnf:=OBJECT Get pointer:C1124(Object named:K67:5;"ticketEnfermeria_Obj")
		
		  // MOD Ticket N° 215398 Patricio Aliaga 20180830
		  //If (cb_ticketEnfermeria=1)
		  //OBJECT SET VISIBLE(*;"ticketEnfermeria_@";True)
		  //If (Is new record([Alumnos_EventosEnfermeria]))
		  //OBJECT SET VISIBLE(*;"b_imprimir";False)
		  //Else 
		  //OBJECT SET VISIBLE(*;"b_imprimir";True)
		  //End if 
		  //Else 
		  //OBJECT SET VISIBLE(*;"ticketEnfermeria_@";False)
		  //OBJECT SET VISIBLE(*;"b_imprimir";False)
		  //End if 
		OBJECT SET VISIBLE:C603(*;"b_imprimir";Not:C34(Is new record:C668([Alumnos_EventosEnfermeria:14])))
		
		  //consultar por los reportes de la enfermeria
		READ ONLY:C145([xShell_Reports:54])
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[Alumnos:2]);*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportType:2="gSR2";*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26="Ticket de Enfermería@";*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]isOneRecordReport:11=True:C214)
		ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)
		SELECTION TO ARRAY:C260([xShell_Reports:54]ID:7;$al_idTicketEnf;[xShell_Reports:54]ReportName:26;$at_TicketEnf)
		
		If (Size of array:C274($at_TicketEnf)>0)
			$at_TicketEnf:=1
			$y_nomTickEnfSel->:=$at_TicketEnf{$at_TicketEnf}
		Else 
			$y_nomTickEnfSel->:=""
			cb_ticketEnfermeria:=0
			$t_help:=__ ("No cuenta con reportes para imprimir tickets de enfermería, para poder tener alguno disponible debe tener al menos un reporte en Super Report, desde el panel Alumnos, que sea de impresión por registro y que su nombre comience con \"Ticket de Enfermer"+"ía\". ")
			OBJECT SET TITLE:C194(*;"help_sinTicketEnfermeria";$t_help)
		End if 
		
		  // MOD Ticket N° 215398 Patricio Aliaga 20180830
		OBJECT SET VISIBLE:C603(*;"ticketEnfermeria_@";(Size of array:C274($at_TicketEnf)>0))
		OBJECT SET VISIBLE:C603(*;"cb_ticketEnfermeria";(Size of array:C274($at_TicketEnf)>0))
		OBJECT SET VISIBLE:C603(*;"help_sinTicketEnfermeria";Not:C34((Size of array:C274($at_TicketEnf)>0)))
		If (Not:C34(Is new record:C668([Alumnos_EventosEnfermeria:14])))
			OBJECT SET VISIBLE:C603(*;"b_imprimir";(Size of array:C274($at_TicketEnf)>0))
		End if 
		
		
		OB SET ARRAY:C1227($o_tEnf;"ticketEnfermeria_nombre";$at_TicketEnf)
		OB SET ARRAY:C1227($o_tEnf;"ticketEnfermeria_id";$al_idTicketEnf)
		OB SET:C1220($o_tEnf;"ticketEnfermeria_seleccionado";$at_TicketEnf)
		
		$y_objtEnf->:=$o_tEnf
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Data Change:K2:15)
		
End case 

