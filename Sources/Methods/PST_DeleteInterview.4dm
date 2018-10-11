//%attributes = {}
  //PST_DeleteInterview

$CellDate:=aWeekStartDate{aWeeks}+(vCol1-2)
$cellIndex:=vRow1
READ WRITE:C146([ADT_Entrevistas:121])
QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2=$cellDate;*)
QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Index:6=$cellIndex;*)
QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]ID_Funcionario:1=[Profesores:4]Numero:1)
If (Records in selection:C76([ADT_Entrevistas:121])#0)
	Case of 
		: (($cellDate<Current date:C33(*)) & ([ADT_Entrevistas:121]Tex_Interview:7=""))
			OK:=CD_Dlog (0;__ ("La fecha de esta entrevista es anterior a la fecha de hoy\r¿Desea realmente eliminarla?");__ ("");__ ("No");__ ("Sí"))
		: ([ADT_Entrevistas:121]Tex_Interview:7#"")
			OK:=CD_Dlog (0;__ ("Hay observaciones ingresadas en esta entrevista\r¿Desea realmente eliminarla?");__ ("");__ ("No");__ ("Sí"))
		Else 
			OK:=CD_Dlog (0;__ ("¿Desea realmente eliminar esta entrevista?");__ ("");__ ("No");__ ("Sí"))
	End case 
	If (ok=2)
		DELETE RECORD:C58([ADT_Entrevistas:121])
		PST_IViewersSchedule 
	End if 
End if 