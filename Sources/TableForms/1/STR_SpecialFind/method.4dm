Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		PERIODOS_LoadData 
		dDate1:=adSTR_Periodos_Desde{atSTR_Periodos_Nombre}
		dDate2:=adSTR_Periodos_Hasta{atSTR_Periodos_Nombre}
		vt_periodo:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
		ARRAY TEXT:C222(<>aWeeks;0)
		ARRAY TEXT:C222(<>aWeeks;1)
		$date:=adSTR_Periodos_Desde{1}
		$day:=Day number:C114($date)
		$offset:=7-$day
		$date2:=$date+$offset
		<>aWeeks{1}:=String:C10($date)+" al "+String:C10($date2)
		While ($date<adSTR_Periodos_Hasta{Size of array:C274(atSTR_Periodos_Nombre)})
			$date:=$date2+2
			$date2:=$date+5
			If ((Current date:C33>=$date) & (Current date:C33<=$date2))
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
		sMonth:=""
		GOTO OBJECT:C206(btoday)
		If ((dDate1=!00-00-00!) | (dDate2=!00-00-00!) | (dDate1>dDate2))
			_O_DISABLE BUTTON:C193(bSearch)
		Else 
			_O_ENABLE BUTTON:C192(bSearch)
		End if 
		
		If (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))>0)
			cbSearchSelection:=1
		Else 
			cbSearchSelection:=0
		End if 
		
		
		  //tablesettings
		Case of 
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Anotaciones:11]))
				r4:=1
				SET WINDOW TITLE:C213(__ ("Búsqueda de Anotaciones"))
				FORM GOTO PAGE:C247(2)
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Atrasos:55]))
				SET WINDOW TITLE:C213(__ ("Búsqueda de Atrasos"))
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Castigos:9]))
				r3:=1
				SET WINDOW TITLE:C213(__ ("Búsqueda de Castigos"))
				FORM GOTO PAGE:C247(3)
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_ControlesMedicos:99]))
				SET WINDOW TITLE:C213(__ ("Búsqueda de Controles Médicos"))
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosEnfermeria:14]))
				SET WINDOW TITLE:C213(__ ("Búsqueda de Visitas a Enfermería"))
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosOrientacion:21]))
				SET WINDOW TITLE:C213(__ ("Búsqueda de Eventos Orientación"))
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Inasistencias:10]))
				r3:=1
				SET WINDOW TITLE:C213(__ ("Búsqueda de Inasistencias"))
				FORM GOTO PAGE:C247(4)
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_ObsOrientacion:127]))
				SET WINDOW TITLE:C213(__ ("Búsqueda de Registro de observaciones"))
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Suspensiones:12]))
				SET WINDOW TITLE:C213(__ ("Búsqueda de Suspensiones"))
				
			: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Licencias:73]))
				SET WINDOW TITLE:C213(__ ("Búsqueda de Licencias"))
				
		End case 
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		If ((dDate1=!00-00-00!) | (dDate2=!00-00-00!) | (dDate1>dDate2))
			_O_DISABLE BUTTON:C193(bSearch)
		Else 
			_O_ENABLE BUTTON:C192(bSearch)
		End if 
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
