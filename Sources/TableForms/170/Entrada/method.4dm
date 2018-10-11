Spell_CheckSpelling 
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_LONGINT:C283($numdia)
		READ ONLY:C145([TMT_Horario:166])
		
		If (Is new record:C668([Asignaturas_Eventos:170]))
			  //157386
			  //proponemos la primera hora de clase si tenemos un horario configurado
			$numdia:=DT_GetDayNumber_ISO8601 (vd_EventDate)
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=$numdia;*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=vd_EventDate;*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=vd_EventDate)
			ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2;>)
			
			[Asignaturas_Eventos:170]Hora_Inicio:13:=[TMT_Horario:166]Desde:3
			[Asignaturas_Eventos:170]Hora_Termino:14:=[TMT_Horario:166]Hasta:4
			[Asignaturas_Eventos:170]ID_asignatura:1:=[Asignaturas:18]Numero:1
			[Asignaturas_Eventos:170]ID_Profesor:8:=[Asignaturas:18]profesor_numero:4
			[Asignaturas_Eventos:170]UserID:10:=<>lUSR_CurrentUserID
			[Asignaturas_Eventos:170]Fecha:2:=vd_EventDate
			[Asignaturas_Eventos:170]Publicar:5:=True:C214
			  // MONO TICKET 179641
			OBJECT SET VISIBLE:C603(*;"DTS_creacion";False:C215)
			OBJECT SET VISIBLE:C603(*;"DTS_Modificacion";False:C215)
		Else 
			  // MONO TICKET 179641
			OBJECT SET TITLE:C194(*;"DTS_creacion";__ ("Creado: ^0";DTS_GetDateTimeString ([Asignaturas_Eventos:170]DTS_creacion:6)))
			OBJECT SET TITLE:C194(*;"DTS_Modificacion";__ ("Modificado: ^0";DTS_GetDateTimeString ([Asignaturas_Eventos:170]DTS_ultimaModificacion:17)))
			OBJECT SET VISIBLE:C603(*;"DTS_creacion";True:C214)
			OBJECT SET VISIBLE:C603(*;"DTS_Modificacion";True:C214)
		End if 
		
		wref:=WDW_GetWindowID 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
