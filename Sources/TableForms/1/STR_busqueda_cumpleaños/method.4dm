Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		PERIODOS_LoadData 
		C_LONGINT:C283(vl_nivel1;vl_nivel2)
		vb_Hoy:=0
		vb_Semana:=0
		vb_Mes:=1
		  //vb_Periodo:=0
		vb_Rango:=0
		cbSearchSelection:=0
		<>currWeek:=0
		ARRAY TEXT:C222(aMeses;0)
		ARRAY TEXT:C222(<>aWeeks;0)
		$date:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
		$day:=Day number:C114($date)
		$offset:=7-$day
		$date2:=$date+$offset+1
		APPEND TO ARRAY:C911(<>aWeeks;String:C10(Day of:C23($date);"00")+"-"+String:C10(Month of:C24($date);"00")+" al "+String:C10(Day of:C23($date2);"00")+"-"+String:C10(Month of:C24($date2);"00"))
		vt_Semana:=<>aWeeks{1}
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vl_Mes:=Month of:C24(Current date:C33(*))
		vt_Mes:=aMeses{vl_Mes}
		vl_dia1:=Day of:C23(Current date:C33(*))
		vl_dia2:=Day of:C23(Current date:C33(*))
		vt_mes1:=aMeses{Month of:C24(Current date:C33(*))}
		vt_mes2:=aMeses{Month of:C24(Current date:C33(*))}
		vl_mes1:=vl_Mes
		vl_mes2:=vl_Mes
		
		_O_DISABLE BUTTON:C193(*;"btn_Semana")
		_O_ENABLE BUTTON:C192(*;"btn_mes")
		  //DISABLE BUTTON(*;"btn_periodo")
		_O_DISABLE BUTTON:C193(*;"btn_entre@")
		OBJECT SET ENTERABLE:C238(*;"vl_dia@";False:C215)
		OBJECT SET ENTERABLE:C238(*;"nivelNombre@";False:C215)
		
		While ($date<DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*))))
			$date:=$date2+1
			$date2:=$date+6
			If ((Current date:C33(*)>=$date) & (Current date:C33(*)<=$date2))
				<>currWeek:=Size of array:C274(<>aWeeks)+3
			End if 
			APPEND TO ARRAY:C911(<>aWeeks;String:C10(Day of:C23($date);"00")+"-"+String:C10(Month of:C24($date);"00")+" al "+String:C10(Day of:C23($date2);"00")+"-"+String:C10(Month of:C24($date2);"00"))
		End while 
		If ($date>DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*))+1))
			AT_Delete (Size of array:C274(<>aWeeks);1;-><>aWeeks)
		End if 
		If (<>currWeek>0)
			INSERT IN ARRAY:C227(<>aWeeks;1;2)
			<>aWeeks:=<>currWeek
			<>aWeeks{1}:=<>aWeeks{<>currWeek}
			<>aWeeks{2}:="(-"
		End if 
		vt_Semana:=<>aWeeks{1}
		If (Size of array:C274(atSTR_Periodos_Nombre)>0)
			vt_Periodo:=atSTR_Periodos_Nombre{1}
			dDate1:=adSTR_Periodos_Desde{1}
			dDate2:=adSTR_Periodos_Hasta{1}
		End if 
		
		$table:=Table:C252(yBWR_CurrentTable)
		If ($table=2)
			OBJECT SET VISIBLE:C603(*;"nivel@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"nivel@";False:C215)
			OBJECT MOVE:C664(*;"bAccept";0;-70;5;0)
			OBJECT MOVE:C664(*;"Button2";0;-70;5;0)
			OBJECT MOVE:C664(*;"cbSearchSelection";0;-70;5;0)
			OBJECT MOVE:C664(*;"cbInactivos";0;-70;5;0)
			GET WINDOW RECT:C443($top;$left;$right;$bottom)
			SET WINDOW RECT:C444($top;$left;$right;$bottom-70)
		End if 
		
		If (Size of array:C274(<>at_NombreNivelesRegulares)>0)
			nivelNombre1:=<>at_NombreNivelesRegulares{1}
			nivelNombre2:=<>at_NombreNivelesRegulares{Size of array:C274(<>at_NombreNivelesRegulares)}
			vl_nivel1:=<>al_NumeroNivelRegular{1}
			vl_nivel2:=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)}
		Else 
			nivelNombre1:=""
			nivelNombre2:=""
			vl_nivel1:=0
			vl_nivel2:=0
		End if 
		
		ARRAY LONGINT:C221(al_diasMes1;0)
		$lastDay:=DT_GetLastDay (vl_mes1;Year of:C25(Current date:C33(*)))
		For ($i;1;$lastDay)
			APPEND TO ARRAY:C911(al_diasMes1;$i)
		End for 
		
		ARRAY LONGINT:C221(al_diasMes2;0)
		$lastDay:=DT_GetLastDay (vl_mes2;Year of:C25(Current date:C33(*)))
		For ($i;1;$lastDay)
			APPEND TO ARRAY:C911(al_diasMes2;$i)
		End for 
		
		  // MOD Ticket N° 168927 Patricio Aliaga 20180822
		C_LONGINT:C283(l_inactivos;$l_table)
		C_TEXT:C284($t_ayuda)
		l_inactivos:=1
		l_inactivos:=Num:C11(PREF_fGet (USR_GetUserID ;"STR_PrefInactivoCupleaños";String:C10(l_inactivos)))
		$l_table:=Table:C252(yBWR_CurrentTable)
		Case of 
			: ($l_table=7)
				$t_ayuda:=__ ("Con esta opción desmarcada sólo se considera apoderados con estado activo")
			: ($l_table=2)
				$t_ayuda:=__ ("Con esta opción desmarcada sólo se considera alumnos con estado activo")
			: ($l_table=4)
				$t_ayuda:=__ ("Con esta opción desmarcada sólo se considera profesores con estado activo")
		End case 
		OBJECT SET HELP TIP:C1181(*;"cbinactivos";$t_ayuda)
		
	: (Form event:C388=On Clicked:K2:4)
		If (vb_Semana=1)
			_O_ENABLE BUTTON:C192(*;"btn_Semana")
		Else 
			_O_DISABLE BUTTON:C193(*;"btn_Semana")
		End if 
		If (vb_Mes=1)
			_O_ENABLE BUTTON:C192(*;"btn_mes")
		Else 
			_O_DISABLE BUTTON:C193(*;"btn_mes")
		End if 
		If (cbSearchSelection=0)
			_O_ENABLE BUTTON:C192(*;"btn_nivel@")
		Else 
			_O_DISABLE BUTTON:C193(*;"btn_nivel@")
		End if 
		If (vb_Rangofecha=1)
			_O_ENABLE BUTTON:C192(*;"btn_entre@")
			OBJECT SET ENTERABLE:C238(*;"vl_dia@";False:C215)
		Else 
			_O_DISABLE BUTTON:C193(*;"btn_entre@")
			OBJECT SET ENTERABLE:C238(*;"vl_dia@";False:C215)
		End if 
		
		ARRAY LONGINT:C221(al_diasMes1;0)
		$lastDay:=DT_GetLastDay (vl_mes1;Year of:C25(Current date:C33(*)))
		For ($i;1;$lastDay)
			APPEND TO ARRAY:C911(al_diasMes1;$i)
		End for 
		
		ARRAY LONGINT:C221(al_diasMes2;0)
		$lastDay:=DT_GetLastDay (vl_mes2;Year of:C25(Current date:C33(*)))
		For ($i;1;$lastDay)
			APPEND TO ARRAY:C911(al_diasMes2;$i)
		End for 
		
		REDRAW WINDOW:C456
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
