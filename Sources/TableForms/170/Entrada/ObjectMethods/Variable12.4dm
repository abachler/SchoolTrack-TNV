  //157386
C_BOOLEAN:C305($b_fechaOK;$b_TipoOk;$b_HoraEvtOk)
  //MONO: ticket 165257

If (([Asignaturas_Eventos:170]Fecha:2#!00-00-00!) & ([Asignaturas_Eventos:170]Tipo Evento:7#"") & ([Asignaturas_Eventos:170]Evento:3#""))
	
	$b_TipoOk:=AS_validaIngresoEventoCalendari ("validaCantidadTipoEvento";[Asignaturas_Eventos:170]Fecha:2;[Asignaturas:18]Numero:1;SchoolTrack;[Asignaturas_Eventos:170]Tipo Evento:7)
	$b_HoraEvtOk:=AS_validaIngresoEventoCalendari ("validaHoraEvento";[Asignaturas_Eventos:170]Fecha:2;[Asignaturas:18]Numero:1;SchoolTrack)
	$b_fechaOK:=AS_validaIngresoEventoCalendari ("validaCalendarioAsig";[Asignaturas_Eventos:170]Fecha:2;[Asignaturas:18]Numero:1)
	
	If (($b_TipoOk) & ($b_HoraEvtOk) & ($b_fechaOK))
		  //ticket 160121 JVP
		If (Not:C34(Is new record:C668([Asignaturas_Eventos:170])))
			LOG_RegisterEvt ("Edición de evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]")
		End if 
		ACCEPT:C269
	End if 
	
Else 
	$ignore:=CD_Dlog (0;__ ("Por favor complete los campos Fecha, Tipo de evento y Evento."))
End if 