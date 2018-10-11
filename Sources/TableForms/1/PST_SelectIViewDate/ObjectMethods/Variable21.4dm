Case of 
	: (alProEvt=2)
		ARRAY INTEGER:C220(aInt2D;2;0)
		$r:=AL_GetCellSel (xALP_IViewTimeTable;vCol1;vRow1;vCol2;vrow2;aInt2D)
		vColor:=aiPST_ColorArrPtr{vCol1-1}->{vRow1}
		$CellDate:=aWeekStartDate{aWeeks}+(vCol1-2)
		$cellStartTime:=aTimeIview{vRow1}
		$cellEndTime:=aTimeIview{vRow1}+(viPST_IviewDuration*60)
		$cellIndex:=vRow1
		Case of 
			: (vColor=10)
				READ WRITE:C146([ADT_Entrevistas:121])
				QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_familia:5=[Alumnos:2]Familia_Número:24)
				If (Records in selection:C76([ADT_Entrevistas:121])=1)
					[ADT_Entrevistas:121]ID_familia:5:=0
					SAVE RECORD:C53([ADT_Entrevistas:121])
				End if 
				
				QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$Celldate;*)
				QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
				QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_familia:5=0)
				[ADT_Entrevistas:121]ID_familia:5:=[Alumnos:2]Familia_Número:24
				  //asigne una entrevista, si cancela el usuario, debo desasignarla
				
				
				SAVE RECORD:C53([ADT_Entrevistas:121])
				READ ONLY:C145([Profesores:4])
				RELATE ONE:C42([ADT_Entrevistas:121]ID_Funcionario:1)
				[ADT_Candidatos:49]Fecha_de_Entrevista:4:=[ADT_Entrevistas:121]Date_IView:2
				[ADT_Candidatos:49]Hora_de_entrevista:17:=[ADT_Entrevistas:121]Start_IView:3
				[ADT_Candidatos:49]ID_Entrevistador:54:=[Profesores:4]Numero:1
				[ADT_Candidatos:49]Entrevistador:20:=[Profesores:4]Apellidos_y_nombres:28
				SAVE RECORD:C53([ADT_Candidatos:49])
				ACCEPT:C269
			: (vColor=11)
				READ WRITE:C146([ADT_Entrevistas:121])
				QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_familia:5=[Alumnos:2]Familia_Número:24)
				If (Records in selection:C76([ADT_Entrevistas:121])=1)
					[ADT_Entrevistas:121]ID_familia:5:=0
					SAVE RECORD:C53([ADT_Entrevistas:121])
				End if 
				ARRAY TEXT:C222(aNombreProf;0)
				ARRAY LONGINT:C221(aIndex;0)
				ARRAY LONGINT:C221(aIDFunc;0)
				QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$Celldate;*)
				QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
				QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_familia:5=0)
				SELECTION TO ARRAY:C260([ADT_Entrevistas:121]ID_Funcionario:1;aIDFunc;[ADT_Entrevistas:121]Index:6;aIndex)
				READ ONLY:C145([Profesores:4])
				ARRAY TEXT:C222(aNombreProf;Size of array:C274(aIDFunc))
				For ($i;1;Size of array:C274(aIDFunc))
					QUERY:C277([Profesores:4];[Profesores:4]Numero:1=aIDFunc{$i})
					aNombreProf{$i}:=[Profesores:4]Apellidos_y_nombres:28
				End for 
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=->aNombreProf
				<>aChoicePtrs{2}:=->aIndex
				<>aChoicePtrs{3}:=->aIDFunc
				TBL_ShowChoiceList (2;"Seleccione el Entrevistador";1;->xALP_IViewTimeTable)
				If (ok=1)
					QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$Celldate;*)
					QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
					QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_familia:5=0;*)
					QUERY:C277([ADT_Entrevistas:121]; & ;[ADT_Entrevistas:121]ID_Funcionario:1=aIDFunc{choiceIdx})
					[ADT_Entrevistas:121]ID_familia:5:=[Alumnos:2]Familia_Número:24
					
					SAVE RECORD:C53([ADT_Entrevistas:121])
					READ ONLY:C145([Profesores:4])
					RELATE ONE:C42([ADT_Entrevistas:121]ID_Funcionario:1)
					[ADT_Candidatos:49]Fecha_de_Entrevista:4:=[ADT_Entrevistas:121]Date_IView:2
					[ADT_Candidatos:49]Hora_de_entrevista:17:=[ADT_Entrevistas:121]Start_IView:3
					[ADT_Candidatos:49]Entrevistador:20:=[Profesores:4]Apellidos_y_nombres:28
					[ADT_Candidatos:49]ID_Entrevistador:54:=[Profesores:4]Numero:1
					SAVE RECORD:C53([ADT_Candidatos:49])
					ACCEPT:C269
				End if 
				AT_Initialize (->aNombreProf;->aIndex;->aIDFunc)
		End case 
End case 