Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		  //Botones de Seleccion de Informes
		br1:=1
		br2:=0
		br3:=0
		br4:=0
		br5:=0
		vl_TipoInformeTT:=1
		  //Botones radiales de seleccion de registros de rutas
		lr1:=0
		lr2:=0
		IT_SetButtonState (False:C215;->lr1;->lr2)
		
		  //Seleccion de Curso para Informe de alumnos por curso
		IT_SetButtonState (False:C215;-><>aCursos)
		
		  //PAra el informe de Asistencia
		
		PERIODOS_Init 
		PERIODOS_LoadData 
		dDate1:=adSTR_Periodos_Desde{atSTR_Periodos_Nombre}
		dDate2:=adSTR_Periodos_Hasta{atSTR_Periodos_Nombre}
		ARRAY TEXT:C222(<>aWeeks;0)
		ARRAY TEXT:C222(<>aWeeks;1)
		$date:=adSTR_Periodos_Desde{1}
		$day:=DT_GetDayNumber_ISO8601 ($date)
		$offset:=7-$day
		$date2:=$date+$offset
		<>aWeeks{1}:=String:C10($date)+" al "+String:C10($date2)
		While (($date<Current date:C33(*)) & ($date2<Current date:C33(*)))
			$date:=$date2+1
			$date2:=$date+6
			If ((Current date:C33(*)>=$date) & (Current date:C33(*)<=$date2))
				<>currWeek:=Size of array:C274(<>aWeeks)+1+3
			End if 
			INSERT IN ARRAY:C227(<>aWeeks;Size of array:C274(<>aWeeks)+1;1)
			<>aWeeks{Size of array:C274(<>aWeeks)}:=String:C10($date;"00/00/0000")+" al "+String:C10($date2;"00/00/0000")
		End while 
		INSERT IN ARRAY:C227(<>aWeeks;1;3)
		<>aWeeks{1}:="Anterior"
		<>aWeeks{2}:="Actual"
		<>aWeeks{3}:="-"
		<>aWeeks:=<>currWeek
		sweek:=""
		READ ONLY:C145([BU_Rutas:26])
		ALL RECORDS:C47([BU_Rutas:26])
		SELECTION TO ARRAY:C260([BU_Rutas:26]Nombre:9;atRuta;[BU_Rutas:26]ID:12;alIDRuta)
		vtNombreRuta:=""
		
		ARRAY TEXT:C222(atSentido;0)
		ARRAY TEXT:C222(atSentido;2)
		atSentido{1}:="Llegada"
		atSentido{2}:="Salida"
		
		IT_SetEnterable (False:C215;0;->sWeek;->dDate1;->dDate2;->vtNombreRuta;->vtSentido)
		IT_SetButtonState (False:C215;->sWeek;-><>aWeeks;->atRuta;->atSentido)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		IT_SetButtonState (True:C214;-><>aCursos;->atRuta)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 