//%attributes = {}
  // dbu_CuentaHorasDeClase()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 21/12/12, 12:27:03
  // ---------------------------------------------
C_DATE:C307($d_fechaSesiones;$d_inicioSemana;$d_finSemana)
C_LONGINT:C283($l_numeroDia_ISO;$i_asignaturas;$i_Periodos;$l_horasEfectivas;$l_progressProcess;$l_recNumHorario;$l_numeroCiclo)

ARRAY LONGINT:C221($al_recNumAsignaturas;0)

  // CÓDIGO
PERIODOS_Init 
$l_progressProcess:=IT_Progress (1;0;0;"Contabilizando sesiones de clases...")
ALL RECORDS:C47([Asignaturas:18])
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas;"")
READ WRITE:C146([Asignaturas:18])
For ($i_asignaturas;1;Size of array:C274($al_recNumAsignaturas))
	GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$i_asignaturas})
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	
	$l_recNumHorario:=Find in field:C653([TMT_Horario:166]ID_Asignatura:5;[Asignaturas:18]Numero:1)
	  //If (($l_recNumHorario>=0) & (vlSTR_Horario_NoCiclos=1)) // Mono agregué la validación del número de ciclo mas abajo 
	If ($l_recNumHorario>=0)
		READ ONLY:C145([TMT_Horario:166])
		  // Modificado por: Saúl Ponce (19/05/2017) Ticket Nº 180337, contabiliar horas de clase vigentes
		  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=[Asignaturas]Numero)
		  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=[Asignaturas]Numero;*)
		  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesHasta>=Current date(*);*)
		  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesDesde<=Current date(*))
		  //[Asignaturas]Horas_Semanales:=Records in selection([TMT_Horario])
		
		  // Modificado por: Saúl Ponce (12/03/2018) valido con el nuevo método creado por Alberto B.
		DT_GetStartEndWeekDates (Current date:C33(*);->$d_inicioSemana;->$d_finSemana)
		QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$d_inicioSemana;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=$d_finSemana)
		[Asignaturas:18]Horas_Semanales:51:=Records in selection:C76([TMT_Horario:166])
		
		READ ONLY:C145([Asignaturas_RegistroSesiones:168])
		
		[Asignaturas:18]Horas_de_clases_efectivas:52:=0
		For ($i_Periodos;1;Size of array:C274(aiSTR_Periodos_Numero))
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_horasEfectivas)
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>=;adSTR_Periodos_Desde{$i_Periodos};*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<=;adSTR_Periodos_Hasta{$i_Periodos})
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			[Asignaturas:18]Horas_de_clases_efectivas:52:=[Asignaturas:18]Horas_de_clases_efectivas:52+$l_horasEfectivas
		End for 
		
		[Asignaturas:18]Horas_Anuales:68:=0
		While (Not:C34(End selection:C36([TMT_Horario:166])))
			$d_fechaSesiones:=[TMT_Horario:166]SesionesDesde:12
			While ($d_fechaSesiones<=[TMT_Horario:166]SesionesHasta:13)
				$l_numeroDia_ISO:=DT_GetDayNumber_ISO8601 ($d_fechaSesiones)
				If ($l_numeroDia_ISO=[TMT_Horario:166]NumeroDia:1)
					$l_numeroCiclo:=TMT_retornaCiclo ($d_fechaSesiones;PERIODOS_refConfiguracion ([TMT_Horario:166]Nivel:10))
					If ($l_numeroCiclo=[TMT_Horario:166]No_Ciclo:14)
						If (DateIsValid ($d_fechaSesiones;0))
							[Asignaturas:18]Horas_Anuales:68:=[Asignaturas:18]Horas_Anuales:68+1
						End if 
					End if 
				End if 
				$d_fechaSesiones:=$d_fechaSesiones+1
			End while 
			NEXT RECORD:C51([TMT_Horario:166])
		End while 
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	$l_progressProcess:=IT_Progress (0;$l_progressProcess;$i_asignaturas/Size of array:C274($al_recNumAsignaturas);"Contabilizando sesiones de clases...")
End for 
$l_progressProcess:=IT_Progress (-1;$l_progressProcess)
UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([Asignaturas:18])

