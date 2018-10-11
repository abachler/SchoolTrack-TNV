//%attributes = {}
  //ADTivws_OnRecordLoad

If (Is new record:C668([Profesores:4]))
	[Profesores:4]Numero:1:=SQ_SeqNumber (->[Profesores:4]Numero:1)
	[Profesores:4]Categoria:20:=1
	Case of 
		: ((<>gPais="Chile") | (<>gPais=""))
			[Profesores:4]Nacionalidad:7:="Chilena"
		: (<>gPais="Paraguay")
			[Profesores:4]Nacionalidad:7:="Paraguaya"
	End case 
	[Profesores:4]Ciudad:11:=<>gCiudad
End if 
viPST_IViewerRecNum:=Record number:C243([Profesores:4])
vsPST_aPaternoIViewer:=[Profesores:4]Apellido_paterno:3
vsPST_aMaternoIViewer:=[Profesores:4]Apellido_materno:4
vsPST_NombresIViewer:=[Profesores:4]Nombres:2
vsPST_ExtIViewer:=[Profesores:4]Anexo:23
vsPST_PhoneIViewer:=[Profesores:4]Telefono_domicilio:24
vdPST_iViewFrom:=vdPST_StartInterviews
vdPST_iViewTo:=vdPST_EndInterviews
[Profesores:4]Entrevista_desde:36:=vdPST_iViewFrom
[Profesores:4]Entrevista_hasta:37:=vdPST_iViewTo

If (vdPST_IViewFrom#!00-00-00!)
	$dayNumberStart:=Day number:C114(vdPST_IViewFrom)
	$fridayDate:=vdPST_IViewFrom+(5-$dayNumberStart)
	If ($dayNumberStart>2)
		$Date:=vdPST_IViewFrom-($dayNumberStart-2)
	Else 
		$date:=vdPST_IViewFrom
	End if 
	$weeks:=Int:C8((vdPST_IViewTo-$date)/7)+1
	If ($weeks>0)
		ARRAY TEXT:C222(aWeeks;$weeks)
		ARRAY DATE:C224(aWeekStartDate;$weeks)
		ARRAY DATE:C224(aWeekEndDate;$weeks)
		For ($i;1;$weeks)
			aWeekStartDate{$i}:=$date
			aWeekEndDate{$i}:=$date+4
			aWeeks{$i}:=DT_SpecialDate2String (aWeekStartDate{$i})+" al "+DT_SpecialDate2String (aWeekEndDate{$i};2)
			$date:=$date+7
		End for 
		aWeeks:=1
		If (vdPST_IViewTo=!00-00-00!)
			[Profesores:4]Entrevista_hasta:37:=aWeekEndDate{1}
			vdPST_IViewTo:=[Profesores:4]Entrevista_hasta:37
		End if 
		PST_IViewersSchedule 
	Else 
		aWeeks:=0
	End if 
Else 
	ARRAY TEXT:C222(aWeeks;0)
	ARRAY DATE:C224(aWeekStartDate;0)
	ARRAY DATE:C224(aWeekEndDate;0)
End if 