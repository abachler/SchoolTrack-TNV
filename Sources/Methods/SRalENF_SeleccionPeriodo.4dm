//%attributes = {}
  //SRalENF_SeleccionPeriodo

PERIODOS_LoadData (0;-1)
FORM GET PROPERTIES:C674([Alumnos_EventosEnfermeria:14];"PeriodoInformeVisitasNivel";$width;$height)
  //WDW_Open ($width;$height;0;-palette form Window;"Período de tiempo a imprimir")
WDW_OpenFormWindow (->[Alumnos_EventosEnfermeria:14];"PeriodoInformeVisitasNivel";0;-Palette form window:K39:9;__ ("Período de tiempo a imprimir"))
DIALOG:C40([Alumnos_EventosEnfermeria:14];"PeriodoInformeVisitasNivel")
CLOSE WINDOW:C154

If (OK=1)
	
	USE SET:C118("LasDelAño")
	Case of 
		: (vPeriod=1)  //Para hoy
			QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Fecha:2=Current date:C33(*))
			CREATE SET:C116([Alumnos_EventosEnfermeria:14];"Selection")
			vParaCuando:="Visitas realizadas el día de hoy hasta las "+String:C10(Current time:C178(*))+"hrs."
		: (vPeriod=2)  //Para esta semana
			$CurrentDay:=Day number:C114(Current date:C33(*))
			$DaysBefore:=$CurrentDay-2
			$InitialQueryDate:=Current date:C33(*)-$DaysBefore
			$FinalQueryDate:=Current date:C33(*)
			QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Fecha:2>=$InitialQueryDate;*)
			QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14]; & ;[Alumnos_EventosEnfermeria:14]Fecha:2<=$FinalQueryDate)
			CREATE SET:C116([Alumnos_EventosEnfermeria:14];"Selection")
			vParaCuando:="Visitas realizadas esta semana hasta el día de hoy a las "+String:C10(Current time:C178(*))+" hrs."
		: (vPeriod=3)  //Para mes anterior
			
			ARRAY LONGINT:C221($aTempsIDs;0)
			$month:=Month of:C24(Current date:C33(*))
			$month:=$month-1
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14];aIDs;[Alumnos_EventosEnfermeria:14]Fecha:2;aFechas)
			For ($u;1;Size of array:C274(aIDs))
				If (Month of:C24(aFechas{$u})=$month)
					INSERT IN ARRAY:C227($aTempsIDs;Size of array:C274($aTempsIDs)+1;1)
					$aTempsIDs{Size of array:C274($aTempsIDs)}:=aIDs{$u}
				End if 
			End for 
			CREATE SET FROM ARRAY:C641([Alumnos_EventosEnfermeria:14];$aTempsIDs;"Selection")
			vParaCuando:="Visitas realizadas para el mes anterior."
			
		: (vPeriod=4)  //Para este mes
			ARRAY LONGINT:C221($aTempsIDs;0)
			$month:=Month of:C24(Current date:C33(*))
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14];aIDs;[Alumnos_EventosEnfermeria:14]Fecha:2;aFechas)
			For ($u;1;Size of array:C274(aIDs))
				If (Month of:C24(aFechas{$u})=$month)
					INSERT IN ARRAY:C227($aTempsIDs;Size of array:C274($aTempsIDs)+1;1)
					$aTempsIDs{Size of array:C274($aTempsIDs)}:=aIDs{$u}
				End if 
			End for 
			CREATE SET FROM ARRAY:C641([Alumnos_EventosEnfermeria:14];$aTempsIDs;"Selection")
			vParaCuando:="Visitas realizadas el mes en curso hasta hoy a las "+String:C10(Current time:C178(*))+" hrs."
		: (vPeriod=5)  //Para un periodo
			$period:=atSTR_Periodos_Nombre
			QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Fecha:2>=adSTR_Periodos_Desde{$period};*)
			QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14]; & ;[Alumnos_EventosEnfermeria:14]Fecha:2<=adSTR_Periodos_Hasta{$period})
			CREATE SET:C116([Alumnos_EventosEnfermeria:14];"Selection")
			vParaCuando:="Visitas realizadas el "+atSTR_Periodos_Nombre{$period}+" hasta hoy a las "+String:C10(Current time:C178(*))+" hrs."
		: (vPeriod=6)  //Para este año
			USE SET:C118("LasDelAño")
			CREATE SET:C116([Alumnos_EventosEnfermeria:14];"Selection")
			vParaCuando:="Visitas realizadas durante el año en curso hasta hoy a las "+String:C10(Current time:C178(*))+" hrs."
		: (vPeriod=7)  //Para esta fecha
			If (vd_FechaENF#!00-00-00!)
				QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Fecha:2=vd_FechaENF)
			Else 
				REDUCE SELECTION:C351([Alumnos_EventosEnfermeria:14];0)
			End if 
			CREATE SET:C116([Alumnos_EventosEnfermeria:14];"Selection")
			vParaCuando:="Visitas realizadas el dia "+String:C10(vd_FechaENF;7)+"."
	End case 
End if 