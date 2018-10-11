Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		PERIODOS_LoadData 
		cbAtrasos:=1
		btNivelCUrso:=1
		vCantidad1:=1
		vCantidad2:=0
		
		<>aNivelT:=Size of array:C274(<>aNivelT)
		$nivelNombre:=<>aNivelT{<>aNivelT}
		$nivNum:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->$nivelNombre;->[xxSTR_Niveles:6]NoNivel:5)
		vNivel2:=$nivelNombre
		vNivelInterno2:=$nivNum
		
		<>aNivelB:=1
		$nivelNombre:=<>aNivelB{<>aNivelB}
		$nivNum:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->$nivelNombre;->[xxSTR_Niveles:6]NoNivel:5)
		vNivelInterno1:=$nivNum
		vNivel1:=$nivelNombre
		
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
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		If ((dDate1=!00-00-00!) | (dDate2=!00-00-00!) | (dDate1>dDate2))
			_O_DISABLE BUTTON:C193(bSearch)
		Else 
			_O_ENABLE BUTTON:C192(bSearch)
		End if 
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (vlAL_WinRef)
End case 
