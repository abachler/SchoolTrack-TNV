vCol1:=0
vCol2:=0
vRow1:=0
vRow2:=0
vColor:=0

$date:=aWeekStartDate{aWeeks}


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
			$ptr:=aiPST_ColorArrPtr{$i-1}
			$ptr->{$j}:=13
			AL_SetCellColor (xALP_IViewTimeTable;$i;$j;$i;$j;aInt2D;"";13;"";13)
		End for 
	End if 
	
	READ ONLY:C145([ADT_Entrevistas:121])
	QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=0;*)
	QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Date_IView:2=$date)
	ORDER BY:C49([ADT_Entrevistas:121];[ADT_Entrevistas:121]Start_IView:3;>)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([ADT_Entrevistas:121]ID_Funcionario:1;$idInterviewer;[ADT_Entrevistas:121]Index:6;$index;[Profesores:4]Nombre_comun:21;$Interviewer)
	CREATE SET:C116([ADT_Entrevistas:121];"schedule")
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	ARRAY LONGINT:C221(aIndexes;0)
	For ($j;1;Size of array:C274($index))
		$in:=Find in array:C230(aIndexes;$index{$j})
		If ($in=-1)
			$ptr->{$index{$j}}:=10
			INSERT IN ARRAY:C227(aIndexes;Size of array:C274(aIndexes)+1;1)
			aIndexes{Size of array:C274(aIndexes)}:=$index{$j}
			ayPST_ScheduleColPointers{$i-1}->{$index{$j}}:=$Interviewer{$j}
			AL_SetCellColor (xALP_IViewTimeTable;$i;$index{$j};0;0;aInt2D;"Black";0;"";178)
			AL_SetCellStyle (xALP_IViewTimeTable;$i;$index{$j};0;0;aInt2D;0)
		Else 
			INSERT IN ARRAY:C227(aIndexes;Size of array:C274(aIndexes)+1;1)
			aIndexes{Size of array:C274(aIndexes)}:=$index{$j}
			aIndexes{0}:=$index{$j}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->aIndexes;"=";->$DA_Return)
			$ptr->{$index{$j}}:=11
			ayPST_ScheduleColPointers{$i-1}->{$index{$j}}:=String:C10(Size of array:C274($DA_Return))+__ (" Disponibles")
			AL_SetCellColor (xALP_IViewTimeTable;$i;$index{$j};0;0;aInt2D;"Black";0;"";180)
			AL_SetCellStyle (xALP_IViewTimeTable;$i;$index{$j};0;0;aInt2D;0)
		End if 
	End for 
	$date:=$date+1
End for 

AL_SetCellSel (xALP_IViewTimeTable;0;0;0;0;aInt2D)
AL_UpdateArrays (xALP_IViewTimeTable;-1)
AL_SetSort (xALP_IViewTimeTable;1)