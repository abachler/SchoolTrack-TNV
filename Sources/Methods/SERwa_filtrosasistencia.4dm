//%attributes = {}
  // TRACE

$y_Names:=$1
$y_Data:=$2

READ ONLY:C145(*)
C_OBJECT:C1216($cursos;$obj)
C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
PERIODOS_Init 
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_profuuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_profesor")
$t_fecha:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha")
If ($t_fecha="")
	$d_fecha:=Current date:C33(*)
Else 
	$d_fecha:=Date:C102(DT_FechaISO_a_FechaHora ($t_fecha))
End if 
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_profuuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (True:C214)  //si fuera necesario verificar algun permiso
		dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$idProf;False:C215)
		  //ALL RECORDS([Asignaturas])
		CREATE SET:C116([Asignaturas:18];"$asignaturas")
		ARRAY LONGINT:C221($aL_asinumero;0)
		ARRAY LONGINT:C221($aL_asinivel;0)
		SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aL_asinumero;[Asignaturas:18]Numero_del_Nivel:6;$aL_asinivel)
		SORT ARRAY:C229($aL_asinivel;$aL_asinumero)
		$curNivel:=-MAXLONG:K35:2
		For ($h;1;Size of array:C274($aL_asinumero))
			$idNivel:=$aL_asinivel{$h}
			If ($idNivel#$curNivel)
				PERIODOS_LoadData ($idNivel)
				$modoasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$idNivel;->[xxSTR_Niveles:6]AttendanceMode:3)
				$ciclo:=TMT_retornaCiclo ($d_fecha)
				$curNivel:=$idNivel
			End if 
			If ($modoasistencia#1)
				QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$aL_asinumero{$h};*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=$ciclo)
				If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=0)
					AS_CreaSesionesAsignatura ($aL_asinumero{$h};$d_fecha)
					QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$aL_asinumero{$h};*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=$ciclo)
					If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=0)
						KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$aL_asinumero{$h})
						REMOVE FROM SET:C561([Asignaturas:18];"$asignaturas")
					End if 
				End if 
			End if 
		End for 
		USE SET:C118("$asignaturas")
		ARRAY TEXT:C222($aT_cursos;0)
		ARRAY OBJECT:C1221($aO_cursos;0)
		DISTINCT VALUES:C339([Asignaturas:18]Curso:5;$aT_cursos)
		$curNivel:=-MAXLONG:K35:2
		For ($i;1;Size of array:C274($aT_cursos))
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$aT_cursos{$i})
			If (Records in selection:C76([Cursos:3])=1)
				$idNivel:=[Cursos:3]Nivel_Numero:7
				$identificador:=Util_MakeUUIDCanonical ([Cursos:3]Auto_UUID:47)
			Else 
				USE SET:C118("$asignaturas")
				SET QUERY LIMIT:C395(1)
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Curso:5=$aT_cursos{$i})
				SET QUERY LIMIT:C395(0)
				$idNivel:=[Asignaturas:18]Numero_del_Nivel:6
				$identificador:=[Asignaturas:18]Curso:5
			End if 
			If ($idNivel#$curNivel)
				PERIODOS_LoadData ($idNivel)
				$modoasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$idNivel;->[xxSTR_Niveles:6]AttendanceMode:3)
				$curNivel:=$idNivel
			End if 
			USE SET:C118("$asignaturas")
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Curso:5=$aT_cursos{$i})
			ARRAY LONGINT:C221($aL_asinumero;0)
			ARRAY TEXT:C222($aT_asinombre;0)
			ARRAY TEXT:C222($aT_asiuuid;0)
			SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aL_asinumero;[Asignaturas:18]denominacion_interna:16;$aT_asinombre;[Asignaturas:18]auto_uuid:12;$aT_asiuuid)
			ARRAY OBJECT:C1221($aO_asignaturas;0)
			For ($j;1;Size of array:C274($aL_asinumero))
				$asignatura_obj:=OB_Create 
				QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$aL_asinumero{$j};*)
				QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12=$d_fecha;*)
				QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13=$d_fecha;*)
				QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=DT_GetDayNumber_ISO8601 ($d_fecha);*)
				QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]No_Ciclo:14=TMT_retornaCiclo ($d_fecha))
				If ((Records in selection:C76([TMT_Horario:166])>0) & ($modoasistencia=2))
					ARRAY OBJECT:C1221($aO_horas;0)
					ARRAY OBJECT:C1221($aO_horas;Records in selection:C76([TMT_Horario:166]))
					ARRAY INTEGER:C220($aL_horariohora;0)
					ARRAY TIME:C1223($aTM_horariodesde;0)
					ARRAY TIME:C1223($aTM_horariohasta;0)
					SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroHora:2;$aL_horariohora;[TMT_Horario:166]Desde:3;$aTM_horariodesde;[TMT_Horario:166]Hasta:4;$aTM_horariohasta)
					SORT ARRAY:C229($aL_horariohora;$aTM_horariodesde;$aTM_horariohasta)
					For ($h;1;Size of array:C274($aL_horariohora))
						$horaobjeto:=OB_Create 
						$hora:=$aL_horariohora{$h}
						$alias:=atSTR_Horario_HoraAlias{$hora}
						$asignatura:="Hora "+$alias+": "+$aT_asinombre{$j}
						OB SET:C1220($horaobjeto;"alias";$asignatura)
						OB SET:C1220($horaobjeto;"hora";$hora)
						If (($aTM_horariodesde{$h}<=Current time:C178) & ($aTM_horariohasta{$h}>=Current time:C178))
							OB SET:C1220($horaobjeto;"iniciar";True:C214)
						Else 
							OB SET:C1220($horaobjeto;"iniciar";False:C215)
						End if 
						$aO_horas{$h}:=$horaobjeto
					End for 
					OB SET:C1220($asignatura_obj;"uuid";Util_MakeUUIDCanonical ($aT_asiuuid{$j}))
					OB SET:C1220($asignatura_obj;"asignatura";$aT_asinombre{$j})
					OB SET ARRAY:C1227($asignatura_obj;"horas";$aO_horas)
					APPEND TO ARRAY:C911($aO_asignaturas;$asignatura_obj)
				Else 
					If ($modoasistencia=1)
						OB SET:C1220($asignatura_obj;"uuid";Util_MakeUUIDCanonical ($aT_asiuuid{$j}))
						OB SET:C1220($asignatura_obj;"asignatura";$aT_asinombre{$j})
						OB SET NULL:C1233($asignatura_obj;"horas")
						APPEND TO ARRAY:C911($aO_asignaturas;$asignatura_obj)
					Else 
						QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$aL_asinumero{$j};*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=TMT_retornaCiclo ($d_fecha))
						If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
							OB SET:C1220($asignatura_obj;"uuid";Util_MakeUUIDCanonical ($aT_asiuuid{$j}))
							OB SET:C1220($asignatura_obj;"asignatura";$aT_asinombre{$j})
							ARRAY OBJECT:C1221($aO_horas;0)
							ARRAY OBJECT:C1221($aO_horas;Records in selection:C76([Asignaturas_RegistroSesiones:168]))
							ARRAY INTEGER:C220($aL_sesionhora;0)
							SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Hora:4;$aL_sesionhora)
							For ($h;1;Size of array:C274($aL_sesionhora))
								$horaobjeto:=OB_Create 
								$hora:=$aL_sesionhora{$h}
								$alias:=atSTR_Horario_HoraAlias{$hora}
								$asignatura:="Hora "+$alias+": "+$aT_asinombre{$j}
								OB SET:C1220($horaobjeto;"alias";$asignatura)
								OB SET:C1220($horaobjeto;"hora";$hora)
								OB SET:C1220($horaobjeto;"iniciar";False:C215)
								$aO_horas{$h}:=$horaobjeto
							End for 
							OB SET ARRAY:C1227($asignatura_obj;"horas";$aO_horas)
							APPEND TO ARRAY:C911($aO_asignaturas;$asignatura_obj)
						End if 
					End if 
				End if 
			End for 
			If (Size of array:C274($aO_asignaturas)>0)
				$curso:=OB_Create 
				OB SET:C1220($curso;"curso";$aT_cursos{$i})
				OB SET:C1220($curso;"identificador";$identificador)
				OB SET:C1220($curso;"modoasistencia";$modoasistencia)
				OB SET ARRAY:C1227($curso;"asignaturas";$aO_asignaturas)
				APPEND TO ARRAY:C911($aO_cursos;$curso)
			End if 
		End for 
		$data:=OB_Create 
		OB SET:C1220($data;"fecha_origen_datos";SN3_MakeDateInmune2LocalFormat (Current date:C33(*)))
		OB SET ARRAY:C1227($data;"cursos";$aO_cursos)
		CLEAR SET:C117("$asignaturas")
		$0:=OB_Object2Json ($data)
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 