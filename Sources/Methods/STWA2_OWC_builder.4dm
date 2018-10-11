//%attributes = {}
  // Método: STWA2_OWC_builder
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:02:02
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$dato:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dato")
Case of 
	: ($dato="calendarevents")
		ARRAY TEXT:C222($at_json;0)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$profID:=STWA2_Session_GetProfID ($uuid)
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([Asignaturas_Eventos:170])
		C_OBJECT:C1216($ob_nodo)
		
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$start:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"start")
		$end:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"end")
		$t_curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
		
		ARRAY TEXT:C222($aTemp;0)
		AT_Text2Array (->$aTemp;$start;"-")
		$dd:=Num:C11($aTemp{3})
		$md:=Num:C11($aTemp{2})
		$ad:=Num:C11($aTemp{1})
		$startDate:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		AT_Text2Array (->$aTemp;$end;"-")
		$dd:=Num:C11($aTemp{3})
		$md:=Num:C11($aTemp{2})
		$ad:=Num:C11($aTemp{1})
		$endDate:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215)
		ARRAY LONGINT:C221($aID_asig;0)
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Retirado@")
		AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$aID_asig)
		QUERY WITH ARRAY:C644([Asignaturas_Eventos:170]ID_asignatura:1;$aID_asig)
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2>=$startDate)
		QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2<$endDate)
		CREATE SET:C116([Asignaturas_Eventos:170];"Eventos")
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]UserID:10=$userID)
		CREATE SET:C116([Asignaturas_Eventos:170];"EventosUsuario")
		USE SET:C118("Eventos")
		If ($userID>=0)
			QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]UserID:10#$userID;*)
			QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Privado:9=False:C215)
		End if 
		CREATE SET:C116([Asignaturas_Eventos:170];"OtrosEventos")
		CREATE EMPTY SET:C140([Asignaturas_Eventos:170];"resultado")
		UNION:C120("EventosUsuario";"OtrosEventos";"resultado")
		USE SET:C118("resultado")
		
		
		  //curso
		
		If ($t_curso#"")
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_curso)
			KRL_RelateSelection (->[Asignaturas_Eventos:170]ID_asignatura:1;->[Asignaturas:18]Numero:1;"")
			QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2>=$startDate)
			QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2<$endDate)
			CREATE SET:C116([Asignaturas_Eventos:170];"curso")
			DIFFERENCE:C122("curso";"resultado";"resultado")
			USE SET:C118("resultado")
		End if 
		
		  //$jsonT:=JSON New 
		ARRAY LONGINT:C221($aRNs;Records in selection:C76([Asignaturas_Eventos:170]))
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Eventos:170];$aRNs)
		For ($i;1;Size of array:C274($aRNs))
			KRL_GotoRecord (->[Asignaturas_Eventos:170];$aRNs{$i};False:C215)
			KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Eventos:170]ID_asignatura:1;False:C215)
			If ([Asignaturas_Eventos:170]Evento:3#"")
				$evento_text:="["+[Asignaturas:18]Curso:5+"]"+"["+[Asignaturas:18]Abreviación:26+"]"+[Asignaturas_Eventos:170]Evento:3
			Else 
				$evento_text:="["+[Asignaturas:18]Curso:5+"]"+"["+[Asignaturas:18]Abreviación:26+"]"+[Asignaturas_Eventos:170]Tipo Evento:7
			End if 
			$editable:=(($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | ([Asignaturas:18]profesor_numero:4=$profID) | ([Asignaturas:18]profesor_firmante_numero:33=$profID) | ([Asignaturas_Eventos:170]UserID:10=$userID))
			
			  //cargo los alumnos
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
			ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_apellidoNombres)
			
			  //MONO TICKET 179641
			CLEAR VARIABLE:C89($ob_nodo)
			OB SET:C1220($ob_nodo;"id";[Asignaturas_Eventos:170]ID_Event:11)
			OB SET:C1220($ob_nodo;"title";$evento_text)
			OB SET:C1220($ob_nodo;"start";String:C10([Asignaturas_Eventos:170]Fecha:2;ISO date:K1:8))
			OB SET:C1220($ob_nodo;"desc";[Asignaturas_Eventos:170]Descripción:4)
			OB SET:C1220($ob_nodo;"tipo";[Asignaturas_Eventos:170]Tipo Evento:7)
			OB SET:C1220($ob_nodo;"evento";[Asignaturas_Eventos:170]Evento:3)
			OB SET:C1220($ob_nodo;"curso";[Asignaturas:18]Curso:5)
			OB SET:C1220($ob_nodo;"asignatura";[Asignaturas:18]denominacion_interna:16)
			OB SET:C1220($ob_nodo;"abrev";[Asignaturas:18]Abreviación:26)
			OB SET:C1220($ob_nodo;"profesor";[Asignaturas:18]profesor_nombre:13)
			OB SET:C1220($ob_nodo;"privado";[Asignaturas_Eventos:170]Privado:9)
			OB SET:C1220($ob_nodo;"publicar";[Asignaturas_Eventos:170]Publicar:5)
			OB SET:C1220($ob_nodo;"editable";$editable)
			OB SET:C1220($ob_nodo;"horadesde";String:C10([Asignaturas_Eventos:170]Hora_Inicio:13))
			OB SET:C1220($ob_nodo;"horahasta";String:C10([Asignaturas_Eventos:170]Hora_Termino:14))
			OB SET ARRAY:C1227($ob_nodo;"alumnos";$at_apellidoNombres)
			OB SET:C1220($ob_nodo;"dtsCreacion";DTS_GetDateTimeString ([Asignaturas_Eventos:170]DTS_creacion:6))
			OB SET:C1220($ob_nodo;"dtsModificacion";DTS_GetDateTimeString ([Asignaturas_Eventos:170]DTS_ultimaModificacion:17))
			APPEND TO ARRAY:C911($at_json;JSON Stringify:C1217($ob_nodo))
		End for 
		
		  //verifico las horas bloqueadas
		CU_cargaDiasBloqueados ([Asignaturas:18]Numero:1)
		If (Size of array:C274(at_curso)=0)
			AT_DimArrays (Size of array:C274(at_HorasBloqueadasMotivo);->at_curso)
		End if 
		
		  //SORT ARRAY(at_HorasBloqueadasMotivo;al_HoraDesde;al_HoraHasta;at_curso;>)
		For ($i;1;Size of array:C274(at_HorasBloqueadasMotivo))
			CLEAR VARIABLE:C89($ob_nodo)
			$evento_text:=at_HorasBloqueadasMotivo{$i}+" - "+Time string:C180(al_HoraDesde{$i})+">>"+Time string:C180(al_HoraHasta{$i})
			OB SET:C1220($ob_nodo;"id";"-2")  //MONO: al no ser un evento propiamente tal va con este -2 para que no sea modificado, ni tenga vista previa
			OB SET:C1220($ob_nodo;"title";$evento_text)
			OB SET:C1220($ob_nodo;"start";String:C10(ad_HorasBloqueadasFechas{$i};ISO date:K1:8))
			OB SET:C1220($ob_nodo;"desc";"")
			OB SET:C1220($ob_nodo;"tipo";$evento_text+" ["+at_curso{$i}+"]")
			OB SET:C1220($ob_nodo;"evento";"")
			OB SET:C1220($ob_nodo;"curso";at_curso{$i})
			OB SET:C1220($ob_nodo;"asignatura";"Hora Bloqueada")
			OB SET:C1220($ob_nodo;"abrev";"")
			OB SET:C1220($ob_nodo;"profesor";"-")
			OB SET:C1220($ob_nodo;"privado";False:C215)
			OB SET:C1220($ob_nodo;"publicar";False:C215)
			OB SET:C1220($ob_nodo;"editable";False:C215)
			OB SET:C1220($ob_nodo;"horadesde";Time string:C180(al_HoraDesde{$i}))
			OB SET:C1220($ob_nodo;"horahasta";Time string:C180(al_HoraHasta{$i}))
			
			APPEND TO ARRAY:C911($at_json;JSON Stringify:C1217($ob_nodo))
		End for 
		
		  //SORT ARRAY(at_fechasBloqueadasMotivo;ad_fechasBloqueadas;>)
		For ($i;1;Size of array:C274(ad_fechasBloqueadas))
			
			CLEAR VARIABLE:C89($ob_nodo)
			$evento_text:="Motivo Bloqueo: "+at_fechasBloqueadasMotivo{$i}
			OB SET:C1220($ob_nodo;"id";"-2")  //MONO: al no ser un evento propiamente tal va con este -2 para que no sea modificado, ni tenga vista previa
			OB SET:C1220($ob_nodo;"title";$evento_text)
			OB SET:C1220($ob_nodo;"start";String:C10(ad_fechasBloqueadas{$i};ISO date:K1:8))
			OB SET:C1220($ob_nodo;"desc";"")
			OB SET:C1220($ob_nodo;"tipo";"")
			OB SET:C1220($ob_nodo;"evento";"")
			OB SET:C1220($ob_nodo;"curso";"")
			OB SET:C1220($ob_nodo;"asignatura";"Día Bloqueado")
			OB SET:C1220($ob_nodo;"abrev";"")
			OB SET:C1220($ob_nodo;"profesor";"-")
			OB SET:C1220($ob_nodo;"privado";False:C215)
			OB SET:C1220($ob_nodo;"publicar";False:C215)
			OB SET:C1220($ob_nodo;"editable";False:C215)
			OB SET:C1220($ob_nodo;"horadesde";Time string:C180(Time:C179("00:00:01")))
			OB SET:C1220($ob_nodo;"horahasta";Time string:C180(Time:C179("23:59:59")))
			
			APPEND TO ARRAY:C911($at_json;JSON Stringify:C1217($ob_nodo))
		End for 
		
		$json:="["
		For ($i;1;Size of array:C274($at_json))
			If ($i=Size of array:C274($at_json))
				$t_delimitador:=""
			Else 
				$t_delimitador:=","
			End if 
			$json:=$json+$at_json{$i}+$t_delimitador
		End for 
		$json:=$json+"]"
		
		
	: ($dato="calendario")
		
		  //20160615 ASM Ticket 163218
		ARRAY TEXT:C222($afechaImpartida;0)
		ARRAY DATE:C224($ad_desde;0)
		ARRAY DATE:C224($ad_hasta;0)
		ARRAY INTEGER:C220($al_numeroDia;0)
		C_OBJECT:C1216($ob_objeto)
		
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12;>)
		SELECTION TO ARRAY:C260([TMT_Horario:166]SesionesDesde:12;$ad_desde;[TMT_Horario:166]SesionesHasta:13;$ad_hasta;[TMT_Horario:166]NumeroDia:1;$al_numeroDia)
		
		For ($i;1;Size of array:C274($ad_desde))
			$fechaDesde:=$ad_desde{$i}
			$fechaHasta:=$ad_hasta{$i}
			While ($fechaDesde<=$fechaHasta)
				$l_dia:=DT_GetDayNumber_ISO8601 ($fechaDesde)
				If (Find in array:C230(adSTR_Calendario_Feriados;$fechaDesde)=-1)
					If ($al_numeroDia{$i}=$l_dia)
						APPEND TO ARRAY:C911($afechaImpartida;String:C10(Year of:C25($fechaDesde);"0000")+"-"+String:C10(Month of:C24($fechaDesde);"00")+"-"+String:C10(Day of:C23($fechaDesde);"00"))
					End if 
				End if 
				$fechaDesde:=$fechaDesde+1
			End while 
		End for 
		AT_DistinctsArrayValues (->$afechaImpartida)
		
		PERIODOS_LoadData (0;[Asignaturas:18]Numero_del_Nivel:6)
		ARRAY TEXT:C222($aferiados;Size of array:C274(adSTR_Calendario_Feriados))
		For ($i;1;Size of array:C274($aferiados))
			$aferiados{$i}:=STWA2_MakeDate4JS (adSTR_Calendario_Feriados{$i})
		End for 
		
		  //ASM verifico los días bloqueados
		CU_cargaDiasBloqueados ([Asignaturas:18]Numero:1)
		ARRAY TEXT:C222($abloqueados;0)
		ARRAY TEXT:C222($abloqueados;Size of array:C274(ad_fechasBloqueadas))
		For ($i;1;Size of array:C274($abloqueados))
			$abloqueados{$i}:=String:C10(Year of:C25(ad_fechasBloqueadas{$i});"0000")+"-"+String:C10(Month of:C24(ad_fechasBloqueadas{$i});"00")+"-"+String:C10(Day of:C23(ad_fechasBloqueadas{$i});"00")
		End for 
		
		  //ASM cargo los cursos y grupos de la BD
		ARRAY TEXT:C222($at_cursosyGrupos;0)
		ARRAY TEXT:C222($at_cursos;0)
		ALL RECORDS:C47([Asignaturas:18])
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Curso:5;$at_cursos)
		
		For ($i;1;Size of array:C274($at_cursos))
			If (Find in array:C230($at_cursosyGrupos;$at_cursos{$i})=-1)
				APPEND TO ARRAY:C911($at_cursosyGrupos;$at_cursos{$i})
			End if 
		End for 
		
		  //cargo la configuración de horario para la semana de la asignatura
		C_OBJECT:C1216($ob_raiz)
		KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215)
		$ob_raiz:=OB_Create 
		ARRAY INTEGER:C220($al_numeroDia;0)
		QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		CREATE SET:C116([TMT_Horario:166];"horario")
		AT_DistinctsFieldValues (->[TMT_Horario:166]NumeroDia:1;->$al_numeroDia)
		For ($i;1;Size of array:C274($al_numeroDia))
			USE SET:C118("horario")
			QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$al_numeroDia{$i})
			ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2;>)
			SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroHora:2;$al_tmt_noHora;[TMT_Horario:166]Sala:8;$at_tmt_sala;[TMT_Horario:166]ID_Asignatura:5;$al_tmt_IdAsignatura;[TMT_Horario:166]Desde:3;$ah_tmt_desde;[TMT_Horario:166]Hasta:4;$ah_tmt_hasta)
			$ob_horario:=OB_Create 
			For ($ii;1;Size of array:C274($al_tmt_noHora))
				$ob_horariotemporal:=OB_Create 
				$t_desde:=Time string:C180($ah_tmt_desde{$ii})
				$t_hasta:=Time string:C180($ah_tmt_hasta{$ii})
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_tmt_IdAsignatura{$ii})
				OB_SET ($ob_horariotemporal;->$al_tmt_noHora{$ii};"hora")
				OB_SET ($ob_horariotemporal;->$t_desde;"horadesde")
				OB_SET ($ob_horariotemporal;->$t_hasta;"horahasta")
				OB_SET ($ob_horariotemporal;->[Asignaturas:18]Asignatura:3;"asignatura")
				OB_SET ($ob_horariotemporal;->[Asignaturas:18]Curso:5;"curso")
				OB_SET ($ob_horariotemporal;->$at_tmt_sala{$ii};"sala")
				OB_SET ($ob_horario;->$ob_horariotemporal;"hora"+String:C10($al_tmt_noHora{$ii}))
			End for 
			OB_SET ($ob_raiz;->$ob_horario;String:C10($al_numeroDia{$i}))
		End for 
		
		$ob_objeto:=OB_Create 
		OB_SET ($ob_objeto;-><>at_EventosAsignatura;"tiposevento")
		  //OB_SET ($ob_objeto;->$aDíasClasesLong;"diasimpartida")
		OB_SET ($ob_objeto;->$afechaImpartida;"diasimpartida")
		OB_SET ($ob_objeto;->$aferiados;"feriados")
		OB_SET ($ob_objeto;->$abloqueados;"diasbloqueados")
		OB_SET ($ob_objeto;->$at_cursosyGrupos;"cursos")
		OB_SET ($ob_objeto;->$ob_raiz;"horario")
		$json:=OB_Object2Json ($ob_objeto)
	: ($dato="inasistenciahora")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$d:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dd")
		$m:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"md")
		$a:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ad")
		$b_expandir:=Choose:C955(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"expandir")="true";True:C214;False:C215)
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			If (($d#"") & ($m#"") & ($a#""))
				$fecha:=DT_GetDateFromDayMonthYear (Num:C11($d);Num:C11($m);Num:C11($a))
				$json:=STWA2_AJAX_SendInasistenciaHora ($profID;$userID;$fecha;$b_expandir)
			Else 
				$json:=STWA2_AJAX_SendInasistenciaHora ($profID;$userID)
			End if 
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="planes")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$anteriores:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"anteriores"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			$json:=STWA2_AJAX_SendPlanes ($anteriores;$profID;$userID)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="sesiones")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$anteriores:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"anteriores"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			$json:=STWA2_AJAX_SendSesiones ($anteriores;$profID;$userID)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="objetivosasignatura")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			$json:=STWA2_AJAX_SendObjetivos ($periodo)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="infocalificacion")
		$tabla:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tabla"))
		$campo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"campo"))
		$rnCal:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$json:=STWA2_AJAX_SendInfoCal ($tabla;$campo;$rnCal;$periodo)
		
	: ($dato="mapas")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$alumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idAlumno"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			If ([Asignaturas:18]EVAPR_IdMatriz:91=0)
				READ ONLY:C145([MPA_AsignaturasMatrices:189])
				KRL_ReloadInReadWriteMode (->[Asignaturas:18])
				QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]Asignatura:3=[Asignaturas:18]Asignatura:3;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19=True:C214)
				If (Records in selection:C76([MPA_AsignaturasMatrices:189])=1)
					[Asignaturas:18]EVAPR_IdMatriz:91:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
				Else 
					[Asignaturas:18]EVAPR_IdMatriz:91:=MPA_CreaMatrizPorDefecto 
				End if 
				SAVE RECORD:C53([Asignaturas:18])
				KRL_ReloadAsReadOnly (->[Asignaturas:18])
			End if 
			If ($alumno=0)
				READ ONLY:C145([Alumnos_Calificaciones:208])
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40)
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					FIRST RECORD:C50([Alumnos_Calificaciones:208])
					
					  //20153006 ASM Ticket 146930 . para evitar que se carguen los datos un alumno con estado distinto a activo.
					  //$t_estado:=KRL_GetTextFieldData (->[Alumnos]Número;->[Alumnos_Calificaciones]ID_Alumno;->[Alumnos]Status)
					  //While ($t_estado#"Activo")
					  //NEXT RECORD([Alumnos_Calificaciones])
					  //$t_estado:=KRL_GetTextFieldData (->[Alumnos]Número;->[Alumnos_Calificaciones]ID_Alumno;->[Alumnos]Status)
					  //End while 
					  //$alumno:=[Alumnos_Calificaciones]ID_Alumno
					
					  //20151012 ASM Ticket 153820
					
					While (Not:C34(End selection:C36([Alumnos_Calificaciones:208])))
						$t_estado:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]Status:50)
						If ($t_estado#"retirado@")
							$alumno:=[Alumnos_Calificaciones:208]ID_Alumno:6
							LAST RECORD:C200([Alumnos_Calificaciones:208])
						End if 
						NEXT RECORD:C51([Alumnos_Calificaciones:208])
					End while 
					
					
				Else 
					$json:=STWA2_JSON_SendError (-60001)
				End if 
			End if 
			$json:=STWA2_AJAX_SendMapas ($alumno;[Asignaturas:18]EVAPR_IdMatriz:91;$periodo;$userID;$profID)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="subnotas")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$columna:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"parcial"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			$json:=STWA2_AJAX_SendSubNotas ($periodo;$columna;$profID;$userID)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="columnas")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			$json:=STWA2_SendChartableCols ($periodo)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="graficanotas")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$tabla:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tabla"))
		$campo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"campo"))
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			$json:=STWA2_AJAX_SendGraficaNotas ($periodo;$tabla;$campo)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="foto")
		$rnCalificaciones:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnCal"))
		If (KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rnCalificaciones;False:C215))
			$rn:=Find in field:C653([Alumnos:2]numero:1;[Alumnos_Calificaciones:208]ID_Alumno:6)
			If ($rn>No current record:K29:2)
				$json:=STWA2_AJAX_SendFotoAlumno ($rn)
			Else 
				$json:="ERR"
			End if 
		End if 
		
	: ($dato="fotoalumnoxalumno")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAlumno"))
		$json:=STWA2_AJAX_SendFotoAlumno ($rn)
		
	: ($dato="asignaturas")
		
		$b_filtrarAsig:=False:C215
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$admin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
		$reemplazoID:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"reemplazoID"))
		If ($reemplazoID#0)
			ARRAY LONGINT:C221($al_AsignaturasReemplazo;0)
			STWA2_ReemplazaUsuario ("inicializa")
			QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$reemplazoID)
			$profID:=[xShell_Users:47]NoEmployee:7
			$t_filtrarAsig:=STWA2_ReemplazaUsuario ("cargaAsignaturasReemplazo";$uuid;->$al_AsignaturasReemplazo)
			$b_filtrarAsig:=Choose:C955($t_filtrarAsig="True";True:C214;False:C215)
		End if 
		READ ONLY:C145([Asignaturas:18])
		If (($profID=0) | ($admin))
			ALL RECORDS:C47([Asignaturas:18])
		Else 
			dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
			If ($b_filtrarAsig)
				QUERY SELECTION WITH ARRAY:C1050([Asignaturas:18]Numero:1;$al_AsignaturasReemplazo)
			Else 
				STWA2_FiltraAsignPref ($uuid;$y_ParameterNames;$y_ParameterValues;"filtraAsignaturasPref")  //20180621 ASM Ticket 209355
			End if 
			
		End if 
		
		$json:=STWA2_AJAX_ListaAsignaturas ($uuid;$profID)
		
	: ($dato="notas")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		  //valido pemisos del usuario 20180723 ASM Ticket 212494
		$b_usuarioAutorizado:=(($profID=[Asignaturas:18]profesor_numero:4) | ((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("M";->[Asignaturas:18])))
		If ($b_usuarioAutorizado)
			If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
				$json:=STWA2_AJAX_SendNotas_v15 ($periodo;$profID;$userID)
			Else 
				$json:=STWA2_JSON_SendError (-60000)
			End if 
		Else 
			C_OBJECT:C1216($o_raiz)
			OB SET:C1220($o_raiz;"SinPermiso";True:C214)
			$json:=JSON Stringify:C1217($o_raiz)
		End if 
		
		
	: ($dato="observaciones")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
			$json:=STWA2_AJAX_SendObservaciones ($periodo;$profID;$userID;$uuid)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
		
	: ($dato="obscategoria")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		If (KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rn;False:C215))
			$json:=STWA2_AJAX_SendObsPredefinidas ($periodo)
		Else 
			$json:=STWA2_JSON_SendError (-40000)
		End if 
		
	: ($dato="observacionespj")
		$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$json:=STWA2_AJAX_SendObservacionesPJ ($periodo;$curso;$profID;$userID)
		
	: ($dato="guias")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
		$profID:=STWA2_Session_GetProfID ($uuid)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$json:=STWA2_AJAX_SendAdjuntosAsig ($rn)
		
	: ($dato="graficaMapas")
		$json:=STWA2_Dash_Aprendizajes ($y_ParameterNames;$y_ParameterValues)
End case 

$0:=$json