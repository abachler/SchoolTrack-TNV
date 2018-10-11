//%attributes = {}
  //PST_ScheduleContextmenu

$CellDate:=aWeekStartDate{aWeeks}+(vCol1-2)
$cellStartTime:=aTimeIview{vRow1}
$cellEndTime:=aTimeIview{vRow1}+(viPST_IviewDuration*60)
$cellIndex:=vRow1
$cellName:=ayPST_ScheduleColPointers{vCol1-1}->{vRow1}

ARRAY INTEGER:C220(aInt2D;2;0)
If ((vColor#0) & (vCol1#0) & (vRow1#0))
	Case of 
		: (vColor=13)  //fuera de limites
			BEEP:C151
			AL_SetCellSel (xALP_IViewTimeTable;0;0)
			AL_UpdateArrays (xALP_IViewTimeTable;-1)
		: (vColor=161)
			$r:=Pop up menu:C542(__ ("Marcar como disponible para entrevista;(Cancelar disponibilidad;(-;Asignar entrevista con acudientes…;(-;(Ver entrevista…");0)
			Case of 
				: ($r=1)  //asignación de disponibilidad,
					CREATE RECORD:C68([ADT_Entrevistas:121])
					[ADT_Entrevistas:121]ID_Funcionario:1:=[Profesores:4]Numero:1
					[ADT_Entrevistas:121]ID_familia:5:=0
					[ADT_Entrevistas:121]Date_IView:2:=$cellDate
					[ADT_Entrevistas:121]Index:6:=$cellIndex
					[ADT_Entrevistas:121]Start_IView:3:=$cellStartTime
					[ADT_Entrevistas:121]End_IView:4:=$cellEndTime
					SAVE RECORD:C53([ADT_Entrevistas:121])
				: ($r=4)  //asignación a familia
					  //$name:=Request("Nombre de la familia:")
					$name:=CD_Request (__ ("Nombre de la familia:");__ ("Aceptar");__ ("Cancelar");__ (""))
					If (($name#"") & (OK=1))
						QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=($name+"@"))
						If (Records in selection:C76([Familia:78])=1)
							QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_familia:5=[Familia:78]Numero:1)
							DELETE RECORD:C58([ADT_Entrevistas:121])
							QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$cellDate;*)
							QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
							QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
							If (Records in selection:C76([ADT_Entrevistas:121])=0)
								CREATE RECORD:C68([ADT_Entrevistas:121])
							End if 
							[ADT_Entrevistas:121]ID_Funcionario:1:=[Profesores:4]Numero:1
							[ADT_Entrevistas:121]ID_familia:5:=[Familia:78]Numero:1
							[ADT_Entrevistas:121]Date_IView:2:=$cellDate
							[ADT_Entrevistas:121]Index:6:=$cellIndex
							[ADT_Entrevistas:121]Start_IView:3:=$cellStartTime
							[ADT_Entrevistas:121]End_IView:4:=$cellEndTime
							SAVE RECORD:C53([ADT_Entrevistas:121])
						End if 
					End if 
			End case 
		: (vColor=4)  //ocupado
			$r:=Pop up menu:C542(__ ("Marcar como disponible para entrevista;Cancelar disponibilidad;(-;Asignar entrevista a otra familia…;(-;Ver entrevista…");0)
			Case of 
				: ($r=1)
					OK:=CD_Dlog (0;Replace string:C233(__ ("Esta hora ha sido asignada para la entrevista con la familia ^0.\r¿Desea usted realmente cancelar esta cita y marcar la hora como disponible?");__ ("^0");$cellName);__ ("");__ ("No");__ ("Sí"))
					If (ok=2)
						QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=aWeekStartDate{aWeeks}+(vCol1-2);*)
						QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=vRow1;*)
						QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
						If (Records in selection:C76([ADT_Entrevistas:121])#0)
							[ADT_Entrevistas:121]ID_familia:5:=0
							SAVE RECORD:C53([ADT_Entrevistas:121])
						End if 
					End if 
				: ($r=2)
					OK:=CD_Dlog (0;Replace string:C233(__ ("Esta hora ha sido asignada para la entrevista con la familia ^0.\r¿Desea usted realmente cancelar esta cita y marcar la hora como NO disponible?");__ ("^0");$cellName);__ ("");__ ("No");__ ("Sí"))
					If (ok=2)
						QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=aWeekStartDate{aWeeks}+(vCol1-2);*)
						QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=vRow1;*)
						QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
						If (Records in selection:C76([ADT_Entrevistas:121])#0)
							DELETE RECORD:C58([ADT_Entrevistas:121])
						End if 
					End if 
				: ($r=4)
					OK:=CD_Dlog (0;Replace string:C233(__ ("Esta hora ha sido asignada para la entrevista con la familia ^0.\r¿Desea usted realmente cancelar esta cita y marcar la hora como NO disponible?");__ ("^0");$cellName);__ ("");__ ("No");__ ("Sí"))
					If (ok=2)
						QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$cellDate;*)
						QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
						QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
						If (Records in selection:C76([ADT_Entrevistas:121])#0)
							DELETE RECORD:C58([ADT_Entrevistas:121])
						End if 
						$name:=CD_Request (__ ("Nombre de la familia:");__ ("Aceptar");__ ("Cancelar");__ (""))
						If (($name#"") & (OK=1))
							QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=($name+"@"))
							If (Records in selection:C76([Familia:78])=1)
								QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_familia:5=[Familia:78]Numero:1)
								DELETE RECORD:C58([ADT_Entrevistas:121])
								QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$cellDate;*)
								QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
								QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
								If (Records in selection:C76([ADT_Entrevistas:121])=0)
									CREATE RECORD:C68([ADT_Entrevistas:121])
								End if 
								[ADT_Entrevistas:121]ID_Funcionario:1:=[Profesores:4]Numero:1
								[ADT_Entrevistas:121]ID_familia:5:=[Familia:78]Numero:1
								[ADT_Entrevistas:121]Date_IView:2:=$cellDate
								[ADT_Entrevistas:121]Index:6:=$cellIndex
								[ADT_Entrevistas:121]Start_IView:3:=$cellStartTime
								[ADT_Entrevistas:121]End_IView:4:=$cellEndTime
								SAVE RECORD:C53([ADT_Entrevistas:121])
							End if 
						End if 
					End if 
			End case 
		: (vColor=10)  //libre
			$r:=Pop up menu:C542(__ ("(Marcar como disponible para entrevista;Cancelar disponibilidad;(-;Asignar entrevista a una familia…;(-;(Ver entrevista…");0)
			Case of 
				: ($r=2)
					QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$cellDate;*)
					QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
					QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
					If (Records in selection:C76([ADT_Entrevistas:121])#0)
						DELETE RECORD:C58([ADT_Entrevistas:121])
					End if 
			End case 
	End case 
	vColor:=0
	vCol1:=0
	vrow1:=0
	PST_IViewersSchedule 
End if 
