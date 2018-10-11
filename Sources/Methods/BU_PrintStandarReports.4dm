//%attributes = {}
  //BU_PrintStandarReports

Case of 
	: (vl_TipoInformeTT=1)
		If (Records in table:C83([BU_Rutas:26])>0)
			READ ONLY:C145([BU_Rutas:26])
			ALL RECORDS:C47([BU_Rutas:26])
			ORDER BY:C49([BU_Rutas:26];[BU_Rutas:26]Nombre:9;>)
			FORM SET OUTPUT:C54([BU_Rutas:26];"Lista Impresa")
			PRINT SELECTION:C60([BU_Rutas:26])
		Else 
			CD_Dlog (0;__ ("No existen rutas para imprimir."))
		End if 
		
	: (vl_TipoInformeTT=2)
		READ ONLY:C145([BU_Rutas_Inscripciones:35])
		QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Profesor:3#0)
		ORDER BY:C49([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Nombre_y_Apellidos:9)
		If (Records in selection:C76([BU_Rutas_Inscripciones:35])>0)
			vl_Correlativo:=0
			FORM SET OUTPUT:C54([BU_Rutas_Inscripciones:35];"ListadoFuncionarios")
			PRINT SELECTION:C60([BU_Rutas_Inscripciones:35])
		Else 
			CD_Dlog (0;__ ("No existen registros de incripciones para imprimir"))
		End if 
		
	: (vl_TipoInformeTT=3)
		Case of 
			: (lr1=1)  //todas las rutas
				ARRAY LONGINT:C221($alCodigoRuta;0)
				READ ONLY:C145([BU_Rutas:26])
				ALL RECORDS:C47([BU_Rutas:26])
				ORDER BY:C49([BU_Rutas:26];[BU_Rutas:26]Nombre:9;>)
				ARRAY LONGINT:C221($alRecNumber;0)
				LONGINT ARRAY FROM SELECTION:C647([BU_Rutas:26];$alRecNumber;"")
				PRINT SETTINGS:C106
				For ($i;1;Size of array:C274($alRecNumber))
					GOTO RECORD:C242([BU_Rutas:26];$alRecNumber{$i})
					vt_RutaName:=[BU_Rutas:26]Nombre:9
					vt_PatenteVeh:=[BU_Rutas:26]Patente_Bus:11
					vt_CalleInicio:=[BU_Rutas:26]Calle_Inicial:6
					vt_CalleFin:=[BU_Rutas:26]Calle_Final:7
					READ ONLY:C145([Profesores:4])
					QUERY:C277([Profesores:4];[Profesores:4]Numero:1;=;[BU_Rutas:26]Numero_Monitor:10)
					vt_MonitorName:=[Profesores:4]Apellidos_y_nombres:28
					READ ONLY:C145([Buses_escolares:57])
					QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1;=;[BU_Rutas:26]Patente_Bus:11)
					vl_NroVeh:=[Buses_escolares:57]Numero:10
					vl_CupoVeh:=[Buses_escolares:57]Capacidad:11
					vt_ConductorName:=[Buses_escolares:57]Chofer:5
					ARRAY TEXT:C222(atBU_ListaComunas;0)
					READ ONLY:C145([BU_Rutas_Comunas:27])
					QUERY:C277([BU_Rutas_Comunas:27];[BU_Rutas_Comunas:27]Numero_Ruta:1;=;[BU_Rutas:26]ID:12)
					SELECTION TO ARRAY:C260([BU_Rutas_Comunas:27]Nombre_Comuna:2;atBU_ListaComunas)
					ARRAY LONGINT:C221(alBU_ListaCodRec;0)
					ARRAY TEXT:C222(atBU_ListaJorRec;0)
					ARRAY LONGINT:C221(alBU_ListaHoraRec;0)
					ARRAY TEXT:C222(atBU_ListaDiaRec;0)
					ARRAY BOOLEAN:C223(abBU_ListaSentRec;0)
					READ ONLY:C145([BU_Rutas_Recorridos:33])
					QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;[BU_Rutas:26]ID:12)
					SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_ListaCodRec;[BU_Rutas_Recorridos:33]Jornada:4;atBU_ListaJorRec;[BU_Rutas_Recorridos:33]Hora:5;alBU_ListaHoraRec;[BU_Rutas_Recorridos:33]Dia_Semana:6;atBU_ListaDiaRec;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;abBU_ListaSentRec)
					READ ONLY:C145([xxSTR_Constants:1])
					ALL RECORDS:C47([xxSTR_Constants:1])
					ONE RECORD SELECT:C189([xxSTR_Constants:1])
					FORM SET OUTPUT:C54([xxSTR_Constants:1];"BU_InformacionRuta")
					PRINT SELECTION:C60([xxSTR_Constants:1];>)
				End for 
			: (lr2=1)  //las rutas seleccionadas
				$Line:=AL_GetLine (xalp_Rutas)
				vt_RutaName:=atBU_NombreRuta{$Line}
				vt_PatenteVeh:=atBU_PatenteRuta{$Line}
				vt_MonitorName:=atBU_MonitorRuta{$Line}
				READ ONLY:C145([BU_Rutas:26])
				QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;alBU_IdRuta{$Line})
				vt_CalleInicio:=[BU_Rutas:26]Calle_Inicial:6
				vt_CalleFin:=[BU_Rutas:26]Calle_Final:7
				READ ONLY:C145([Buses_escolares:57])
				QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1;=;vt_PatenteVeh)
				vl_NroVeh:=[Buses_escolares:57]Numero:10
				vl_CupoVeh:=[Buses_escolares:57]Capacidad:11
				vt_ConductorName:=[Buses_escolares:57]Chofer:5
				ARRAY TEXT:C222(atBU_ListaComunas;0)
				READ ONLY:C145([BU_Rutas_Comunas:27])
				QUERY:C277([BU_Rutas_Comunas:27];[BU_Rutas_Comunas:27]Numero_Ruta:1;=;alBU_IdRuta{$Line})
				SELECTION TO ARRAY:C260([BU_Rutas_Comunas:27]Nombre_Comuna:2;atBU_ListaComunas)
				ARRAY LONGINT:C221(alBU_ListaCodRec;0)
				ARRAY TEXT:C222(atBU_ListaJorRec;0)
				ARRAY LONGINT:C221(alBU_ListaHoraRec;0)
				ARRAY TEXT:C222(atBU_ListaDiaRec;0)
				ARRAY BOOLEAN:C223(abBU_ListaSentRec;0)
				READ ONLY:C145([BU_Rutas_Recorridos:33])
				QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;alBU_IdRuta{$Line})
				SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_ListaCodRec;[BU_Rutas_Recorridos:33]Jornada:4;atBU_ListaJorRec;[BU_Rutas_Recorridos:33]Hora:5;alBU_ListaHoraRec;[BU_Rutas_Recorridos:33]Dia_Semana:6;atBU_ListaDiaRec;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;abBU_ListaSentRec)
				READ ONLY:C145([xxSTR_Constants:1])
				ALL RECORDS:C47([xxSTR_Constants:1])
				ONE RECORD SELECT:C189([xxSTR_Constants:1])
				FORM SET OUTPUT:C54([xxSTR_Constants:1];"BU_InformacionRuta")
				PRINT SELECTION:C60([xxSTR_Constants:1])
		End case 
		
	: (vl_TipoInformeTT=4)
		vt_ALCurso:=<>aCursos{<>acursos}
		ARRAY LONGINT:C221(alBU_ALCod;0)
		ARRAY LONGINT:C221(alBU_ALCodigo;0)
		ARRAY TEXT:C222(atBU_ALName;0)
		ARRAY TEXT:C222(alBU_ALRutaName;0)
		ARRAY TEXT:C222(atBU_ALTipoServicio;0)
		ARRAY TEXT:C222(atBU_ALAcomp;0)
		
		READ ONLY:C145([BU_Rutas_Inscripciones:35])
		QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Alumno:2#0)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Alumno:2;alBU_ALCod)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		QRY_QueryWithArray (->[Alumnos:2]numero:1;->alBU_ALCod)
		CREATE SET:C116([Alumnos:2];"ALinscritos")
		REDUCE SELECTION:C351([Alumnos:2];0)
		
		  //2.- Busca los alumnos del curso seleccionado
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=vt_ALCurso)
		CREATE SET:C116([Alumnos:2];"ALdelCurso")
		REDUCE SELECTION:C351([Alumnos:2];0)
		
		  //3.- Reduce la selección a no inscritos
		CREATE SET:C116([Alumnos:2];"ALInsCurso")
		INTERSECTION:C121("ALdelCurso";"ALinscritos";"ALInsCurso")
		
		ARRAY LONGINT:C221(alBU_ALCod;0)
		USE SET:C118("ALInsCurso")
		ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;alBU_ALCod)
		
		QRY_QueryWithArray (->[BU_Rutas_Inscripciones:35]Numero_Alumno:2;->alBU_ALCod)
		ORDER BY:C49([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Nombre_y_Apellidos:9;>)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Alumno:2;alBU_ALCodigo;[BU_Rutas_Inscripciones:35]Nombre_y_Apellidos:9;atBU_ALName;[BU_Rutas_Inscripciones:35]Tipo_Servicio:6;atBU_ALTipoServicio;[BU_Rutas_Inscripciones:35]Acompañado_por:7;atBU_ALAcomp;[BU_Rutas:26]Nombre:9;alBU_ALRutaName)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		SET_ClearSets ("ALdelCurso";"ALinscritos";"ALInsCurso")
		
		READ ONLY:C145([xxSTR_Constants:1])
		ALL RECORDS:C47([xxSTR_Constants:1])
		ONE RECORD SELECT:C189([xxSTR_Constants:1])
		FORM SET OUTPUT:C54([xxSTR_Constants:1];"BU_AlumnosxCurso")
		PRINT SELECTION:C60([xxSTR_Constants:1])
		
		
	: (vl_TipoInformeTT=5)
		C_LONGINT:C283(vlNumeroRuta)
		READ ONLY:C145([BU_Rutas:26])
		QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;vlNumeroRuta)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		vt_BUMonitor:=[Profesores:4]Apellidos_y_nombres:28
		vt_BUConductor:=[Buses_escolares:57]Chofer:5
		vt_PTBus:=[BU_Rutas:26]Patente_Bus:11
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		  //1.- Se buscan todos los alumnos inscritos en algún recorrido de la ruta
		
		If (vtSentido="Llegada")
			$SentidoRec:=True:C214
		Else 
			$SentidoRec:=False:C215
		End if 
		ARRAY LONGINT:C221(alBU_totalRecRuta;0)
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;vlNumeroRuta;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;=;$SentidoRec)
		SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_totalRecRuta)
		
		ARRAY LONGINT:C221(alBU_totalALRuta;0)
		READ ONLY:C145([BU_Rutas_Inscripciones:35])
		QRY_QueryWithArray (->[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;->alBU_totalRecRuta)
		SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Alumno:2;alBU_totalALRuta)
		
		ARRAY LONGINT:C221(alBU_ALIDGeneral;0)
		ARRAY TEXT:C222(atBU_ALNameGral;0)
		ARRAY TEXT:C222(atBU_ALCursoGral;0)
		READ ONLY:C145([Alumnos:2])
		QRY_QueryWithArray (->[Alumnos:2]numero:1;->alBU_totalALRuta)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;alBU_ALIDGeneral;[Alumnos:2]apellidos_y_nombres:40;atBU_ALNameGral;[Alumnos:2]curso:20;atBU_ALCursoGral)
		
		ARRAY TEXT:C222(atBU_AsisLunes;0)
		ARRAY TEXT:C222(atBU_AsisMartes;0)
		ARRAY TEXT:C222(atBU_AsisMiercoles;0)
		ARRAY TEXT:C222(atBU_AsisJueves;0)
		ARRAY TEXT:C222(atBU_AsisViernes;0)
		ARRAY TEXT:C222(atBU_AsisSabado;0)
		ARRAY TEXT:C222(atBU_AsisLunes;Size of array:C274(alBU_ALIDGeneral))
		ARRAY TEXT:C222(atBU_AsisMartes;Size of array:C274(alBU_ALIDGeneral))
		ARRAY TEXT:C222(atBU_AsisMiercoles;Size of array:C274(alBU_ALIDGeneral))
		ARRAY TEXT:C222(atBU_AsisJueves;Size of array:C274(alBU_ALIDGeneral))
		ARRAY TEXT:C222(atBU_AsisViernes;Size of array:C274(alBU_ALIDGeneral))
		ARRAY TEXT:C222(atBU_AsisSabado;Size of array:C274(alBU_ALIDGeneral))
		ARRAY LONGINT:C221(alBU_IDAuxiliar;0)
		ARRAY BOOLEAN:C223(alBU_AsisAuxiliar;0)
		ARRAY LONGINT:C221(alBU_ViajeAux;0)
		
		
		
		  //Se arma el arreglo de la asistencia del día lunes
		ARRAY LONGINT:C221(alBU_totalRecRuta;0)
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;vlNumeroRuta;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;=;$SentidoRec;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Dia_Semana_Num:12;=;1)
		SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_totalRecRuta)
		QRY_QueryWithArray (->[BU_Viajes:109]Numero_Recorrido:4;->alBU_totalRecRuta)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2>=dDate1)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2<=dDate2)
		SELECTION TO ARRAY:C260([BU_Viajes:109]ID:1;alBU_ViajeAux)
		QRY_QueryWithArray (->[BU_Viajes_Personas:111]Numero_Viaje:2;->alBU_ViajeAux)
		QUERY SELECTION:C341([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Alumno:3#0)
		SELECTION TO ARRAY:C260([BU_Viajes_Personas:111]Numero_Alumno:3;alBU_IDAuxiliar;[BU_Viajes_Personas:111]Asiste:5;alBU_AsisAuxiliar)
		For ($i;1;Size of array:C274(alBU_ALIDGeneral))
			$codigoAL:=alBU_ALIDGeneral{$i}
			$encontrado:=Find in array:C230(alBU_IDAuxiliar;$codigoAL)
			If ($encontrado>0)
				If (alBU_AsisAuxiliar{$encontrado}=True:C214)
					atBU_AsisLunes{$i}:="Si"
				Else 
					atBU_AsisLunes{$i}:="No"
				End if 
				
			Else 
				atBU_AsisLunes{$i}:="-"
			End if 
			
		End for 
		
		
		  //Se arma el arreglo de la asistencia del día Martes
		ARRAY LONGINT:C221(alBU_totalRecRuta;0)
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;vlNumeroRuta;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;=;$SentidoRec;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Dia_Semana_Num:12;=;2)
		SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_totalRecRuta)
		QRY_QueryWithArray (->[BU_Viajes:109]Numero_Recorrido:4;->alBU_totalRecRuta)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2>=dDate1)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2<=dDate2)
		SELECTION TO ARRAY:C260([BU_Viajes:109]ID:1;alBU_ViajeAux)
		QRY_QueryWithArray (->[BU_Viajes_Personas:111]Numero_Viaje:2;->alBU_ViajeAux)
		QUERY SELECTION:C341([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Alumno:3#0)
		SELECTION TO ARRAY:C260([BU_Viajes_Personas:111]Numero_Alumno:3;alBU_IDAuxiliar;[BU_Viajes_Personas:111]Asiste:5;alBU_AsisAuxiliar)
		For ($i;1;Size of array:C274(alBU_ALIDGeneral))
			$codigoAL:=alBU_ALIDGeneral{$i}
			$encontrado:=Find in array:C230(alBU_IDAuxiliar;$codigoAL)
			If ($encontrado>0)
				If (alBU_AsisAuxiliar{$encontrado}=True:C214)
					atBU_AsisMartes{$i}:="Si"
				Else 
					atBU_AsisMartes{$i}:="No"
				End if 
				
			Else 
				atBU_AsisMartes{$i}:="-"
			End if 
			
		End for 
		  //Se arma el arreglo de la asistencia del día Mércoles
		ARRAY LONGINT:C221(alBU_totalRecRuta;0)
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;vlNumeroRuta;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;=;$SentidoRec;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Dia_Semana_Num:12;=;3)
		SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_totalRecRuta)
		QRY_QueryWithArray (->[BU_Viajes:109]Numero_Recorrido:4;->alBU_totalRecRuta)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2>=dDate1)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2<=dDate2)
		SELECTION TO ARRAY:C260([BU_Viajes:109]ID:1;alBU_ViajeAux)
		QRY_QueryWithArray (->[BU_Viajes_Personas:111]Numero_Viaje:2;->alBU_ViajeAux)
		QUERY SELECTION:C341([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Alumno:3#0)
		SELECTION TO ARRAY:C260([BU_Viajes_Personas:111]Numero_Alumno:3;alBU_IDAuxiliar;[BU_Viajes_Personas:111]Asiste:5;alBU_AsisAuxiliar)
		For ($i;1;Size of array:C274(alBU_ALIDGeneral))
			$codigoAL:=alBU_ALIDGeneral{$i}
			$encontrado:=Find in array:C230(alBU_IDAuxiliar;$codigoAL)
			If ($encontrado>0)
				If (alBU_AsisAuxiliar{$encontrado}=True:C214)
					atBU_AsisMiercoles{$i}:="Si"
				Else 
					atBU_AsisMiercoles{$i}:="No"
				End if 
				
			Else 
				atBU_AsisMiercoles{$i}:="-"
			End if 
			
		End for 
		
		  //Se arma el arreglo de la asistencia del día Jueves
		ARRAY LONGINT:C221(alBU_totalRecRuta;0)
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;vlNumeroRuta;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;=;$SentidoRec;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Dia_Semana_Num:12;=;4)
		SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_totalRecRuta)
		QRY_QueryWithArray (->[BU_Viajes:109]Numero_Recorrido:4;->alBU_totalRecRuta)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2>=dDate1)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2<=dDate2)
		SELECTION TO ARRAY:C260([BU_Viajes:109]ID:1;alBU_ViajeAux)
		QRY_QueryWithArray (->[BU_Viajes_Personas:111]Numero_Viaje:2;->alBU_ViajeAux)
		QUERY SELECTION:C341([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Alumno:3#0)
		SELECTION TO ARRAY:C260([BU_Viajes_Personas:111]Numero_Alumno:3;alBU_IDAuxiliar;[BU_Viajes_Personas:111]Asiste:5;alBU_AsisAuxiliar)
		For ($i;1;Size of array:C274(alBU_ALIDGeneral))
			$codigoAL:=alBU_ALIDGeneral{$i}
			$encontrado:=Find in array:C230(alBU_IDAuxiliar;$codigoAL)
			If ($encontrado>0)
				If (alBU_AsisAuxiliar{$encontrado}=True:C214)
					atBU_AsisJueves{$i}:="Si"
				Else 
					atBU_AsisJueves{$i}:="No"
				End if 
				
			Else 
				atBU_AsisJueves{$i}:="-"
			End if 
			
		End for 
		
		  //Se arma el arreglo de la asistencia del día Viernes
		ARRAY LONGINT:C221(alBU_totalRecRuta;0)
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;vlNumeroRuta;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;=;$SentidoRec;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Dia_Semana_Num:12;=;5)
		SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_totalRecRuta)
		QRY_QueryWithArray (->[BU_Viajes:109]Numero_Recorrido:4;->alBU_totalRecRuta)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2>=dDate1)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2<=dDate2)
		SELECTION TO ARRAY:C260([BU_Viajes:109]ID:1;alBU_ViajeAux)
		QRY_QueryWithArray (->[BU_Viajes_Personas:111]Numero_Viaje:2;->alBU_ViajeAux)
		QUERY SELECTION:C341([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Alumno:3#0)
		SELECTION TO ARRAY:C260([BU_Viajes_Personas:111]Numero_Alumno:3;alBU_IDAuxiliar;[BU_Viajes_Personas:111]Asiste:5;alBU_AsisAuxiliar)
		For ($i;1;Size of array:C274(alBU_ALIDGeneral))
			$codigoAL:=alBU_ALIDGeneral{$i}
			$encontrado:=Find in array:C230(alBU_IDAuxiliar;$codigoAL)
			If ($encontrado>0)
				If (alBU_AsisAuxiliar{$encontrado}=True:C214)
					atBU_AsisViernes{$i}:="Si"
				Else 
					atBU_AsisViernes{$i}:="No"
				End if 
				
			Else 
				atBU_AsisViernes{$i}:="-"
			End if 
			
		End for 
		  //Se arma el arreglo de la asistencia del día Sábado
		ARRAY LONGINT:C221(alBU_totalRecRuta;0)
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;vlNumeroRuta;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;=;$SentidoRec;*)
		QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Dia_Semana_Num:12;=;6)
		SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_totalRecRuta)
		QRY_QueryWithArray (->[BU_Viajes:109]Numero_Recorrido:4;->alBU_totalRecRuta)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2>=dDate1)
		QUERY SELECTION:C341([BU_Viajes:109];[BU_Viajes:109]Fecha:2<=dDate2)
		SELECTION TO ARRAY:C260([BU_Viajes:109]ID:1;alBU_ViajeAux)
		QRY_QueryWithArray (->[BU_Viajes_Personas:111]Numero_Viaje:2;->alBU_ViajeAux)
		QUERY SELECTION:C341([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Alumno:3#0)
		SELECTION TO ARRAY:C260([BU_Viajes_Personas:111]Numero_Alumno:3;alBU_IDAuxiliar;[BU_Viajes_Personas:111]Asiste:5;alBU_AsisAuxiliar)
		For ($i;1;Size of array:C274(alBU_ALIDGeneral))
			$codigoAL:=alBU_ALIDGeneral{$i}
			$encontrado:=Find in array:C230(alBU_IDAuxiliar;$codigoAL)
			If ($encontrado>0)
				If (alBU_AsisAuxiliar{$encontrado}=True:C214)
					atBU_AsisSabado{$i}:="Si"
				Else 
					atBU_AsisSabado{$i}:="No"
				End if 
			Else 
				atBU_AsisSabado{$i}:="-"
			End if 
			
		End for 
		READ ONLY:C145([xxSTR_Constants:1])
		ALL RECORDS:C47([xxSTR_Constants:1])
		ONE RECORD SELECT:C189([xxSTR_Constants:1])
		FORM SET OUTPUT:C54([xxSTR_Constants:1];"BU_AsistenciaSemanal")
		PRINT SELECTION:C60([xxSTR_Constants:1])
End case 