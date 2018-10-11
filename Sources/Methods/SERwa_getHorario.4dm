//%attributes = {}
  //TRACE

$y_Names:=$1
$y_Data:=$2

READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([TMT_Horario:166])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([TMT_Horario:166])
PERIODOS_Init 

ARRAY LONGINT:C221($aL_Niveles;0)
ARRAY LONGINT:C221($aL_Horarios;0)
ARRAY OBJECT:C1221($aO_Bloques;0)
ARRAY OBJECT:C1221($aO_Confs;0)
C_OBJECT:C1216($data)
C_OBJECT:C1216($confs)
C_LONGINT:C283($lineasHorario)

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid;$t_uuid;$t_paraquien)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_paraquien:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"paraquien")
$t_uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	If (True:C214)  //permiso para ver horario
		Case of 
			: ($t_paraquien="profesor")
				If (KRL_FindAndLoadRecordByIndex (->[Profesores:4]Auto_UUID:41;->$t_uuid)>-1)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
					If (Records in selection:C76([Asignaturas:18])>0)
						CREATE SET:C116([Asignaturas:18];"delProfesor")
						AT_DistinctsFieldValues (->[Asignaturas:18]Numero_del_Nivel:6;->$aL_Niveles)
						ARRAY OBJECT:C1221($aO_Confs;Size of array:C274($aL_Niveles))
						For ($i;1;Size of array:C274($aL_Niveles))
							PERIODOS_LoadData ($aL_Niveles{$i})
							ARRAY LONGINT:C221($days;5)
							$days{1}:=1
							$days{2}:=2
							$days{3}:=3
							$days{4}:=4
							$days{5}:=5
							If (vlSTR_Horario_SabadoLabor=1)
								APPEND TO ARRAY:C911($days;6)
							End if 
							OB SET:C1220($aO_Confs{$i};"nivel";$aL_Niveles{$i})
							OB SET ARRAY:C1227($aO_Confs{$i};"dias";$days)
							OB SET:C1220($aO_Confs{$i};"numerodeciclos";vlSTR_Horario_TipoCiclos)
							OB SET:C1220($aO_Confs{$i};"resetciclos";vlSTR_Horario_ResetCiclos)
							ARRAY TEXT:C222($aT_inicioCiclos;Size of array:C274(adSTR_Periodos_InicioCiclos))
							For ($j;1;Size of array:C274($aT_inicioCiclos))
								$aT_inicioCiclos{$j}:=STWA2_MakeDate4JS (adSTR_Periodos_InicioCiclos{$j})
							End for 
							OB SET ARRAY:C1227($aO_Confs{$i};"iniciociclos";$aT_inicioCiclos)
							OB SET:C1220($aO_Confs{$i};"fechainicio";STWA2_MakeDate4JS (vdSTR_Periodos_InicioEjercicio))
							$fechas:=OB_Create 
							ARRAY TEXT:C222($aT_feriados;Size of array:C274(adSTR_Calendario_Feriados))
							For ($j;1;Size of array:C274(adSTR_Calendario_Feriados))
								$aT_feriados{$j}:=SN3_MakeDateInmune2LocalFormat2 (adSTR_Calendario_Feriados{$j})
							End for 
							OB SET ARRAY:C1227($fechas;"feriados";$aT_feriados)
							ARRAY OBJECT:C1221($aO_periodos;Size of array:C274(adSTR_Periodos_Desde))
							For ($j;1;Size of array:C274(adSTR_Periodos_Desde))
								$periodo:=OB_Create 
								OB SET:C1220($periodo;"numero";aiSTR_Periodos_Numero{$j})
								OB SET:C1220($periodo;"nombre";atSTR_Periodos_Nombre{$j})
								OB SET:C1220($periodo;"desde";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Desde{$j}))
								OB SET:C1220($periodo;"hasta";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Hasta{$j}))
								$aO_periodos{$j}:=$periodo
							End for 
							OB SET ARRAY:C1227($fechas;"periodos";$aO_periodos)
							OB SET:C1220($aO_Confs{$i};"fechas";$fechas)
							$lineasHorario:=Size of array:C274(aiSTR_Horario_HoraNo)
							USE SET:C118("delProfesor")
							QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$aL_Niveles{$i})
							KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
							QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2<=$lineasHorario)
							QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*))
							LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$aL_Horarios)
							For ($j;1;Size of array:C274($aL_Horarios))
								INSERT IN ARRAY:C227($aO_Bloques;Size of array:C274($aO_Bloques)+1)
								KRL_GotoRecord (->[TMT_Horario:166];$aL_Horarios{$j};False:C215)
								RELATE ONE:C42([TMT_Horario:166]ID_Asignatura:5)
								RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"uuid";Util_MakeUUIDCanonical ([TMT_Horario:166]Auto_UUID:17))
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horario";[TMT_Horario:166]No_Ciclo:14)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horaInicio";String:C10([TMT_Horario:166]Desde:3;HH MM:K7:2))
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horaTermino";String:C10([TMT_Horario:166]Hasta:4;HH MM:K7:2))
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"fechaDesde";STWA2_MakeDate4JS ([TMT_Horario:166]SesionesDesde:12))
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"fechaHasta";STWA2_MakeDate4JS ([TMT_Horario:166]SesionesHasta:13))
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"numeroDia";[TMT_Horario:166]NumeroDia:1)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"numeroBloque";[TMT_Horario:166]NumeroHora:2)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"nombre";"Bloque "+String:C10([TMT_Horario:166]NumeroHora:2))
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"uuidasignatura";[Asignaturas:18]auto_uuid:12)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"asignatura";[Asignaturas:18]denominacion_interna:16)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"abrevasignatura";[Asignaturas:18]Abreviación:26)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"fijo";False:C215)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"tipohora";[TMT_Horario:166]TipoHora:16)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"curso";[TMT_Horario:166]Curso:11)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"sala";[TMT_Horario:166]Sala:8)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"uuidprofesor";[Profesores:4]Auto_UUID:41)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"profesor";[Profesores:4]Apellidos_y_nombres:28)
								OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"nivel";[Asignaturas:18]Numero_del_Nivel:6)
							End for 
						End for 
						CLEAR SET:C117("delProfesor")
					Else 
						ARRAY OBJECT:C1221($aO_Confs;1)
						PERIODOS_LoadData (0;-1)
						ARRAY LONGINT:C221($days;5)
						$days{1}:=1
						$days{2}:=2
						$days{3}:=3
						$days{4}:=4
						$days{5}:=5
						If (vlSTR_Horario_SabadoLabor=1)
							APPEND TO ARRAY:C911($days;6)
						End if 
						OB SET:C1220($aO_Confs{1};"nivel";-1)
						OB SET ARRAY:C1227($aO_Confs{1};"dias";$days)
						OB SET:C1220($aO_Confs{1};"resetciclos";vlSTR_Horario_ResetCiclos)
						SORT ARRAY:C229(adSTR_Periodos_InicioCiclos;>)
						ARRAY TEXT:C222($aT_inicioCiclos;Size of array:C274(adSTR_Periodos_InicioCiclos))
						For ($j;1;Size of array:C274($aT_inicioCiclos))
							$aT_inicioCiclos{$j}:=STWA2_MakeDate4JS (adSTR_Periodos_InicioCiclos{$j})
						End for 
						OB SET ARRAY:C1227($aO_Confs{1};"iniciociclos";$aT_inicioCiclos)
						OB SET:C1220($aO_Confs{1};"fechainicio";STWA2_MakeDate4JS (vdSTR_Periodos_InicioEjercicio))
						$fechas:=OB_Create 
						ARRAY TEXT:C222($aT_feriados;Size of array:C274(adSTR_Calendario_Feriados))
						For ($i;1;Size of array:C274(adSTR_Calendario_Feriados))
							$aT_feriados{$i}:=SN3_MakeDateInmune2LocalFormat2 (adSTR_Calendario_Feriados{$i})
						End for 
						OB SET ARRAY:C1227($fechas;"feriados";$aT_feriados)
						ARRAY OBJECT:C1221($aO_periodos;Size of array:C274(adSTR_Periodos_Desde))
						For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
							$periodo:=OB_Create 
							OB SET:C1220($periodo;"numero";aiSTR_Periodos_Numero{$i})
							OB SET:C1220($periodo;"nombre";atSTR_Periodos_Nombre{$i})
							OB SET:C1220($periodo;"desde";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Desde{$i}))
							OB SET:C1220($periodo;"hasta";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Hasta{$i}))
							$aO_periodos{$i}:=$periodo
						End for 
						OB SET ARRAY:C1227($fechas;"periodos";$aO_periodos)
						OB SET:C1220($aO_Confs{1};"fechas";$fechas)
					End if 
					OB SET ARRAY:C1227($data;"confs";$aO_Confs)
					OB SET ARRAY:C1227($data;"bloques";$aO_Bloques)
					$0:=OB_Object2Json ($data)
				Else 
					$0:=SERwa_GeneraRespuesta ("-2";"Profesor inexistente.")
				End if 
			: ($t_paraquien="alumno")
				If (KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->$t_uuid)>-1)
					PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
					$lineasHorario:=Size of array:C274(aiSTR_Horario_HoraNo)
					ARRAY OBJECT:C1221($aO_Confs;1)
					ARRAY LONGINT:C221($days;5)
					$days{1}:=1
					$days{2}:=2
					$days{3}:=3
					$days{4}:=4
					$days{5}:=5
					If (vlSTR_Horario_SabadoLabor=1)
						APPEND TO ARRAY:C911($days;6)
					End if 
					OB SET:C1220($aO_Confs{1};"nivel";[Alumnos:2]nivel_numero:29)
					OB SET ARRAY:C1227($aO_Confs{1};"dias";$days)
					OB SET:C1220($aO_Confs{1};"numerodeciclos";vlSTR_Horario_TipoCiclos)
					OB SET:C1220($aO_Confs{1};"resetciclos";vlSTR_Horario_ResetCiclos)
					ARRAY TEXT:C222($aT_inicioCiclos;Size of array:C274(adSTR_Periodos_InicioCiclos))
					For ($i;1;Size of array:C274($aT_inicioCiclos))
						$aT_inicioCiclos{$i}:=STWA2_MakeDate4JS (adSTR_Periodos_InicioCiclos{$i})
					End for 
					OB SET ARRAY:C1227($aO_Confs{1};"iniciociclos";$aT_inicioCiclos)
					OB SET:C1220($aO_Confs{1};"fechainicio";STWA2_MakeDate4JS (vdSTR_Periodos_InicioEjercicio))
					$fechas:=OB_Create 
					ARRAY TEXT:C222($aT_feriados;Size of array:C274(adSTR_Calendario_Feriados))
					For ($i;1;Size of array:C274(adSTR_Calendario_Feriados))
						$aT_feriados{$i}:=SN3_MakeDateInmune2LocalFormat2 (adSTR_Calendario_Feriados{$i})
					End for 
					OB SET ARRAY:C1227($fechas;"feriados";$aT_feriados)
					ARRAY OBJECT:C1221($aO_periodos;Size of array:C274(adSTR_Periodos_Desde))
					For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
						$periodo:=OB_Create 
						OB SET:C1220($periodo;"numero";aiSTR_Periodos_Numero{$i})
						OB SET:C1220($periodo;"nombre";atSTR_Periodos_Nombre{$i})
						OB SET:C1220($periodo;"desde";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Desde{$i}))
						OB SET:C1220($periodo;"hasta";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Hasta{$i}))
						$aO_periodos{$i}:=$periodo
					End for 
					OB SET ARRAY:C1227($fechas;"periodos";$aO_periodos)
					OB SET:C1220($aO_Confs{1};"fechas";$fechas)
					READ ONLY:C145([Alumnos_Calificaciones:208])
					READ ONLY:C145([TMT_Horario:166])
					READ ONLY:C145([Asignaturas:18])
					READ ONLY:C145([Profesores:4])
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
					QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2<=$lineasHorario)
					QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*))
					LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$aL_Horarios)
					ARRAY OBJECT:C1221($aO_Bloques;Size of array:C274($aL_Horarios))
					For ($j;1;Size of array:C274($aL_Horarios))
						KRL_GotoRecord (->[TMT_Horario:166];$aL_Horarios{$j};False:C215)
						RELATE ONE:C42([TMT_Horario:166]ID_Asignatura:5)
						RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
						OB SET:C1220($aO_Bloques{$j};"uuid";Util_MakeUUIDCanonical ([TMT_Horario:166]Auto_UUID:17))
						OB SET:C1220($aO_Bloques{$j};"horario";[TMT_Horario:166]No_Ciclo:14)
						OB SET:C1220($aO_Bloques{$j};"horaInicio";String:C10([TMT_Horario:166]Desde:3;HH MM:K7:2))
						OB SET:C1220($aO_Bloques{$j};"horaTermino";String:C10([TMT_Horario:166]Hasta:4;HH MM:K7:2))
						OB SET:C1220($aO_Bloques{$j};"fechaDesde";STWA2_MakeDate4JS ([TMT_Horario:166]SesionesDesde:12))
						OB SET:C1220($aO_Bloques{$j};"fechaHasta";STWA2_MakeDate4JS ([TMT_Horario:166]SesionesHasta:13))
						OB SET:C1220($aO_Bloques{$j};"numeroDia";[TMT_Horario:166]NumeroDia:1)
						OB SET:C1220($aO_Bloques{$j};"numeroBloque";[TMT_Horario:166]NumeroHora:2)
						OB SET:C1220($aO_Bloques{$j};"aliasBloque";atSTR_Horario_HoraAlias{[TMT_Horario:166]NumeroHora:2})
						OB SET:C1220($aO_Bloques{$j};"nombre";"Bloque "+String:C10([TMT_Horario:166]NumeroHora:2))
						OB SET:C1220($aO_Bloques{$j};"uuidasignatura";[Asignaturas:18]auto_uuid:12)
						OB SET:C1220($aO_Bloques{$j};"asignatura";[Asignaturas:18]denominacion_interna:16)
						OB SET:C1220($aO_Bloques{$j};"abrevasignatura";[Asignaturas:18]Abreviación:26)
						OB SET:C1220($aO_Bloques{$j};"fijo";False:C215)
						OB SET:C1220($aO_Bloques{$j};"tipohora";[TMT_Horario:166]TipoHora:16)
						OB SET:C1220($aO_Bloques{$j};"curso";[TMT_Horario:166]Curso:11)
						OB SET:C1220($aO_Bloques{$j};"sala";[TMT_Horario:166]Sala:8)
						OB SET:C1220($aO_Bloques{$j};"uuidprofesor";[Profesores:4]Auto_UUID:41)
						OB SET:C1220($aO_Bloques{$j};"profesor";[Profesores:4]Apellidos_y_nombres:28)
						OB SET:C1220($aO_Bloques{$j};"nivel";[Asignaturas:18]Numero_del_Nivel:6)
					End for 
					For ($i;1;Size of array:C274(alSTR_Horario_RefTipoHora))
						If (alSTR_Horario_RefTipoHora{$i}<=0)
							For ($w;1;vlSTR_Horario_NoCiclos)
								For ($j;1;Size of array:C274($days))
									INSERT IN ARRAY:C227($aO_Bloques;Size of array:C274($aO_Bloques)+1)
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horario";$w)
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horaInicio";String:C10(Time:C179(alSTR_Horario_Desde{$i});HH MM:K7:2))
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horaTermino";String:C10(Time:C179(alSTR_Horario_Hasta{$i});HH MM:K7:2))
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"fechaDesde")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"fechaHasta")
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"numeroDia";$days{$j})
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"numeroBloque";$i)
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"aliasBloque";atSTR_Horario_HoraAlias{$i})
									$l_indiceTipoHora:=Find in array:C230(<>alSTR_Horario_RefTipoHora;alSTR_Horario_RefTipoHora{$i})
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"nombre";<>atSTR_Horario_TipoHora{$l_indiceTipoHora})
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"uuidasignatura")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"asignatura")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"abrevasignatura")
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"fijo";True:C214)
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"tipohora";alSTR_Horario_RefTipoHora{$i})
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"curso";[Alumnos:2]curso:20)
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"sala")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"uuidprofesor")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"profesor")
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"nivel";[Alumnos:2]nivel_numero:29)
								End for 
							End for 
						End if 
					End for 
					OB SET ARRAY:C1227($data;"confs";$aO_Confs)
					OB SET ARRAY:C1227($data;"bloques";$aO_Bloques)
					$0:=OB_Object2Json ($data)
				Else 
					$0:=SERwa_GeneraRespuesta ("-2";"Alumno inexistente.")
				End if 
			: ($t_paraquien="curso")
				If (KRL_FindAndLoadRecordByIndex (->[Cursos:3]Auto_UUID:47;->$t_uuid)>-1)
					PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
					$lineasHorario:=Size of array:C274(aiSTR_Horario_HoraNo)
					ARRAY OBJECT:C1221($aO_Confs;1)
					ARRAY LONGINT:C221($days;5)
					$days{1}:=1
					$days{2}:=2
					$days{3}:=3
					$days{4}:=4
					$days{5}:=5
					If (vlSTR_Horario_SabadoLabor=1)
						APPEND TO ARRAY:C911($days;6)
					End if 
					OB SET:C1220($aO_Confs{1};"nivel";[Cursos:3]Nivel_Numero:7)
					OB SET ARRAY:C1227($aO_Confs{1};"dias";$days)
					OB SET:C1220($aO_Confs{1};"numerodeciclos";vlSTR_Horario_TipoCiclos)
					OB SET:C1220($aO_Confs{1};"resetciclos";vlSTR_Horario_ResetCiclos)
					ARRAY TEXT:C222($aT_inicioCiclos;Size of array:C274(adSTR_Periodos_InicioCiclos))
					For ($i;1;Size of array:C274($aT_inicioCiclos))
						$aT_inicioCiclos{$i}:=STWA2_MakeDate4JS (adSTR_Periodos_InicioCiclos{$i})
					End for 
					OB SET ARRAY:C1227($aO_Confs{1};"iniciociclos";$aT_inicioCiclos)
					OB SET:C1220($aO_Confs{1};"fechainicio";STWA2_MakeDate4JS (vdSTR_Periodos_InicioEjercicio))
					$fechas:=OB_Create 
					ARRAY TEXT:C222($aT_feriados;Size of array:C274(adSTR_Calendario_Feriados))
					For ($i;1;Size of array:C274(adSTR_Calendario_Feriados))
						$aT_feriados{$i}:=SN3_MakeDateInmune2LocalFormat2 (adSTR_Calendario_Feriados{$i})
					End for 
					OB SET ARRAY:C1227($fechas;"feriados";$aT_feriados)
					ARRAY OBJECT:C1221($aO_periodos;Size of array:C274(adSTR_Periodos_Desde))
					For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
						$periodo:=OB_Create 
						OB SET:C1220($periodo;"numero";aiSTR_Periodos_Numero{$i})
						OB SET:C1220($periodo;"nombre";atSTR_Periodos_Nombre{$i})
						OB SET:C1220($periodo;"desde";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Desde{$i}))
						OB SET:C1220($periodo;"hasta";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Hasta{$i}))
						$aO_periodos{$i}:=$periodo
					End for 
					OB SET ARRAY:C1227($fechas;"periodos";$aO_periodos)
					OB SET:C1220($aO_Confs{1};"fechas";$fechas)
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"Ret@")
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
					KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
					QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2<=$lineasHorario)
					QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*))
					LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$aL_Horarios)
					ARRAY OBJECT:C1221($aO_Bloques;Size of array:C274($aL_Horarios))
					For ($j;1;Size of array:C274($aL_Horarios))
						KRL_GotoRecord (->[TMT_Horario:166];$aL_Horarios{$j};False:C215)
						RELATE ONE:C42([TMT_Horario:166]ID_Asignatura:5)
						RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
						OB SET:C1220($aO_Bloques{$j};"uuid";Util_MakeUUIDCanonical ([TMT_Horario:166]Auto_UUID:17))
						OB SET:C1220($aO_Bloques{$j};"horario";[TMT_Horario:166]No_Ciclo:14)
						OB SET:C1220($aO_Bloques{$j};"horaInicio";String:C10([TMT_Horario:166]Desde:3;HH MM:K7:2))
						OB SET:C1220($aO_Bloques{$j};"horaTermino";String:C10([TMT_Horario:166]Hasta:4;HH MM:K7:2))
						OB SET:C1220($aO_Bloques{$j};"fechaDesde";STWA2_MakeDate4JS ([TMT_Horario:166]SesionesDesde:12))
						OB SET:C1220($aO_Bloques{$j};"fechaHasta";STWA2_MakeDate4JS ([TMT_Horario:166]SesionesHasta:13))
						OB SET:C1220($aO_Bloques{$j};"numeroDia";[TMT_Horario:166]NumeroDia:1)
						OB SET:C1220($aO_Bloques{$j};"numeroBloque";[TMT_Horario:166]NumeroHora:2)
						OB SET:C1220($aO_Bloques{$j};"aliasBloque";atSTR_Horario_HoraAlias{[TMT_Horario:166]NumeroHora:2})
						OB SET:C1220($aO_Bloques{$j};"nombre";"Bloque "+String:C10([TMT_Horario:166]NumeroHora:2))
						OB SET:C1220($aO_Bloques{$j};"uuidasignatura";[Asignaturas:18]auto_uuid:12)
						OB SET:C1220($aO_Bloques{$j};"asignatura";[Asignaturas:18]denominacion_interna:16)
						OB SET:C1220($aO_Bloques{$j};"abrevasignatura";[Asignaturas:18]Abreviación:26)
						OB SET:C1220($aO_Bloques{$j};"fijo";False:C215)
						OB SET:C1220($aO_Bloques{$j};"tipohora";[TMT_Horario:166]TipoHora:16)
						OB SET:C1220($aO_Bloques{$j};"curso";[TMT_Horario:166]Curso:11)
						OB SET:C1220($aO_Bloques{$j};"sala";[TMT_Horario:166]Sala:8)
						OB SET:C1220($aO_Bloques{$j};"uuidprofesor";[Profesores:4]Auto_UUID:41)
						OB SET:C1220($aO_Bloques{$j};"profesor";[Profesores:4]Apellidos_y_nombres:28)
						OB SET:C1220($aO_Bloques{$j};"nivel";[Asignaturas:18]Numero_del_Nivel:6)
					End for 
					For ($i;1;Size of array:C274(alSTR_Horario_RefTipoHora))
						If (alSTR_Horario_RefTipoHora{$i}<=0)
							For ($w;1;vlSTR_Horario_NoCiclos)
								For ($j;1;Size of array:C274($days))
									INSERT IN ARRAY:C227($aO_Bloques;Size of array:C274($aO_Bloques)+1)
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horario";$w)
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horaInicio";String:C10(Time:C179(alSTR_Horario_Desde{$i});HH MM:K7:2))
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"horaTermino";String:C10(Time:C179(alSTR_Horario_Hasta{$i});HH MM:K7:2))
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"fechaDesde")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"fechaHasta")
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"numeroDia";$days{$j})
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"numeroBloque";$i)
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"aliasBloque";atSTR_Horario_HoraAlias{$i})
									$l_indiceTipoHora:=Find in array:C230(<>alSTR_Horario_RefTipoHora;alSTR_Horario_RefTipoHora{$i})
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"nombre";<>atSTR_Horario_TipoHora{$l_indiceTipoHora})
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"uuidasignatura")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"asignatura")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"abrevasignatura")
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"fijo";True:C214)
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"tipohora";alSTR_Horario_RefTipoHora{$i})
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"curso";[Cursos:3]Curso:1)
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"sala")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"uuidprofesor")
									OB SET NULL:C1233($aO_Bloques{Size of array:C274($aO_Bloques)};"profesor")
									OB SET:C1220($aO_Bloques{Size of array:C274($aO_Bloques)};"nivel";[Cursos:3]Nivel_Numero:7)
								End for 
							End for 
						End if 
					End for 
					OB SET ARRAY:C1227($data;"confs";$aO_Confs)
					OB SET ARRAY:C1227($data;"bloques";$aO_Bloques)
					$0:=OB_Object2Json ($data)
				Else 
					$0:=SERwa_GeneraRespuesta ("-2";"Curso inexistente.")
				End if 
		End case 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 