Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vb_Año:=1
		vPeriod:=6
		vt_FechaENF:=""
		vd_FechaENF:=!00-00-00!
		OBJECT SET ENTERABLE:C238(vt_FechaENF;False:C215)
		_O_DISABLE BUTTON:C193(bCalendar1)
		COPY ARRAY:C226(atSTR_Periodos_Nombre;atSTR_Periodos_Nombre)
		atSTR_Periodos_Nombre:=atSTR_Periodos_Nombre
		_O_DISABLE BUTTON:C193(atSTR_Periodos_Nombre)
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
End case 