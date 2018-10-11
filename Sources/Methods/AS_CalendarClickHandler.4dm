//%attributes = {}
  //AS_CalendarClickHandler

C_LONGINT:C283($feriados)
GET MOUSE:C468($vlMouseX;$vlMouseY;$vlButton)
C_TEXT:C284($popUpItems;$vt_userName)

$horizontal:=$vlMouseX-9
$vertical:=$vlMouseY-100
$column:=Int:C8($horizontal/154)+1
$line:=Int:C8($vertical/80)+1
If ($line>1)
	If ($line>5)
		$line:=5
	End if 
	$Index:=(($line-1)*5)+$column
Else 
	$index:=$column
End if 

$macControlDown:=Macintosh control down:C544
$displayContextMenu:=$macControlDown | ($vlButton=2)
$date:=ad_date1{$index}
$pos:=Find in array:C230(adSTR_Calendario_Feriados;$date)
$pointer:=Get pointer:C304("vt_Events"+String:C10($index))
$lines:=ST_countlines ($pointer->)
$cellLine:=Int:C8($vertical/12)
If ($line>1)
	$cellLine:=Int:C8($cellLine-($line-1*7))
End if 
If ($cellLine=0)
	$cellLine:=1
End if 

$date:=ad_date1{$index}
$pos:=Find in array:C230(adSTR_Calendario_Feriados;$date)
$pointer:=Get pointer:C304("vt_Events"+String:C10($index))
$lines:=ST_countlines ($pointer->)
$text:=ST_GetLine ($pointer->;$cellLine)

If ($line=1)
	$cellIndex:=$line*$column
Else 
	$cellIndex:=$line-1*5+$column
End if 
If ($cellIndex=1)
	$eventIndex:=$cellLine
Else 
	$eventIndex:=$cellIndex-1*6+$cellline
End if 
$eventRecNum:=al_EventRecNums{$eventIndex}

If ($text#"")
	$event:=$text+"..."
Else 
	$event:="..."
End if 
$stringDate:=String:C10($date;3)+"..."

C_LONGINT:C283($respuesta_feriado)
$respuesta_feriado:=0

  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //VERIFICAR SI EL EVENTO A MODIFICACR O ELIMINAR, CORRESPONDE AL PROFESOR DE LA ASIGNATURA EN LA CUAL NOS ENCONTRAMOS
If ($eventRecNum>0)
	GOTO RECORD:C242([Asignaturas_Eventos:170];$eventRecNum)
End if 
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Case of 
	: ($displayContextMenu)
		Case of 
			: ($pos>0)  //dia feriado
				If ($eventRecNum>=0)  //ya hay eventos para el dia feriado seleccionado
					$popUpItems:=__ ("Nuevo evento...;(-;Editar ")+$event+__ (";Editar ")+$stringDate+__ (";(-;Borrar ")+$event+__ (";Borrar ")+$stringDate+__ (";-;Eventos de los Alumnos inscritos en la Asignatura")
				Else   //no hay eventos para el feriado seleccionado
					$popUpItems:=__ ("Nuevo evento...;(-;(Editar ")+$event+__ (";(Editar ")+$stringDate+__ (";(-;(Borrar ")+$event+__ (";(Borrar ")+$stringDate+__ (";-;(Eventos de los Alumnos inscritos en la Asignatura")
				End if 
				  //AVISANDO QUE ES UN FERIADO
				$respuesta_feriado:=CD_Dlog (0;__ ("Usted está sobre  un día festivo, no se pueden ingresar eventos."))
				
			: ($lines=0)  //cuando no hay eventos para el dia seleccionado
				  //cualquiera que llegue aqui debiera poder crear nuevos eventos en las asignaturas
				$popUpItems:=__ ("Nuevo evento...;(-;(Editar ")+$event+__ (";(Editar ")+$stringDate+__ (";(-;(Borrar ")+$event+__ (";(Borrar ")+$stringDate+__ (";-;(Eventos de los Alumnos inscritos en la Asignatura")
				
			: (($eventRecNum>=0) & (([Asignaturas_Eventos:170]UserID:10=<>lUSR_CurrentUserID) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))))  //cuando se selecciona un evento ya ingresado
				  //solo el creador del evento va a poder modificarlo, o el superUser o alguien del grupo administración
				$popUpItems:=__ ("Nuevo evento...;(-;Editar ")+$event+__ (";Editar ")+$stringDate+__ (";(-;Borrar ")+$event+__ (";Borrar ")+$stringDate+__ (";-;Eventos de los Alumnos inscritos en la Asignatura")
				
			: (($eventRecNum>=0) & (([Asignaturas_Eventos:170]UserID:10#<>lUSR_CurrentUserID) & (<>lUSR_CurrentUserID>0) & (Not:C34(USR_IsGroupMember_by_GrpID (-15001)))))  //boton derecho sobre un evento y sin permisos para editarlo
				$vt_userName:=KRL_GetTextFieldData (->[xShell_Users:47]No:1;->[Asignaturas_Eventos:170]UserID:10;->[xShell_Users:47]Name:2)
				CD_Dlog (0;"Solo el creador o el administrador del sistema pueden editar y/o eliminar este evento.\n\nEl creador de este evento es: "+ST_Qte ($vt_userName)+".")
				
			: (($lines>=1) & ($eventRecNum=-1))  //cuando ya hay eventos, pero se desea crear uno nuevo, no se hace click sobre ningun evento creado
				  //cualquiera que llegue aqui debiera poder crear nuevos eventos, solo el creador, podra luego borrarlos, salvo el administrador y el superUser que tb podran.
				$popUpItems:=__ ("Nuevo evento...;(-;(Editar ")+$event+__ ("...;(Editar ")+$stringDate+__ (";(-;(Borrar ")+$event+__ (";(Borrar ")+$stringDate+__ (";-;Eventos de los Alumnos inscritos en la Asignatura")
				
			: (($lines>=1) & ($eventRecNum>=0))
				
		End case 
		
		If (($respuesta_feriado=0))
			$userChoice:=Pop up menu:C542($popUpItems)
		Else 
			$userChoice:=-1
		End if 
		
		Case of 
			: ($userChoice=1)
				$b_continuar:=AS_validaIngresoEventoCalendari ("validaCalendarioAsig";$date;[Asignaturas:18]Numero:1)
				If ($b_continuar)
					vd_EventDate:=$date
					$title:=__ ("Nuevo evento en ")+[Asignaturas:18]denominacion_interna:16
					WDW_OpenFormWindow (->[Asignaturas_Eventos:170];"Entrada";-1;4;$title)
					FORM SET INPUT:C55([Asignaturas_Eventos:170];"Entrada")
					ADD RECORD:C56([Asignaturas_Eventos:170];*)
					CLOSE WINDOW:C154
					If (ok=1)
						LOG_RegisterEvt ("Nuevo evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
						AS_PageCalendar (vd_currentDate)
					End if 
				End if 
			: ($userChoice=3)
				
				If (([Asignaturas_Eventos:170]UserID:10=<>lUSR_CurrentUserID) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)))
					GOTO RECORD:C242([Asignaturas_Eventos:170];$eventRecNum)
					$title:=[Asignaturas:18]denominacion_interna:16+", "+String:C10([Asignaturas_Eventos:170]Fecha:2;3)
					WDW_OpenFormWindow (->[Asignaturas_Eventos:170];"Entrada";-1;4;$title)
					KRL_ModifyRecord (->[Asignaturas_Eventos:170];"Entrada")
					If (ok=1)
						LOG_RegisterEvt ("Edición de evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
						AS_PageCalendar (vd_currentDate)
					End if 
				Else 
					$vt_userName:=KRL_GetTextFieldData (->[xShell_Users:47]No:1;->[Asignaturas_Eventos:170]UserID:10;->[xShell_Users:47]Name:2)
					CD_Dlog (0;"Solo el creador o el administrador del sistema pueden editar y/o eliminar este evento.\n\nEl creador de este evento es: "+ST_Qte ($vt_userName)+".")
				End if 
				
			: ($userChoice=4)
				  //editar día    
			: ($userChoice=6)
				OK:=CD_Dlog (0;__ ("¿Desea realemente eliminar el evento ")+Char:C90(34)+Substring:C12($event;1;Length:C16($event)-3)+Char:C90(34)+__ ("?");__ ("");__ ("No");__ ("Sí"))
				If (ok=2)
					READ WRITE:C146([Asignaturas_Eventos:170])
					GOTO RECORD:C242([Asignaturas_Eventos:170];$eventRecNum)
					LOG_RegisterEvt ("Evento eliminado en el calendario de "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
					DELETE RECORD:C58([Asignaturas_Eventos:170])
					READ ONLY:C145([Asignaturas_Eventos:170])
					AS_PageCalendar (vd_currentDate)
				End if 
			: ($userChoice=7)
				OK:=CD_Dlog (0;__ ("¿Desea realemente eliminar todos los eventos del ")+Substring:C12($stringDate;1;Length:C16($stringDate)-3)+__ ("?");__ ("");__ ("No");__ ("Sí"))
				If (ok=2)
					LOG_RegisterEvt ("Eventos eliminados en el calendario de "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+":["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+"]";Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
					READ WRITE:C146([Asignaturas_Eventos:170])
					QUERY:C277([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]ID_asignatura:1=[Asignaturas:18]Numero:1;*)
					QUERY:C277([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2=$date)
					DELETE SELECTION:C66([Asignaturas_Eventos:170])
					READ ONLY:C145([Asignaturas_Eventos:170])
					AS_PageCalendar (vd_currentDate)
				End if 
				
			: ($userChoice=9)
				
				ARRAY LONGINT:C221($aID_asig;0)
				ARRAY LONGINT:C221(aRecNum_Eventos;0)
				_O_C_INTEGER:C282($f;$t)
				C_LONGINT:C283($recnum_asig)
				
				$recnum_asig:=Record number:C243([Asignaturas:18])
				
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$aID_asig)
				
				QUERY WITH ARRAY:C644([Asignaturas_Eventos:170]ID_asignatura:1;$aID_asig)
				QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2=$date)
				QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]UserID:10=<>lUSR_CurrentUserID;*)
				QUERY SELECTION:C341([Asignaturas_Eventos:170]; | [Asignaturas_Eventos:170]Privado:9=False:C215)
				LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Eventos:170];aRecNum_Eventos)
				  //vt_eventosactualesdelcurso:=""
				ARRAY TEXT:C222(a_ev_curso;0)
				ARRAY TEXT:C222(a_ev_asig;0)
				ARRAY TEXT:C222(a_ev_detalle;0)
				ARRAY LONGINT:C221(a_ev_idEvento;0)
				
				For ($t;1;Size of array:C274(aRecNum_Eventos))
					
					GOTO RECORD:C242([Asignaturas_Eventos:170];aRecNum_Eventos{$t})
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_Eventos:170]ID_asignatura:1)
					
					If ([Asignaturas_Eventos:170]Evento:3#"")
						APPEND TO ARRAY:C911(a_ev_curso;[Asignaturas:18]Curso:5)
						APPEND TO ARRAY:C911(a_ev_asig;[Asignaturas:18]Abreviación:26)
						APPEND TO ARRAY:C911(a_ev_detalle;Substring:C12([Asignaturas_Eventos:170]Evento:3;1;25))
						APPEND TO ARRAY:C911(a_ev_idEvento;[Asignaturas_Eventos:170]ID_Event:11)
					Else 
						APPEND TO ARRAY:C911(a_ev_curso;[Asignaturas:18]Curso:5)
						APPEND TO ARRAY:C911(a_ev_asig;[Asignaturas:18]Abreviación:26)
						APPEND TO ARRAY:C911(a_ev_detalle;Substring:C12([Asignaturas_Eventos:170]Tipo Evento:7;1;25))
						APPEND TO ARRAY:C911(a_ev_idEvento;[Asignaturas_Eventos:170]ID_Event:11)
					End if 
				End for 
				
				GOTO RECORD:C242([Asignaturas:18];$recnum_asig)
				$title:=__ ("Eventos Correspondientes al: ")+String:C10($date)
				vd_fechaBloqueoDia:=$date
				WDW_OpenFormWindow (->[Cursos:3];"Eventos_Agenda";0;4;$title)
				DIALOG:C40([Cursos:3];"Eventos_Agenda")
				CLOSE WINDOW:C154
				
		End case 
		
	: (Form event:C388=On Double Clicked:K2:5)
		Case of 
			: (($text#"") & ($eventRecNum>=0) & ([Asignaturas:18]profesor_numero:4=[Asignaturas_Eventos:170]ID_Profesor:8) | (<>lUSR_CurrentUserID<0))
				HIGHLIGHT TEXT:C210($pointer->;Position:C15($text;$pointer->);Position:C15($text;$pointer->)+Length:C16($text))
			: ($text="")
				vd_EventDate:=$date
				$title:=__ ("Nuevo evento en ")+[Asignaturas:18]denominacion_interna:16
				WDW_OpenFormWindow (->[Asignaturas_Eventos:170];"Entrada";7;Palette form window:K39:9;$title)
				FORM SET INPUT:C55([Asignaturas_Eventos:170];"Entrada")
				ADD RECORD:C56([Asignaturas_Eventos:170];*)
				CLOSE WINDOW:C154
				If (ok=1)
					AS_PageCalendar (vd_currentDate)
				End if 
			Else 
		End case 
	: (Form event:C388=On Clicked:K2:4)
		If (($text#"") & ($eventRecNum>=0) & (Not:C34($displayContextMenu)))
			
			If ((([Asignaturas_Eventos:170]UserID:10=<>lUSR_CurrentUserID) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))))
				  // Modificado por: Saúl Ponce (10-05-2017) Ticket 181055, agregué esto para anunciar al usuario por qué no puede editar el evento.
				vd_EventDate:=$date
				GOTO RECORD:C242([Asignaturas_Eventos:170];$eventRecNum)
				$title:=[Asignaturas:18]denominacion_interna:16+", "+String:C10([Asignaturas_Eventos:170]Fecha:2;3)
				WDW_OpenFormWindow (->[Asignaturas_Eventos:170];"Entrada";7;Palette form window:K39:9;$title)
				KRL_ModifyRecord (->[Asignaturas_Eventos:170];"Entrada")
				CLOSE WINDOW:C154
				If (ok=1)
					AS_PageCalendar (vd_currentDate)
				End if 
				HIGHLIGHT TEXT:C210($pointer->;Position:C15($text;$pointer->);Position:C15($text;$pointer->)+Length:C16($text))
			Else 
				$vt_userName:=KRL_GetTextFieldData (->[xShell_Users:47]No:1;->[Asignaturas_Eventos:170]UserID:10;->[xShell_Users:47]Name:2)
				CD_Dlog (0;"Solo el creador o el administrador del sistema pueden editar y/o eliminar este evento.\n\nEl creador de este evento es: "+ST_Qte ($vt_userName)+".")
			End if 
			
		End if 
		
End case 