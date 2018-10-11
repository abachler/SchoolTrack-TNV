Case of 
	: (alProEvt=1)
		If ([Profesores:4]Es_Entrevistador_Admisiones:35)
			ARRAY INTEGER:C220(aInt2D;2;0)
			$r:=AL_GetCellSel (xALP_IViewTimeTable;vCol1;vRow1;vCol2;vrow2;aInt2D)
			Case of 
				: ((vCol1#0) & (vCol2=0))  //one cell selected
					If (vCol1#1)
						vColor:=aiPST_ColorArrPtr{vCol1-1}->{vRow1}
					Else 
						vColor:=0
					End if 
				: ((vCol1#0) & (vCol2#0))  //contigous cell selected
					Case of 
						: ((vCol1#1) & (vCol2#1))
							vColor:=aiPST_ColorArrPtr{vCol1-1}->{vRow1}
						: ((vCol1=1) & (vCol2#1))
							vCol1:=vCol1+1
							AL_SetCellSel (xALP_IViewTimeTable;vCol1;vRow1;vCol2;vRow2)
							vColor:=aiPST_ColorArrPtr{vCol1-1}->{vRow1}
						: ((vCol1=1) & (vCol2=1))
							AL_SetCellSel (xALP_IViewTimeTable;0;0;0;0)
							vColor:=0
					End case 
					If (vColor#0)
						For ($i;vCol1;vCol2)
							For ($j;vRow1;vRow2)
								If (vColor#aiPST_ColorArrPtr{$i-1}->{$j})
									$i:=vCol2+1
									$j:=vRow2+1
									vColor:=0
									CD_Dlog (0;__ ("No es posible seleccionar simultánemente celdas con diferentes status."))
								End if 
							End for 
						End for 
					End if 
				: (Size of array:C274(aInt2D{1})>0)  //non contigous cell selected
					$col1:=Find in array:C230(aInt2D{1};1)
					While ($col1#-1)
						AT_Delete ($col1;1;->aInt2D{1};->aInt2D{2})
						$col1:=Find in array:C230(aInt2D{1};1)
					End while 
					AL_SetCellSel (xALP_IViewTimeTable;0;0;0;0;aInt2D)
					If (Size of array:C274(aInt2D{1})>0)
						vColor:=aiPST_ColorArrPtr{aInt2D{1}{1}-1}->{aInt2D{2}{1}}
						For ($i;1;Size of array:C274(aInt2D{1}))
							If (vColor#aiPST_ColorArrPtr{aInt2D{1}{$i}-1}->{aInt2D{2}{$i}})
								$i:=Size of array:C274(aInt2D{1})+1
								vColor:=0
								CD_Dlog (0;__ ("No es posible seleccionar simultánemente celdas con diferentes status."))
							End if 
						End for 
					End if 
			End case 
			Case of 
				: (vColor=161)
					ENABLE MENU ITEM:C149(5;1)
					SET MENU ITEM MARK:C208(5;1;"")
				: (vColor=10)
					ENABLE MENU ITEM:C149(5;1)
					SET MENU ITEM MARK:C208(5;1;Char:C90(18))
				: (vColor=4)
					DISABLE MENU ITEM:C150(5;1)
					SET MENU ITEM MARK:C208(5;1;"")
				: (vColor=0)
					DISABLE MENU ITEM:C150(5;1)
					ARRAY INTEGER:C220(aInt2D;2;0)
					AL_SetCellSel (xALP_IViewTimeTable;0;0;0;0;aInt2D)
			End case 
			If ((vCol1#0) & (vCol2=0) & (Size of array:C274(aInt2D{1})=0) & (vColor=4))
				ENABLE MENU ITEM:C149(5;3)
				ENABLE MENU ITEM:C149(5;5)
				ENABLE MENU ITEM:C149(5;7)
			Else 
				DISABLE MENU ITEM:C150(5;3)
				DISABLE MENU ITEM:C150(5;5)
				DISABLE MENU ITEM:C150(5;7)
			End if 
		Else 
			BEEP:C151
		End if 
		  //: (alProEvt=2)
	: ((alProEvt=2) & (Not:C34(Macintosh option down:C545 | Windows Alt down:C563)))  //20150612 ASM ticket 145724
		If ([Profesores:4]Es_Entrevistador_Admisiones:35)
			$r:=AL_GetCellSel (xALP_IViewTimeTable;vCol1;vRow1;vCol2;vrow2;aInt2D)
			If (vCol1#1)
				vColor:=aiPST_ColorArrPtr{vCol1-1}->{vRow1}
				$CellDate:=aWeekStartDate{aWeeks}+(vCol1-2)
				$cellStartTime:=aTimeIview{vRow1}
				$cellEndTime:=aTimeIview{vRow1}+(viPST_IviewDuration*60)
				$cellIndex:=vRow1
				Case of 
					: (vColor=161)
						READ WRITE:C146([ADT_Entrevistas:121])
						CREATE RECORD:C68([ADT_Entrevistas:121])
						[ADT_Entrevistas:121]ID_Funcionario:1:=[Profesores:4]Numero:1
						[ADT_Entrevistas:121]ID_familia:5:=0
						[ADT_Entrevistas:121]Date_IView:2:=$cellDate
						[ADT_Entrevistas:121]Index:6:=$cellIndex
						[ADT_Entrevistas:121]Start_IView:3:=$cellStartTime
						[ADT_Entrevistas:121]End_IView:4:=$cellEndTime
						SAVE RECORD:C53([ADT_Entrevistas:121])
						READ ONLY:C145([ADT_Entrevistas:121])
						PST_IViewersSchedule 
					: (vColor=10)
						READ WRITE:C146([ADT_Entrevistas:121])
						QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$cellDate;*)
						QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
						QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
						If (Records in selection:C76([ADT_Entrevistas:121])#0)
							DELETE RECORD:C58([ADT_Entrevistas:121])
						End if 
						READ ONLY:C145([ADT_Entrevistas:121])
						PST_IViewersSchedule 
				End case 
			Else 
				DISABLE MENU ITEM:C150(5;1)
				ARRAY INTEGER:C220(aInt2D;2;0)
				AL_SetCellSel (xALP_IViewTimeTable;0;0;0;0;aInt2D)
			End if 
		Else 
			BEEP:C151
		End if 
	: (alproevt=5)
		  //ARRAY INTEGER(aInt2D;2;0)
		  //$r:=AL_GetCellSel (xALP_IViewTimeTable;vCol1;vRow1;vCol2;vrow2;aInt2D)
		  //$text:="test1;test2;test3"
		  //$choice:=Pop up menu($text)
End case 