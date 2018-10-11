//%attributes = {}
  //PST_IViewersSchedule

PST_ReadParameters 
$date:=aWeekStartDate{aWeeks}
$dayNumberStart:=Day number:C114($date)
READ ONLY:C145([ADT_Entrevistas:121])
QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
ORDER BY:C49([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2;>;[ADT_Entrevistas:121]Start_IView:3;>)
CREATE SET:C116([ADT_Entrevistas:121];"schedule")
ARRAY INTEGER:C220(aInt2D;2;0)
AL_SetCellSel (xALP_IViewTimeTable;0;0;0;0;aInt2D)
vCol1:=0
vCol2:=0
vRow1:=0
vRow2:=0
vColor:=0

For ($i;2;6)
	$ptr:=aiPST_ColorArrPtr{$i-1}
	If (($date>=vdPST_StartInterviews) & ($date<=vdPST_EndInterviews))
		AL_SetHeaders (xALP_IViewTimeTable;$i;1;DT_GetDayNameFromDate ($date)+"\r"+String:C10($date))
		AL_SetHdrStyle (xALP_IViewTimeTable;$i;"Tahoma";9;1)
		For ($j;1;Size of array:C274(aTimeIView))
			$ptr->{$j}:=161
			AL_SetCellColor (xALP_IViewTimeTable;$i;$j;$i;$j;aInt2D;"";161;"";161)
		End for 
	Else 
		AL_SetHeaders (xALP_IViewTimeTable;$i;1;DT_GetDayNameFromDate ($date)+"\r"+String:C10($date))
		AL_SetHdrStyle (xALP_IViewTimeTable;$i;"Tahoma";9;2)
		For ($j;1;Size of array:C274(aTimeIView))
			$ptr->{$j}:=13
			AL_SetCellColor (xALP_IViewTimeTable;$i;$j;$i;$j;aInt2D;"";13;"";13)
		End for 
	End if 
	
	USE SET:C118("Schedule")
	QUERY SELECTION:C341([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$date)
	SELECTION TO ARRAY:C260([ADT_Entrevistas:121]ID_familia:5;$idCandidate;[ADT_Entrevistas:121]Index:6;$index;[Familia:78]Nombre_de_la_familia:3;$family)
	For ($j;1;Size of array:C274($index))
		If ($idCandidate{$j}#0)
			$ptr->{$index{$j}}:=4
			$stringArrPointer:=ayPST_ScheduleColPointers{$i-1}
			$stringArrPointer->{$index{$j}}:=$family{$j}
			AL_SetCellColor (xALP_IViewTimeTable;$i;$index{$j};0;0;aInt2D;"";(9*16);"";(8*16)+1)
		Else 
			$ptr->{$index{$j}}:=10
			$stringArrPointer:=ayPST_ScheduleColPointers{$i-1}
			$stringArrPointer->{$index{$j}}:="Disponible"
			AL_SetCellColor (xALP_IViewTimeTable;$i;$index{$j};0;0;aInt2D;"";12*16;"";178)
		End if 
	End for 
	$date:=$date+1
End for 
AL_UpdateArrays (xALP_IViewTimeTable;-2)
AL_SetSort (xALP_IViewTimeTable;1)