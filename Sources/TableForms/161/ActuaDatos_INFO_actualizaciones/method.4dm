Case of 
	: (Form event:C388=On Load:K2:1)
		NIV_LoadArrays 
		C_LONGINT:C283(ActuaDatos_INFO_tabs)
		ActuaDatos_INFO_tabs:=New list:C375
		APPEND TO LIST:C376(ActuaDatos_INFO_tabs;__ ("Alumnos");1)
		APPEND TO LIST:C376(ActuaDatos_INFO_tabs;__ ("Relaciones Familiares");2)
		opc_1:=1
		opc_2:=0
		
		vb_Hoy:=0
		vb_Mes:=0
		vb_Año:=0
		vb_Rango:=0
		
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vl_Mes:=Month of:C24(Current date:C33(*))
		vt_Mes:=aMeses{vl_Mes}
		vl_Año:=Year of:C25(Current date:C33(*))
		vl_Año2:=Year of:C25(Current date:C33(*))
		vt_Fecha1:=String:C10(Current date:C33(*))
		vt_Fecha2:=String:C10(Current date:C33(*))
		vt_Fecha3:=String:C10(Current date:C33(*))
		vlSN3_CurrentTab:=1
		SN3_ActuaDatos_INFO_Actua (1)
		FORM GOTO PAGE:C247(1)
		
		
	: (Form event:C388=On Close Box:K2:21)
		
End case 

