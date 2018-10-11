If (vb_AplicarDesctos)
	If ((vl_Mes=vl_PrevMes) & (vl_Año=vl_PrevAño))
		$r:=CD_Dlog (0;__ ("¿Desea aplicar los descuentos ingresados o regenerar el área de ingreso para el mes de ")+aMeses{vl_Mes}+__ (" de ")+String:C10(vl_Año)+__ ("?");__ ("");__ ("Aplicar");__ ("Regenerar"))
		$mismoMes:=True:C214
	Else 
		$r:=CD_Dlog (0;__ ("¿Desea aplicar los descuentos para el mes de ")+aMeses{vl_Prevmes}+__ (" de ")+String:C10(vl_PrevAño)+__ ("?");__ ("");__ ("Si");__ ("No"))
		$mismoMes:=False:C215
	End if 
Else 
	$r:=3
End if 
If ($r=3)
	vl_PrevMes:=vl_Mes
	vl_PrevAño:=vl_Año
	$date1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año)
	$date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
	CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection1")
	ACTdesctos_BuildDesctosArea ($date1;$date2;"Selection1")
Else 
	If ($mismoMes)
		If ($r=1)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection1")
			ACTdesctos_AplicaDesctos 
			vl_PrevMes:=vl_Mes
			vl_PrevAño:=vl_Año
			$date1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año)
			$date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
			ACTdesctos_BuildDesctosArea ($date1;$date2;"Selection1")
		Else 
			vl_PrevMes:=vl_Mes
			vl_PrevAño:=vl_Año
			$date1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año)
			$date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection1")
			ACTdesctos_BuildDesctosArea ($date1;$date2;"Selection1")
		End if 
	Else 
		If ($r=1)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection1")
			ACTdesctos_AplicaDesctos 
			vl_PrevMes:=vl_Mes
			vl_PrevAño:=vl_Año
			$date1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año)
			$date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
			ACTdesctos_BuildDesctosArea ($date1;$date2;"Selection1")
		Else 
			vl_PrevMes:=vl_Mes
			vl_PrevAño:=vl_Año
			$date1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año)
			$date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection1")
			ACTdesctos_BuildDesctosArea ($date1;$date2;"Selection1")
		End if 
	End if 
End if 