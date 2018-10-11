  // [Cursos].Eventos_Agenda.vlbox()
  //
  //
  // creado por: Alberto Bachler Klein: 04-08-16, 19:17:35
  // -----------------------------------------------------------
C_LONGINT:C283($l_accion;$l_columna;$l_fila)
C_POINTER:C301($y_EventosRecNum)

$y_EventosRecNum:=OBJECT Get pointer:C1124(Object named:K67:5;"eventos_RecNum")

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087(Object current:K67:2);$l_columna;$l_fila)
			If ($l_fila>0)
				KRL_GotoRecord (->[Asignaturas_Eventos:170];$y_EventosRecNum->{$l_fila};False:C215)
				READ ONLY:C145([Asignaturas:18])
				RELATE ONE:C42([Asignaturas_Eventos:170]ID_asignatura:1)
				If (([Asignaturas:18]profesor_numero:4=[Asignaturas_Eventos:170]ID_Profesor:8) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)))
					$l_accion:=Pop up menu:C542("Eliminar evento")
				Else 
					$l_accion:=Pop up menu:C542("(Eliminar evento")
				End if 
				If ($l_accion=1)
					OK:=ModernUI_Notificacion (__ ("Eliminación de evento de asignatura");"¿Desea realmente eliminar este evento?";"Cancelar";"Eliminar")
					If (OK=2)
						KRL_DeleteRecord (->[Asignaturas_Eventos:170])
						LISTBOX DELETE ROWS:C914(*;OBJECT Get name:C1087(Object current:K67:2);$l_fila)
					End if 
				End if 
			Else 
				$l_accion:=Pop up menu:C542("(Eliminar evento")
			End if 
		End if 
End case 



