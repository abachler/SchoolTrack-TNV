//%attributes = {}
  //dbu_AS_CuentaHorasSemanales
C_DATE:C307($d_inicioSemana;$d_finSemana)
READ WRITE:C146([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])

SELECTION TO ARRAY:C260([Asignaturas:18];$aRecNums)
SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Contabilizando hortas de clases semanales..."))
For ($recnumIndex;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$recNumIndex})
	
	$recNum:=Find in field:C653([TMT_Horario:166]ID_Asignatura:5;[Asignaturas:18]Numero:1)
	If (($recNum>=0) & (vlSTR_Horario_NoCiclos=1))
		  // Modificado por: Saúl Ponce (19/05/2017) Ticket Nº 180337, contabiliar horas de clase vigentes
		  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=[Asignaturas]Numero)
		  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=[Asignaturas]Numero;*)
		  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesHasta>=Current date(*);*)
		  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesDesde<=Current date(*))
		
		  // Modificado por: Saúl Ponce (12/03/2018) valido con el nuevo método creado por Alberto B.
		DT_GetStartEndWeekDates (Current date:C33(*);->$d_inicioSemana;->$d_finSemana)
		QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$d_inicioSemana;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=$d_finSemana)
		[Asignaturas:18]Horas_Semanales:51:=$records
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$recnumIndex/Size of array:C274($aRecNums);__ ("Contabilizando horas de clases semanales..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([Asignaturas:18])