Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_BOOLEAN:C305(vb_ocultarExportar)
		C_TEXT:C284($vt_filter)
		vb_Hoy:=0
		vb_Mes:=1
		vb_Año:=0
		vb_Rango:=0
		cb_Archivo:=0
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vl_Mes:=Month of:C24(Current date:C33(*))
		vt_Mes:=aMeses{vl_Mes}
		vl_Año:=Year of:C25(Current date:C33(*))
		vl_Año2:=Year of:C25(Current date:C33(*))
		vd_Fecha1:=Current date:C33(*)
		vd_Fecha2:=Current date:C33(*)
		
		OBJECT SET ENTERABLE:C238(vl_Año;False:C215)
		OBJECT SET ENTERABLE:C238(vl_Año2;True:C214)
		OBJECT SET ENTERABLE:C238(vt_Fecha1;False:C215)
		OBJECT SET ENTERABLE:C238(vt_Fecha2;False:C215)
		_O_ENABLE BUTTON:C192(bMes)
		_O_DISABLE BUTTON:C193(bCalendar1)
		_O_DISABLE BUTTON:C193(bCalendar2)
		$vt_filter:="&9##"+<>tXS_RS_DateSeparator+"##"+<>tXS_RS_DateSeparator+"####"
		OBJECT SET FILTER:C235(*;"vt_Fecha@";$vt_filter)
		
		C_DATE:C307(vdACT_SelFecha1;vdACT_SelFecha2)
		If ((vdACT_SelFecha1#!00-00-00!) & (vdACT_SelFecha2#!00-00-00!))
			vd_Fecha1:=vdACT_SelFecha1
			vd_Fecha2:=vdACT_SelFecha2
			vb_Mes:=0
			vb_Rango:=1
			_O_DISABLE BUTTON:C193(bMes)
			_O_ENABLE BUTTON:C192(bCalendar1)
			_O_ENABLE BUTTON:C192(bCalendar2)
		End if 
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		IT_SetEnterable (vb_Mes=1;0;->vl_Año2)
		
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: (vb_Hoy=1)
				vd_Fecha1:=Current date:C33(*)
				vt_fecha1:=String:C10(vd_Fecha1;7)
				vd_fecha2:=vd_fecha1
				vt_fecha2:=vt_fecha1
				aMeses:=Month of:C24(vd_Fecha1)
				vt_Mes:=aMeses{aMeses}
				vl_año:=Year of:C25(vd_Fecha1)
				vl_año2:=vl_año
				
			: (vb_mes=1)
				$lastday:=DT_GetLastDay (vl_Mes;vl_Año2)
				vd_Fecha1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año2)
				vd_Fecha2:=DT_GetDateFromDayMonthYear ($lastday;vl_Mes;vl_Año2)
				vt_fecha1:=String:C10(vd_Fecha1;7)
				vt_fecha2:=String:C10(vd_fecha2;7)
				vl_año:=vl_Año2
				
			: (vb_año=1)
				$lastday:=DT_GetLastDay (vl_Mes;vl_año)
				vd_Fecha1:=PERIODOS_InicioAñoSTrack (vl_año)
				vd_Fecha2:=PERIODOS_FinAñoPeriodosSTrack (vl_año)
				If (vd_Fecha1=!00-00-00!)
					vd_Fecha1:=DT_GetDateFromDayMonthYear (1;1;vl_año)
				End if 
				If (vd_Fecha2=!00-00-00!)
					vd_Fecha2:=DT_GetDateFromDayMonthYear (31;12;vl_año)
				End if 
				vt_fecha1:=String:C10(vd_Fecha1;7)
				vt_fecha2:=String:C10(vd_fecha2;7)
				vl_Año2:=vl_Año
				
			: (vb_Rango=1)
				
				
				
		End case 
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET ENTERABLE:C238(vt_Fecha1;vb_Rango=1)
		OBJECT SET ENTERABLE:C238(vt_Fecha2;vb_Rango=1)
		OBJECT SET ENTERABLE:C238(vl_Año;vb_Año=1)
		OBJECT SET ENTERABLE:C238(vl_Año2;vb_Mes=1)
		OBJECT SET ENTERABLE:C238(vl_Año2;vb_Mes=1)
		If (vb_Mes=1)
			_O_ENABLE BUTTON:C192(bMes)
		Else 
			_O_DISABLE BUTTON:C193(bMes)
		End if 
		IT_SetEnterable (vb_Mes=1;0;->vl_Año2)
		If (vb_Rango=1)
			_O_ENABLE BUTTON:C192(bCalendar1)
			_O_ENABLE BUTTON:C192(bCalendar2)
		Else 
			_O_DISABLE BUTTON:C193(bCalendar1)
			_O_DISABLE BUTTON:C193(bCalendar2)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		vdACT_SelFecha1:=!00-00-00!
		vdACT_SelFecha2:=!00-00-00!
End case 
